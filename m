From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/16] list-files: command skeleton
Date: Thu, 12 Mar 2015 14:02:36 -0700
Message-ID: <xmqq1tku2akz.fsf@gitster.dls.corp.google.com>
References: <1425896314-10941-1-git-send-email-pclouds@gmail.com>
	<1425896314-10941-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, git@drmicha.warpmail.net
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 12 22:02:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YWAFh-00022N-Ol
	for gcvg-git-2@plane.gmane.org; Thu, 12 Mar 2015 22:02:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755838AbbCLVCl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Mar 2015 17:02:41 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:51778 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755749AbbCLVCj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Mar 2015 17:02:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0FE403FE5D;
	Thu, 12 Mar 2015 17:02:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Gnb9mVMZsnY9
	GVoaXL8Svc2iPM0=; b=vDWW+wouFiLlpkXuNPsxLAQik984ZHIrDMyb4H3PtBea
	eYnImTZ2cXWzMI8rOSebJQ+MiTB2DXnsaGZUeYKLXc8/o3NyPg/+EBoC4jtlA1LQ
	fpyP1XkWLXAKOViyes89IZYnvh3zVt5k5hW1eC/13us1MUHUXVL30VqicJYlUlE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=WbmfGX
	bN1Rz+8Gks7HnoNAouXSix1FEvzVBIt4lXJsJfpZxJF1/0c5yiLrWR2jr8dgX9Qg
	Hqzf92aOtxFzIrPW4rg+Ni1m3rtqTozoxpbIUDB8QqhvEqwSrVyRdYcRLWb7YvRU
	2OPUQ56SCFb83jHAryMIZeWMwvTebbx0qv7Hs=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0900D3FE5A;
	Thu, 12 Mar 2015 17:02:39 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D0F1D3FE58;
	Thu, 12 Mar 2015 17:02:37 -0400 (EDT)
In-Reply-To: <1425896314-10941-2-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Mon, 9 Mar
 2015 17:18:19 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1D1C48A6-C8FB-11E4-9C83-A2259F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265370>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> list-files is supposed to be the user friendly version of ls-files, o=
r
> an alternative to git-status. Nothing fancy in this patch yet.

The result of applying this patch alone will not give us anything
fancy, but the patch itself is interesting ;-)

> +static void populate_cached_entries(struct string_list *result,
> +				    const struct index_state *istate)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < istate->cache_nr; i++) {
> +		const struct cache_entry *ce =3D istate->cache[i];
> +
> +		if (!match_pathspec(&pathspec, ce->name, ce_namelen(ce),
> +				    0, NULL,
> +				    S_ISDIR(ce->ce_mode) ||
> +				    S_ISGITLINK(ce->ce_mode)))

Because we won't tell the user "You gave me Mkaefile but that did
not match" when "git list-files Mkaefile" does not produce anything,
we do not need to pass seen[] down from here.

> +	prefix =3D cmd_prefix;
> +	if (prefix)
> +		prefix_length =3D strlen(prefix);
> +
> +	if (read_cache() < 0)
> +		die(_("index file corrupt"));
> +
> +	git_config(ls_config, NULL);
> +
> +	argc =3D parse_options(argc, argv, prefix, ls_options, ls_usage, 0)=
;
> +
> +	parse_pathspec(&pathspec, 0,
> +		       PATHSPEC_PREFER_CWD |
> +		       PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP,
> +		       cmd_prefix, argv);
> +	pathspec.max_depth =3D 0;
> +	pathspec.recursive =3D 1;
> +
> +	refresh_index(&the_index, REFRESH_QUIET | REFRESH_UNMERGED,
> +		      &pathspec, NULL, NULL);

It would be better to do read-cache-preload, instead of read-cache,
if you are going to immediately refresh.  That is what "git status"
does.

> +	populate_cached_entries(&result, &the_index);
> +	display(&result);
> +	string_list_clear(&result, 0);
> +	return 0;
> +}
> diff --git a/git.c b/git.c
> index 18fbf79..ae7fe77 100644
> --- a/git.c
> +++ b/git.c
> @@ -418,6 +418,7 @@ static struct cmd_struct commands[] =3D {
>  	{ "init", cmd_init_db, NO_SETUP },
>  	{ "init-db", cmd_init_db, NO_SETUP },
>  	{ "interpret-trailers", cmd_interpret_trailers, RUN_SETUP },
> +	{ "list-files", cmd_list_files, RUN_SETUP | USE_PAGER | NEED_WORK_T=
REE },

Thanks.
