Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE1CC77B7A
	for <git@archiver.kernel.org>; Fri,  2 Jun 2023 00:08:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231942AbjFBAIq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jun 2023 20:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjFBAIp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2023 20:08:45 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB46D1
        for <git@vger.kernel.org>; Thu,  1 Jun 2023 17:08:44 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-babb76a9831so1932267276.2
        for <git@vger.kernel.org>; Thu, 01 Jun 2023 17:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685664523; x=1688256523;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=71tue5TMQVA8WHP6XIpcMzYTPt90AFSKoVHmi4zBmok=;
        b=52RRpDQEZEDDlCzjO7L+GoBhlQ2Kgns5M2glOusTkCdn7CVghyie39FAuWqM3CA98x
         hV2RJpDnjjUOeSUAnn341/kEgWe1RfKCQgmnGjbFP7TG9KT+qfjqS+VabHZMVGOsSAXT
         uFSeQRiRX84aryjsQ+gLDN9Plyg3UzuU+u4PQcGYWqNkjlO9tj8OwSAupJ00yuhtCGTH
         rQQ2fbYvaowMRJ+Vt2ISpv2iX6gdGmHWvNK6XgXDqQP/yeA7o5Ii09FyQ5nBcGn/tn8B
         BBT2UU/iFLP8Z+e09cOL5belyNhewMN938hZb7q/MNNjbcW94QGh3o8RyGamu8+wHpWV
         eGcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685664523; x=1688256523;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=71tue5TMQVA8WHP6XIpcMzYTPt90AFSKoVHmi4zBmok=;
        b=QPXy5+UikUSz8UnTLAdkEGIQATXODvLV9C1fItDQrUYHEve0/i5MzB4eLa2ftIJxob
         4SpRmeGyt0sMowIJ+3lxoX53qfihbp9cc+kZDa1tDyyeG3pVhDeYfwF/RBC/PpVJlMp9
         k+Uj/freYybGun6swB00Zq/SB8FzIw0PzktNswOY5Jhi6V3PwoLJAClrIbKS574rPZfJ
         Y0e8AyDijrHKyAJry/DF+ScEcMPJHbykgZmSIJYJ0zgQghcfPDEEhiOXEB3fE/7yG3LA
         PDwdAzSdEaslUNe80vyvgbYrIwDvOx9JXUZx6yvmA0fmjZjV6PrbZy93rLHcDqdJCXDq
         9a0A==
X-Gm-Message-State: AC+VfDw0tPC0Wfc5OLDidQ4WkaivCBWmOORwK4Im4p5LGROtvLqBTzr7
        lXYPKaWFMXZ1dCjHjuYiRFhmsX8izTX66JrdqoG5
X-Google-Smtp-Source: ACHHUZ4u9PzkY0iQY4KSqn/ctDnSCin33Cl3bDDdSm26jgDzfi7/AiTDe9Lx/F9iKHWqlszR47IbLseYytv660T0Ng/a
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:9bd:7d22:5bbe:5b1c])
 (user=jonathantanmy job=sendgmr) by 2002:a25:abc1:0:b0:bad:e8b:17d4 with SMTP
 id v59-20020a25abc1000000b00bad0e8b17d4mr613585ybi.7.1685664523770; Thu, 01
 Jun 2023 17:08:43 -0700 (PDT)
Date:   Thu,  1 Jun 2023 17:08:41 -0700
In-Reply-To: <9e35b5b1f4dbdeafca5be7516477dc033b7643a6.1685472134.git.gitgitgadget@gmail.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230602000841.434702-1-jonathantanmy@google.com>
Subject: Re: [PATCH v2 14/14] config: pass source to config_parser_event_fn_t
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, Emily Shaffer <nasamuffin@google.com>,
        Glen Choo <chooglen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Glen Choo via GitGitGadget" <gitgitgadget@gmail.com> writes:
> From: Glen Choo <chooglen@google.com>
> 
> ..so that the callback can use a "struct config_source" parameter
> instead of "config_reader.source". "struct config_source" is internal to
> config.c, but this refactor is okay because this function has only ever
> been (and probably ever will be) used internally by config.c.

Maybe s/this refactor/adding a pointer to a struct defined in a .c into
a public function signature defined in a .h/

So this means that callers cannot instantiate that public function
unless they are in config.c, but I see that it has been appropriately
documented, so it should be fine.

Thanks for this series. Overall I had some minor comments, but things
look good overall.
 
