Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB2DAC388F9
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 20:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B39820797
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 20:47:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jI3UwBCG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726056AbgKKUrM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 15:47:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbgKKUrM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 15:47:12 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7BEBC0613D1
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 12:47:10 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id g2so1834537plg.1
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 12:47:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=nGQrVAddualzRnbk8TPpxR7L1JTmklmQ7Xz8JmnjFJ8=;
        b=jI3UwBCG8gLLoESb336gw7z8ZNOjZwOUG1QxISKF+rUrUhPQ/r2HX4ti4Ik/2yFe/s
         zu6d/+fVmGPfHCfh4uX26Lwp4SOkO9AZwAp2WKtr5uN6AkUL0UAN9k3Ivx3RoQfnrVPA
         6q8QPS/qiLBTvJF3FguABDvmcIYcyDVL3IAWD0MZIXGd/ii/z3Ly9J96zLJL+nKINYD/
         HNmnbtoySfhbYLrOPv7I41RGPPo+X0xQqT8mPlrlNMU4kPZUcIIWXx52PuetJOkuxHO4
         PcxA1UXIKjEKDf897d9LxDd0IdLpV6JllKAQAct6Ml6ZqEto95uy5JwQ/Fo03VXp+ULk
         OdvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=nGQrVAddualzRnbk8TPpxR7L1JTmklmQ7Xz8JmnjFJ8=;
        b=AziuA4cFMKIHqab+qUSYAaGTrJpKPF/f/Nel9TMdslGz6G2kQY2M7YK6nhSclwsXIX
         dKcSU1VMrjtRXLz1wfswDByVou5RlTbjuTZ9bWYCJJdLQSnk32clHpyXKSxt5XQbZTCW
         7DRR4QH6SgPHnCxELiF9MT3O5S0ys5ImIrDOOdciGUMHliUptrJQaq+yQ+WZEsg2uL+A
         waDI8lHs+TZAkf1NL0eumwNWfH8X7Xd+JA1N9eXRWLEet1CU2Uvb1pLynjqckrNDYibN
         6VpcWrRfKb+t7vPLSSB9HDZ7/08kFA89HSMphoWsyGOOjveRZ3ICYY2rGg4+/50rDug5
         q1Hg==
X-Gm-Message-State: AOAM533sjsVHmc5VjdR/EytcBhOE2eq1RSmcZ2i9RQXyhLRL5tJx1+Xj
        YUTaviI0RlwrMc8BjcKIqgX23BIP2QMwwVx8XZbD
X-Google-Smtp-Source: ABdhPJw4WIqa9gB4sXuwQxYmno1UDfKIKgqGHkgHvkXPSJHNa8goy+i14SgifOjxauojhEpXa/7RJm611zQM2ekqOTVx
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90a:4742:: with SMTP id
 y2mr5641600pjg.228.1605127630064; Wed, 11 Nov 2020 12:47:10 -0800 (PST)
Date:   Wed, 11 Nov 2020 12:47:07 -0800
In-Reply-To: <20201102204344.342633-15-newren@gmail.com>
Message-Id: <20201111204707.3126694-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20201102204344.342633-15-newren@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
Subject: Re: [PATCH v2 14/20] merge-ort: step 2 of tree writing -- function to
 create tree object
From:   Jonathan Tan <jonathantanmy@google.com>
To:     newren@gmail.com
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> +static void write_tree(struct object_id *result_oid,
> +		       struct string_list *versions,
> +		       unsigned int offset)
> +{
> +	size_t maxlen = 0;
> +	unsigned int nr = versions->nr - offset;
> +	struct strbuf buf = STRBUF_INIT;
> +	struct string_list relevant_entries = STRING_LIST_INIT_NODUP;
> +	int i;
> +
> +	/*
> +	 * We want to sort the last (versions->nr-offset) entries in versions.
> +	 * Do so by abusing the string_list API a bit: make another string_list
> +	 * that contains just those entries and then sort them.
> +	 *
> +	 * We won't use relevant_entries again and will let it just pop off the
> +	 * stack, so there won't be allocation worries or anything.
> +	 */
> +	relevant_entries.items = versions->items + offset;
> +	relevant_entries.nr = versions->nr - offset;
> +	string_list_sort(&relevant_entries);
> +
> +	/* Pre-allocate some space in buf */
> +	for (i = 0; i < nr; i++) {
> +		maxlen += strlen(versions->items[offset+i].string) + 34;

Probably should include the_hash_algo->rawsz instead of hardcoding 34.

The rest looks straightforward.
