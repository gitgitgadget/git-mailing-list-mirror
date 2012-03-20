From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH 0/9 v2] difftool: teach command to perform directory diffs
Date: Mon, 19 Mar 2012 19:52:30 -0700
Message-ID: <CAJDDKr74cLSfj9JCeQQcm8U_26Re0u0nueoQ3nvj0O4FWBsqxg@mail.gmail.com>
References: <1331949442-15039-1-git-send-email-tim.henigan@gmail.com>
	<1332035734-5443-1-git-send-email-tim.henigan@gmail.com>
	<7vhaxk9ui6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Tim Henigan <tim.henigan@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 20 03:52:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9pBc-0002sD-Cy
	for gcvg-git-2@plane.gmane.org; Tue, 20 Mar 2012 03:52:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756257Ab2CTCwc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Mar 2012 22:52:32 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:51539 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755262Ab2CTCwb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Mar 2012 22:52:31 -0400
Received: by yenl12 with SMTP id l12so5994575yen.19
        for <git@vger.kernel.org>; Mon, 19 Mar 2012 19:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=6f6091th/29iYfLpWcCdITI0lQn8t/jl/DZGEUKUGE4=;
        b=x3KJz/kgGyQIOSE2EEWsJ1AfBCVv2THv8I1xHKecVWbjpFT2h3gpbc4ybR+R1C8oYu
         sAklhe7XBSTdkJfChv2UFmLuAjeCUdGobo1dHNcFVyhbOgBLLNAXzLKzco7q4GK29rEB
         rNLtFpMMDKrMzfk60wQHAwbsw46jE8BuF5dzPJuZoPYUagHROf1dInnCo4LJbuGZ7HbL
         LYwmTibr/VOdojMgdBZOaiJS9onvaNTk2CKO3xfE4GzC8wp1UIQZR+6pzuSloRl/lT8h
         1rqO8yKjwo9IOkmhpQzDBvSnKDZzeVNsfiZ5jJHmQ78j4p1keTE7cJYVRvfvq6dRPckm
         HLbw==
Received: by 10.236.156.232 with SMTP id m68mr14410024yhk.97.1332211950477;
 Mon, 19 Mar 2012 19:52:30 -0700 (PDT)
Received: by 10.147.143.4 with HTTP; Mon, 19 Mar 2012 19:52:30 -0700 (PDT)
In-Reply-To: <7vhaxk9ui6.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193481>

On Mon, Mar 19, 2012 at 2:00 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Thanks.
>
> I do not know a difftool user, and I wasn't paying close attention to=
 the
> discussion but I recall these points raised and I do not recall the
> resolutions:
>
> =C2=A0* In [1/9], use of pass_through would mean 'git difftool' must =
be fed the
> =C2=A0 options for difftool and then options meant for underlying dif=
f
> =C2=A0 machinery. =C2=A0Is this limitation still there? =C2=A0If so, =
isn't this a
> =C2=A0 regression? =C2=A0Shouldn't it at least be advertised to the u=
sers a lot
> =C2=A0 stronger in documentation?

Tim asserted that this is not the case.  The options should pass
through.  Hopefully there aren't any behavior changes between perl
versions and this option.

I sent a patch adding a test case to cover this scenario.  I would
prefer that we avoid a regression.  If there's a regression then we
can do without Getopt::Long, IMO.

I believe users should be oblivious as to which options are for
difftool and which are for diff.  E.g. `git difftool --cached -t
xxdiff` -- the user does not care that --cached is for diff and -t is
for difftool.

> =C2=A0* In [4/9], you remove the .exe extension when running git, whi=
ch was
> =C2=A0 there since the beginning of difftool 5c38ea3 (contrib: add 'g=
it
> =C2=A0 difftool' for launching common merge tools, 2009-01-16). =C2=A0=
I think it is
> =C2=A0 safe but are Windows folks OK with this?

I do not have Windows to test with, but this supposedly works since
Git.pm does not use git.exe either.  The git.exe stuff was originally
there because difftool originally did exec('git.exe', ...).  It was
later changed to use system() and it's possible that we could have
dropped the .exe extension at that time.

But, like I said, I don't have any Windows machines with which to
verify this behavior, and highly appreciate feedback from Windows
folks.


> =C2=A0* In [6/9], the exit code in the failure case seem to be modifi=
ed from
> =C2=A0 that of the underlying "git diff" to whatever croak gives us. =
=C2=A0Is this
> =C2=A0 a regression, or nobody cares error status from difftool? =C2=A0=
I personally
> =C2=A0 suspect it is the latter, but just double-checking if you have
> =C2=A0 considered it.

This doesn't seem like too big of an issue.  Had we documented the old
exit codes then it would be a bigger concern.  I would personally
prefer to preserve the exit code from diff itself, but if that
complicates it too much then the new behavior is ok.


> =C2=A0* In [7/9], difftool--helper declares SUBDIRECTORY_OK, but ther=
e doesn't
> =C2=A0 seem to be any inclusion of git-sh-setup in this script, and t=
he patch
> =C2=A0 does not have any effort to prepend $prefix to paths relative =
to $cwd.
> =C2=A0 What good does the variable do here?

I'll defer to Tim on this one.  This seems like an oversight.  It
seems like something should be done to handle it.

I recall that we made $GIT_PREFIX available to aliases and builtins
not too long ago.  That may help here.  See
1f5d271f5e8f7b1e2a5b296ff43ca4087eb08244.

Also.. I think we need some tests to cover the new behavior.  A test
to cover the subdirectory behavior would be especially helpful given
the note about [7/9].
--=20
David
