Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 194B1EB64DD
	for <git@archiver.kernel.org>; Fri, 23 Jun 2023 20:41:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232488AbjFWUlP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jun 2023 16:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232508AbjFWUko (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2023 16:40:44 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7020B212C
        for <git@vger.kernel.org>; Fri, 23 Jun 2023 13:40:12 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-56938733c13so13740867b3.1
        for <git@vger.kernel.org>; Fri, 23 Jun 2023 13:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687552804; x=1690144804;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QErkryb9UGiHCXXDe2kIJlsEnth2iwntVC/j8hu/hPs=;
        b=cjpwSnd+LPSin5pC//T3xZmhx0VXWCfq2zxGBZmIoMpZyjNA/VETXwmOyAea9H0MZu
         RdvCzuiEjMuE27Kv7G/PCM589VmKTpYNXBzEfccEY5svCPfRLb+l0lYgOht0SQhmoiiz
         aCuhF3vStHTwrIHEyikGxtTctLAZiRHfMbW5s0QpDgr3CYoKZVJwogW5ekCsl5vyA3nn
         rRQrP/85txrVIk3Uyb8BOEUb3NPoNgJEf4SO8aWRYvZ56U9LBAzuFp1lYQco2AFtg/Ml
         EAChS6QdUZg0HfcipsdvV6j6ZxvBYwkaeqYzL3V0TbcVtHoXux/A8mjTs6wL3e5H72us
         1Tug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687552804; x=1690144804;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QErkryb9UGiHCXXDe2kIJlsEnth2iwntVC/j8hu/hPs=;
        b=C8ecOPyitVE7Yzs6y0l/EF3uvXcZYsoQlMsvtJdsrW5Gh1ryM/W2tpaRIwpD491ZPH
         tDM2pTEimLpy3zRckQQwfuWIdxQMEWR/6mlJ2FUD+aCycU5DB0gtgoE3fShJG+Lucdx7
         bYshWkKyXtboQV/IBt+NKCAoQGQAJdVQ2rJMlwhi20CA0YreIZpPNMI7Eb4KSVVXPo5D
         TCvUHIf7hlY7UXxMnzVgu4808uEEZXAKI8e0SXABqT5uj6ZejCwV+0TsvcdiNz5GFtum
         p7BLpv89nWeJ3g+wGcZfPWPseXSLfNmRTYz9aOuX08abF+Um89jD7Y1Q1AlUXaKq/2sv
         2uKw==
X-Gm-Message-State: AC+VfDyd6xGZtbW2gmcpNzL0/Ow0Y1zpceeg5UwzkFajPZUT+khOGAWk
        JuKjfIKWmnksZzooqD8XX60ZjYeKnD1SPujeFhCU
X-Google-Smtp-Source: ACHHUZ58JMB+PUUsrNeq9uoZLmCOuCov657vlrK3tnd3qzsKhjb1rSbnalcp4zXeKO6TPeSvfnohc5WuUDSOB9EgqUqH
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:7ab2:ee09:eab1:38cc])
 (user=jonathantanmy job=sendgmr) by 2002:a81:b647:0:b0:56c:f8b7:d4fa with
 SMTP id h7-20020a81b647000000b0056cf8b7d4famr9188967ywk.7.1687552804466; Fri,
 23 Jun 2023 13:40:04 -0700 (PDT)
Date:   Fri, 23 Jun 2023 13:40:02 -0700
In-Reply-To: <66572df7beb220b8f7d5ce2eb724fda55c128b94.1687290233.git.gitgitgadget@gmail.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.178.g377b9f9a00-goog
Message-ID: <20230623204002.3256359-1-jonathantanmy@google.com>
Subject: Re: [PATCH v3 08/12] trace2: plumb config kvi
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, Emily Shaffer <nasamuffin@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Glen Choo <chooglen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Glen Choo via GitGitGadget" <gitgitgadget@gmail.com> writes:
> @@ -125,19 +115,9 @@ static inline struct config_source *config_reader_pop_source(struct config_reade
>  static inline void config_reader_set_kvi(struct config_reader *reader,
>  					 struct key_value_info *kvi)
>  {
> -	if (kvi && (reader->source || reader->parsing_scope))
> -		BUG("kvi should not be set while parsing a config source");
>  	reader->config_kvi = kvi;
>  }
>  

We're removing this check now because reader->parsing_scope is
removed in this patch. Makes sense (no reason to just remove the
reader->parsing_scope first and then remove the whole check later).

Rest of the patch looks good too.
 
