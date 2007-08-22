From: "Miles Bader" <miles@gnu.org>
Subject: "git pull REMOTE" question
Date: Wed, 22 Aug 2007 13:23:52 +0900
Message-ID: <fc339e4a0708212123p6e922b4cy3f5f19bfafafa395@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 22 06:24:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INhl7-0004Nn-FT
	for gcvg-git@gmane.org; Wed, 22 Aug 2007 06:23:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751437AbXHVEXy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Aug 2007 00:23:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751414AbXHVEXy
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Aug 2007 00:23:54 -0400
Received: from wr-out-0506.google.com ([64.233.184.226]:61697 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751359AbXHVEXx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2007 00:23:53 -0400
Received: by wr-out-0506.google.com with SMTP id 36so46080wra
        for <git@vger.kernel.org>; Tue, 21 Aug 2007 21:23:52 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=FxnkPiiG9PcZdMbAFVt+nBiqWrTPbau1ibxy2bC/Q7jYK953OQuaF+rGHiiw+eFW2hiRnG+2YTfW9D/3LTPStwWHf7Mk0Y2ycAWUVUzkhQIA4XqeP2MTMNVBj0h4BFfmPyW3kL/hvXBBhUNLU3xv9pkX/+sJv4h2apH6F9adlK4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=HvCffg5d3Wksn+yPeulNW8Oppuc/Zp/5Ull61/fn34RW1R88skwXmWFXCa6y8kqg1LjtXyTxg3/b3F0leGfT0E0UHIF5A9Rfjzh9zIAAuMy4XC94lxY53Ros10QiJiGziaLpcsoz0Rbx6i0ExDOETqz+x78pVpT6B2X4b0Wc47w=
Received: by 10.90.99.20 with SMTP id w20mr3618334agb.1187756632441;
        Tue, 21 Aug 2007 21:23:52 -0700 (PDT)
Received: by 10.90.105.17 with HTTP; Tue, 21 Aug 2007 21:23:52 -0700 (PDT)
Content-Disposition: inline
X-Google-Sender-Auth: 82997e45ce9524ed
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56347>

Hi,

I have a .git/config file in my tree that looks like:

   [remote "origin"]
           url = ssh://HOST.org/home/miles/git/PROJECT.git
           fetch = +refs/heads/*:refs/remotes/origin/*
   [remote "usb"]
           url = /media/usb/git/PROJECT.git
           fetch = +refs/heads/*:refs/remotes/usb/*
   [branch "master"]
           remote = origin
           merge = refs/heads/master

and I'm normally using branch "master".

"git pull" or "git push", without arguments, do exactly the right thing for
interacting with the "origin" remote.

When I want to push to "usb" (a usb thumbdrive), "git push usb" also does I
want, but "git pull usb" does not:  the git-fetch phase of the git-pull
correctly fetches all the proper objects from the usb repository, but the
git-merge part of the git-pull fails with an error message like:

   Warning: No merge candidate found because value of config option
            "branch.master.merge" does not match any remote branch fetched.
   No changes.

[See end of this message for a more complete output of a the pull command.]

After doing the pull, I can manually do the merge I want using a
command like "git merge remotes/usb/master", but it's kind of annoying
to have to do this every time.

>From my experimentation, it seems that this is because the local
branch "master" can only ever be associated with one remote ("origin"
in this case), and the "branch.master.merge" config _only_ applies to
that remote.

Is there a way to set things up so that "git pull REMOTE"
automatically merges fetched branches when doing a non-default pull?
If not, wouldn't this be a good feature to add?

Thanks,

-Miles


Here's the complete output of the git-pull command:

   $ git pull usb
   remote: Generating pack...
   remote: Done counting 59 objects.
   remote: Result has 38 objects.
   remote: Deltifying 38 objects...
   remote:
   Unpacking 38 objects...
   remote: Total 38 (delta 21), reused 24 (delta 8)
     97% (37/38) done 100% (38/38) done
   * refs/remotes/usb/master: storing branch 'master' of /media/usb/git/PROJECT
     commit: 243e656
   * refs/remotes/usb/branch1: storing branch 'branch1' of
/media/usb/git/PROJECT
     commit: e08c6ac
   * refs/remotes/usb/branch2: storing branch 'branch2' of
/media/usb/git/PROJECT
     commit: 8ad20e8
   * refs/remotes/usb/branch3: storing branch 'branch3' of
/media/usb/git/PROJECT
     commit: e874f3d
   Warning: No merge candidate found because value of config option
            "branch.master.merge" does not match any remote branch fetched.
   No changes.
   $


-- 
Everywhere is walking distance if you have the time.  -- Steven Wright
