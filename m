Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD0BC433EF
	for <git@archiver.kernel.org>; Wed, 27 Apr 2022 17:07:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243804AbiD0RK2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Apr 2022 13:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243791AbiD0RKZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Apr 2022 13:10:25 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AEC8FD2A
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 10:07:13 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id g23so2667455edy.13
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 10:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FpDiGQnp1Nu+45j/747eMHFnTtINpjPoNCKuSm/d1GI=;
        b=bxlP1pzs8oFfc8Nrsv6xieZAFbvS5KHUYopvzrlaB/se+5td4VNVkZXE57X90IeGjq
         0eDOnUB6vBr6RPTSQwbvmjN0W4Co7v/96dvEfhetxX4vBjGHASSWUCjkUTbLOn1fzCyw
         b0j8AmzREGoR9j/riPmZTjrjgzVLuu0DmSTVhgHUN7xvHwhwJpGVybsPry8vyUE1kiKv
         L4LkT/1H1XY9HubCEs7W8vWdYY9EAqfbGIO75H8ZoUMIHmKCk8hz2My7QKeonjKcHxvl
         Z19itLv1X+IwdFLrbz1AgbGD61LbKvoi5j8drWfvxx4F6xT4OMeeLADQGENGXe/0Ghub
         h6tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FpDiGQnp1Nu+45j/747eMHFnTtINpjPoNCKuSm/d1GI=;
        b=KzVEXevji4aG7hAEo5AWaWKRtfDMQoW4Z87MMpJHGZMcUwhbdaOf6YFmQOxrngjdu7
         XfGcVt9P3VG6emHMB0uhBbrGf+zB+oaDauN8oMkQ22+2Wkzcsztu6Wdd+NCe2xOAmSQw
         qLZFAXYXK7oi1jIZj5Os+WXgIKeK4bHxHMJv8mCyfTj/lhwBTF106FMlzSQWKH4ZyuBD
         JIxkXJBQk0Vs9kqBPZCwJfOohn+wv4kiENApXqKEpHRXhV4+v057HdnNirCXDU12LHi/
         Paf6JVNwfz5Qid9i61dQb+ZWWsr0pW1TpPzeoTyGUH2HKo2tiAdJk7K0jRyRfub7GaGh
         eqSQ==
X-Gm-Message-State: AOAM530VMW0AMA1CEhFjVC45nAepGa9SO8M7+Uepmj5IilZSa6MiDQau
        ChXOjAfMdC6dTM6trUwED8Tz9Vf5EY/+RA==
X-Google-Smtp-Source: ABdhPJx5ZXzn7HQB9hkRbyILWPDNYX7iKD1RG/L7WakTnwoV/iI989GNjkzk0K7/OoOKisqlzGFi5Q==
X-Received: by 2002:aa7:d416:0:b0:425:f5c7:d633 with SMTP id z22-20020aa7d416000000b00425f5c7d633mr13454335edq.105.1651079231566;
        Wed, 27 Apr 2022 10:07:11 -0700 (PDT)
Received: from buzz.local (62-165-236-195.pool.digikabel.hu. [62.165.236.195])
        by smtp.gmail.com with ESMTPSA id jl5-20020a17090775c500b006f3b76a87ffsm2748849ejc.51.2022.04.27.10.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 10:07:10 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 0/3] t0033-safe-directory: test improvements and a documentation clarification
Date:   Wed, 27 Apr 2022 19:06:46 +0200
Message-Id: <20220427170649.4949-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.36.0.676.gf39b21ed98
In-Reply-To: <pull.1215.git.1649863951.gitgitgadget@gmail.com>
References: <pull.1215.git.1649863951.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add coverage for the cases when 'safe.directory' is ignored, a minor
test improvement, and a small documentation clarification.

SZEDER Gábor (3):
  t0033-safe-directory: check the error message without matching the
    trash dir
  t0033-safe-directory: check when 'safe.directory' is ignored
  safe.directory: document and check that it's ignored in the
    environment

 Documentation/config/safe.txt |  4 ++--
 t/t0033-safe-directory.sh     | 30 +++++++++++++++++++++++++++++-
 2 files changed, 31 insertions(+), 3 deletions(-)

-- 
2.36.0.676.gf39b21ed98

