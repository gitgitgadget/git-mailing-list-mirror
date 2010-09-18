From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Commiting unchanged tree
Date: Sat, 18 Sep 2010 09:30:04 +0000
Message-ID: <AANLkTi=ODMjevBTLSK8W1AcdiiSiX=yfQfr_kK7Bh-cn@mail.gmail.com>
References: <loom.20100918T095640-130@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Maaartin <grajcar1@seznam.cz>
X-From: git-owner@vger.kernel.org Sat Sep 18 11:30:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OwtkL-0000Qu-S7
	for gcvg-git-2@lo.gmane.org; Sat, 18 Sep 2010 11:30:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755351Ab0IRJaH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 18 Sep 2010 05:30:07 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:60223 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755345Ab0IRJaG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Sep 2010 05:30:06 -0400
Received: by iwn5 with SMTP id 5so2646784iwn.19
        for <git@vger.kernel.org>; Sat, 18 Sep 2010 02:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=iL9cZk2FFxmtcZ0Ik+sDZia9gWpHMjTseOd8+D0cqLU=;
        b=xktT3s3Zc76Cu6jVW1chTjJFMs5Bd7jnkVg4e8vP4Y5yt6kuiRqEfigzoV/nPCq/E0
         5UB+UkUVZPPJSDboe+GJLePWn6ejGxVFZJuIcVAysXo6nKw/+ToKNtMstQs26kM+NnuW
         UKC4JGDWcBDI+MP6eRq2Lmdb88afOHAAF0Zxo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=J4r26c6Sy/RjWWuWplkcRfkjtfh/dRK/XkSUW/TEEGAF2bsYgHV7Lr+gkubeXzPvjs
         tc+lHeHdk25dv3dR7oATaxT47TyLlDXRJ7CKVhmLF/3JkK5A/MfGNn6jcMmXMMfnuPF7
         NEb8KNcyGuvmOoum+WGx1Nb9L4tNtavgDx9K4=
Received: by 10.231.173.9 with SMTP id n9mr6625581ibz.146.1284802204722; Sat,
 18 Sep 2010 02:30:04 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Sat, 18 Sep 2010 02:30:04 -0700 (PDT)
In-Reply-To: <loom.20100918T095640-130@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156444>

On Sat, Sep 18, 2010 at 08:15, Maaartin <grajcar1@seznam.cz> wrote:
> I thought that calling
>
> git commit --amend -m "A message"
>
> twice in a row should lead to an error saying "nothing to commit (wor=
king
> directory clean)", but it doesn't. Or at least, the result of the sec=
ond commit
> should be the same as the result of the first one, but I keep getting=
 a
> different hash each time
>
> # git commit --amend -m "A message"
> [master b8cf1c2] A message
> # git commit --amend -m "A message"
> [master 6c8ea30] A message
> # git commit --amend -m "A message"
> [master be318b3] A message
>
> I wonder if everything is fine with my repo since I was doing some fu=
nny
> rebasing and filtering and I'm quite new to git.

This is expected behavior. You're telling Git to amend the latest
commit with a new commit message (which happens to be equivalent to
the old one), and your sha1 keeps changing because the `commiter` time
entry in the commit changes every time you commit (well, with a
granularity of 1 second):

    v foo (master) $ git commit --amend -m"blah"; GIT_PAGER=3Dcat git
show --pretty=3Draw
    [master 9cc96c7] blah
     0 files changed, 0 insertions(+), 0 deletions(-)
     create mode 100644 blah
    commit 9cc96c71ae30f94afaf891be58671a0adf89cedb
    tree c4bf67b477e5e7470266b4227a664f7b175c9d4a
    author =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> 12=
84802065 +0000
    committer =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>=
 1284802096 +0000

        blah

    diff --git a/blah b/blah
    new file mode 100644
    index 0000000..e69de29
    v foo (master) $ git commit --amend -m"blah"; GIT_PAGER=3Dcat git
show --pretty=3Draw
    [master bc71b18] blah
     0 files changed, 0 insertions(+), 0 deletions(-)
     create mode 100644 blah
    commit bc71b18ae254b33e895ee840825bf357baa40e00
    tree c4bf67b477e5e7470266b4227a664f7b175c9d4a
    author =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> 12=
84802065 +0000
    committer =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>=
 1284802097 +0000

        blah

    diff --git a/blah b/blah
    new file mode 100644
    index 0000000..e69de29
    v foo (master) $

Note the difference between 1284802096 and 1284802097 there.
