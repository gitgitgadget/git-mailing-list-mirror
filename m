Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44ADDC0015E
	for <git@archiver.kernel.org>; Wed,  9 Aug 2023 21:41:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232495AbjHIVlB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Aug 2023 17:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232476AbjHIVk7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2023 17:40:59 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 552071BFA
        for <git@vger.kernel.org>; Wed,  9 Aug 2023 14:40:59 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5899ed05210so4030577b3.3
        for <git@vger.kernel.org>; Wed, 09 Aug 2023 14:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1691617258; x=1692222058;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VscUSjE+HnNmFhZ0XPQ6KuBOksK2NFTSqjDuPdCs+9I=;
        b=2VzzLEN2XrjZXoOVntbzM5u2AsTC3US14DA+4JKL9MEFF06h+d3RWVRtUzbSoOdMn3
         c4zTaVYaWKDNEYEKEI0BKqZjXJNGDi5RI9D5K7SxVV37Hod2iQDXb9tgKrbL53Udncfb
         ViGU8vwegghiyQVS6ql3p7IYs5vBiKR9UXQJmPP8mFYuaYZ8jFUGxqg5FXpsY2M6grux
         aqNs0AJW8uaPWxXev+SMLqvACfxU4wU1RJRXgs98gW3Mcs0TjusWLuMXcaNbtgt/IBdh
         n4YZ3Rkn+XuKtrjtDnDIYF8tdQ5YDU+6NtCBn7VlJQRyLHAohaP4uBWHkMd1gKh+Pk3o
         QUsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691617258; x=1692222058;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VscUSjE+HnNmFhZ0XPQ6KuBOksK2NFTSqjDuPdCs+9I=;
        b=Bu28atVS5HSUcXtLNW6vFmfnF7BblGUGOC9FGpgu/CvOJCtwSG096aD9wtP37SITOO
         UJ0vFd9JJ23+cE2OXfPdplvY1cODdQQ09aCOZ7HWZi2Ujy1egAuRZ6TdVq2gh3pRACLN
         0O3m1e3h/qTwvOR9oDLf/JkhVfBelc/pQWrCA4CEDapGEdBATlsbBFM5UX+hlfWUCFK6
         gG3+VwtqXe6NirQB23LgiE4seRs1oZOBGYkvEQkmTpKj69aD0RPwbG4Wm/MaK5oKP6PZ
         JEgDqG/Qsh+yGDpZJ8adNyCfx3aoOj9rPWG3TJIvoa8wJ16xoOKXBU+JmOfD5JqEo7Ki
         eaYA==
X-Gm-Message-State: AOJu0YwoZd4OaolJH7xsCsRxxoa3V/JzA12U9v1a+lPSKUmRocTma8kB
        l15NIfqSIC3NzR+k1J2EsdJQcA==
X-Google-Smtp-Source: AGHT+IEil3pTTjc+9r72YOj4ok3AhFkyXQPBkTq62dYCteKsZtoXcWuiIZTvianAcGXADzDusFrTUA==
X-Received: by 2002:a0d:dfd4:0:b0:589:9f3b:17fe with SMTP id i203-20020a0ddfd4000000b005899f3b17femr674546ywe.23.1691617257700;
        Wed, 09 Aug 2023 14:40:57 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id w2-20020a814902000000b00583b40d907esm4236243ywa.16.2023.08.09.14.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 14:40:57 -0700 (PDT)
Date:   Wed, 9 Aug 2023 17:40:56 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v4 5/8] repack: add `--filter=<filter-spec>` option
Message-ID: <ZNQH6EMKqbuUzEhs@nand.local>
References: <20230724085909.3831831-1-christian.couder@gmail.com>
 <20230808082608.582319-1-christian.couder@gmail.com>
 <20230808082608.582319-6-christian.couder@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230808082608.582319-6-christian.couder@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 08, 2023 at 10:26:05AM +0200, Christian Couder wrote:
> @@ -871,6 +925,9 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
>  		OPT_END()
>  	};
>
> +	list_objects_filter_init(&po_args.fturailter_options);
> +	list_objects_filter_init(&cruft_po_args.filter_options);

Initializing `po_args`'s `filter_options` makes sense to me, but do we
ever use the cruft_po_args ones? From looking at this patch, I don't
think we do.

Initializing them and then calling list_objects_filter_release() on it
isn't wrong, but I can't tell whether initializing these is necessary
or not in the first place.

> +test_expect_success '--filter fails with --write-bitmap-index' '
> +	GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP=0 test_must_fail git -C bare.git repack \
> +		-a -d --write-bitmap-index --filter=blob:none
> +'

I can't remember off-hand why, but I am pretty sure that we usually
write "test_must_fail env ..." before the command-line arguments instead
of setting the environment variable outside of the test_must_fail call.

I *think* that this is the same issue as the single-shot environment
variable assignment before function call thing that we see in some
shells.

Regardless, I wonder if we should be catching this --filter +
--write-bitmap-index thing earlier. The error message I get when
running this is:

    warning: Failed to write bitmap index. Packfile doesn't have full closure (object ac3e272b72bbf89def8657766b855d0656630ed4 is missing)
    fatal: failed to write bitmap index

Which comes from deep within the pack-bitmap-write.c internals
(specifically in a failing call to `find_object_pos()`).

I don't think that's wrong per-se, but I wonder if catching the
combination earlier would allow us to carry on writing the pack even if
the caller erroneously specified that they wanted a bitmap, similar to
how we handle that combination with other options (see the comment in
builtin/pack-objects.c that starts with "'hard reasons not to use
bitmaps [...]'").

I doubt we'd see many naturally occurring instances of users running
"git repack" with both the --filter spec option and
--write-bitmap-index. But, I think that it would come up more often in
bare repositories, where writing reachability bitmaps is the default
state during repacking unless specified otherwise.

I suspect doing something like:

--- 8< ---
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 000ebec7ab..d75d122a86 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -4431,7 +4431,10 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		use_bitmap_index = use_bitmap_index_default;

 	/* "hard" reasons not to use bitmaps; these just won't work at all */
-	if (!use_internal_rev_list || (!pack_to_stdout && write_bitmap_index) || is_repository_shallow(the_repository))
+	if (!use_internal_rev_list ||
+	    (!pack_to_stdout && write_bitmap_index) ||
+	    is_repository_shallow(the_repository) ||
+	    filter_options.choice)
 		use_bitmap_index = 0;

 	if (pack_to_stdout || !rev_list_all)
--- >8 ---

would do the trick (perhaps with a warning(), and the corresponding test
modification, but I think I could go either way on the warning() since
there isn't one there currently.)

I looked through the rest of the tests, and they all looked good to me,
thanks.

Thanks,
Taylor
