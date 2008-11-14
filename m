From: "Bob Hiestand" <bob.hiestand@gmail.com>
Subject: reflog delete results in reflog show strangeness?
Date: Fri, 14 Nov 2008 16:33:10 -0600
Message-ID: <cc29171c0811141433t43d27c5gb57ca11d2ddb67cb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 14 23:34:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L17FD-0005xu-Qb
	for gcvg-git-2@gmane.org; Fri, 14 Nov 2008 23:34:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751560AbYKNWdM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2008 17:33:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751579AbYKNWdM
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Nov 2008 17:33:12 -0500
Received: from rv-out-0506.google.com ([209.85.198.226]:3310 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751560AbYKNWdM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2008 17:33:12 -0500
Received: by rv-out-0506.google.com with SMTP id k40so1581819rvb.1
        for <git@vger.kernel.org>; Fri, 14 Nov 2008 14:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=dtMS8nTvZmpf6XLMPJtDUNy9lopRbcWngw/+tDYoVGk=;
        b=McZ/WnCKiSoJ7IAgxd0t5BPMTxi5zh+T9iI5qMQ1zS6zzBHkaYc1gEfGHybhR/ZNjg
         WKe7rhDxrUh5/uiDa10SYbrg77sf68TiYopeY/aaEO/1z79c77lZdROALAciHE0EUGQ6
         L9z+SjEUBof0EP+P69OUcViHeQG0bV0BorcNU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=CXBCbgw1HbrS2nv6wMpzH4vzGW1kb9qoxFd+NdVOJlqX63sdP5064GtW82ljLt8HWf
         pbDHIUwrUIGzX6EeqaYtR/984bekTTK1KoK5LH1boVuneCVgYtPRbN9eRLrUx0VRCS8O
         UTUffih+OEjMKZiDIKzGpgyb9meAlAf+xm07I=
Received: by 10.114.205.14 with SMTP id c14mr845578wag.226.1226701990523;
        Fri, 14 Nov 2008 14:33:10 -0800 (PST)
Received: by 10.114.123.9 with HTTP; Fri, 14 Nov 2008 14:33:10 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101022>

I see a possible bug in the output of 'git reflog show' after using
'git reflog delete'.  Simple example:

$ git init
$ git commit --allow-empty -m 'root'
$ git commit --allow-empty -m 'good'
$ git commit --allow-empty -m 'bad'
$ git reflog
996ca67... HEAD@{0}: commit: bad
e431a20... HEAD@{1}: commit: good
992dd88... HEAD@{2}: commit (initial): root

$ git reset HEAD^
$ git reflog
e431a20... HEAD@{0}: HEAD^: updating HEAD
996ca67... HEAD@{1}: commit: bad
e431a20... HEAD@{2}: commit: good
992dd88... HEAD@{3}: commit (initial): root

$ git reflog delete HEAD@{1}
$ git reflog
e431a20... HEAD@{0}: HEAD^: updating HEAD
996ca67... HEAD@{1}: commit: good
992dd88... HEAD@{2}: commit (initial): root

In this listing, please note that, after the delete, the commit SHA
shown as HEAD@{1} is that of the deleted reference (the bad commit)
and does not match the reflog message, which has the expected value.

Thank you,

bob
