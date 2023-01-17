Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 552ECC3DA78
	for <git@archiver.kernel.org>; Tue, 17 Jan 2023 13:19:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236479AbjAQNTE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Jan 2023 08:19:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237098AbjAQNS1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2023 08:18:27 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F363A587
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 05:18:26 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id m21so45001713edc.3
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 05:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KuSd9iqWepNg+bOiCXu6p8743JxEGRVI/7wV6sOl4Qw=;
        b=IKa0992t3kDzRP7NEmn9ZBRwpIgxbYU+DUWsDYbK0xozqfoh1WW+lkXFzQUlAwaIeK
         Fdl0Nk4h8Jxvp9CHAqgMH+gpq9lXYRq5M1XF0uA8zy+97++ToBYgM6ghbzsj7saVAEkB
         SClPwNnuVUWAXvzsDtp8DPBBKyIDaVA1FFNxgJOKGhfyDbG2M5Eu5h/qjbtXzNcxpmH5
         zzPcU1B6S/EmWDU4IsEwhfFwp6rHT+rEqnzFObDCfaZCNVfk2DHznDvij67EjyYMnLWc
         yALzskR9IxGJoLj+xHjaC1u5IswA+WP4mIWB97K30T7Y5Zk3ttCfKCtbyM981H3lcDl7
         IlYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KuSd9iqWepNg+bOiCXu6p8743JxEGRVI/7wV6sOl4Qw=;
        b=QM3dpbm57BMTSCwSmPC/Ix54tffL3+Fkx7+X1LrZGkOZYT5TZrrsGg0mlAAzSavDH0
         wmYHiwol6qNjSvgAx6NV+BvGLkN5vcJ+AU93pN3NLHhDF8T3XOGnyseEZwMxmUX1nOJ/
         HPBjLrAX6wT04vnM09Z4qK9oARlBZ5etw1amU5LEzYl+DPwbVZ9ZZ05M1uQos53xNMiM
         NMka/pz2H0vzOUN7ghXq2Tyq4d3qAq6hrUz49qa7nbFgVC/Yy+7ORe6I4QjO9jlY06pl
         J4cG86gVIGTK5xqld5AoxapP748rQVz4P0wYcNap9ZeNarCnXRTg7V4lTztDC/aSh3WD
         v+Lg==
X-Gm-Message-State: AFqh2krz9htYtVCr0ttc6syNE4eg/E/BCZQk/2MVywMDYPUfIYpAOlDr
        a9kz8qRfisEdCn2pTKF/1tSMAKnBVCQ=
X-Google-Smtp-Source: AMrXdXsGiNLZeCe8EbRK6IwCvZkQr67HBvbuJ+/qJG5BUzBqJNHqDYfuqksJzKPjIZmizT76Sa966A==
X-Received: by 2002:a05:6402:120a:b0:472:d867:4c3d with SMTP id c10-20020a056402120a00b00472d8674c3dmr13746651edw.40.1673961504361;
        Tue, 17 Jan 2023 05:18:24 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id b20-20020aa7c6d4000000b004610899742asm12793348eds.13.2023.01.17.05.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 05:18:23 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pHlr5-002eDl-0B;
        Tue, 17 Jan 2023 14:18:23 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Christian Couder <christian.couder@gmail.com>,
        Jeff King <peff@peff.net>, ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH 2/2] [RFC] push: allow delete one level ref
Date:   Tue, 17 Jan 2023 14:14:59 +0100
References: <pull.1465.git.1673951562.gitgitgadget@gmail.com>
 <605b95bf8ab6f1fb5b1ec5b75cd4dcaefbb7f3b6.1673951562.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <605b95bf8ab6f1fb5b1ec5b75cd4dcaefbb7f3b6.1673951562.git.gitgitgadget@gmail.com>
Message-ID: <230117.861qntz4dc.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jan 17 2023, ZheNing Hu via GitGitGadget wrote:

> From: ZheNing Hu <adlternative@gmail.com>
>
> Git will reject the deletion of one level refs e,g. "refs/foo"
> through "git push -d", however, some users want to be able to
> clean up these branches that were created unexpectedly on the
> remote.
>
> Therefore, when updating branches on the server with
> "git receive-pack", by checking whether it is a branch deletion
> operation, it will determine whether to allow the update of
> one level refs. This avoids creating/updating such one level
> branches, but allows them to be deleted.
>
> On the client side, "git push" also does not properly fill in
> the old-oid of one level refs, which causes the server-side
> "git receive-pack" to think that the ref's old-oid has changed
> when deleting one level refs, this causes the push to be rejected.
>
> So the solution is to fix the client to be able to delete
> one level refs by properly filling old-oid.
>
> Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> ---
>  builtin/receive-pack.c |  5 ++++-
>  connect.c              |  2 +-
>  t/t5516-fetch-push.sh  | 13 +++++++++++++
>  3 files changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index 13ff9fae3ba..ad21877ea1b 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -1463,7 +1463,10 @@ static const char *update(struct command *cmd, struct shallow_info *si)
>  		find_shared_symref(worktrees, "HEAD", name);
>  
>  	/* only refs/... are allowed */
> -	if (!starts_with(name, "refs/") || check_refname_format(name + 5, 0)) {
> +	if (!starts_with(name, "refs/") ||
> +	    check_refname_format(name + 5,
> +				 is_null_oid(new_oid) ?
> +				 REFNAME_ALLOW_ONELEVEL : 0)) {

Style nit: We tend to wrap at 79 characters, adn with argument lists you
"keep going" until you hit that limit.

In this case strictly following that rule will lead to funny
indentation, as we'll have to wrap at "is_null_oid(...)" etc.

But even when avoiding that (which seems good in this case) this should
be:

	if (!starts_with(name, "refs/") ||
	    check_refname_format(name + 5, is_null_oid(new_oid) ?
				 REFNAME_ALLOW_ONELEVEL : 0)) {



>  		rp_error("refusing to update funny ref '%s' remotely", name);
>  		ret = "funny refname";
>  		goto out;
> diff --git a/connect.c b/connect.c
> index 63e59641c0d..b841ae58e03 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -30,7 +30,7 @@ static int check_ref(const char *name, unsigned int flags)
>  		return 0;
>  
>  	/* REF_NORMAL means that we don't want the magic fake tag refs */
> -	if ((flags & REF_NORMAL) && check_refname_format(name, 0))
> +	if ((flags & REF_NORMAL) && check_refname_format(name, REFNAME_ALLOW_ONELEVEL))

Here we should wrap after "name,", we end up with a too-long line.

>  		return 0;
>  
>  	/* REF_HEADS means that we want regular branch heads */
> diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
> index f37861efc40..dec8950a392 100755
> --- a/t/t5516-fetch-push.sh
> +++ b/t/t5516-fetch-push.sh
> @@ -903,6 +903,19 @@ test_expect_success 'push --delete refuses empty string' '
>  	test_must_fail git push testrepo --delete ""
>  '
>  
> +test_expect_success 'push --delete onelevel refspecs' '
> +	mk_test testrepo heads/main &&
> +	(
> +		cd testrepo &&
> +		git update-ref refs/onelevel refs/heads/main
> +	) &&

Avoid the subshell here with:

	git -C update-ref ....

> +	git push testrepo --delete refs/onelevel &&
> +	(
> +		cd testrepo &&
> +		test_must_fail git rev-parse --verify refs/onelevel

Ditto.
