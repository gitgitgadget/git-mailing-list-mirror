Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D94DFC433E6
	for <git@archiver.kernel.org>; Sun, 31 Jan 2021 04:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A422564E29
	for <git@archiver.kernel.org>; Sun, 31 Jan 2021 04:41:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbhAaEk7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Jan 2021 23:40:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbhAaEkM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jan 2021 23:40:12 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A79FC061573
        for <git@vger.kernel.org>; Sat, 30 Jan 2021 20:39:31 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id y187so8435108pfc.7
        for <git@vger.kernel.org>; Sat, 30 Jan 2021 20:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=Gy2jz0n82IsrRw3okj2wPihlegGvSzrJGC07FoBAXHs=;
        b=aPMRihf4UgmpFyKYJ5bQJeIoqhE0vSPUpxqOIFeFKP/7uLbZeUe95s55HSRxBs8ri7
         lWnei+1R/ZsaDSuh5NZTWujltDfUId+gYOClxclaCpKkiBGdvtcwYOVCWw4CYVqDV2pc
         efKDF8Pz7lhCCHx1a0LrdKIXNsnmAJJIxdGUVH1rWcgIaqwxFkzFVbT+Xw5aKcutATzN
         HeRF5RXHSAE0XC2Jtd5cTVc6piKakRorKLFdamjqJWFIGKW+H41+/zAxMoTIV306jhhz
         u+K2Pf8kWUuqro6aHPB1wL3B4xymR5UJdMfApfCQbRuf0t5dMk4rXOmwYSr63vf1hOTg
         aaHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Gy2jz0n82IsrRw3okj2wPihlegGvSzrJGC07FoBAXHs=;
        b=dt2IgAzxg5AgcFBHA7r0jDrk46n6HN5/iuJpVzLC0ay8ISsi3N4xTxFvymfbUdZyjw
         VXTKzc6xoFXCLBvr69xuxBsg7zlnOMXhvn62oOvXTXJhuf9hl/BYl7LIMjYllYL6A9An
         LWbcdzTa6x4FRmA2XecEpNEAXLCuf6oytdmRcLL3wOfBIc7VE7Ur8Txe4euA2X9RA39C
         9OXsRv2xF94riE3uz3Q9kYnlqug8T92HB5CwsUc2HotK5xdfdSpWEk7Lvo0avJYqKVI/
         od0kjULPqoYQtT4S2mjEyEh9ZgnnI0dg/YEpsC8H8PHpdZ6dbXdiTuul2n5Dc6vsgOdY
         9IOQ==
X-Gm-Message-State: AOAM533LZGUh6k9GHS1xkbv7GPvwTxPOiSRoA3QoblwkgOJ+peXe0OQx
        i7f5Nn/l8LuJpLFrn1GYaiNxbhGcxtmZ+jwSEWRV
X-Google-Smtp-Source: ABdhPJyt5B7qJIxUE+oa9T1Py0BCYNTIxHq64d70ET90J0GI8ZaNNFz9VXM4e+th4iahbsaZzIJ4uzWqQ7sBPqM9JIkP
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:aa7:909a:0:b029:1bc:22d3:9e58 with
 SMTP id i26-20020aa7909a0000b02901bc22d39e58mr10780528pfa.29.1612067970946;
 Sat, 30 Jan 2021 20:39:30 -0800 (PST)
Date:   Sat, 30 Jan 2021 20:39:28 -0800
In-Reply-To: <20201222000220.1491091-10-emilyshaffer@google.com>
Message-Id: <20210131043928.1036246-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20201222000220.1491091-10-emilyshaffer@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: Re: [PATCH v7 09/17] hook: replace find_hook() with hook_exists()
From:   Jonathan Tan <jonathantanmy@google.com>
To:     emilyshaffer@google.com
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Add a helper to easily determine whether any hooks exist for a given
> hook event.
> 
> Many callers want to check whether some state could be modified by a
> hook; that check should include the config-based hooks as well. Optimize
> by checking the config directly. Since commands which execute hooks
> might want to take args to replace 'hook.runHookDir', let
> 'hook_exists()' mirror the behavior of 'hook.runHookDir'.

The text makes sense, but the title might better be "introduce
hook_exists()" instead of "replace", since find_hook() is still around.

Also maybe briefly mention the future plans - e.g. in the future, no
code will use find_hook() except <whatever the hook-internal functions
are>, because all of them will use hook_exists() and run_hook().

> +/*
> + * Returns 1 if any hooks are specified in the config or if a hook exists in the
> + * hookdir. Typically, invoke hook_exsts() like:
> + *   hook_exists(hookname, configured_hookdir_opt());
> + * Like with run_hooks, if you take a --run-hookdir flag, reflect that
> + * user-specified behavior here instead.
> + */
> +int hook_exists(const char *hookname, enum hookdir_opt should_run_hookdir);

I wonder if enum hookdir_opt should support a "unspecified" instead, in
which case hook_exists() will automatically read the config (instead of
relying on the caller to call configured_hookdir_opt()), but I see that
this patch set is version 7 and perhaps this design point has already
been discussed.
