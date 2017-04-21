Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83148207BD
	for <e@80x24.org>; Fri, 21 Apr 2017 02:17:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034542AbdDUCRB (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 22:17:01 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55791 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1034478AbdDUCRB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 22:17:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D82A17F9AD;
        Thu, 20 Apr 2017 22:16:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=2dMHBzuWT37s
        PQYadFi6lwUzh9E=; b=jTZcuD1YphWwNzNoIWMJAEu8Z8m1WU8tgHQVHa/VS4v9
        gQo5bpeOpE70rqon+ZaOXCXBPa/xR9b9N+T/plLOpBTWFPjtjSz1RQM5jhyZjvHG
        +WXEDKRIZZRNE8LqKYMAe8kYrNW8NImt/ulaZHt0PRjStVo6ds42jGya5l/oLXs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=AHhI1G
        9jTNafw1A4qZES2FtxoJ9CJCcdxyNLVMJPjM40akKnAQclXDYKWVtYSnHFLIDQG5
        gxswECLoa0a06oFTi1rN9bCb3oURPqm3MYpOmNI6D9XKZev3vmMXPgputlgP1yTk
        VLeSci608M/PjDux5DAscxIS9VAMK6ium6jk0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CF9447F9AC;
        Thu, 20 Apr 2017 22:16:59 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3C0E77F9AB;
        Thu, 20 Apr 2017 22:16:59 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/6] worktree.c: add validate_worktree()
References: <20170420101024.7593-1-pclouds@gmail.com>
        <20170420101024.7593-2-pclouds@gmail.com>
Date:   Thu, 20 Apr 2017 19:16:57 -0700
In-Reply-To: <20170420101024.7593-2-pclouds@gmail.com> (=?utf-8?B?Ik5ndXk=?=
 =?utf-8?B?4buFbiBUaMOhaSBOZ+G7jWM=?=
        Duy"'s message of "Thu, 20 Apr 2017 17:10:19 +0700")
Message-ID: <xmqqh91i7bdy.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 9973C9A0-2638-11E7-AC38-C260AE2156B6-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> This function is later used by "worktree move" and "worktree remove"
> to ensure that we have a good connection between the repository and
> the worktree. For example, if a worktree is moved manually, the
> worktree location recorded in $GIT_DIR/worktrees/.../gitdir is
> incorrect and we should not move that one.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
.com>
> ---
>  worktree.c | 66 ++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
>  worktree.h |  5 +++++
>  2 files changed, 71 insertions(+)
>
> diff --git a/worktree.c b/worktree.c
> index bae787cf8d..40cc031ac9 100644
> --- a/worktree.c
> +++ b/worktree.c
> @@ -294,6 +294,72 @@ const char *is_worktree_locked(struct worktree *wt=
)
>  	return wt->lock_reason;
>  }
> =20
> +static int report(int quiet, const char *fmt, ...)
> +{
> +	va_list params;
> +
> +	if (quiet)
> +		return -1;
> +
> +	va_start(params, fmt);
> +	vfprintf(stderr, fmt, params);
> +	fputc('\n', stderr);
> +	va_end(params);
> +	return -1;
> +}
> +
> +int validate_worktree(const struct worktree *wt, int quiet)
> +{
> +	struct strbuf sb =3D STRBUF_INIT;
> +	char *path;
> +	int err, ret;
> +
> +	if (is_main_worktree(wt)) {
> +		/*
> +		 * Main worktree using .git file to point to the
> +		 * repository would make it impossible to know where
> +		 * the actual worktree is if this function is executed
> +		 * from another worktree. No .git file support for now.
> +		 */
> +		strbuf_addf(&sb, "%s/.git", wt->path);
> +		if (!is_directory(sb.buf)) {
> +			strbuf_release(&sb);
> +			return report(quiet, _("'%s/.git' at main worktree is not the repos=
itory directory"),
> +				      wt->path);

These messages come without telling what they are.  Should they say
that these are errors?  Or does the severity depend on the caller,
i.e. why they want to know if a particular worktree is valid, and
sometimes these are errors and other times they are mere warnings?

> +		}
> +		return 0;
> +	}
> +
> +	/*
> +	 * Make sure "gitdir" file points to a real .git file and that
> +	 * file points back here.
> +	 */
> +	if (!is_absolute_path(wt->path))
> +		return report(quiet, _("'%s' file does not contain absolute path to =
the worktree location"),
> +			      git_common_path("worktrees/%s/gitdir", wt->id));

It makes me wonder if this kind of error reporting belongs to the
place where these are read (and a new wt is written out to the
filesystem, perhaps).  The programmer who wrote this code may have
known that wt->path is prepared by reading "worktrees/%s/gitdir" and
without doing real_path() or absolute_path() on the result when this
code was written, but nothing guarantees that to stay true over time
as the code evolves.

> +	strbuf_addf(&sb, "%s/.git", wt->path);
> +	if (!file_exists(sb.buf)) {
> +		strbuf_release(&sb);
> +		return report(quiet, _("'%s/.git' does not exist"), wt->path);
> +	}
> +
> +	path =3D xstrdup_or_null(read_gitfile_gently(sb.buf, &err));
> +	strbuf_release(&sb);
> +	if (!path)
> +		return report(quiet, _("'%s/.git' is not a .git file, error code %d"=
),
> +			      wt->path, err);

The above should do, at least for now.  It is unfortunate that no
existing code needs to turn READ_GITFILE_ERR_* into human readble
error message.

> +	ret =3D fspathcmp(path, real_path(git_common_path("worktrees/%s", wt-=
>id)));
> +	free(path);
> +
> +	if (ret)
> +		return report(quiet, _("'%s' does not point back to '%s'"),
> +			      wt->path, git_common_path("worktrees/%s", wt->id));
> +
> +	return 0;
> +}
> +
>  int is_worktree_being_rebased(const struct worktree *wt,
>  			      const char *target)
>  {
> diff --git a/worktree.h b/worktree.h
> index 6bfb985203..33f7405e33 100644
> --- a/worktree.h
> +++ b/worktree.h
> @@ -58,6 +58,11 @@ extern int is_main_worktree(const struct worktree *w=
t);
>  extern const char *is_worktree_locked(struct worktree *wt);
> =20
>  /*
> + * Return zero if the worktree is in good condition.
> + */
> +extern int validate_worktree(const struct worktree *wt, int quiet);
> +
> +/*
>   * Free up the memory for worktree(s)
>   */
>  extern void free_worktrees(struct worktree **);
