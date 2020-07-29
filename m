Return-Path: <SRS0=QOHA=BI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C1CDC433E0
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 22:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7D2D20656
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 22:22:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YtfM04uG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727862AbgG2WWe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jul 2020 18:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726947AbgG2WWd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jul 2020 18:22:33 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24E0C061794
        for <git@vger.kernel.org>; Wed, 29 Jul 2020 15:22:33 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id m22so15263066pgv.9
        for <git@vger.kernel.org>; Wed, 29 Jul 2020 15:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ffMnYJTOTAvC3NpI4V5Ie1XX5Dou3uHtlunEWssojvY=;
        b=YtfM04uGxMiUv5tXrjZW69LT54yCaL2qZB/80iV6vdXnqXrBl54lF8u4StlrU+xmxT
         oZxCiUq+IhTy4AbbDDumQQP2WrIDmtCIHNSH4eWJW9l5RcFC3wPg4pHNdDO9RXewHBu+
         sohmQvUYrl2X8WmKusz/jb90ePupqJWFCh6d1llEtntVGQtgPE1Lv5yhmFfanvNTeShs
         KZnJqbs/qTzQNZOpf2esLF/DHj9BsYiVF2w+TUtnPgWmEwPX2ZA7B7F0KGuZu/hLDrlI
         cINkue65DcX6FMgL8dBz8ka2RWJN202QEt510QYmviTiks537OFxhDkNiCFQtDEVgyDW
         SdDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ffMnYJTOTAvC3NpI4V5Ie1XX5Dou3uHtlunEWssojvY=;
        b=H9MdvuFddLtdy/wAhFGXLujZGDol9R9hwq5jr+wcYl0eL1Ymsl1ZG2fhW04l9VOL/e
         JToplnGOYFHwYMIyRWGheuD8XMV0EDN6z30QJ+bYD8xqM46aYpq97ohi1kYORklZOF9v
         cSq5RbarFqlDn4LhlYn2ksF/x0vQlOgsqmf1Dle568c8e6nS6NvcgLv5KxZKO0aEdGTn
         U9piy9lBcpCkHTgBO3d+cb36jvUoQglDlTHmCoKc9JUvfd/vYm56EN7Nw5r33GM/ELw5
         YUDhlewJpR/Ds2bYMGSYh8yRYcTPZ8X8XiWi5dUIT4jZAluD6FYSrtLO/Hep0+tzpHAd
         uuxg==
X-Gm-Message-State: AOAM533Un77dxxS/FEIk4IbyULVd/bG7GxQglZfSLnPj0TOWxB2K7Lsp
        HFjAalVuX8M1i+Lgfnhtun3RcQ==
X-Google-Smtp-Source: ABdhPJztHLXFyqeROPKyFPt8gHhMzhh1VmLb5k51kPdQzLnECZET6Bu/Ha/5L4b4+Re7CPfTlVe1qA==
X-Received: by 2002:a63:5116:: with SMTP id f22mr8423603pgb.303.1596061353056;
        Wed, 29 Jul 2020 15:22:33 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
        by smtp.gmail.com with ESMTPSA id y20sm3607808pfo.170.2020.07.29.15.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 15:22:32 -0700 (PDT)
Date:   Wed, 29 Jul 2020 15:22:26 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        sandals@crustytoothpaste.net, steadmon@google.com,
        jrnieder@gmail.com, peff@peff.net, congdanhqx@gmail.com,
        phillip.wood123@gmail.com, sluongng@gmail.com,
        jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 10/18] maintenance: add incremental-repack task
Message-ID: <20200729222226.GD2965447@google.com>
References: <pull.671.git.1594131695.gitgitgadget@gmail.com>
 <pull.671.v2.git.1595527000.gitgitgadget@gmail.com>
 <b6328c210625e1ba98e2065208a2a478c2c64f94.1595527000.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6328c210625e1ba98e2065208a2a478c2c64f94.1595527000.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 23, 2020 at 05:56:32PM +0000, Derrick Stolee via GitGitGadget wrote:
> 1. 'git multi-pack-index write' creates a multi-pack-index file if
>    one did not exist, and otherwise will update the multi-pack-index
>    with any new pack-files that appeared since the last write. This
>    is particularly relevant with the background fetch job.

[emily shaffer] Will this use midx even if the user has disabled it in
their config?

> diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
> index 94bb493733..3ec813979a 100755
> --- a/t/t7900-maintenance.sh
> +++ b/t/t7900-maintenance.sh
> @@ -103,4 +103,41 @@ test_expect_success 'loose-objects task' '
>  	test_cmp packs-between packs-after
>  '

[emily shaffer] Can we include a test to prove that this task is or is
not run if core.multipackindex is set or unset? That behavior is hard to
deduce from the code... we might want to be cautious.

>  
> +test_expect_success 'incremental-repack task' '
> +	packDir=.git/objects/pack &&
> +	for i in $(test_seq 1 5)
> +	do
> +		test_commit $i || return 1
> +	done &&
> +
> +	# Create three disjoint pack-files with size BIG, small, small.
> +	echo HEAD~2 | git pack-objects --revs $packDir/test-1 &&
> +	test_tick &&
> +	git pack-objects --revs $packDir/test-2 <<-\EOF &&
> +	HEAD~1
> +	^HEAD~2
> +	EOF
> +	test_tick &&
> +	git pack-objects --revs $packDir/test-3 <<-\EOF &&
> +	HEAD
> +	^HEAD~1
> +	EOF
> +	rm -f $packDir/pack-* &&
> +	rm -f $packDir/loose-* &&
> +	ls $packDir/*.pack >packs-before &&
> +	test_line_count = 3 packs-before &&
> +
> +	# the job repacks the two into a new pack, but does not
> +	# delete the old ones.
> +	git maintenance run --task=incremental-repack &&
> +	ls $packDir/*.pack >packs-between &&
> +	test_line_count = 4 packs-between &&
> +
> +	# the job deletes the two old packs, and does not write
> +	# a new one because only one pack remains.
> +	git maintenance run --task=incremental-repack &&
> +	ls .git/objects/pack/*.pack >packs-after &&
> +	test_line_count = 1 packs-after
> +'
> +
>  test_done
> -- 
> gitgitgadget
> 
