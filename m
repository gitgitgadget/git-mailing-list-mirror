Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6B43C433FE
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 23:39:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238568AbiBPXjc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Feb 2022 18:39:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238561AbiBPXja (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Feb 2022 18:39:30 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 225DB1A276E
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 15:39:18 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id z10-20020a634c0a000000b0036c5eb39076so1949376pga.18
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 15:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=iO7jmuartNCWZevhS48yfgRYOpZLeeg87TBHdSUtGXs=;
        b=Zz5JwNhEkZmTPxhThQmHpb/KqRjn+dhxdVyg+gHazFIQZruN26YwKf+1xm7ChYrch8
         sZyaFlRnt/kZ7AUhLA5sT8wm2MXWrSsBaLGfwQZV0d0h23/V+8kFXH5TxaOlfluMf0CX
         rlutT6FyZT6jyKk+KSYf1/S2ElzzT3wWHof4jgV4Lv6an21kUoERFsJ8MDDr2xkpRMPl
         pxb9pDHd4so/B6QwNfRzyJGaYCnLQTXjZ2W/y+Vw0++G5rGKok9jLQOII+5153rpH9j4
         NZf7tM6VdvMQx9RGAJ3pL3X3c5fpknMI2IpL3w+ozmDHu2r4sS1ryB2DDg7bYthuQK2w
         /Iqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=iO7jmuartNCWZevhS48yfgRYOpZLeeg87TBHdSUtGXs=;
        b=WfJM57OxfBqT0TLX+7fiCgdJ+fFOmRwJHth6uA1m7n/sIupVnS1nvJPkqHeeY9ZUNp
         2FcrvMF4pRT2UeswEfvz7pFNlIlOn/Mt+fje32oGShIxZ8qTww0SLPKZG2q7E8ICkX5w
         XSaY9lX1+vGyQcApJdibKGdCRFjB/HjLfmQEl/MH1Lwf0A0tk6akcsINRSgRPf3Dvizh
         S8CddD41nEJE1H0gjTA8E6a8DaZScYAOvdQ89Er2R2a0dZPo1Z/8t0VBydmierONu4Zx
         4hF/jAu2OM8eY3sKfIe11q9RBzMoqpzuX6Mr+Em0N+fVwxsERn2Lhc/2uUnHYpmyrQT/
         qPFw==
X-Gm-Message-State: AOAM531eVtVVDTi/9wfb5gjh/keyU1b6zvAjsrH5Wh48CsZMauqH3Zzh
        ZXAG3wTsYe84xSU1FkyH+MycjN5hyU8cAGfUdj7G
X-Google-Smtp-Source: ABdhPJy6ocDFOs1fx9HTIRFpCq17S3Ea/It1U2Q3hayDfoHldPStJH4gZmfD3VQPNNO7fV8+MCSKDrVItS0yLEhPhLhl
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6a00:a92:b0:4e0:57a7:2d5d with
 SMTP id b18-20020a056a000a9200b004e057a72d5dmr398412pfl.81.1645054757655;
 Wed, 16 Feb 2022 15:39:17 -0800 (PST)
Date:   Wed, 16 Feb 2022 15:39:15 -0800
In-Reply-To: <682f16117b743bec59c533e15ae5a88d39250222.1644565025.git.ps@pks.im>
Message-Id: <20220216233915.1975217-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
Subject: Re: [PATCH 6/6] fetch: make `--atomic` flag cover pruning of refs
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:
> diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
> index 93a0db3c68..afa6bf9f7d 100755
> --- a/t/t5510-fetch.sh
> +++ b/t/t5510-fetch.sh
> @@ -349,11 +349,9 @@ test_expect_success 'fetch --atomic --prune executes a single reference transact
>  	cat >expected <<-EOF &&
>  		prepared
>  		$ZERO_OID $ZERO_OID refs/remotes/origin/scheduled-for-deletion
> -		committed
> -		$ZERO_OID $ZERO_OID refs/remotes/origin/scheduled-for-deletion
> -		prepared
>  		$ZERO_OID $head_oid refs/remotes/origin/new-branch
>  		committed
> +		$ZERO_OID $ZERO_OID refs/remotes/origin/scheduled-for-deletion
>  		$ZERO_OID $head_oid refs/remotes/origin/new-branch
>  	EOF

I think that there is a comment above this change that needs to be
deleted too.

Overall, I think that this patch set is a good change, and I have no
further comments. (Regarding patch 5, I can't think of a better way to
know what refs are duplicates.)
