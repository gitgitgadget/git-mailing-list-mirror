From: "Denis Bueno" <dbueno@gmail.com>
Subject: Recovering from repository corruption
Date: Tue, 10 Jun 2008 13:26:51 -0400
Message-ID: <6dbd4d000806101026m458513ecqa8141f509bad7602@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 10 19:27:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K67dL-0005GQ-6c
	for gcvg-git-2@gmane.org; Tue, 10 Jun 2008 19:27:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754832AbYFJR0y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2008 13:26:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753904AbYFJR0y
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jun 2008 13:26:54 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:33049 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751386AbYFJR0x (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2008 13:26:53 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1855878fgg.17
        for <git@vger.kernel.org>; Tue, 10 Jun 2008 10:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=HI4zHU1mNFulmb9VhVzcHtD1zs8GUIWM//KBVZs14Q4=;
        b=Qt27hRDlfmxLoiDUr0rsl+9+s7z3htE1VCUTV2oo/xPVgSqEMT1vdQ/FbUkc9vFQaZ
         +1AbJ5+36yxPV0CfM3zxB5sGowawpnWkzVHwcwurMboU/Xm4xO+3R4QGG2ZTiuW0ikCN
         WIFN0w6PsyNhDfOryiGLvFN/+CM00kMWNSa50=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=UeEIMm0gR2QthTNPEmgmEoh8F0Ve9TJqr5GakWZ+sJYv08XX1/jyHcRnsCTmEdaRVN
         sO7iDoRd/AKpsIKsTDzPIHBeIQxv2g7GU1PiUfzxjQadcMAhFKVPWD4oj4PAzN1e+NUc
         6OV73TKrysoCYAa0IEG7Rw3UV1tycJyjwpNCA=
Received: by 10.86.89.1 with SMTP id m1mr6019199fgb.45.1213118811279;
        Tue, 10 Jun 2008 10:26:51 -0700 (PDT)
Received: by 10.86.59.7 with HTTP; Tue, 10 Jun 2008 10:26:51 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84528>

I started a thread a while back about repository corruption.  It
manifested as a clone error and the thread is here:

    http://kerneltrap.org/mailarchive/git/2007/7/31/253475

I just ran, again, into corruption after my laptop kernel-panic'd.
(Ironically, at the moment I ran into the corruption I was trying to
push my repo to a backup location.)  Since that thread took place it
seems a section about recovering from repo corruption was added to the
manual --- but it assumes you can (or care to painstakingly) recreate
each corrupted version.

I made several changes to one file, home.html, and now have the
following corruption:

    identity.corrupt[56] > git fsck --full
    error: 320bd6e82267b71dd2ca7043ea3f61dbbca16109: object corrupt or missing
    error: 4d0be2816d5eea5ae2b40990235e2225c1715927: object corrupt or missing
    missing blob 320bd6e82267b71dd2ca7043ea3f61dbbca16109
    missing blob 4d0be2816d5eea5ae2b40990235e2225c1715927

I know which commits these hashes correspond to, and I know roughly
what I did in those commits, but, I really don't care that much, and
anyway it will be painful to recreate them because of
whitespace/formatting issues.  Here are the commits, in case it is
relevant:

    commit 163a93df14d246dee91c3a503e6372b8313f337d
    Author: Denis Bueno <dbueno@gmail.com>
    Date:   Tue Jun 10 09:45:41 2008 -0400

        Add lambda-the-ultimate link

    :100644 100644 320bd6e... 2ab4775... M  home.html

    [... intervenent commits ...]

    commit 4737fea59fdc8325e09b5206cc7a6ac593446ce3
    Author: Denis Bueno <dbueno@gmail.com>
    Date:   Tue Jun 10 09:37:12 2008 -0400

        Hoogle up top too

    :100644 100644 4d0be28... c6fe111... M  home.html

Assuming I can't recreate the hashed files, what are my options?

I was told in the thread above that I could use grafts and "git
filter-branch" to create a new repository that simply got rid of the
offending object.  That case was simpler, as it was the initial import
of a file that had only two commits total that was corrupted.
However, in this case there are changes between the initial and latest
version of the file, and commits between the corrupted versions, so, I
can imagine that it would be hard to get rid of in-between commits.

The thing that makes sense intuitively (read: not as a Git expert, but
as a user) is to just let me replace the commits associated with the
problematic objects with new versions of those commits (e.g. make
change described in the commit message, which is different from the
actual change that was recorded, due to whitespace/formatting issues).
 Is this what I should do?  And to do so, should I be reading chapter
5 of the manual?

Thanks.

-- 
                              Denis
