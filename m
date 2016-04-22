From: Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
Subject: Re: possible bug of git stash deleting uncommitted files in corner
 case
Date: Fri, 22 Apr 2016 21:04:25 +0200 (CEST)
Message-ID: <754076461.4029096.1461351865455.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <CAND5yRvCK9YuVOJ91CHbnbWAVYcPrpihGkoKs28f7PJgzRwW6Q@mail.gmail.com> <CAND5yRvU1-AgvQW106fHbNN-GRQ615HjTDjR6AY9gkpoquBgDw@mail.gmail.com> <1304154573.4013923.1461328186541.JavaMail.zimbra@ensimag.grenoble-inp.fr> <xmqqmvolpmsw.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Daniele Segato <daniele.segato@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 22 20:58:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atgHf-0002yv-MU
	for gcvg-git-2@plane.gmane.org; Fri, 22 Apr 2016 20:58:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751911AbcDVS61 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Apr 2016 14:58:27 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:55333 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751831AbcDVS61 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2016 14:58:27 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 73D9A2053;
	Fri, 22 Apr 2016 20:58:23 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JJuIArEpaDCT; Fri, 22 Apr 2016 20:58:23 +0200 (CEST)
Received: from zm-int-mbx1.grenet.fr (zm-int-mbx1.grenet.fr [130.190.242.140])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 60E61200E;
	Fri, 22 Apr 2016 20:58:23 +0200 (CEST)
In-Reply-To: <xmqqmvolpmsw.fsf@gitster.mtv.corp.google.com>
X-Originating-IP: [130.190.242.137]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF45 (Linux)/8.0.9_GA_6191)
Thread-Topic: possible bug of git stash deleting uncommitted files in corner case
Thread-Index: oiYa/Amc240lgFr4AYShF29KUI5kxg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292245>

Junio C Hamano <gitster@pobox.com> writes:
> Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
> writes:
>=20
> > Daniele Segato <daniele.segato@gmail.com> wrote:
> > ...
> >> git version 1.9.1
> >
> > Contrary to what I expected, this seems to still be the case with:
> >   $ git --version
> >   git version 2.8.0.rc2
>=20
> I do not think "git stash" has been updated in any major way to
> address correctness (including its corner case behaviour) ever since
> it was originally written, so it is very likely that any bug you see
> would be with it since the very old days.

=46or this bug it doesn't seem to be specifically linked to git stash,
since 'git status' doesn't display correct informations in the first
place (it doesn't show foo/bar as an untracked file).

I tried something quickly, based on Daniele's case:
    git init
    echo 'X' >foo
    git add foo
    git commit -m "Added foo"
    rm foo
    mkdir foo
    echo 'B' >foo/bar

    git status # foo/bar not shown in Untracked files

    git add foo/bar

git status then shows as expected:
# On branch master
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#=20
# 	deleted:    foo
# 	new file:   foo/bar

However git stash fails this time:
# error: foo: is a directory - add individual files instead
# fatal: Unable to process path foo
# Cannot save the current worktree state

I am not sure what should be the correct behaviour here.
This however might be one of the corner cases you mentionned.

Thanks,
R=C3=A9mi
