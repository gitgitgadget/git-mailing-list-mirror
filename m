From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [QGIT PATCH] Add safeguards to Git::userInfo()
Date: Tue, 7 Oct 2008 19:03:29 +0100
Message-ID: <e5bfff550810071103j52ce2617iae2f77b9bd3fba93@mail.gmail.com>
References: <48EB10C8.4070009@lyx.org>
	 <e5bfff550810070410t1097ace4pf401821292fd7565@mail.gmail.com>
	 <48EB49B3.1090509@lyx.org>
	 <e5bfff550810070457i702c2935lfcc0b60ae3df4dc4@mail.gmail.com>
	 <48EB5FAF.4080303@lyx.org>
	 <e5bfff550810070950j66bbb980vc26bd50a5615d44@mail.gmail.com>
	 <e5bfff550810070955o5ea20e90jf52faf31a0ada013@mail.gmail.com>
	 <48EB9EB1.7080302@lyx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Abdelrazak Younes" <younes@lyx.org>
X-From: git-owner@vger.kernel.org Tue Oct 07 20:06:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnGvL-0006qi-Jx
	for gcvg-git-2@gmane.org; Tue, 07 Oct 2008 20:04:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753838AbYJGSDb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2008 14:03:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753835AbYJGSDb
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Oct 2008 14:03:31 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:15180 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753808AbYJGSDb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Oct 2008 14:03:31 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2407543fgg.17
        for <git@vger.kernel.org>; Tue, 07 Oct 2008 11:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=sRmbxtyVtXVPHOAM2kPwp3o2fJ+ma7o0PNyY62pT0Ro=;
        b=EAwFOYsAadE025AG/rVmOdqiBlMTQ3UcTZb2i56N4gALaFpngB+H0u3tAQmusVK3iZ
         ROwTzvs0lqt+lZEv02TOimaDWcrgeydMztwB1a3icoj2w5QCnOHvfg87bh3uefJJJD4U
         ehmp/URLAhCng0FO6LHRNeTEzvDavoveEayqs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=ivsoQxoAV54d1GdO6KLzlGIzXO3Q3oaYBDzroaAoUFtTcWqZ+qajD4r0TCafgD92PJ
         Dn0d+FtM1T1rQMEWn2k3jtK1pdROM10cS4mqabhrWS0yaL1Pam2b1oY1ltYZ/h3kU5Ks
         SViS+CaXYALvbQedzHydCRFfLtEpDzFw3jzSE=
Received: by 10.181.2.2 with SMTP id e2mr5269744bki.49.1223402609074;
        Tue, 07 Oct 2008 11:03:29 -0700 (PDT)
Received: by 10.180.220.15 with HTTP; Tue, 7 Oct 2008 11:03:29 -0700 (PDT)
In-Reply-To: <48EB9EB1.7080302@lyx.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97737>

On Tue, Oct 7, 2008 at 6:38 PM, Abdelrazak Younes <younes@lyx.org> wrote:
>
> So how do you explain this:
>

Form git-config(1) docs:

This command will fail if:

-The config file is invalid,
......
-you use --global option without $HOME being properly set.


So please try to comment out following line

--- a/src/git.cpp
+++ b/src/git.cpp
@@ -345,7 +345,7 @@ void Git::userInfo(SList info) {
 	info.clear();
 	info << "Environment" << user << email;

-	errorReportingEnabled = false; // 'git config' could fail, see docs
+	//errorReportingEnabled = false; // 'git config' could fail, see docs

 	run("git config user.name", &user);
 	run("git config user.email", &email);


run from double click and you probably will see an error message box
where git says $HOME is not set (I can reproduce this now).

So what I think is that when you run from command line there is the
$HOME variable set and command does not fails.


Marco
