Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25CEFC4338F
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 20:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8D7660F39
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 20:57:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233155AbhHPU5t (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Aug 2021 16:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231698AbhHPU5s (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Aug 2021 16:57:48 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5881C061764
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 13:57:16 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id f17-20020a170902ab91b029012c3bac8d81so11499452plr.23
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 13:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=cRQA/Meb9xbKBHp/nfI0WxALaj1gho+sl5/WnkNJlwo=;
        b=vjUPgPatk+aFP9Qofc1bF63iQqlqbcT5HxlrcBd11fPt8mI18HDDAw4gpxZrDzaqiE
         A+KogkGXc6lC9FsHPJCFwaEK8vTc4pLcOnFp1OV+TYqq6IVbXvCFf/WFCVOYl+42sb28
         DNTrD/2Qptr1AADBchw4swEJAvlO5JguFUtd2ANm5z3mNxidgeWOa+GyRcIRcyDZ/hs2
         qvSIUwkqIXzz8GA+YDSCwgeVbdfugTWM45mf5bemdVYE8bvbo5lv8nnJyelRroPb2ist
         ttFn3kby1CZRd6V7ChdwToMc4+y7L2WI7dXW5kBBTVD04QEDP4ULmXKC3ClgIEWJiEk6
         2/Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=cRQA/Meb9xbKBHp/nfI0WxALaj1gho+sl5/WnkNJlwo=;
        b=bhx4vOnHKn+92rhl3t17EeGKe6VkGOFFi/RWOveH04zLRxhHg3z8qBujstra5k+jRW
         VNZ7/wtKCykNMlKeX0i4Xx68e3IbBOOq28ldv/2yq0F7t+T2tU28HUyl5HzbC78QEmQr
         owuBmf8SD2YP3YQOpyOhDrz5YuOIHlFGwBBdEMEHlnGs1OpMZba0gaZ1r5T0hOhJly45
         trqXUEnCIwaJHcqALOD/Y/gPlLAJjL6fPoLEccPRegh3DnLqSJE4oSW7pYiSPK5/wfxN
         p9NrkoFBaQHUOBRhtgnHrqFumG9vVm4MZZW8ztHCOnJM/IjXf25P22tcl68a25MO2uGj
         mdhA==
X-Gm-Message-State: AOAM53297ijgvsAF5HEjmRyasTz4rRz97ZZLmWBq4A+DzH2NN1ZyT6sL
        /OrUL1csZ1OCNtVRwrMalQymZuYPbwmE0gr9axuq
X-Google-Smtp-Source: ABdhPJze3oPesH+D2ohw1UHZevsKoTCDkLIpsImOv5dNj4KxlOuMQbGGGiDxTjYvTc+YHZ13KnhjaJEGSvxsyBgbEp9w
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a62:cf86:0:b029:3e0:7cef:9e03 with
 SMTP id b128-20020a62cf860000b02903e07cef9e03mr90564pfg.0.1629147436191; Mon,
 16 Aug 2021 13:57:16 -0700 (PDT)
Date:   Mon, 16 Aug 2021 13:57:13 -0700
In-Reply-To: <20210816200938.1639871-1-jonathantanmy@google.com>
Message-Id: <20210816205713.2924648-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20210816200938.1639871-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: Re: [PATCH v2 7/8] submodule-config: pass repo upon blob config read
From:   Jonathan Tan <jonathantanmy@google.com>
To:     jonathantanmy@google.com
Cc:     matheus.bernardino@usp.br, git@vger.kernel.org,
        emilyshaffer@google.com, gitster@pobox.com,
        ramsay@ramsayjones.plus.com, steadmon@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > > @@ -1827,7 +1829,7 @@ static int git_config_from_blob_ref(config_fn_t fn,
> > >
> > >         if (get_oid(name, &oid) < 0)
> > 
> > This should be `repo_get_oid(repo, ...)` now.
> 
> Ah, good catch! This wasn't caught by the tests because the submodule
> config mechanism always passes a full-length hexadecimal string hash as
> "name" - and probably would never be caught because
> git_config_from_blob_ref() is only called from config_with_options(),
> which is called with non-NULL source from only 2 files:
> submodule-config.c (this one) and builtin/config.c (which most likely
> will never operate on any repo other than the_repository). I'll refactor
> the API to avoid this situation in the first place.

The refactoring I was thinking of was parsing the OID in
builtin/config.c and then passing only the OID (instead of a
user-provided string that could contain anything), but that doesn't
really work because the user-provided string is used in certain outputs.
I'll just change it to repo_get_oid() in this patch.
