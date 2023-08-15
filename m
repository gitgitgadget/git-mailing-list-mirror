Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA70AC001B0
	for <git@archiver.kernel.org>; Tue, 15 Aug 2023 21:44:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240379AbjHOVno (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Aug 2023 17:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240443AbjHOVnj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2023 17:43:39 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E2C1FCE
        for <git@vger.kernel.org>; Tue, 15 Aug 2023 14:43:38 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-589f784a972so23439747b3.0
        for <git@vger.kernel.org>; Tue, 15 Aug 2023 14:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1692135817; x=1692740617;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y+zoNDWdz8xdoRAP43YQY3kocgWQbvB1Sa25L7IQ9T8=;
        b=2orZUuZQZV8xB7M9scqiy+aw62594l8etHTcsG01qhsUGt8x5ZQBcGj627CLHjeroI
         EziMQS/Cs12LS/4U9NfwDV3V0ZiAUFGzT51tiF/ka4POFYKng0eNMir0GAssLVHbrPd5
         IsxBQiHvMWrPicHJJ/OtWxDdzqWN5S4sEmCTVQhoOk9bvwxjQYeatAQMIpmo6YoNxvRJ
         kR6yUz1s3tXUSR3Y9M68XIUxdJOpfSP4iJpm8SpUvjQ4mUt51dUWFx6DVUEibPMLUFkK
         qfwdj3K9E03mSp/XPDdXy49g0EEg/nCQRnRtCzieFkxurK1i/QQ+BeKT63cgujXKd6GY
         8pTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692135817; x=1692740617;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y+zoNDWdz8xdoRAP43YQY3kocgWQbvB1Sa25L7IQ9T8=;
        b=LbC02I8oX5urfssvbqUs1O6Bli0Jdg5DDdTup/S3ldcF2Z/3F+SGxlkgAcVjOs0qFq
         XLSWR83nOBB35Jcg7qo5LuKYVEoYJtScQW8tUhHQ3hrbU+kubLksGMH2wHEIhTjAJEAR
         gFzfJfcSoSP548QAD22cXYNoQheDoXsqO0LmJt09T0zKwULCOX/U8DXQXMlxyKYrV+X5
         AgKQvlkqzP/nxRB6tZtIHJ0qnRYfdHtgUbfZ9dA7YIaQR4K48Jc/kTN9E8ZptWkFZKdt
         7h95hWenHtuMGGdktRVvddPg/KeNyOW2EwJm7okDqMH7SRPpDDGhaFxhrdTaBOR5M66Z
         ae3A==
X-Gm-Message-State: AOJu0YxQcPFAsiACFb/w3ppTAsuV+tU4SttBs8yQY0amTWBEAmnhafqI
        MfFyKdkgwxXFA5jFBeO+oaYw7u+GpbdTUip9X89BKg==
X-Google-Smtp-Source: AGHT+IFJ9/ODzrSJvbqiPfnZ71XQhiF2QAIH0dyBgjFt3wLFvFzIWFoG8aO8/J5MDt0srxxi/C3rBQ==
X-Received: by 2002:a81:8882:0:b0:585:f4e0:6532 with SMTP id y124-20020a818882000000b00585f4e06532mr11139220ywf.30.1692135817237;
        Tue, 15 Aug 2023 14:43:37 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id u185-20020a8160c2000000b005869d9535dcsm3666605ywb.55.2023.08.15.14.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 14:43:36 -0700 (PDT)
Date:   Tue, 15 Aug 2023 17:43:31 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
        John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v5 0/8] Repack objects into separate packfiles based on a
 filter
Message-ID: <ZNvxg7BVJ+C5XFY4@nand.local>
References: <20230808082608.582319-1-christian.couder@gmail.com>
 <20230812000011.1227371-1-christian.couder@gmail.com>
 <xmqqv8dhjfgm.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqv8dhjfgm.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 14, 2023 at 05:51:05PM -0700, Junio C Hamano wrote:
> Thanks.  I do not recall if the previous version with SQUASH??? passed
> the tests or not, but this round seems to be breaking the exact test
> we had trouble with with the previous round:
>
>   https://github.com/git/git/actions/runs/5850998716/job/15861158252#step:4:1822
>
> The symptom looks like that "test_must_fail env" test is not
> failing.  Ring a bell?

That does ring a bell for me, but this is a different failure than
before, IIRC.

This time we're expecting to fail writing a bitmap during a filtered
repack, but we succeed. I was wondering in [1] whether or not we should
be catching this bad combination of options more eagerly than relying on
the pack-bitmap machinery to notice that we're missing a reachability
closure.

I think the reason that this succeeds is that we already have a bitmap,
and it likely reuses all of the existing bitmaps before discovering that
the pack we wrote doesn't contain all objects. So doing this "fixes" the
immediate issue:

--- 8< ---
diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index 48e92aa6f7..e5134d3451 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -342,6 +342,7 @@ test_expect_success 'repacking with a filter works' '
 '

 test_expect_success '--filter fails with --write-bitmap-index' '
+	rm -f bare.git/objects/pack/*.bitmap &&
 	test_must_fail \
 		env GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP=0 \
 		git -C bare.git repack -a -d --write-bitmap-index --filter=blob:none
--- >8 ---

but I wonder if a more complete fix would be something like:

--- 8< ---
diff --git a/builtin/repack.c b/builtin/repack.c
index c396029ec9..f021349c4e 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -48,6 +48,11 @@ static const char incremental_bitmap_conflict_error[] = N_(
 "--no-write-bitmap-index or disable the pack.writeBitmaps configuration."
 );

+static const char filtered_bitmap_conflict_error[] = N_(
+"Filtered repacks are incompatible with bitmap indexes.  Use\n"
+"--no-write-bitmap-index or disable the pack.writeBitmaps configuration."
+);
+
 struct pack_objects_args {
 	const char *window;
 	const char *window_memory;
@@ -953,7 +958,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)

 	if (write_bitmaps < 0) {
 		if (!write_midx &&
-		    (!(pack_everything & ALL_INTO_ONE) || !is_bare_repository()))
+		    (!(pack_everything & ALL_INTO_ONE) || !is_bare_repository()) &&
+		    !po_args.filter_options.choice)
 			write_bitmaps = 0;
 	} else if (write_bitmaps &&
 		   git_env_bool(GIT_TEST_MULTI_PACK_INDEX, 0) &&
@@ -966,6 +972,9 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	if (write_bitmaps && !(pack_everything & ALL_INTO_ONE) && !write_midx)
 		die(_(incremental_bitmap_conflict_error));

+	if (write_bitmaps && po_args.filter_options.choice)
+		die(_(filtered_bitmap_conflict_error));
+
 	if (write_bitmaps && po_args.local && has_alt_odb(the_repository)) {
 		/*
 		 * When asked to do a local repack, but we have
--- >8 ---

would be preferable.

Thanks,
Taylor

[1]: https://lore.kernel.org/git/ZNQH6EMKqbuUzEhs@nand.local/
