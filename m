Return-Path: <SRS0=Vx3J=3N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E6B6C2D0DB
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 18:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AE232075D
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 18:30:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="sesA94RH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391358AbgAXSax (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jan 2020 13:30:53 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61314 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389746AbgAXSax (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jan 2020 13:30:53 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 20619410AB;
        Fri, 24 Jan 2020 13:30:51 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=3NlZEgXRBhww
        QoFFU/2BPRdbQZw=; b=sesA94RHmbFFwk9AZsCypPHvRlWgnW9flGzVCOXm+BJk
        M0LojvU+8hALsgADbDaSHTezbNgjAJZbUlq5ENuCBCKbX92GBC016FVSF7mArv9M
        5q7+z4scMdDgX9LXgaWx3zTi2E/ctefJ7KRFkHn9ZiHGM6AOc9f28gKN94tOOSE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=K6a73e
        FJopDfN514WkxoPDeDAoBm7WqsXLfDqkqnnbXtckhN+gfoLhV1kKO1X2r5okEXYs
        fiamjnxqXvFSFd1jTrMYX1jjpzhzoaOzM0JlN9IptC5jJJgU2PeztKZ3bvFFGnUJ
        rE6hGHo8kXmjEOQ7/OoALofFDDBEGYh897ItA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DAE1D410AA;
        Fri, 24 Jan 2020 13:30:50 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 16B49410A9;
        Fri, 24 Jan 2020 13:30:49 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        =?utf-8?B?w4Z2?= =?utf-8?B?YXIgQXJuZmrDtnLDsA==?= 
        <avarab@gmail.com>, Eugeniu Rosca <erosca@de.adit-jv.com>,
        Jeff King <peff@peff.net>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3] rebase -i: stop checking out the tip of the branch to rebase
References: <20200124144545.12984-1-alban.gruin@gmail.com>
        <20200124150500.15260-1-alban.gruin@gmail.com>
Date:   Fri, 24 Jan 2020 10:30:48 -0800
In-Reply-To: <20200124150500.15260-1-alban.gruin@gmail.com> (Alban Gruin's
        message of "Fri, 24 Jan 2020 16:05:00 +0100")
Message-ID: <xmqqk15g1zc7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A5591D50-3ED7-11EA-AA9D-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alban Gruin <alban.gruin@gmail.com> writes:

> On big repositories, it's a performance penalty: with `rebase -i', the
> user may have to wait before editing the todo list while git is
> extracting the branch silently, and "quiet" rebases will be slower than
> `am'.
>
> Since we already have the oid of the tip of the branch in
> `opts->orig_head', it's useless to switch to this commit.
> ...
>   Before this patch:
>
>     $ time git rebase -m --onto v4.18 463fa44eec2fef50~ 463fa44eec2fef5=
0
>
>     real    0m8,940s
>     user    0m6,830s
>     sys     0m2,121s
>
>   After this patch:
>
>     $ time git rebase -m --onto v4.18 463fa44eec2fef50~ 463fa44eec2fef5=
0
>
>     real    0m1,834s
>     user    0m0,916s
>     sys     0m0,206s
>
> Reported-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
> ---

Good.

> diff --git a/sequencer.c b/sequencer.c
> index b9dbf1adb0..4dc245d7ec 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -3715,20 +3715,6 @@ static int run_git_checkout(struct repository *r=
, struct replay_opts *opts,
>  	return ret;
>  }
> =20
> -int prepare_branch_to_be_rebased(struct repository *r, struct replay_o=
pts *opts,
> -				 const char *commit)
> -{
> -	const char *action;
> -
> -	if (commit && *commit) {
> -		action =3D reflog_message(opts, "start", "checkout %s", commit);
> -		if (run_git_checkout(r, opts, commit, action))
> -			return error(_("could not checkout %s"), commit);
> -	}
> -
> -	return 0;
> -}
> -
>  static int checkout_onto(struct repository *r, struct replay_opts *opt=
s,
>  			 const char *onto_name, const struct object_id *onto,
>  			 const char *orig_head)
> diff --git a/sequencer.h b/sequencer.h
> index 9f9ae291e3..74f1e2673e 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -190,9 +190,6 @@ void commit_post_rewrite(struct repository *r,
>  			 const struct commit *current_head,
>  			 const struct object_id *new_head);
> =20
> -int prepare_branch_to_be_rebased(struct repository *r, struct replay_o=
pts *opts,
> -				 const char *commit);
> -
>  #define SUMMARY_INITIAL_COMMIT   (1 << 0)
>  #define SUMMARY_SHOW_AUTHOR_DATE (1 << 1)
>  void print_commit_summary(struct repository *repo,

Nice to see this helper to go.

Thanks.
