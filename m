Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F54C433B4
	for <git@archiver.kernel.org>; Fri, 16 Apr 2021 02:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C68516113B
	for <git@archiver.kernel.org>; Fri, 16 Apr 2021 02:47:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236513AbhDPCrY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Apr 2021 22:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234961AbhDPCrY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Apr 2021 22:47:24 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA0AC061574
        for <git@vger.kernel.org>; Thu, 15 Apr 2021 19:47:00 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id 142so2877213qkj.1
        for <git@vger.kernel.org>; Thu, 15 Apr 2021 19:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=HerMPBiJd2OyZhC0AqH8AqJ8ZgR9D8g8EYI8fWh4vSU=;
        b=sXQlIKDEMQ1/EakudgLyYNu21xEX9fQM0gpNABC1KkbW3KJ2DZEVL5Tg9oZ7ryN7zu
         xdeRcbdxIcv/BZKb6L0Wa/xQrtnAKH8U90RiREnwyW7QcDBCMZ3KQnh0pm4fivG2H5CV
         cV57c5bu5f2esPHZgtR3V7i8ZO3yw0cZBAaB8HQ1xss3e5fLwZz/rW2tziXdrfcKmPOx
         33663E8qNi6c6jUGPc7xLU9LtQXgkR3Jzv3NRDm3VW5hnHFglr9cnBlK6loFb1ltl8Y7
         opUfQcnEyxCu1WzSfmNHfzAAvO0hTx86wohXyUt/Ts4VTJPQUpq7tAZ5GaKrb5Fug0mM
         coJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=HerMPBiJd2OyZhC0AqH8AqJ8ZgR9D8g8EYI8fWh4vSU=;
        b=fycP+SR4UmI1vJCH2K7bNx2RaveLSLh6G/iTiIBqMlm/ZI72NmbcPwzRO8WsH+2D7D
         qW05O8Su95ZJma3E5eqCMaRCBGhkb9/2uNI+trgD5W0s+TJNDN72QMuV/JaZWRvuboWY
         Zir2hB3QpgYioz8J0DTb2s+Jttm7S3Iw7GZHPMJptAyhJyIkOa/hXd+4lgW+f+r76UnC
         IxmgCpB681uh7lYj8jrMvSmEkuGuyAzj8dHdPRLNT07KNW4BgsxnZBjQGZtQxJoK2fmo
         IfEaBiOKXNGPx4/EmIm5zpN5/FHJBgLuHYmotbxhjBI1hCQNMCjEbhZcuHrRYuIeHawx
         OB0w==
X-Gm-Message-State: AOAM532vwY7f87F6O1VnZACA0TXaPqng4jwhFjVnbUPx7o0bXp/ocQn1
        G1tM9PvEIr+TmxpBifYs4dyl4yY++FjMCoGIh5hb
X-Google-Smtp-Source: ABdhPJywX2MUyyIdDm5eWaEqRy8QJ940ji4xN28Ju7lQYHQq0sLWi7Dco6aqxFX1YYSiWDbIx4vissu4ZEXvZf0CsjaR
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:ad4:4944:: with SMTP id
 o4mr6233382qvy.18.1618541218867; Thu, 15 Apr 2021 19:46:58 -0700 (PDT)
Date:   Thu, 15 Apr 2021 19:46:57 -0700
In-Reply-To: <d199954ef2246165f32a4f703d1e0ebf43847152.1617991824.git.me@ttaylorr.com>
Message-Id: <20210416024657.17563-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <d199954ef2246165f32a4f703d1e0ebf43847152.1617991824.git.me@ttaylorr.com>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
Subject: Re: [PATCH 02/22] pack-bitmap-write.c: gracefully fail to write
 non-closed bitmaps
From:   Jonathan Tan <jonathantanmy@google.com>
To:     me@ttaylorr.com
Cc:     git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com,
        gitster@pobox.com, jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> @@ -125,15 +125,20 @@ static inline void push_bitmapped_commit(struct commit *commit)
>  	writer.selected_nr++;
>  }
>  
> -static uint32_t find_object_pos(const struct object_id *oid)
> +static uint32_t find_object_pos(const struct object_id *oid, int *found)

find_object_pos() is only called by fill_bitmap_tree() and
fill_bitmap_commit(). fill_bitmap_tree() is only called by itself and
fill_bitmap_commit(). fill_bitmap_commit() is only called by
bitmap_writer_build(). And bitmap_writer_build() is only called by
write_pack_file(), which has been changed to die when
bitmap_writer_build() fails. So looks like everything is accounted for.
