From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [PATCH 1/2] Add support for a shared config file
Date: Sat, 27 Nov 2010 14:29:43 -0200
Message-ID: <AANLkTi=0MUfdXppze4bPdMnE--koRTvMfRJ=L=cvieOX@mail.gmail.com>
References: <cover.1290870041.git.nathan.panike@gmail.com>
	<f687e6c4830e21db606db99b584864a61e5cf8c3.1290870042.git.nathan.panike@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Nathan W. Panike" <nathan.panike@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 27 17:31:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PMNgX-0006u7-1P
	for gcvg-git-2@lo.gmane.org; Sat, 27 Nov 2010 17:31:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752829Ab0K0Q3p convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Nov 2010 11:29:45 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:60338 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751499Ab0K0Q3o convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 27 Nov 2010 11:29:44 -0500
Received: by bwz15 with SMTP id 15so2667990bwz.19
        for <git@vger.kernel.org>; Sat, 27 Nov 2010 08:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=BpmC4Q3GOWU1NOjbjoaMnQKihNgddeM71JWEns+rVs4=;
        b=lV64lY3X3LNCkhmE6NZFKQPE1sEqTcQT6PArWwEphY05urqnrsw3e23QaFKqkmVvaf
         jWIGbW8DFKsBPSMG3PpGnWyR2VThxrB3Avi/60osgTzQL0IoUiOXhmRH+T+0XomhtfYn
         UrArVwkbkefpeJ58SB9KUh2v6Kf7z5yHTQugM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=S4LJ4Xk9BdqJD3NoiY3g4zx4KuafeXohyevcKZ2PLd2aKj7MB/cXyRbJhf/wpNyADv
         +D16DYlDDwavW7b4ULlR4+DcMqAli9uaXJsx2HUo2j1IZNtsufsepDucV1i5vzs3QcbX
         ZtNzJYkOqeV+lOqIPK26OTktrZrwich4pL7Ug=
Received: by 10.204.114.141 with SMTP id e13mr3124746bkq.94.1290875383224;
 Sat, 27 Nov 2010 08:29:43 -0800 (PST)
Received: by 10.204.58.71 with HTTP; Sat, 27 Nov 2010 08:29:43 -0800 (PST)
In-Reply-To: <f687e6c4830e21db606db99b584864a61e5cf8c3.1290870042.git.nathan.panike@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162314>

Some minor nits (style) below.

On Thu, Nov 25, 2010 at 3:21 PM, Nathan W. Panike
<nathan.panike@gmail.com> wrote:
> The idea is that a project develops indigenous aliases that
> should be shared project-wide. =C2=A0The only way to communicate this
> now is by channels outside of git--email or IRC or such. We add
> support for the case where a project configuration can be in
> .gitconfig in the top level of the repository.
>
> Signed-off-by: Nathan W. Panike <nathan.panike@gmail.com>
> ---
> =C2=A0builtin/config.c | =C2=A0 =C2=A09 ++++++++-
> =C2=A0config.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 49 ++++++++++++++=
++++++++++++++++++++++++++++++++++-
> =C2=A02 files changed, 56 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/config.c b/builtin/config.c
> index ca4a0db..26c679d 100644
> --- a/builtin/config.c
> +++ b/builtin/config.c
> @@ -154,7 +154,7 @@ static int get_value(const char *key_, const char=
 *regex_)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int ret =3D -1;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0char *tl;
> - =C2=A0 =C2=A0 =C2=A0 char *global =3D NULL, *repo_config =3D NULL;
> + =C2=A0 =C2=A0 =C2=A0 char *global =3D NULL, *repo_config =3D NULL, =
*shared =3D NULL;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *system_wide =3D NULL, *local;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0local =3D config_exclusive_filename;
> @@ -165,6 +165,8 @@ static int get_value(const char *key_, const char=
 *regex_)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0global =3D xstrdup(mkpath("%s/.gitconfig", home));
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (git_config=
_system())
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0system_wide =3D git_etc_gitconfig();
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if(git_config_shar=
ed())
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 shared=3Dxstrdup(".gitconfig");
nit: add a space before and after the =3D

> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0key =3D xstrdup(key_);
> @@ -198,11 +200,15 @@ static int get_value(const char *key_, const ch=
ar *regex_)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0git_config_fro=
m_file(show_config, system_wide, NULL);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (do_all && global)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0git_config_fro=
m_file(show_config, global, NULL);
> + =C2=A0 =C2=A0 =C2=A0 if (do_all && shared)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git_config_from_sh=
ared_file(show_config, shared, NULL);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (do_all)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0git_config_fro=
m_file(show_config, local, NULL);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git_config_from_parameters(show_config, NU=
LL);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!do_all && !seen)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0git_config_fro=
m_file(show_config, local, NULL);
> + =C2=A0 =C2=A0 =C2=A0 if (!do_all && !seen && shared)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git_config_from_sh=
ared_file(show_config, shared, NULL);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!do_all && !seen && global)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0git_config_fro=
m_file(show_config, global, NULL);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!do_all && !seen && system_wide)
> @@ -222,6 +228,7 @@ static int get_value(const char *key_, const char=
 *regex_)
> =C2=A0free_strings:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0free(repo_config);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0free(global);
> + =C2=A0 =C2=A0 =C2=A0 free(shared);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;
> =C2=A0}
>
> diff --git a/config.c b/config.c
> index c63d683..a9e6bec 100644
> --- a/config.c
> +++ b/config.c
> @@ -795,6 +795,38 @@ int git_config_from_file(config_fn_t fn, const c=
har *filename, void *data)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;
> =C2=A0}
>
> +struct config_interceptor {
> + =C2=A0 =C2=A0 =C2=A0 config_fn_t fn;
> + =C2=A0 =C2=A0 =C2=A0 void* data;
> +};
> +
Would be good to add a description about what is this structure and wha=
t is for?

> +/*
> + * The purpose of this function is to keep a malicious contributor f=
rom
> + * poisoning our configuration. =C2=A0The idea of a shared configura=
tion it to
> + * pass around helpful stuff like aliases, but we do not want to all=
ow someone
> + * to say, change our email address or the url of the remote.
> + */
> +
> +static int config_interceptor_fn(const char*name, const char* value,=
 void* data)
> +{
> + =C2=A0 =C2=A0 =C2=A0 int ret=3D0;
nit: add space before and after the =3D

> + =C2=A0 =C2=A0 =C2=A0 struct config_interceptor *ci =3D (struct conf=
ig_interceptor*)data;
> + =C2=A0 =C2=A0 =C2=A0 if( !ci ) {
wrong, wrong.

I think the style used here is:

if (!ci) {

So, add a space after the if, and no spaces in the () please.

> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;
> + =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 if(!prefixcmp(name,"alias."))
same thing here about the space after the if

> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D (*ci->fn)(=
name,value,ci->data);
> + =C2=A0 =C2=A0 =C2=A0 return ret;
> +}
> +
> +int git_config_from_shared_file(config_fn_t fn,const char* filename,=
 void* data)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct config_interceptor ci;
> + =C2=A0 =C2=A0 =C2=A0 ci.fn=3Dfn;
nit: fix this too and the other occurrences below.
