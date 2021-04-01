Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75E00C47061
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 17:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BA31613CA
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 17:43:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235791AbhDARnN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Apr 2021 13:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234733AbhDARjc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Apr 2021 13:39:32 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BCB0C05BD34
        for <git@vger.kernel.org>; Thu,  1 Apr 2021 06:06:00 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id k25so1704907oic.4
        for <git@vger.kernel.org>; Thu, 01 Apr 2021 06:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5+u+FPEdYVvSJcHAkWKWdMiGNp7iQ8KHWBkQe232MKc=;
        b=ivLpzoKh0WCGHZvTyS8hjooa5UDbWxAbOhWUvNldd8zXyqxk75RnKDUiM/gwpdzW59
         Tnh4tfWIZOW+3A2hAwFpZiYukgPZkV2OCuK+MgEy+sZjkf9NiXTNbCPv74A8MAcXnO06
         xcTWfJH04P2dCdFAkdB++q5Mp6Gmgt4h2EnvDoVI/Gtf5I6fU4UdqnmOLfx7Kmb+z2yA
         kIDxsYkjnHv2i0TmT80KREiXpU8EyOEXUGQG0XMbRWWCTnh54L6sB0juGDvDtPqttntl
         zVIPtqheWM/WfrVJM45HCQZ5a6F04arEq+eDIYszhjO6A5UWML1GO1aP1L0fAVewXKrT
         KOpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5+u+FPEdYVvSJcHAkWKWdMiGNp7iQ8KHWBkQe232MKc=;
        b=eHIMK16+nHJXylBKt6ppXL4GEbxFCiLhAYtq8fTUtLMGh6Gjwba6UhLJUDLTb7w5XD
         McysVAhsv1qF/W7TEw6oqDdmOvARiHPeoVaDVwATfah87bI7Uaw9W/Pw2O1jFyIYjimX
         8TF/I1H+VDY2lbxnItOpHwuM/DZiajDNF2tlwXetcF02LhyEPJRppV9xaG90GkPdByPw
         H/SQYC+RoHbtboPrWm32q/t0m6GBgTsNOJRX39Gq6zvEOVWFr2tkXsl1J9vOzcYFNcEo
         XQwAprJVT/8Y0Z1fna8fu2jX67H9qnoXjkPrZ6RTekaLAtOUTMxlk1gDvx+Ei0rPlMOa
         O/MQ==
X-Gm-Message-State: AOAM533M+DDzHs7dIri20gTFoWSvNVpRhKOuC7/vjM2Qqo1+11ClrWx4
        i1yKEvmz9E+LqP4nDYOMZoQ=
X-Google-Smtp-Source: ABdhPJyAXkeKqs+9HqgYvzynhq8KxW1shTOtQmIrEy336Ls+Z+YsZuWMpATI29uGiG6xrU9VViVH1w==
X-Received: by 2002:aca:ea8a:: with SMTP id i132mr5795525oih.68.1617282359273;
        Thu, 01 Apr 2021 06:05:59 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:1cff:cd17:c59a:654? ([2600:1700:e72:80a0:1cff:cd17:c59a:654])
        by smtp.gmail.com with ESMTPSA id 24sm1027594oiq.11.2021.04.01.06.05.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Apr 2021 06:05:58 -0700 (PDT)
Subject: Re: [PATCH 3/3] builtin/pack-objects.c: respect
 'pack.preferBitmapTips'
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net
References: <cover.1617240723.git.me@ttaylorr.com>
 <5e10199dae5e342c0482497b038b3299a8ed046b.1617240723.git.me@ttaylorr.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <924b5815-f7c6-7451-92e5-19bb936c54b1@gmail.com>
Date:   Thu, 1 Apr 2021 09:05:55 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <5e10199dae5e342c0482497b038b3299a8ed046b.1617240723.git.me@ttaylorr.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/31/2021 9:32 PM, Taylor Blau wrote:
> When writing a new pack with a bitmap, it is sometimes convenient to
> indicate some reference prefixes which should receive priority when
> selecting which commits to receive bitmaps.
> 
> A truly motivated caller could accomplish this by setting
> 'pack.islandCore', (since all commits in the core island are similarly
> marked as preferred) but this requires callers to opt into using delta
> islands, which they may or may not want to do.
> 
> Introduce a new multi-valued configuration, 'pack.preferBitmapTips' to
> allow callers to specify a list of reference prefixes. All references
> which have a prefix contained in 'pack.preferBitmapTips' will mark their
> tips as "preferred" in the same way as commits are marked as preferred
> for selection by 'pack.islandCore'.

I almost hit send on an email saying "this doesn't seem to work with
prefixes" but I have discovered the subtle reason why. I'll point it
out below.

> +static int mark_bitmap_preferred_tip(const char *refname,
> +				     const struct object_id *oid, int flags,
> +				     void *_data)
> +{
> +	struct object_id peeled;
> +	struct object *object;
> +
> +	if (!peel_iterated_oid(oid, &peeled))
> +		oid = &peeled;
> +
> +	object = parse_object_or_die(oid, refname);
> +	if (object->type == OBJ_COMMIT)
> +		object->flags |= NEEDS_BITMAP;
> +
> +	return 0;
> +}

This takes a refname and peels it (in case of a tag) but doesn't
do any prefix matching.

> +static void mark_bitmap_preferred_tips(void)
> +{
> +	struct string_list_item *item;
> +	const struct string_list *preferred_tips;
> +
> +	preferred_tips = bitmap_preferred_tips(the_repository);
> +	if (!preferred_tips)
> +		return;
> +
> +	for_each_string_list_item(item, preferred_tips) {
> +		for_each_ref_in(item->string, mark_bitmap_preferred_tip, NULL);
> +	}
> +}

This iterates on the list returned by bitmap_preferred_tips(), but
specifically for_each_ref_in() does the prefix matching for us. I
missed that point on my first read.

> +const struct string_list *bitmap_preferred_tips(struct repository *r)
> +{
> +	return repo_config_get_value_multi(r, "pack.preferbitmaptips");
> +}

And this just returns the config values, which are fed into
for_each_ref_in().

> +test_expect_success 'pack.preferBitmapTips' '
> +	git init repo &&
> +	test_when_finished "rm -fr repo" &&
> +	(
> +		cd repo &&
> +
> +		# create enough commits that not all are receive bitmap
> +		# coverage even if they are all at the tip of some reference.
> +		test_commit_bulk --message="%s" 103 &&
> +
> +		git rev-list HEAD >commits.raw &&
> +		sort <commits.raw >commits &&
> +
> +		git log --format="create refs/tags/%s %H" HEAD >refs &&
> +		git update-ref --stdin <refs &&
> +
> +		git repack -adb &&
> +		test-tool bitmap list-commits | sort >bitmaps &&
> +
> +		# remember which commits did not receive bitmaps
> +		comm -13 bitmaps commits >before &&
> +		test_file_not_empty before &&
> +
> +		# mark the commits which did not receive bitmaps as preferred,
> +		# and generate the bitmap again
> +		perl -pe "s{^}{create refs/tags/include/$. }" <before |
> +			git update-ref --stdin &&
> +		git -c pack.preferBitmapTips=refs/tags/include repack -adb &&

And this test is a clever way of creating a new ref category to
check the prefix matching. Since you created refs pointing to
every commit earlier, this verifies that the config is the reason
they are picked now. Good.

Sorry for all of my thinking out loud. These are good patches and
I have no recommended changes.

Thanks,
-Stolee
