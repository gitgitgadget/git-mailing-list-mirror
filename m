Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE042C6FD1D
	for <git@archiver.kernel.org>; Fri, 17 Mar 2023 20:59:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjCQU7j (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Mar 2023 16:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbjCQU7f (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2023 16:59:35 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE5361AB6
        for <git@vger.kernel.org>; Fri, 17 Mar 2023 13:59:13 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id m13-20020a25800d000000b00b3dfeba6814so6360815ybk.11
        for <git@vger.kernel.org>; Fri, 17 Mar 2023 13:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679086751;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dA1oI3Pz9W0xmiFaFCtKwUEGwpWxmR80ppA/QWrCX2I=;
        b=D86LOaa5HlO+QBkUFUs/UxQVZJW+qjfsRbM7ANTocO/Joh1dBbmpNplZaU1AiuGxVw
         55I0ThPSCvXcXmN9zh3Qn0Yv10hg9T5lT1lu+ImsNUggQRDvFl2kmTATOOz9CYORwbMw
         PYbhiFhGzCbezooSyZ8cxFv7+INA3l6tnT9OuRPQncH93BzgWkHnnd1Ln4TqN3DWRY55
         JEF146suN2wykmtFzF6VXWspDVQenvXvDQeWFZ1y/cpp+znshjAlsVkBfShLh/q4e2yo
         eNY/zLmeFdZYMJPp0XunCgS0h/aOrSqUwmTkK64oo8+Uf5elBcklu8RCI3MKP2/qJ0OI
         nvBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679086751;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dA1oI3Pz9W0xmiFaFCtKwUEGwpWxmR80ppA/QWrCX2I=;
        b=uE6AYMZP+2jPuG4t6B8efAba9aC4n7Ynhw9eNd6VdLZEX6/PJ3PHAukYgv2PYj6QOa
         tFh3TlkqOc9B+BzRoWrdgIOzesSwq7JVdg84xjb7Rcx+d7MO9f7zxZZGCWqN3L+POi5J
         FJFDrvtPTpTqE84SQYXIUnZC3a6TGcjHVvlop72IbAX3Yq6jBWGb+W75/Dydcbobulcm
         LawjxQlLdX8hOvNGAQ7mYtt52mevXjGXB1CSiX5Mseg2haW1KwRyMk7h/4OL2iHAxFD7
         az6vdq8vs6cUBPfS+RvZAZLEZrJB3q9h8YmaYG6241yC0YvAgUoiPE8GsdNwLgC9vwLA
         voDQ==
X-Gm-Message-State: AO0yUKWjBrO0NYrzHZs50nU/+DmmhWWueJsBt0Ig1zgzsuQDx6V+xNTi
        BpUgANDJPdLJGbHr49lqSWpQSHRaWcRkAiCpwKaY
X-Google-Smtp-Source: AK7set9P8SB3gicSYup/x9VQKw3dhUZVbjGd8zY5wQXssH4a9vHa1eWxAdZsN0ksY8nGnhTkvfiRA4D4YDcJNwx+uRW7
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:97a1:d5da:aaf2:92eb])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6902:1109:b0:b27:4632:f651 with
 SMTP id o9-20020a056902110900b00b274632f651mr576278ybu.3.1679086751579; Fri,
 17 Mar 2023 13:59:11 -0700 (PDT)
Date:   Fri, 17 Mar 2023 13:59:08 -0700
In-Reply-To: <RFC-patch-5.5-2b80d293c83-20230317T042408Z-avarab@gmail.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.rc2.332.ga46443480c-goog
Message-ID: <20230317205909.1089309-1-jonathantanmy@google.com>
Subject: Re: [RFC PATCH 5/5] config API: add and use a repo_config_kvi()
From:   Jonathan Tan <jonathantanmy@google.com>
To:     "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Glen Choo <chooglen@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Emily Shaffer <nasamuffin@google.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
> This change is an alternate direction to the topic at [1], this
> expands on the vague suggestions I made in [2] to go in this
> direction.

Are you suggesting that we merge your patches instead of Glen's? (Or
maybe merge your patches and a subset of Glen's, but I'm not sure which
subset.)

> As this shows we can split apart the "config_fn_t", and thus avoid
> having to change the hundreds of existing "config_fn_t" callers. By
> doing this we can already get rid of the current_config_kvi()
> function, as "builtin/remote.c" and "t/helper/test-config.c" were the
> only users of it.

[snip]

> This leaves the other current_config_*() functions. Subsequent commits
> will need to deal with those.

I think we already know that splitting config_fn_t is possible but the
change will be quite widespread.
