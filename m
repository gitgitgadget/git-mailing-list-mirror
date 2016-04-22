From: Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
Subject: Re: possible bug of git stash deleting uncommitted files in corner
 case
Date: Fri, 22 Apr 2016 14:29:46 +0200 (CEST)
Message-ID: <1304154573.4013923.1461328186541.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <CAND5yRvCK9YuVOJ91CHbnbWAVYcPrpihGkoKs28f7PJgzRwW6Q@mail.gmail.com> <CAND5yRvU1-AgvQW106fHbNN-GRQ615HjTDjR6AY9gkpoquBgDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Daniele Segato <daniele.segato@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 22 14:23:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ata7n-0007Oh-Vr
	for gcvg-git-2@plane.gmane.org; Fri, 22 Apr 2016 14:23:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751957AbcDVMXw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Apr 2016 08:23:52 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:60498 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751845AbcDVMXv convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2016 08:23:51 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id E88BA20AF;
	Fri, 22 Apr 2016 14:23:46 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kIFPx8Fo59Zf; Fri, 22 Apr 2016 14:23:46 +0200 (CEST)
Received: from zm-int-mbx1.grenet.fr (zm-int-mbx1.grenet.fr [130.190.242.140])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id D536720AD;
	Fri, 22 Apr 2016 14:23:46 +0200 (CEST)
In-Reply-To: <CAND5yRvU1-AgvQW106fHbNN-GRQ615HjTDjR6AY9gkpoquBgDw@mail.gmail.com>
X-Originating-IP: [130.190.242.137]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF39 (Linux)/8.0.9_GA_6191)
Thread-Topic: possible bug of git stash deleting uncommitted files in corner case
Thread-Index: S5Gm664dNUifvGu7MB3ER/08JKC+6g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292186>

Daniele Segato <daniele.segato@gmail.com> wrote:
> git init
> echo 'X' > foo
> git add foo
> git commit -m 'foo file committed'
>=20
> rm foo
> mkdir foo
> echo 'B' > foo/bar
>=20
> # git status
>=20
> git stash
>=20
> at this point stash deleted the "bar" file, in his case all the work
> on the previous couple of hours, but he didn't know yet
>=20
> the foo directory was gone, replaced by the foo file
>=20
> git stash pop
>=20
> did not complained and deleted foo file again
>=20
> I know my co-worker shouldn't had created a directory with the same
> file he was deleting but I also think git shouldn't have allowed him
> to stash at all, or should have been clever enough to actually stash
> the directory with its files.

AFAIK it is a bug.
Without even going to the stash command,
    git init
    echo 'X' >foo
    git add foo
    git commit -m "Adding foo"
    rm foo
    mkdir foo
    echo 'B' >foo/bar
    git status
At this point the state is incorrect, the file foo/bar isn't there, as
you mentionned.

>  $ git --version
> git version 1.9.1

Contrary to what I expected, this seems to still be the case with:
  $ git --version
  git version 2.8.0.rc2

Being at $daywork right now, I am unable to test this any further.

Thanks,
R=C3=A9mi
