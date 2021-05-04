Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2070CC433ED
	for <git@archiver.kernel.org>; Tue,  4 May 2021 17:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC331613C6
	for <git@archiver.kernel.org>; Tue,  4 May 2021 17:51:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232047AbhEDRwZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 May 2021 13:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231845AbhEDRwY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 May 2021 13:52:24 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF038C061574
        for <git@vger.kernel.org>; Tue,  4 May 2021 10:51:29 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id i12-20020ac860cc0000b02901cb6d022744so2528864qtm.20
        for <git@vger.kernel.org>; Tue, 04 May 2021 10:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=xpJhMGyXZx6PuSG5db5jweS1cgPfb5AZA0V82+ku5j4=;
        b=R640gYbWQHZOk0biombNXstvsCz1ag9knpj5sWXIzJUVawd3doXm9/UgU1FSkzNiI4
         wTuPGk7gEq42jyPo16Jb47qHvby+8oJlEmWSbhfA9KAMG3GYPXBv46QFywkLQCJTcC0F
         fDbQtAC6VuANHLKV+2DuZR+nV9dif4vtKvjIgF4f0Gv1Lx5oh1APrH7Bg001VW/BQL8p
         STD0CvbQowJ8v8obDR4tyVMhwvTZso/E0ZP0hH4hQtQAFobkFq/qMvPC35xr/50HNdjc
         ZTfDf3tomOsoOYhKUwnCJCOI28Emo9SHW8NM/8/Mkhi/ucttcQXRwFjmQhhhMEK7Q3I2
         esfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xpJhMGyXZx6PuSG5db5jweS1cgPfb5AZA0V82+ku5j4=;
        b=fiCkwkRYJ8hS4D/aSFbmupMA6qDAxblrNQ8nOKmAbGmsMgr/nZsFxKXR/mymVtnP4u
         4fGeHQ6VG39rUrFRu0e2JLlNzle8Rdca7Bb8H7tLbajMNW4NrCNjjU9rlsjG+Q9kjsRi
         qYwV93agcmARQCASUI7a/IFoJsrtMRt2tfHX5COI6I1RyzXLIy+IQK52IaVJ0a9qP7eZ
         Tikx/uwyR2ME0op4uA3tm1/zxAixasXb1YUZ14EEYPaVUsYcowb5+imuVJliTeyoKA3+
         00PbylsnKqm8cjM3EQmXG1MPbXNH3VcxGZlnWEe8h/NfEMsHM9BV+LH+MfMN+tSxyR3N
         s97w==
X-Gm-Message-State: AOAM5306ypRG9O5WAlSfjIH2cQam1xdqcVcgkfdxhICsd+KrnCjjuH0B
        rjAeIvMpo5vXSDbSkbbq3DPDZ4/pnFpk1zyuk9I9
X-Google-Smtp-Source: ABdhPJwtfMLkf/TT/PjOxJqEZLrdI3bmP4fl5gG8iwcnrqwE8/Mz17roXaZjDWC4s2HIkRrBU9tsgYBZUuYgN9008szo
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a0c:a045:: with SMTP id
 b63mr26239093qva.19.1620150688853; Tue, 04 May 2021 10:51:28 -0700 (PDT)
Date:   Tue,  4 May 2021 10:51:25 -0700
In-Reply-To: <ff74181e85975690b4fccfb6b72fb80045f4adc7.1617991824.git.me@ttaylorr.com>
Message-Id: <20210504175125.2987651-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <ff74181e85975690b4fccfb6b72fb80045f4adc7.1617991824.git.me@ttaylorr.com>
X-Mailer: git-send-email 2.31.1.527.g47e6f16901-goog
Subject: Re: [PATCH 16/22] t5326: test multi-pack bitmap behavior
From:   Jonathan Tan <jonathantanmy@google.com>
To:     me@ttaylorr.com
Cc:     git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com,
        gitster@pobox.com, jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> +test_expect_success 'clone with bitmaps enabled' '
> +	git clone --no-local --bare . clone-reverse-delta.git &&
> +	test_when_finished "rm -fr clone-reverse-delta.git" &&
> +
> +	git rev-parse HEAD >expect &&
> +	git --git-dir=clone-reverse-delta.git rev-parse HEAD >actual &&
> +	test_cmp expect actual
> +'

What is this test testing? That bitmaps are used? (I'm not sure how to
verify that though - we seem to have tracing for bitmap writing but not
for reading, for example.)

> +bitmap_reuse_tests() {
> +	from=$1
> +	to=$2
> +
> +	test_expect_success "setup pack reuse tests ($from -> $to)" '
> +		rm -fr repo &&
> +		git init repo &&
> +		(
> +			cd repo &&
> +			test_commit_bulk 16 &&
> +			git tag old-tip &&
> +
> +			git config core.multiPackIndex true &&
> +			if test "MIDX" = "$from"
> +			then
> +				GIT_TEST_MULTI_PACK_INDEX=0 git repack -Ad &&
> +				git multi-pack-index write --bitmap
> +			else
> +				GIT_TEST_MULTI_PACK_INDEX=0 git repack -Adb
> +			fi
> +		)
> +	'
> +
> +	test_expect_success "build bitmap from existing ($from -> $to)" '
> +		(
> +			cd repo &&
> +			test_commit_bulk --id=further 16 &&
> +			git tag new-tip &&
> +
> +			if test "MIDX" = "$to"
> +			then
> +				GIT_TEST_MULTI_PACK_INDEX=0 git repack -d &&
> +				git multi-pack-index write --bitmap
> +			else
> +				GIT_TEST_MULTI_PACK_INDEX=0 git repack -Adb
> +			fi
> +		)
> +	'
> +
> +	test_expect_success "verify resulting bitmaps ($from -> $to)" '
> +		(
> +			cd repo &&
> +			git for-each-ref &&
> +			git rev-list --test-bitmap refs/tags/old-tip &&
> +			git rev-list --test-bitmap refs/tags/new-tip
> +		)
> +	'
> +}
> +
> +bitmap_reuse_tests 'pack' 'MIDX'
> +bitmap_reuse_tests 'MIDX' 'pack'
> +bitmap_reuse_tests 'MIDX' 'MIDX'

Is it possible to verify that the bitmaps have truly been reused (and
not, say, created from scratch)? (E.g. is there any nature of the
bitmap created - for example, the order of commits?)

> +test_expect_success 'pack.preferBitmapTips' '
> +	git init repo &&
> +	test_when_finished "rm -fr repo" &&
> +	(
> +		cd repo &&
> +
> +		test_commit_bulk --message="%s" 103 &&
> +
> +		git log --format="%H" >commits.raw &&
> +		sort <commits.raw >commits &&
> +
> +		git log --format="create refs/tags/%s %H" HEAD >refs &&
> +		git update-ref --stdin <refs &&
> +
> +		git multi-pack-index write --bitmap &&
> +		test_path_is_file $midx &&
> +		test_path_is_file $midx-$(midx_checksum $objdir).bitmap &&
> +
> +		test-tool bitmap list-commits | sort >bitmaps &&
> +		comm -13 bitmaps commits >before &&
> +		test_line_count = 1 before &&
> +
> +		perl -ne "printf(\"create refs/tags/include/%d \", $.); print" \
> +			<before | git update-ref --stdin &&
> +
> +		rm -fr $midx-$(midx_checksum $objdir).bitmap &&
> +		rm -fr $midx-$(midx_checksum $objdir).rev &&
> +		rm -fr $midx &&
> +
> +		git -c pack.preferBitmapTips=refs/tags/include \
> +			multi-pack-index write --bitmap &&
> +		test-tool bitmap list-commits | sort >bitmaps &&
> +		comm -13 bitmaps commits >after &&
> +
> +		! test_cmp before after
> +	)
> +'

Could we have a more precise comparison of "before" and "after" (besides
the fact that they're different)?

Besides that, all the patches up to this one look good (including patch
14, verified with "--color-moved
--color-moved-ws=allow-indentation-change").
