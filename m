Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2957207BD
	for <e@80x24.org>; Fri, 21 Apr 2017 02:23:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034492AbdDUCWx (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 22:22:53 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56184 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1034689AbdDUCWw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 22:22:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 96BF27C029;
        Thu, 20 Apr 2017 22:22:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=oR1wWNbjiQy+
        //qV5ipyykYtY30=; b=EHPXoQAal5SjJliYJ2E5n9OZnf1K+cyW+MTE5KNGyVck
        WPg+d13/N8ANVjoDxSiZIsMPTiMSAwoeTTDxbp0z8Ngwm7zoHsdqDoG7Jae+OrlR
        cM7AhKacO4ikkwHUFDDJlGFYAGstA1UODPWjEB5hfaRu6uNc2/73sSVumkD1rLs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=g9zAC7
        eCwyLsUqoeDJ2zvJjAOahP6Kc9YIXWfLmY2RfTcmUX8DVVrmayPlufvL6VWEyPc4
        MwWewuawb5kg9a+UCM1cc1P2PGEhHvVIY/Wel+Mhftau+bsMxT/nR/yjs0yXszRG
        QpKrUx4XV3XdlSzBTRqciScSFe0+C06wzCSGc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8CFFC7C028;
        Thu, 20 Apr 2017 22:22:45 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F186D7C027;
        Thu, 20 Apr 2017 22:22:44 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/6] worktree.c: add update_worktree_location()
References: <20170420101024.7593-1-pclouds@gmail.com>
        <20170420101024.7593-3-pclouds@gmail.com>
Date:   Thu, 20 Apr 2017 19:22:43 -0700
In-Reply-To: <20170420101024.7593-3-pclouds@gmail.com> (=?utf-8?B?Ik5ndXk=?=
 =?utf-8?B?4buFbiBUaMOhaSBOZ+G7jWM=?=
        Duy"'s message of "Thu, 20 Apr 2017 17:10:20 +0700")
Message-ID: <xmqqd1c67b4c.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6787AB22-2639-11E7-B692-E680B56B9B0B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
.com>
> ---
>  worktree.c | 21 +++++++++++++++++++++
>  worktree.h |  6 ++++++
>  2 files changed, 27 insertions(+)
>
> diff --git a/worktree.c b/worktree.c
> index 40cc031ac9..c695dcf982 100644
> --- a/worktree.c
> +++ b/worktree.c
> @@ -360,6 +360,27 @@ int validate_worktree(const struct worktree *wt, i=
nt quiet)
>  	return 0;
>  }
> =20
> +int update_worktree_location(struct worktree *wt, const char *path_)
> +{
> +	struct strbuf path =3D STRBUF_INIT;
> +	int ret =3D 0;
> +
> +	if (is_main_worktree(wt))
> +		return 0;

There is no "refusing to move main worktree location" error message
issued?  Perhaps it is done elsewhere and this is merely for an
added safety (in which case it is OK)?

> +
> +	strbuf_add_absolute_path(&path, path_);
> +	if (fspathcmp(wt->path, path.buf)) {
> +		write_file(git_common_path("worktrees/%s/gitdir",
> +					   wt->id),
> +			   "%s/.git", real_path(path.buf));
> +		free(wt->path);
> +		wt->path =3D strbuf_detach(&path, NULL);
> +		ret =3D 0;
> +	}
> +	strbuf_release(&path);
> +	return ret;
> +}

Does anybody set "ret" to anything but 0 in this function?  It is
unclear what the return value from this function means in the first
place, but I am assuming that this is meant to follow the usual
convention of 0 for success and negative for error, in which case
the "return early if this is the primary one" would want to return
-1, I guess.

>  int is_worktree_being_rebased(const struct worktree *wt,
>  			      const char *target)
>  {
> diff --git a/worktree.h b/worktree.h
> index 33f7405e33..b896bdec55 100644
> --- a/worktree.h
> +++ b/worktree.h
> @@ -63,6 +63,12 @@ extern const char *is_worktree_locked(struct worktre=
e *wt);
>  extern int validate_worktree(const struct worktree *wt, int quiet);
> =20
>  /*
> + * Update worktrees/xxx/gitdir with the new path.
> + */
> +extern int update_worktree_location(struct worktree *wt,
> +				    const char *path_);
> +
> +/*
>   * Free up the memory for worktree(s)
>   */
>  extern void free_worktrees(struct worktree **);
