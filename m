Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D24C433EF
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 00:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F803619E1
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 00:29:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232959AbhKPAcu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 19:32:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345336AbhKOT2G (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 14:28:06 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F28F6C05536D
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 10:50:31 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id m15-20020a170902bb8f00b0014382b67873so5772835pls.19
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 10:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=MagPdJgjIh5Ud9HZC5HqusMVjCG//Nvcgbih+Mrzz7o=;
        b=s2zYqZPQaN2rqFgTo+54a5Yx3gDHnMVgZtKJV0Ob4nP3ADpYfbjFFfpwUnRrHTNIC6
         1ujoIWVD6V6zUIwmYA0nMugqZo9kweRqSp+5B9a6nXJ7HlSAXbgLy4PSfQllCYkJOJof
         lcJ/wkdH6KWDEuof1o33YYeh2t1FhhYGhKEzmH7YjxJdvpbbAd4Gzs4HlDB7k4FiYYRS
         Njzbgx7w+zs/MRJQD4kVtFzEwM33AD01lrFDUBnU+PkdxbcovL5iqO9R7KizuoNCjGxH
         6fLl/kUkoEWpvUOCtYYc0Ar4FGJ0G9/MLCtug+lH4mT6beJx+5IcVjZh0VkRarm0hFzm
         tHIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MagPdJgjIh5Ud9HZC5HqusMVjCG//Nvcgbih+Mrzz7o=;
        b=W+F75ct4Ig9vED6qCuiL+Eoj/KfcF5tu7J7EfmIazXpNoE7ufnMCnrEKhFlF/R4vTf
         bnO0fi/X+UaZUnVgQW3Sdf10i6dv4gDpfSjGXK5RQlMJExogeRnvBfvdpw0nSNyh+UM/
         3MHSADC2hlNtWWsMrSfNfkL17LoHHur57XebxRdVNWtbfkyG1vmXNSZmKwREPo31A2BP
         19tDo7u2kmRYz56pmXBmPFFgrbEcQfiBeSHh9wP52mzyG/Lzu00ZF0tdDgeijyeCyZRe
         GkVPr+NSAbWd+9pv10MPk9Lcho8h/yz3Ub5c7NMxu24AFbclirPONYrTgSKejQL7GMoC
         sdoA==
X-Gm-Message-State: AOAM5302SC+7i+akTQrqVTf/522jvX8xNeZSatlDrShC0tvnodFLyRhS
        dMECFEi2Z4WAMangI8siEls2SmMg85hdO6ypwQrN
X-Google-Smtp-Source: ABdhPJxyROD0H9Cew/NqjxyJ9iMrBr9iwQf4hqrun6Nqa9EV2rBkBBkdbMg6uqUnkbcsFOwz/lFIiBTWJZxAbRZbQI0S
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:6b07:b0:142:852a:9e1f with
 SMTP id o7-20020a1709026b0700b00142852a9e1fmr37487853plk.29.1637002231484;
 Mon, 15 Nov 2021 10:50:31 -0800 (PST)
Date:   Mon, 15 Nov 2021 10:50:29 -0800
In-Reply-To: <20211028183101.41013-6-chooglen@google.com>
Message-Id: <20211115185029.1081720-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20211028183101.41013-6-chooglen@google.com>
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
Subject: Re: [PATCH v4 5/6] remote: die if branch is not found in repository
From:   Jonathan Tan <jonathantanmy@google.com>
To:     chooglen@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> In a subsequent commit, we would like external-facing functions to be
> able to accept "struct repository" and "struct branch" as a pair. This
> is useful for functions like pushremote_for_branch(), which need to take
> values from the remote_state and branch, even if branch == NULL.
> However, a caller may supply an unrelated repository and branch, which
> is not supported behavior.
> 
> To prevent misuse, add a die_on_missing_branch() helper function that
> dies if a given branch is not from a given repository. Speed up the
> existence check by using a new branches_hash hashmap to remote_state,
> and use the hashmap to remove the branch array iteration in
> make_branch().
> 
> Like read_config(), die_on_missing_branch() is only called from
> non-static functions; static functions are less prone to misuse because
> they have strong conventions for keeping remote_state and branch in
> sync.

This makes sense, but how often would this be called? Couldn't we just
iterate over the array (instead of making a hashmap)? If speed is
important, I think we could just sort the array and do a binary search.
