From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: Git Submodule Problem - Bug?
Date: Tue, 29 Nov 2011 11:15:46 +0100
Message-ID: <20111129101546.GB2829@kolya>
References: <38AE3033-6902-48AA-819B-DB4083F1F8EF@gmail.com>
 <201111291024.01230.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Manuel Koller <koller.manuel@gmail.com>, git@vger.kernel.org,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Fredrik Gustafsson <iveqy@iveqy.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Nov 29 11:15:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVKix-0003Ud-IV
	for gcvg-git-2@lo.gmane.org; Tue, 29 Nov 2011 11:15:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754440Ab1K2KPd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Nov 2011 05:15:33 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:57316 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753690Ab1K2KPc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Nov 2011 05:15:32 -0500
Received: by bkas6 with SMTP id s6so300131bka.19
        for <git@vger.kernel.org>; Tue, 29 Nov 2011 02:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=uGcdKAu9wjhbKozldZA31Wc+0oK9EWWyKDPhzwe1wa4=;
        b=AcCT2aERD5ZK6tHPo1Y7XAswpwPYVqHLei34MqHIX7qYLEP2F8Bl8SuUyRMQWSk7q4
         oDKKmsx6AsQQrl4OyReVzcupV6GdYhAEFHlFZVVfvMyhBLqUxSnQlDiNfzfortusVShS
         +675cYOAW7xU4UNrBUUDRk2VYrMOT+r/5Hz7E=
Received: by 10.204.141.24 with SMTP id k24mr47511470bku.97.1322561730690;
        Tue, 29 Nov 2011 02:15:30 -0800 (PST)
Received: from kolya (1-1-3-35a.mfb.mlm.bostream.se. [82.182.194.253])
        by mx.google.com with ESMTPS id e8sm36004165bkd.7.2011.11.29.02.15.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 29 Nov 2011 02:15:28 -0800 (PST)
Received: from iveqy by kolya with local (Exim 4.72)
	(envelope-from <iveqy@kolya>)
	id 1RVKj4-0002ex-RF; Tue, 29 Nov 2011 11:15:46 +0100
Content-Disposition: inline
In-Reply-To: <201111291024.01230.trast@student.ethz.ch>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186049>

On Tue, Nov 29, 2011 at 10:24:01AM +0100, Thomas Rast wrote:
> Manuel Koller wrote:
> >=20
> > The problem arises when I pull a commit that switches a submodule w=
ith another one and then run git submodule update. Say I have a repo "s=
uper" that has one submodule "sub1" in the folder "sub" and a clone "su=
per2". Now I remove the submodule in "super2" and add another one ("sub=
2") again named "sub", commit this and push it. Now after pulling the c=
ommit to "super", I need to run git submodule sync and then git submodu=
le update.=20
> >=20
> > I expect to end up with the submodule "sub2" in sub. But the log cl=
early shows that the commits from "sub1" are still there (the master br=
anch belongs to "sub1" while origin/master comes from "sub2").  I get t=
he following output:
> >=20
> > > ...
> > > commit 77d8d11fed3b07e1d4e47b3df9fc44c278694a39
> > > Author: Manuel Koller <koller@stat.math.ethz.ch>
> > > Date:   Mon Nov 28 17:46:45 2011 +0100
> > >=20
> > >     initial commit sub1
> > > commit 346fe6bd9e7957f10c5e833bb1155153379da41c
> > > Author: Manuel Koller <koller@stat.math.ethz.ch>
> > > Date:   Mon Nov 28 17:46:45 2011 +0100
> > >=20
> > >     initial commit sub2
> >=20
> > I think it should be twice the same, and "sub2". I checked also wit=
h Charon, on his machine, the two log messages reported are "sub1" whic=
h completely baffles me.
>=20
> I used the test script at the end (just a testification of your
> attachment) to bisect this to the following commit:
>=20
>     commit 501770e1bb5d132ae4f79aa96715f07f6b84e1f6
>     Author: Fredrik Gustafsson <iveqy@iveqy.com>
>     Date:   Mon Aug 15 23:17:47 2011 +0200
>=20
>         Move git-dir for submodules
>        =20
>         Move git-dir for submodules into $GIT_DIR/modules/[name_of_su=
bmodule] of
>         the superproject. This is a step towards being able to delete=
 submodule
>         directories without loosing the information from their .git d=
irectory
>         as that is now stored outside the submodules work tree.
>        =20
>         This is done relying on the already existent .git-file functi=
onality.
>         When adding or updating a submodule whose git directory is fo=
und under
>         $GIT_DIR/modules/[name_of_submodule], don't clone it again bu=
t simply
>         point the .git-file to it and remove the now stale index file=
 from it.
>         The index will be recreated by the following checkout.
>        =20
>         This patch will not affect already cloned submodules at all.
>        =20
>         Tests that rely on .git being a directory have been fixed.
>        =20
>         Signed-off-by: Fredrik Gustafsson <iveqy@iveqy.com>
>         Mentored-by: Jens Lehmann <Jens.Lehmann@web.de>
>         Mentored-by: Heiko Voigt <hvoigt@hvoigt.net>
>         Signed-off-by: Junio C Hamano <gitster@pobox.com>
>=20
> That is, before 501770 I get sub1/sub2 as Manuel said above.  After
> 501770 I get sub1/sub1 (!).  I have not been able to reproduce the
> sub2/sub2 behavior with any version I tried (1.7.0, 1.7.3.4, 1.7.6,
> etc.).  Perhaps there is a configuration setting that changes this?
>=20
> In any case, since it's -rc4 time and 501770 is set to go into the
> release, it would be nice if you could check whether this is indeed
> correct/intended.
>=20
>=20
>=20
> ---- 8< ----
> #!/bin/sh
>=20
> test_description=3D'submodule change bug'
> . ./test-lib.sh
>=20
> ## set current directory as working directory
> wd=3D`pwd`
>=20
> test_expect_success 'set up submodules' '
> ## create repositories to be used as submodules
> mkdir sub1 sub2 remote &&
> (cd sub1 &&
>     git init &&
>     echo "test sub1" >> file &&
>     git add file &&
>     git commit -m "initial commit sub1"
> ) &&
> git clone --bare sub1 remote/sub1.git &&
> (cd sub2 &&
>     git init &&
>     echo "test sub2" >> file &&
>     git add file &&
>     git commit -m "initial commit sub2"
> ) &&
> git clone --bare sub2 remote/sub2.git
> '
>=20
> test_expect_success 'set up super-repo' '
> ## create super repository
> git init --bare remote/super.git &&
> git clone remote/super.git super &&
> (cd super &&
>     git submodule add "$wd"/remote/sub1.git sub &&
>     git commit -m "Added submodule sub1 as sub" &&
>     git push -u origin master
> )'
>=20
> test_expect_success 'make super-repo with sub1->sub2' '
> ## clone super repository again
> ## and switch submodule sub1 by sub2
> git clone --recursive remote/super.git super2 &&
> (cd super2 &&
>     ## remote submodule sub
>     git config --remove-section submodule.sub &&
>     git rm .gitmodules &&
>     rm -rf sub &&
>     git rm sub &&
>     git commit -m "Removed submodule sub" &&
>     ## add submodule sub2 as sub
>     git submodule add "$wd"/remote/sub2.git sub &&
>     git commit -m "Added submodule sub2 as sub" &&
>     git push
> )
> '
>=20
> test_expect_success 'pull from super2' '
> ## now pull super
> (cd super &&
>     git pull &&
>     ## this will fail
>     if ! git submodule update --init; then
>     ## so sync first und update again
>         git submodule sync &&
>         git submodule update --init
>     fi &&
>     ## now sub is corrupt
>     (cd sub &&
>         git log master >log1 && ## this is from sub1
>         echo "# next line should be: initial commit from sub1" &&
>         grep sub1 log1 &&
>         echo "# next line should be: initial commit from sub2" &&
>         git log origin/master >log2 && ## this is from sub2
>         grep sub2 log2
>     )
> )
> '
>=20
> test_done

This is something I did not thought about when writing that patch. The
reason that this fails is that the part when the first submodule is
removed is no longer complete (as intended). Before this patch
     git config --remove-section submodule.sub &&
     git rm .gitmodules &&
     rm -rf sub &&
Did remove all the data associated with the submodule. That's no longer
the case. The submodule repository is stored in .git/modules and is
still there. When a new submodule (at the same path) is added, the
repository already associated with that path will be used.

If to the three lines above from the test a line that removes the
repository also is added, the test will work:
     git config --remove-section submodule.sub &&
     git rm .gitmodules &&
     rm -rf sub &&
     rm -rf .git/modules/sub &&
     git rm sub &&

The point beeing that 'rm -rf sub' is not longer sufficient to remove a
submodule and its repository. As 'rm -rf' is not a git command, I'm not
sure how this should be solved (or if it should at all).

* Note: the .git/modules/sub is only valid if .git is a git-dir, if it'=
s
  a gitfile, it's not...

--=20
Med v=E4nliga h=E4lsningar
=46redrik Gustafsson

E-post: iveqy@iveqy.com
Tel. nr.: 0733 60 82 74
