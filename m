From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] Another reroll of sb/submodule-init
Date: Mon, 18 Apr 2016 12:30:15 -0700
Message-ID: <xmqq1t6267g8.fsf@gitster.mtv.corp.google.com>
References: <1460767813-25916-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, pclouds@gmail.com, j6t@kdbg.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Mon Apr 18 21:30:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asEsJ-0002FL-8z
	for gcvg-git-2@plane.gmane.org; Mon, 18 Apr 2016 21:30:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751533AbcDRTaU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 Apr 2016 15:30:20 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64331 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751405AbcDRTaT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Apr 2016 15:30:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C9F271431E;
	Mon, 18 Apr 2016 15:30:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=s7/Fgm0wfjkQ
	RHLnpYMrGU7CsU4=; b=yLX7D0qYZ6ESV7kBmqOJvPJIvL52tVvj4J6MxMON1/tw
	eX5a7oIrrjHHzSOLLmmMR7vnV59mcU8edetskK3c+ilIpdIH++er7DVanNEclbHI
	o89uK1oIPn9IIZwj1nVbOYdLNhhcCJlHIq7G3GSEBveDTCraP1az8dngNC8k28U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=qqDl5v
	vcD5Frw5MgP1wTBeqogpLB5BO+Iq4LGuVvgsfysvo4V/qOGKfGzRSCdS802ozihO
	uuOQa1Qg5RYBnyP3aXpmCCmvlHIYdnmebkCI/rDEVdGuFiYeZUAcr94QT8IYZz/K
	j0dJ5HNaQEymHC3LBLi3Ck0Iu19nESKm1OMrE=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BFD771431D;
	Mon, 18 Apr 2016 15:30:17 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1968E1431C;
	Mon, 18 Apr 2016 15:30:17 -0400 (EDT)
In-Reply-To: <1460767813-25916-1-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Fri, 15 Apr 2016 17:50:11 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: FB09A3F6-059B-11E6-B526-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291821>

Stefan Beller <sbeller@google.com> writes:

> * squashed the fixes from Johannes Sixt to unbreak Windows tests.
>   (I had encoding issues; so I manually integrated the changes)
> * fixed memleaks
> * the base to apply did not change (ee30f17805f51d37 Merge branch
> 'sb/submodule-path-misc-bugs' into sb/submodule-init)
>
> Thanks,
> Stefan

Queued.  I read it twice and I think this is ready for 'next'.

Comments from others?

>
> diff to current origin/sb/submodule-init:
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.=
c
> index ad3cba6..b6d4f27 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -309,8 +309,7 @@ static void init_submodule(const char *path, cons=
t char *prefix, int quiet)
>  {
>  	const struct submodule *sub;
>  	struct strbuf sb =3D STRBUF_INIT;
> -	const char *upd =3D NULL;
> -	char *url =3D NULL, *displaypath;
> +	char *upd =3D NULL, *url =3D NULL, *displaypath;
> =20
>  	/* Only loads from .gitmodules, no overlay with .git/config */
>  	gitmodules_config();
> @@ -340,7 +339,7 @@ static void init_submodule(const char *path, cons=
t char *prefix, int quiet)
>  		/* Possibly a url relative to parent */
>  		if (starts_with_dot_dot_slash(url) ||
>  		    starts_with_dot_slash(url)) {
> -			char *remoteurl;
> +			char *remoteurl, *relurl;
>  			char *remote =3D get_default_remote();
>  			struct strbuf remotesb =3D STRBUF_INIT;
>  			strbuf_addf(&remotesb, "remote.%s.url", remote);
> @@ -352,9 +351,11 @@ static void init_submodule(const char *path, con=
st char *prefix, int quiet)
>  				 * authoritative upstream
>  				 */
>  				remoteurl =3D xgetcwd();
> -			url =3D relative_url(remoteurl, url, NULL);
> +			relurl =3D relative_url(remoteurl, url, NULL);
>  			strbuf_release(&remotesb);
>  			free(remoteurl);
> +			free(url);
> +			url =3D relurl;
>  		}
> =20
>  		if (git_config_set_gently(sb.buf, url))
> @@ -368,14 +369,14 @@ static void init_submodule(const char *path, co=
nst char *prefix, int quiet)
>  	/* Copy "update" setting when it is not set yet */
>  	strbuf_reset(&sb);
>  	strbuf_addf(&sb, "submodule.%s.update", sub->name);
> -	if (git_config_get_string_const(sb.buf, &upd) &&
> +	if (git_config_get_string(sb.buf, &upd) &&
>  	    sub->update_strategy.type !=3D SM_UPDATE_UNSPECIFIED) {
>  		if (sub->update_strategy.type =3D=3D SM_UPDATE_COMMAND) {
>  			fprintf(stderr, _("warning: command update mode suggested for sub=
module '%s'\n"),
>  				sub->name);
> -			upd =3D "none";
> +			upd =3D xstrdup("none");
>  		} else
> -			upd =3D submodule_strategy_to_string(&sub->update_strategy);
> +			upd =3D xstrdup(submodule_strategy_to_string(&sub->update_strateg=
y));
> =20
>  		if (git_config_set_gently(sb.buf, upd))
>  			die(_("Failed to register update mode for submodule path '%s'"), =
displaypath);
> @@ -383,6 +384,7 @@ static void init_submodule(const char *path, cons=
t char *prefix, int quiet)
>  	strbuf_release(&sb);
>  	free(displaypath);
>  	free(url);
> +	free(upd);
>  }
> =20
>  static int module_init(int argc, const char **argv, const char *pref=
ix)
> diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
> index 2e62548..bf2deee 100755
> --- a/t/t0060-path-utils.sh
> +++ b/t/t0060-path-utils.sh
> @@ -305,13 +305,16 @@ test_git_path GIT_COMMON_DIR=3Dbar config      =
             bar/config
>  test_git_path GIT_COMMON_DIR=3Dbar packed-refs              bar/pack=
ed-refs
>  test_git_path GIT_COMMON_DIR=3Dbar shallow                  bar/shal=
low
> =20
> +# In the tests below, the distinction between $PWD and $(pwd) is imp=
ortant:
> +# on Windows, $PWD is POSIX style (/c/foo), $(pwd) has drive letter =
(c:/foo).
> +
>  test_submodule_relative_url "../" "../foo" "../submodule" "../../sub=
module"
>  test_submodule_relative_url "../" "../foo/bar" "../submodule" "../..=
/foo/submodule"
>  test_submodule_relative_url "../" "../foo/submodule" "../submodule" =
"../../foo/submodule"
>  test_submodule_relative_url "../" "./foo" "../submodule" "../submodu=
le"
>  test_submodule_relative_url "../" "./foo/bar" "../submodule" "../foo=
/submodule"
>  test_submodule_relative_url "../../../" "../foo/bar" "../sub/a/b/c" =
"../../../../foo/sub/a/b/c"
> -test_submodule_relative_url "../" "$PWD/addtest" "../repo" "$PWD/rep=
o"
> +test_submodule_relative_url "../" "$PWD/addtest" "../repo" "$(pwd)/r=
epo"
>  test_submodule_relative_url "../" "foo/bar" "../submodule" "../foo/s=
ubmodule"
>  test_submodule_relative_url "../" "foo" "../submodule" "../submodule=
"
> =20
> @@ -322,16 +325,16 @@ test_submodule_relative_url "(null)" "../foo" "=
=2E./submodule" "../submodule"
>  test_submodule_relative_url "(null)" "./foo/bar" "../submodule" "foo=
/submodule"
>  test_submodule_relative_url "(null)" "./foo" "../submodule" "submodu=
le"
>  test_submodule_relative_url "(null)" "//somewhere else/repo" "../sub=
repo" "//somewhere else/subrepo"
> -test_submodule_relative_url "(null)" "$PWD/subsuper_update_r" "../su=
bsubsuper_update_r" "$PWD/subsubsuper_update_r"
> -test_submodule_relative_url "(null)" "$PWD/super_update_r2" "../subs=
uper_update_r" "$PWD/subsuper_update_r"
> -test_submodule_relative_url "(null)" "$PWD/." "../." "$PWD/."
> -test_submodule_relative_url "(null)" "$PWD" "./." "$PWD/."
> -test_submodule_relative_url "(null)" "$PWD/addtest" "../repo" "$PWD/=
repo"
> -test_submodule_relative_url "(null)" "$PWD" "./=C3=A5 =C3=A4=C3=B6" =
"$PWD/=C3=A5 =C3=A4=C3=B6"
> -test_submodule_relative_url "(null)" "$PWD/." "../submodule" "$PWD/s=
ubmodule"
> -test_submodule_relative_url "(null)" "$PWD/submodule" "../submodule"=
 "$PWD/submodule"
> -test_submodule_relative_url "(null)" "$PWD/home2/../remote" "../bund=
le1" "$PWD/home2/../bundle1"
> -test_submodule_relative_url "(null)" "$PWD/submodule_update_repo" ".=
/." "$PWD/submodule_update_repo/."
> +test_submodule_relative_url "(null)" "$PWD/subsuper_update_r" "../su=
bsubsuper_update_r" "$(pwd)/subsubsuper_update_r"
> +test_submodule_relative_url "(null)" "$PWD/super_update_r2" "../subs=
uper_update_r" "$(pwd)/subsuper_update_r"
> +test_submodule_relative_url "(null)" "$PWD/." "../." "$(pwd)/."
> +test_submodule_relative_url "(null)" "$PWD" "./." "$(pwd)/."
> +test_submodule_relative_url "(null)" "$PWD/addtest" "../repo" "$(pwd=
)/repo"
> +test_submodule_relative_url "(null)" "$PWD" "./=C3=A5 =C3=A4=C3=B6" =
"$(pwd)/=C3=A5 =C3=A4=C3=B6"
> +test_submodule_relative_url "(null)" "$PWD/." "../submodule" "$(pwd)=
/submodule"
> +test_submodule_relative_url "(null)" "$PWD/submodule" "../submodule"=
 "$(pwd)/submodule"
> +test_submodule_relative_url "(null)" "$PWD/home2/../remote" "../bund=
le1" "$(pwd)/home2/../bundle1"
> +test_submodule_relative_url "(null)" "$PWD/submodule_update_repo" ".=
/." "$(pwd)/submodule_update_repo/."
>  test_submodule_relative_url "(null)" "file:///tmp/repo" "../subrepo"=
 "file:///tmp/subrepo"
>  test_submodule_relative_url "(null)" "foo/bar" "../submodule" "foo/s=
ubmodule"
>  test_submodule_relative_url "(null)" "foo" "../submodule" "submodule=
"
>
>
> Stefan Beller (2):
>   submodule: port resolve_relative_url from shell to C
>   submodule: port init from shell to C
>
>  builtin/submodule--helper.c | 324 ++++++++++++++++++++++++++++++++++=
+++++++++-
>  git-submodule.sh            | 127 +----------------
>  submodule.c                 |  21 +++
>  submodule.h                 |   1 +
>  t/t0060-path-utils.sh       |  46 +++++++
>  5 files changed, 397 insertions(+), 122 deletions(-)
