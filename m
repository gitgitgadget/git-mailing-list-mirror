From: Ben Olive <sionide21@gmail.com>
Subject: Super long branch names corrupt `.git/config`
Date: Thu, 4 Oct 2012 13:15:25 -0400
Message-ID: <CAAmo=1BU5N8nbonEb1aZEx=-e8VexwsE74pjm_56dXmCDK+K6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 05 01:02:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJte7-00033L-4d
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 00:11:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754755Ab2JDRP0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2012 13:15:26 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:58197 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753024Ab2JDRPZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2012 13:15:25 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so1487526iea.19
        for <git@vger.kernel.org>; Thu, 04 Oct 2012 10:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=N1xAy/oVxwLb/2PqSa1q+qWlBeT9X/YeOckNkPFiZrg=;
        b=iTT8rLuuQqu1Xivchr/2kPGIY5cmVjPOt3RBZXWnqTN1h2K5icJb+4CCXB+XIHKV+o
         XX+mlpZs9kDRQfbVbyq+uUkdMyqaEQDbXWgMDWgc3oUS9IWn247oltFOCpBPqL+VxUNT
         RTbZwvU4N6gik8n1b48RlMTAVW9NvZvuJcBGu6FHqpI0sB8rD+6P1Lp8WH4MHAFKMFrh
         WMnISJXuvDLRi5UI6yXH4j0Dnb53R4zi/HKCbwCY9ArGM4QLvGkZko5te4Xzc17CFjqW
         Aza167yrDqh+JncxUWuv9FTth85PegNWJqlc9kyMD2Gz1qrQ434GvaiKtuPYWncodSzT
         K8MQ==
Received: by 10.50.15.132 with SMTP id x4mr5902065igc.58.1349370925396; Thu,
 04 Oct 2012 10:15:25 -0700 (PDT)
Received: by 10.231.103.198 with HTTP; Thu, 4 Oct 2012 10:15:25 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207041>

My `.git/config` can be corrupted if I try to get a local branch with
an extremely long name to track a remote branch.

Here is a (contrived) example to reproduce the issue:


    $ cd /tmp
    $ mkdir buggyrepo otherrepo
    $ cd buggyrepo/ && git init && cd -
    $ cd otherrepo/ && git init && cd -
    $ cd buggyrepo/
    $ echo foo > MYFILE
    $ git add MYFILE && git commit -m "Initial"
    $ git remote add otherrepo ../otherrepo/
    $ git checkout -b `ruby -e "puts 'a'*200"`
    $ git push -u otherrepo `ruby -e "puts 'a'*200"`
    fatal: bad config file line 11 in .git/config
    $ git status
    fatal: bad config file line 11 in .git/config


Workaround available: Just delete the offending entry.

I tested this with 1.7.12.2

--Ben Olive
