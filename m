Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A91CBC7EE23
	for <git@archiver.kernel.org>; Tue, 16 May 2023 00:17:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245507AbjEPARN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 May 2023 20:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245312AbjEPARL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2023 20:17:11 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B036D61A3
        for <git@vger.kernel.org>; Mon, 15 May 2023 17:17:10 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5618b2341d9so2556287b3.2
        for <git@vger.kernel.org>; Mon, 15 May 2023 17:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684196230; x=1686788230;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bQGuqi4dw34XdLMIVs36UPzzeEvntq3patIGMcE/xpA=;
        b=CylprvD14h2HqalprB0Rq/MqRrvN1B8E7iv3DswVNZEibiX9h+QWnUCW4vXZWNd/fc
         VyyZGlDDLj9S6ZC941JZYP71AqiZ1d0tqsl1iYovlGACRJ0W/p3unrJqoGtIIB9HbICh
         V7AgRMCD4hA8aBA1beowcrBeQ0oDWBpgubTPWQ9pyYFt/JLv8fvFqOlaavLHm82W+C7j
         cgSL7t8KZWw2APlJaHNIEKhj5t1Vl1JgA/5VQ/S1y3B9O5yj5mkB7fudVitAI/rRbfuu
         9QaBA3LafehRbNB6PpJ8k84on3gtq25LQSSRF9+AuvafPns6uYcMxM8Tw0gEYfXJmezO
         AFhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684196230; x=1686788230;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bQGuqi4dw34XdLMIVs36UPzzeEvntq3patIGMcE/xpA=;
        b=CKBza4mHuU2yLChGaFFWS0txtFJ5cvrO6IrYyYZRLrpqvJGVYcwEkMx4SPPskZKh3j
         26lS/ZlmGSxAG/TJkX5BiCej65Na2J2gISQps878v/SLORpmvTKp0Lrx0/bzykYI/WzN
         C6tiMYCSBPjmM9o33VdS2++wUcwwpqX8qik9Fj8n8+n3HogUu02Lrzr4ZPfAEALT40Ii
         v6WxHZplbglBvYdieQMAZQUW71WNzqphM60kDdMKxvmv4iGoqI3fhWb5t60DtsCowdb7
         C/DNArDlHnIqj/nqdlW41Me8pYAIUwkrMUifrfx8xKRVpAPpmusxCyXO9y0RMn7r2cEK
         KK0A==
X-Gm-Message-State: AC+VfDx41CM0lVyB5rBOhwj10PmwTOe8QSMayfWCX3jIpHCwONHe2jwS
        isiksBqnrfRGsMU0PIvdW97TRCyp96zaUfdRxuet
X-Google-Smtp-Source: ACHHUZ4aIYzpgo9/fkwN7fsC9BXedJ2IxdsZBH2IaVrEYDcBd1XIwVhZJ/M4BaSXqAGPeXTbXbKDW6dxA2GBC8pxPreY
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:3aab:56bd:1f4b:d239])
 (user=jonathantanmy job=sendgmr) by 2002:a81:b70b:0:b0:561:8fc0:24af with
 SMTP id v11-20020a81b70b000000b005618fc024afmr89315ywh.9.1684196229989; Mon,
 15 May 2023 17:17:09 -0700 (PDT)
Date:   Mon, 15 May 2023 17:17:07 -0700
In-Reply-To: <bbe64fccd5289aa6fc65d1301110812d71bb6f63.1683875073.git.gitgitgadget@gmail.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Message-ID: <20230516001707.1460816-1-jonathantanmy@google.com>
Subject: Re: [PATCH v2 27/27] fsmonitor-ll.h: split this header out of fsmonitor.h
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
> This creates a new fsmonitor-ll.h with most of the functions from
> fsmonitor.h, though it leaves three inline functions where they were.
> Two-thirds of the files that previously included fsmonitor.h did not
> need those three inline functions or the six extra includes those inline
> functions required, so this allows them to only include the lower level
> header.
> 
> Diff best viewed with `--color-moved`.
> 
> Signed-off-by: Elijah Newren <newren@gmail.com>

Looks good. Thanks for this significant effort.
 
