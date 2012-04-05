From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 4/7] revert: allow single-pick in the middle of
 cherry-pick sequence
Date: Thu, 5 Apr 2012 13:49:42 +0200
Message-ID: <CACBZZX53dhb2SYMcMrQnhm3nsdTvZOm_0BCbSdPEPNdT0vxgTA@mail.gmail.com>
References: <CALkWK0=45OwcBoH2TorsgwTbaXjnffVuh0mGxh2+ShN9cuF-=A@mail.gmail.com>
 <20111120094650.GB2278@elie.hsd1.il.comcast.net> <20111122111207.GA7399@elie.hsd1.il.comcast.net>
 <20111122112001.GF7399@elie.hsd1.il.comcast.net> <7vr50zd5x0.fsf@alter.siamese.dyndns.org>
 <20111123012721.GA14217@elie.hsd1.il.comcast.net> <4ECCB3A2.5030102@viscovery.net>
 <20111123100452.GA30629@elie.hsd1.il.comcast.net> <4ECCC935.7010407@viscovery.net>
 <20111210124644.GA22035@elie.hsd1.il.comcast.net> <20111210125948.GE22035@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 05 13:50:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFlCg-0002dF-0v
	for gcvg-git-2@plane.gmane.org; Thu, 05 Apr 2012 13:50:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751805Ab2DELuG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Apr 2012 07:50:06 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:42882 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751588Ab2DELuD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Apr 2012 07:50:03 -0400
Received: by eaaq12 with SMTP id q12so407068eaa.19
        for <git@vger.kernel.org>; Thu, 05 Apr 2012 04:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=oViXhRQbVVdYfKfeVvYRO2mrjl+i4YG5IQN1qUraUFM=;
        b=iCqM8/mayGcFro4JMYpIuB0LrHPETaPY6/kJ4+X0BIPq9Lir70rqFzIsNqC7JqdeBu
         +mqVb6WabmrqSdc428SGJj8KwZUKmxW0+b/KDkV9G3pwJEfhZEkZgjcMYH/IOqZGLBBK
         GEY7kEvMndLRrGxCl7uRBCt8WYlBo46hsZtNGJkzJhlJdXje7gXKUNy3dfG8E7Mrfccv
         O6BlebTmYmYXWMtUY2HHO1ePKzuBg26CVJsd56QhT6CD2H26742mJPKL1OAfIfLBqpP0
         HMT/hNGd0nxC3UDw8tKzdvIG3b5IJfiSZIDk8GfTXnyNW/4ztRiPVDHIt9+myUYcDfz9
         MSSA==
Received: by 10.14.99.10 with SMTP id w10mr542054eef.51.1333626602236; Thu, 05
 Apr 2012 04:50:02 -0700 (PDT)
Received: by 10.213.103.1 with HTTP; Thu, 5 Apr 2012 04:49:42 -0700 (PDT)
In-Reply-To: <20111210125948.GE22035@elie.hsd1.il.comcast.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194766>

On Sat, Dec 10, 2011 at 13:59, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/*
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* If we were called as "git cherry-pick =
<commit>", just
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* cherry-pick/revert it, set CHERRY_PICK=
_HEAD /
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* REVERT_HEAD, and don't touch the seque=
ncer state.
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* This means it is possible to cherry-pi=
ck in the middle
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* of a cherry-pick sequence.
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
> + =C2=A0 =C2=A0 =C2=A0 if (opts->revs->cmdline.nr =3D=3D 1 &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 opts->revs->cmdline.rev->whence =
=3D=3D REV_CMD_REV &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 opts->revs->no_walk &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 !opts->revs->cmdline.rev->flags)=
 {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct commit *cmi=
t;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (prepare_revisi=
on_walk(opts->revs))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 die(_("revision walk setup failed"));
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cmit =3D get_revis=
ion(opts->revs);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!cmit || get_r=
evision(opts->revs))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 die("BUG: expected exactly one commit from walk");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return single_pick=
(cmit, opts);
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 /*
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Start a new cherry-pick/ revert sequenc=
e; but

This might be an issue introduced later in Ramkumar's code when he
moved this around, but on git.git's e5056c0 I get this:

    $ ./git revert --author=3D=C3=86var :/i18n
    fatal: BUG: expected exactly one commit from walk

That should find and revert this, right:

    $ git --no-pager log --author=3D=C3=86var --grep=3D"i18n" -1
    commit 5eb660e
    Author: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
    Date:   Sat Mar 10 12:29:35 2012 +0000

        perl/Makefile: install Git::I18N under NO_PERL_MAKEMAKER

        When I added the i18n infrastructure in v1.7.8-rc2-1-g5e9637c I=
 forgot
        to install Git::I18N also when NO_PERL_MAKEMAKER=3DYesPlease wa=
s
        set. Change the generation of the fallback perl.mak file to do =
that.

        Now Git/I18N.pm is installed alongside Git.pm in such a way tha=
t
        anything that uses GITPERLLIB will find it.

        Reported-by: Tom G. Christensen <tgc@statsbiblioteket.dk>
        Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@g=
mail.com>
        Signed-off-by: Junio C Hamano <gitster@pobox.com>

?
