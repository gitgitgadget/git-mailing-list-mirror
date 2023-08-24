Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2656AC6FA8F
	for <git@archiver.kernel.org>; Thu, 24 Aug 2023 22:22:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243889AbjHXWVk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Aug 2023 18:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243970AbjHXWVC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Aug 2023 18:21:02 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A14831BF1
        for <git@vger.kernel.org>; Thu, 24 Aug 2023 15:20:54 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-cf4cb742715so344938276.2
        for <git@vger.kernel.org>; Thu, 24 Aug 2023 15:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692915654; x=1693520454;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WDOdu6l9Djsj1QsAqv71nq8TrMqXclTmEW4c+PotZII=;
        b=jhlvrG/1em4AqNOXwwos7PzBx3seCgs5DkgXWtJtO18A1kkD+s8FslImvpLaaobY9U
         KwBeUZ9KVOFUe9C99IptjcLTXAfJV7Ij4fjE5aPYIfSZ0NRXhDRbtwHW8OHEkKTtaoMc
         nW914gCtkXT0JHAv0lvOXnBb71LxTIJh+GhNF+/CrCO7MXjmeiP2M5kS6J0ss8WM8HwA
         PAYGu5akegKmXdKs+K3N+ylak0iotTZo5UaGNiy9HI8/Nx0AJrsyA3EKoO1gCg8tGbOQ
         jgagTE7zOFqAYMKNOTEi95W2/sTNmpP6FPNbmR/VOYl7fOeS/igzvULqSMkQleDC03ui
         Azpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692915654; x=1693520454;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WDOdu6l9Djsj1QsAqv71nq8TrMqXclTmEW4c+PotZII=;
        b=mCmLQHSrq5ZKXjB7Wg/0Cv0r7r6IM1pHEt9afTil7DxxmBRChoSo7op1d77w1uPrxr
         O+DjjN8tCM54k281Sxp08Mo+ArUJGZpOlkqFyKT/qXCBvnaRGz/yG6oZxWdzYVH775vg
         CIQeUpAufH1E6hasTSnkWF3sLFMLR+QMiX++XlX3pjfLqokk3vTRBY+SNfk/Mi+SbziI
         czqrVVymRacnTaoaKM6ZhJQR8OT4t5P/09AuFl22ea1M81TgmkWcemAeLmO5av58WWdA
         T+Jk+4zqLihuGPH9e1kwm5M3ws21p3+WLWd9HA3lABNApO7DyvEQ8IWUWAa9p1F0KDoG
         SCRA==
X-Gm-Message-State: AOJu0YxsZiRgDJ/YcDDCYROMcCOFUiM6lVJx4T+MMun/ODMiAFYM2AYh
        0CYyctjWtcnEoNlMyMdpI4BuVJOKFq86dlRggKwl
X-Google-Smtp-Source: AGHT+IF4xa3MbMjnJxizgJEJvEEr1l9zS1Bl3FiMmyM/5Ep4m0DbNUzG6TBTneHTqgeZDwN67V+uoEM4SdKUF99H9XYn
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:d0eb:2757:7b54:470])
 (user=jonathantanmy job=sendgmr) by 2002:a25:ac82:0:b0:d77:e43d:6e80 with
 SMTP id x2-20020a25ac82000000b00d77e43d6e80mr127061ybi.6.1692915653864; Thu,
 24 Aug 2023 15:20:53 -0700 (PDT)
Date:   Thu, 24 Aug 2023 15:20:51 -0700
In-Reply-To: <a4cb5fe69247ba737a8373948c1f4ff8a150d283.1691426160.git.me@ttaylorr.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Message-ID: <20230824222051.2320003-1-jonathantanmy@google.com>
Subject: Re: [RFC PATCH 2/6] bloom: prepare to discard incompatible Bloom filters
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:
> diff --git a/bloom.c b/bloom.c
> index 9b6a30f6f6..739fa093ba 100644
> --- a/bloom.c
> +++ b/bloom.c
> @@ -250,6 +250,23 @@ static void init_truncated_large_filter(struct bloom_filter *filter,
>  	filter->version = version;
>  }
>  
> +struct bloom_filter *get_bloom_filter(struct repository *r, struct commit *c)
> +{
> +	struct bloom_filter *filter;
> +	int hash_version;
> +
> +	filter = get_or_compute_bloom_filter(r, c, 0, NULL, NULL);
> +	if (!filter)
> +		return NULL;
> +
> +	prepare_repo_settings(r);
> +	hash_version = r->settings.commit_graph_changed_paths_version;
> +
> +	if (!(hash_version == -1 || hash_version == filter->version))
> +		return NULL; /* unusable filter */
> +	return filter;
> +}

I missed this the last time, but this should match what fill_bloom_key()
does. Use get_bloom_filter_settings(), then compare filter->version to
version 2 if hash_version is 2, and to version 1 otherwise.

Everything else looks good.
 
