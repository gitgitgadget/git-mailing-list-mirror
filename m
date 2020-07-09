Return-Path: <SRS0=1oE7=AU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47670C433E0
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 02:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0ECB7206F6
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 02:29:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B20sofxa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726228AbgGIC3q (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jul 2020 22:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbgGIC3p (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jul 2020 22:29:45 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 705E4C061A0B
        for <git@vger.kernel.org>; Wed,  8 Jul 2020 19:29:45 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id w35so1100869ybi.16
        for <git@vger.kernel.org>; Wed, 08 Jul 2020 19:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=SA5/roU6yVC0FyLuOElMvwMnpjba5cFZWMuPry22n28=;
        b=B20sofxaW8eePGyhC9Mz1/VFwyGXuyL5GtfhrCe6ZYXhuACn5AhTyG5/rcr8mij8gL
         YYWKjTMJsXWf5TF3fAcNSLGhbfr+xyBBpYVAKPhZapIhvHYwNWx/VJgSvVGBREmRZaKy
         p7RBgTyGZliFUK8YR0NXwfClTliUz2nTShy5EQf4qEhpKdOMaZpZfQWv0Ov6uRFgo7oO
         3FYCHbtLWJ/PbsksoY2bYuxlXPYRbY4f0IatRqnweA62A/IVbmzKgMnQOkMz883WU/Rq
         OcDcByHiUXn4RqD16sGrJJTT/AifULQ8SuaZ68kg7ghHxdDaFrpG5jdnl1LoUSQZ/g6e
         5BpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=SA5/roU6yVC0FyLuOElMvwMnpjba5cFZWMuPry22n28=;
        b=qnPfqCmNImg6tzbiwSSKQ0TaJmgEDCpk4Fmk+gqhtiBzEYe1JHfJzq36vi3tevwtfb
         hq3IYsU93Rpwcg63zeF7ia+Pf1ltGZR5IenyrGEsN3H2+12MBJ/tg8mM1gcqi34ROnVl
         MCi3b0SYw7lepm8J1AmGNaCtNQbY4rEiDakCsm71msukvq5G2Sglkg90Yt4V8MF520Zz
         /aPsCVd8L1cQrqMcvkn6LyJWNcHlDUJlAp+pOD9lS41z7pJSKXx15BndIkxKRmIwXPuJ
         2wX3gkXy7nMVNw5ADZiMX83CjQo7OxhKZTQPsv6f0dkVvT9f9oAvCSFnKW4gAKRLz56F
         ONnQ==
X-Gm-Message-State: AOAM530+xoCwrCpjIqMzSNAwPlP1cr5k3KRQcHkUbNbogb0hDG/mRp4i
        pPFKIPmG97+tZmDa1LN0O5p0jIKZFHR8aTT6lLUO
X-Google-Smtp-Source: ABdhPJyUXRUWjetyttfOkO6tL7jolruC74KUpMXKLoNwiphfVZ36qrgPCDLRfszB8v+YIKf3OD6qrgWC9TyO0T3wp8Co
X-Received: by 2002:a25:6806:: with SMTP id d6mr42559213ybc.124.1594261784694;
 Wed, 08 Jul 2020 19:29:44 -0700 (PDT)
Date:   Wed,  8 Jul 2020 19:29:42 -0700
In-Reply-To: <c8fbd14d41093e12905027ff628b98652cd931d0.1594131695.git.gitgitgadget@gmail.com>
Message-Id: <20200709022942.39848-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <c8fbd14d41093e12905027ff628b98652cd931d0.1594131695.git.gitgitgadget@gmail.com>
X-Mailer: git-send-email 2.27.0.383.g050319c2ae-goog
Subject: Re: [PATCH 09/21] maintenance: add commit-graph task
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitgitgadget@gmail.com
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        sandals@crustytoothpaste.net, steadmon@google.com,
        jrnieder@gmail.com, peff@peff.net, congdanhqx@gmail.com,
        phillip.wood123@gmail.com, derrickstolee@github.com,
        dstolee@microsoft.com, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> +static int run_write_commit_graph(struct repository *r)
> +{
> +	int result;
> +	struct argv_array cmd = ARGV_ARRAY_INIT;
> +
> +	argv_array_pushl(&cmd, "-C", r->worktree,
> +			 "commit-graph", "write",
> +			 "--split", "--reachable",
> +			 NULL);

As mentioned in my reply to an earlier patch (sent a few minutes ago),
this won't work if there are environment variables like GIT_DIR present.

Besides that, the overall design looks reasonable.
