From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [RFC/PATCH] ls-remote: optionally return non-zero on non-existing refs
Date: Wed, 18 May 2011 13:59:53 -0300
Message-ID: <BANLkTi=juUtyPFNZQQ7h0jWHgmK2D1hFbA@mail.gmail.com>
References: <20110512120536.GA22033@camk.edu.pl>
	<7voc37dh4l.fsf@alter.siamese.dyndns.org>
	<7vk4dvdg6x.fsf@alter.siamese.dyndns.org>
	<4DD3D490.1090503@elegosoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Kacper Kornet <draenog@pld-linux.org>, git@vger.kernel.org
To: Michael Schubert <mschub@elegosoft.com>
X-From: git-owner@vger.kernel.org Wed May 18 19:00:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMk6L-0001oS-0R
	for gcvg-git-2@lo.gmane.org; Wed, 18 May 2011 19:00:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932989Ab1ERQ7y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 May 2011 12:59:54 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:64050 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932791Ab1ERQ7y convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 May 2011 12:59:54 -0400
Received: by ywe9 with SMTP id 9so433990ywe.19
        for <git@vger.kernel.org>; Wed, 18 May 2011 09:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=/ZAUuQd7Z18PNxxxXd99bJKx6AvXJjcxmhtD4xeg4Yc=;
        b=p0D1Rvxh+ZsGd46uYCSvVXHqmgwCKMw4Ab3mrgn34+3tZASm7hMUkoOI/L3A1rkmzO
         cDy2gQbx2U0gP5uguPhT2N3M+r6kE2Lj7PB92EJGoRifhNOzRaBW/TfyFnO3y20e0UPn
         1ab8QMc6St3tGPokB2F2h8IDoR77TWewt9ZOY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=h5dRZiEC80JqBCVnBpLUUh/tPrx7Uy2HVIUSsvRxzfpsEMTdantBHiJwUKbUN70zCy
         iA2dN6lyu/Z+DC56kh1MiIl/peQ/mZh+eHDykpWxwluvhfZhmz4Q7hE4pnAtKJ4F0FVY
         rtx0ibP99WRcXx7k0XfWNOhihoyGuNCvYBZgg=
Received: by 10.150.187.1 with SMTP id k1mr1644632ybf.5.1305737993198; Wed, 18
 May 2011 09:59:53 -0700 (PDT)
Received: by 10.151.42.19 with HTTP; Wed, 18 May 2011 09:59:53 -0700 (PDT)
In-Reply-To: <4DD3D490.1090503@elegosoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173888>

On Wed, May 18, 2011 at 11:15 AM, Michael Schubert <mschub@elegosoft.co=
m> wrote:
> git ls-remote returns zero no matter if the given references were fou=
nd
> or not. Teach ls-remote an option --exit-status to make it optionally
> returning a non-zero status.
>
> Signed-off-by: Michael Schubert <mschub@elegosoft.com>
> ---
>
> If there is just one existing ref in a list of non-exising refs, this=
 will
> return zero though - as "git show-ref" does.
>
>
> =C2=A0Documentation/git-ls-remote.txt | =C2=A0 =C2=A07 ++++++-
> =C2=A0builtin/ls-remote.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
 =C2=A0 12 ++++++++++--
> =C2=A02 files changed, 16 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/git-ls-remote.txt b/Documentation/git-ls-r=
emote.txt
> index c3df8c0..26cf705 100644
> --- a/Documentation/git-ls-remote.txt
> +++ b/Documentation/git-ls-remote.txt
> @@ -10,7 +10,7 @@ SYNOPSIS
> =C2=A0--------
> =C2=A0[verse]
> =C2=A0'git ls-remote' [--heads] [--tags] =C2=A0[-u <exec> | --upload-=
pack <exec>]
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <repository> [<refs>...]
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [-e|--exit-code] <reposit=
ory> [<refs>...]
>
> =C2=A0DESCRIPTION
> =C2=A0-----------
> @@ -36,6 +36,11 @@ OPTIONS
> =C2=A0 =C2=A0 =C2=A0 =C2=A0SSH and where the SSH daemon does not use =
the PATH configured by the
> =C2=A0 =C2=A0 =C2=A0 =C2=A0user.
>
> +-e::
> +--exit-code::
> + =C2=A0 =C2=A0 =C2=A0 Exit with a non-zero status code when the spec=
ified references don't
> + =C2=A0 =C2=A0 =C2=A0 exist.
> +
> =C2=A0<repository>::
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Location of the repository. =C2=A0The shor=
thand defined in
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$GIT_DIR/branches/ can be used. Use "." (d=
ot) to list references in
> diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
> index 1a1ff87..99fcf6b 100644
> --- a/builtin/ls-remote.c
> +++ b/builtin/ls-remote.c
> @@ -5,7 +5,7 @@
>
> =C2=A0static const char ls_remote_usage[] =3D
> =C2=A0"git ls-remote [--heads] [--tags] =C2=A0[-u <exec> | --upload-p=
ack <exec>]\n"
> -" =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 [-q|--quiet] [<repository> [<refs>...]]";
> +" =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 [-q|--quiet] [-e|--exit-code] [<repository> [<refs>...]]";
>
> =C2=A0/*
> =C2=A0* Is there one among the list of patterns that match the tail p=
art
> @@ -35,6 +35,7 @@ int cmd_ls_remote(int argc, const char **argv, cons=
t char *prefix)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned flags =3D 0;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int get_url =3D 0;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int quiet =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 int exit_code =3D 0;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *uploadpack =3D NULL;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0const char **pattern =3D NULL;
>
> @@ -74,6 +75,10 @@ int cmd_ls_remote(int argc, const char **argv, con=
st char *prefix)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0get_url =3D 1;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0continue;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0}
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 if (!strcmp("--exit-code", arg) || !strcmp("-e", arg)) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exit_code =3D 1;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 }
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0usage(ls_remote_usage);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dest =3D arg;
> @@ -115,12 +120,15 @@ int cmd_ls_remote(int argc, const char **argv, =
const char *prefix)
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!dest && !quiet)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(stderr=
, "From %s\n", *remote->url);
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0for ( ; ref; ref =3D ref->next) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!check_ref=
_type(ref, flags))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0continue;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!tail_matc=
h(pattern, ref->name))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0continue;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0printf("%s =C2=
=A0 =C2=A0 =C2=A0%s\n", sha1_to_hex(ref->old_sha1), ref->name);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exit_code =3D 0;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> - =C2=A0 =C2=A0 =C2=A0 return 0;
> +
> + =C2=A0 =C2=A0 =C2=A0 return (exit_code) ? 2 : 0;

We know, just a small nitpick. The parentheses around exit_code are unn=
ecessary.

> =C2=A0}
> --
> 1.7.5.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
