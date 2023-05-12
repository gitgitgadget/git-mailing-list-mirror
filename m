Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D21DBC77B75
	for <git@archiver.kernel.org>; Fri, 12 May 2023 21:28:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239614AbjELV27 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 May 2023 17:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240089AbjELV2t (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2023 17:28:49 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C9F0E714
        for <git@vger.kernel.org>; Fri, 12 May 2023 14:28:27 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5611211f767so38324297b3.0
        for <git@vger.kernel.org>; Fri, 12 May 2023 14:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683926904; x=1686518904;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bkuLqQDCcn87i+k+N5vQITuLnOE5RhMmMZSBcwktxsc=;
        b=i+dLP5g/xACkW4kayoeJH5He/NRPSo0XKY3GJqP2h1M7c+aJqE9szp+UzPNsbr3538
         CxdLe8jVORra3Bpz8rC+zvKc3UOlmxMUDE0WZRp56wFlUZHcTAtx/RTlPeWl0H0ymw8T
         YRNZPZONNX2U3PPU+mar+5vkFXY3/riHp/IZvsAjarKtq0DoWk+t0vPMF5ckCHGcg1T2
         2xWliIh2i6zmiIJ8Ps2vPDYRK+l+JInjFf3Orj03MSm9L7zOg2MjRsRB7yslSsDjID4b
         NsMwd14bU36xy1RhDaE8FYgJ4wgDOr+JoOy6WCRaUj5ttMhLmO9gR73x39Cub74gssk4
         wSPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683926904; x=1686518904;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bkuLqQDCcn87i+k+N5vQITuLnOE5RhMmMZSBcwktxsc=;
        b=ZO5ZIJswfkzXxlNoMEDfXcQyElPHTf08VQ13GtMEQVyHuhKXfJ0aJ4v0F/OGQ39LCu
         hejllYWht7jjevYNNWoSMBgYYFUNC5mvDf9FKy6dxu2NTQMTjmMrIGevhSqJjLK+jZco
         lFTOaJ7pR7EsTrZ32vInkN/OdBYaorHSYh/m7hrq5Okv+usEJaw4NB+/JWnRdIQcXSWv
         uT1Rfe6/MFwJGFK5ymYzq6SjT5Lal9uXz8kjy/IzjnGTypJWv2ysdSlVwZmMLvio2aNo
         l/LqwVKbELAjHqXCHl+tDklZFkB3MBXBBlMaHKA6EKtt3maXAp1V41oY1+E3MbQ62nJu
         dWeQ==
X-Gm-Message-State: AC+VfDwFIjUZGZcJgI3tNzpYOyjNVLxBK8f1qVKmbaIRk86PAX7M5RFb
        VzKdl8XC32iK+CAYKyI6d30kPvB2RuhBetn8ZFHC
X-Google-Smtp-Source: ACHHUZ7xEp7pQK0UejL/Lem59DhgG9rYtysYsxSHT/xhbsqzVvOk/pcRcdEbm/cVHpAjy636ykTQMe9GeUWmEZcdwCQr
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:fca5:20a4:493f:ac3a])
 (user=jonathantanmy job=sendgmr) by 2002:a81:4318:0:b0:55a:8fe8:4fc8 with
 SMTP id q24-20020a814318000000b0055a8fe84fc8mr15587616ywa.3.1683926904708;
 Fri, 12 May 2023 14:28:24 -0700 (PDT)
Date:   Fri, 12 May 2023 14:28:22 -0700
In-Reply-To: <3bc4dfeea901d9e57cee41666f85c783026d7e82.1683875070.git.gitgitgadget@gmail.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Message-ID: <20230512212822.1126697-1-jonathantanmy@google.com>
Subject: Re: [PATCH v2 03/27] init-db, clone: change unnecessary global into
 passed parameter
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Elijah Newren <newren@gmail.com>,
        Calvin Wan <calvinwan@google.com>, Jeff King <peff@peff.net>,
        Glen Choo <chooglen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
> From: Elijah Newren <newren@gmail.com>
> 
> Much like the former commit, this commit was prompted by a desire to

Could we have s/former/parent? I'm not used to "former" with this
meaning (but if it's understood by others, then that's fine).

> diff --git a/builtin/clone.c b/builtin/clone.c
> index 15f9912b4ca..cc34c194f5e 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -930,6 +930,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  	int submodule_progress;
>  	int filter_submodules = 0;
>  	int hash_algo;
> +	const int do_not_override_repo_unix_permissions = -1;

I don't really like this name, but init_db() is undocumented so an
anonymous -1 at the call site is not much better. For the purposes of
this patch set (getting rid of cache.h), this should be fine for now.
