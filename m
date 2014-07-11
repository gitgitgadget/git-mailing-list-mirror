From: Olaf Hering <olaf@aepfle.de>
Subject: pitfall with empty commits during git rebase
Date: Fri, 11 Jul 2014 12:15:47 +0200
Message-ID: <20140711101547.GA26050@aepfle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 11 12:15:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5Xrv-00014L-Q6
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jul 2014 12:15:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753109AbaGKKPv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Jul 2014 06:15:51 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.220]:10917 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753063AbaGKKPu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2014 06:15:50 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; t=1405073748; l=1261;
	s=domk; d=aepfle.de;
	h=Content-Transfer-Encoding:Content-Disposition:Content-Type:
	MIME-Version:Subject:To:From:Date;
	bh=vngopXZGisQsHQhYTb/HpoGzLQw=;
	b=qt1VTjH+f5N9sOhYoJcJ7k2IxLWF0vXckA/8zqTpNimhT9JeOaoA5vM+bdtXjpe+Udb
	d9dBWG/9Yq50QRKXxE5skVwNM88BGhwn/LIDrJUDx9MieQdwpoD2mBEcHTY0kN+8csMeu
	n9I6aW62G9NDFpDi+AEEOEqPFL1fIav0GdU=
X-RZG-AUTH: :P2EQZWCpfu+qG7CngxMFH1J+yackYocTD1iAi8x+OWi/zfN1cLnBYfssVYdSE5SlMz/SeUZHOvusx46dNQAHsRCe7PSMlQ==
X-RZG-CLASS-ID: mo00
Received: from probook.fritz.box ([2001:a60:10a9:ef01:1ec1:deff:fe91:f51c])
	by smtp.strato.de (RZmta 35.2 AUTH)
	with ESMTPSA id R0226cq6BAFlCGq
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	for <git@vger.kernel.org>;
	Fri, 11 Jul 2014 12:15:47 +0200 (CEST)
Received: by probook.fritz.box (Postfix, from userid 1000)
	id 7C26350282; Fri, 11 Jul 2014 12:15:47 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.22.rev6346 (2013-10-29)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253269>


There is an incorrect message when doing "git rebase -i remote/branch".
I have it only in german, see below. what happend is:

#01 make changes on another host
#02 copy patchfile to localhost
#03 apply patchfile
#04 git commit -avs # create commit#1
#05 sleep 123456
#06 make different changes on another host
#07 copy patchfile to localhost
#08 git show | patch -Rp1
#09 git commit -avs # create commit#2
#10 apply patchfile
#11 git commit -avs # create commit#3
#12 git rebase -i remote/branch
     pick commit#1 msg
     f    commit#2 msg
     f    commit#3 msg

=2E...
".git/rebase-merge/git-rebase-todo" 21L, 707C geschrieben
Sie fragten den j=C3=BCngsten Commit nachzubessern, aber das w=C3=BCrde=
 diesen leer
machen. Sie k=C3=B6nnen Ihr Kommando mit --allow-empty wiederholen, ode=
r diesen
Commit mit "git reset HEAD^" vollst=C3=A4ndig entfernen.
Rebase im Gange; auf c105589
Sie sind gerade beim Rebase von Branch 'mybranch' auf 'c105589'.

Keine =C3=84nderungen

Could not apply 6c5842320acc797d395afb5cdf373c2bfaebfa34... revert
=2E...

Its not clear what '--allow-empty' refers to, git rebase does not seem =
to
understand this option.

I should have skipped step #09 to avoid the trouble.
git version is 2.0.1. Please adjust the error msg above.


Olaf
