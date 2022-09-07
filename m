Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 372A1C54EE9
	for <git@archiver.kernel.org>; Wed,  7 Sep 2022 16:38:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbiIGQiT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Sep 2022 12:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiIGQiS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2022 12:38:18 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C405A2865
        for <git@vger.kernel.org>; Wed,  7 Sep 2022 09:38:17 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id t3so10071255ply.2
        for <git@vger.kernel.org>; Wed, 07 Sep 2022 09:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=HwM61GFLuqIF35rAyPgc2xUxA3HjK5LaOYCsKT3EOcM=;
        b=nuMo+asi3FGoTT0HRCNcd27ZFk0Z11HZuE4VAOG8K1Sr1QK68LjCu6MNBT1xi3Pvcn
         EbteIrEVT5nJPpJWyTwHPsqnPD2NAf+nocnPF1ZHj0G1320td6hLJ09mivAnFZ7mZj2s
         JGiRlPULVVd/BR9Nq1NUX05laXyW2qqsh+XdJYboLElF+Z7oZtgfTCBfWH9iwSrTW8E5
         mgpDPbAUX8Aq5rdARF2lVQHgQ4JGxfF2I6StJMMaRzFgOQS0WFikXzwEvTLwqiLDVclU
         +KQgsmtEk7Ln3QNzi66hnMXp4FGiU62MZHjXj60k1z4u04cBYkl/mlPVaB13m+I/ohWw
         Aaqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date;
        bh=HwM61GFLuqIF35rAyPgc2xUxA3HjK5LaOYCsKT3EOcM=;
        b=LzUqphpmgq4KcpvhqfRG1nDyQ0bNBV7N3Mmx0msufhnB3kQqjKzjBO1Kwv6GntjB/2
         BmzAikTYQ213p8FI2Hm77acz+Lh//JxspERJiiLepkaiqCKdomj48s6Ne5NU5WRZ6gYQ
         c54OZ2W0uevXEDfBEkpUQncVhhaOuL1aI1pbfr7sSfgj8/xPPxNRHLfDJVGQDjLxJwNQ
         /JntWaQnXYILNB6Z9eBlTOjBiaYiJ2xpyeXJZVzHGvCsRBIgMtiuW/31g9mWuy9PNLzU
         mMV56/ntgFzNN1cBIbHJYL0KAR8yRUiYWHwiBQeP+rCBxx1ZSQmkvDgk5mLsqkha9Btb
         8Xjg==
X-Gm-Message-State: ACgBeo11kEA7wN5FxDd/KXG2JaqklkFTv6Qit43+GQukpdtGwyech7BW
        qO8pR23M4Uy/6gXwNIZk4So=
X-Google-Smtp-Source: AA6agR4Lq4oyeReXSo7ypMRWkBeNwEDxVSSiJZ5FK6xxobOqfsOQzNYabZyT4YOwlPFqFEnyRsoKNA==
X-Received: by 2002:a17:903:509:b0:176:8db1:5ac8 with SMTP id jn9-20020a170903050900b001768db15ac8mr4720462plb.54.1662568696534;
        Wed, 07 Sep 2022 09:38:16 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id w21-20020a634915000000b0042a93b625d4sm10964338pga.27.2022.09.07.09.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 09:38:16 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 2/2] rev-list: disable commit graph with --verify-objects
References: <Yxe0k++LA/UfFLF/@coredump.intra.peff.net>
        <Yxe1422xPYoMNlkG@coredump.intra.peff.net>
Date:   Wed, 07 Sep 2022 09:38:15 -0700
In-Reply-To: <Yxe1422xPYoMNlkG@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 6 Sep 2022 17:04:35 -0400")
Message-ID: <xmqq35d3ywaw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> diff --git a/revision.c b/revision.c
> index ee702e498a..00f9c7943b 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -2426,6 +2426,7 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg

It is consistent with the description in the proposed log message ...

>  		revs->tree_objects = 1;
>  		revs->blob_objects = 1;
>  		revs->verify_objects = 1;
> +		disable_commit_graph(revs->repo);

... to disable commit graph when "--verify-objects" is requested.

> diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
> index 53c2aa10b7..f9a1bc5de7 100755
> --- a/t/t1450-fsck.sh
> +++ b/t/t1450-fsck.sh
> @@ -507,6 +507,34 @@ test_expect_success 'rev-list --verify-objects with bad sha1' '
>  	test_i18ngrep -q "error: hash mismatch $(dirname $new)$(test_oid ff_2)" out
>  '
>  
> +test_expect_success 'set up repository with commit-graph' '
> +	git init corrupt-graph &&
> +	(
> +		cd corrupt-graph &&
> +		test_commit one &&
> +		test_commit two &&
> +		git commit-graph write --reachable
> +	)
> +'
> +
> +corrupt_graph_obj () {
> +	oid=$(git -C corrupt-graph rev-parse "$1") &&
> +	obj=corrupt-graph/.git/objects/$(test_oid_to_path $oid) &&
> +	test_when_finished 'mv backup $obj' &&

OK.  I missed this when-finished thing in my first read and wondered
who takes care of the 'backup' file.  We obviously cannot use it in
tests that do not follow the "break single loose object and inspect
the command behaviour in the repository" pattern, but that is OK.

> +	mv $obj backup &&
> +	echo garbage >$obj
> +}
> +
> +test_expect_success 'rev-list --verify-objects with commit graph (tip)' '
> +	corrupt_graph_obj HEAD &&
> +	test_must_fail git -C corrupt-graph rev-list --verify-objects HEAD
> +'
> +
> +test_expect_success 'rev-list --verify-objects with commit graph (parent)' '
> +	corrupt_graph_obj HEAD^ &&
> +	test_must_fail git -C corrupt-graph rev-list --verify-objects HEAD
> +'
> +

Looks good, thanks.

>  test_expect_success 'force fsck to ignore double author' '
>  	git cat-file commit HEAD >basis &&
>  	sed "s/^author .*/&,&/" <basis | tr , \\n >multiple-authors &&
