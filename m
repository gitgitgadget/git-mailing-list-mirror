From: David Turner <dturner@twopensource.com>
Subject: mktree: multiple same-named objects
Date: Wed, 27 Aug 2014 00:41:57 -0400
Organization: Twitter
Message-ID: <1409114517.13351.6.camel@leckie>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 27 06:42:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMV3f-0006ZK-96
	for gcvg-git-2@plane.gmane.org; Wed, 27 Aug 2014 06:42:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932518AbaH0EmB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2014 00:42:01 -0400
Received: from mail-qc0-f173.google.com ([209.85.216.173]:48379 "EHLO
	mail-qc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932097AbaH0EmA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2014 00:42:00 -0400
Received: by mail-qc0-f173.google.com with SMTP id w7so16666067qcr.32
        for <git@vger.kernel.org>; Tue, 26 Aug 2014 21:41:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:date:organization
         :content-type:mime-version:content-transfer-encoding;
        bh=mZBpCvUg3lKsnTqUEHbCMcyhZBXWQ2wj4ScFTnOxwls=;
        b=WQGZ6nQg5j3eO+UphTbCvhKLn+CPbvNca4SeJJqL4w/1vWCr/t7xEMLZtlxXvAr6WM
         nSv57FxWqz1JXYdrPLVaC25U0axJPFM67v8m9e2dM6Z7rTA/uaV1SV8UsjvLHu4HTPr4
         R4fD+xpSUeVUiOhY+2ewHv5VJcA+2Mmmv3VvhkjFp6q0GQMBPNr57ayXH4tyfWKImiO3
         BuDybhP0Er0E35CAITwuLNJXUiS50hXHbT29m2hu2dCABHh4uLIKh8/lKbjw4sHYR4l1
         4rghkxQg0VZRXRqelEMvyWSlpIG6GWrpyoXJFl2ukDThquWszhDBUNmGN5oBCIERW7Y1
         hGdg==
X-Gm-Message-State: ALoCoQmYchIvFd/mlUPLlWXKrW7CJgfR4T4d85KuMFvHVvNKEEq9DWbip6bdpcNX2IS2Xi0bJY0B
X-Received: by 10.140.25.226 with SMTP id 89mr49579212qgt.62.1409114519491;
        Tue, 26 Aug 2014 21:41:59 -0700 (PDT)
Received: from [172.17.131.24] (ip-66-9-26-66.autorev.intellispace.net. [66.9.26.66])
        by mx.google.com with ESMTPSA id a17sm4556280qgf.12.2014.08.26.21.41.58
        for <git@vger.kernel.org>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Tue, 26 Aug 2014 21:41:58 -0700 (PDT)
X-Mailer: Evolution 3.10.4-0ubuntu2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255977>

git mktree seems to allow the creation of a tree object with multiple
objects of the same name but different SHAs.  This leads to weird
behavior later, unsurprisingly.  For instance, if there are two tree
objects with the same name but different SHAs, the checked out tree will
be the union of them (reasonably), but if you do git add $name, some or
all unmodified files under $name will show up in git status as modified
-- since they differ from one of the parent trees, presumably.

And if different git implementations treat this case differently, then
it might be possible to make a repo that appears to contain one thing
when viewed with one implementation, but contains a different thing for
a different implementation.

Summary: git mktree ought to forbid this, and possibly there ought to be
other checks (for instance, when unpacking) to prevent this.
