Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E9BC6FA8E
	for <git@archiver.kernel.org>; Fri, 24 Feb 2023 22:33:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbjBXWdS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Feb 2023 17:33:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjBXWdR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2023 17:33:17 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D991A94C
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 14:33:16 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-536af109f9aso12358357b3.13
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 14:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2jv5jHCwVVBPU2XBLABk9/6kFYYzT/0DhgwzlEZ4SoE=;
        b=WQzqRGhpfumO17KBCVLgbAIQX1FfISWCKZs1WaOsD24gEo22y5n7ErwtDlDSTuxRFV
         QBkLexjSqilzRZ1zAhShTEwwtL9ig3HmNPFWBtKN+KMjBMofRblhXFdLj1ZcubEEczwM
         0JPxUeR6WyKZrbuYt+4x6z4SxteH6IGvk7nmEdgNPLNXIDny1quBDjbR7vK5nJ8icJtR
         ibb3kMjnZyGsXYjFfTRzdjLmxbctCK+ax85oWQ9sRU00FIr39ftazJ0GS8m4ugyis3j+
         gK8BsMXqPl8x/17lDxVCmaMWiYLQkglQuJ6wfo2+HpL3SwkD/chWvli7M7LZnTcY8cjd
         krxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2jv5jHCwVVBPU2XBLABk9/6kFYYzT/0DhgwzlEZ4SoE=;
        b=HpJJA7g4srmk8q1YBpqwJ4VtNC5csTtpCowtV0wUJhSfhRYz3wgfbYOXXLTn2iynuj
         sJ8MFdMfevlc54wS3N7BJKTUAhrnXwQ/2EwddWMPnJU/b8Q5dUfArumBBzgWnKXnM0z/
         Xw8Y3ASKmPxplGfsLBVGjrDJtGTuAIiB2nDYH+2MWWx2Gwc2zB541zjeAU90jY/bflqN
         KXY2E9Bp+fiiUxZGGl4iqUxesTAFLMz3LgDZrlmLNPb0XH6tNJZdklevk24EIIeWBUsj
         Y4TCDyQStlx2DuUlg/Iv0bEj8+8k4DTvIXmnrSxFsM0J/lqqCMrhkHi5d206lp9QxUe6
         cpdQ==
X-Gm-Message-State: AO0yUKU1casDxgy/6XNOH5AAZCo/2GfauUyNB2NxUlXPTYP0ri9k1x25
        d6Z6jswMpNeZoulJeB1GH7rNM/PvFYYgJ9S4TjDe
X-Google-Smtp-Source: AK7set923c6FmfhCiYGX2rJwPw3G7jC+cSretI2q67H1OwOyu6zJAskj440cV7zjwL15U/Kj3fd+rakZaJNBysY7KhBp
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:6b04:35a6:9357:29a1])
 (user=jonathantanmy job=sendgmr) by 2002:a25:880c:0:b0:a17:c04e:bf7c with
 SMTP id c12-20020a25880c000000b00a17c04ebf7cmr4512159ybl.11.1677277995762;
 Fri, 24 Feb 2023 14:33:15 -0800 (PST)
Date:   Fri, 24 Feb 2023 14:33:13 -0800
In-Reply-To: <f5a58123034a708b49aac7076197ad2ccdd3cba1.1677143700.git.gitgitgadget@gmail.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Message-ID: <20230224223313.1509428-1-jonathantanmy@google.com>
Subject: Re: [PATCH 04/11] unpack-trees: clean up some flow control
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>   * update_sparsity() has a check early on that will BUG() if
>     o->skip_sparse_checkout is set; as such, there's no need to check
>     for that condition again later in the code.  We can simply remove
>     the check and its corresponding goto label.

[snip]

> @@ -2113,8 +2115,6 @@ enum update_sparsity_result update_sparsity(struct unpack_trees_options *o)
>  		memset(&pl, 0, sizeof(pl));
>  		free_pattern_list = 1;
>  		populate_from_existing_patterns(o, &pl);
> -		if (o->skip_sparse_checkout)
> -			goto skip_sparse_checkout;

I've verified that indeed there is a prior check that
o->skip_sparse_checkout is not set (not visible in the diff).

Up to here, everything looks good.
