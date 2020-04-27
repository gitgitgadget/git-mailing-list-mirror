Return-Path: <SRS0=mOGp=6L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D867C54FD0
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 17:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2513B20728
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 17:28:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K3W2s+Pi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgD0R2l (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Apr 2020 13:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbgD0R2k (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Apr 2020 13:28:40 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58CFEC0610D5
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 10:28:40 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id f132so18565109qke.11
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 10:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=coMEcIyTRlZVxn/YrFMnXjgFQNJousZcpal2IsxfhpI=;
        b=K3W2s+PiV/J3PmDo3IxU2JtHJrqkZ6Mcs0W8DqQbkzK4bZjxELi+BWEccEW2XysvpK
         xrvZH3YG6BikPVL/3Wpoluoy9alkgmUYCq4rJketJG0re/j2pXulNQL03ippZpIwIVLA
         xwQRbeypJO0WlquM3rVMbXX5eGVsCg+edmr9A/Vd4ttuFdoOigLnvvizp8Uz6nRli8Wf
         0Bbp+EroyXQZ+5UeZFJg17xHPnJIPjUUu0IB7LiMH0pms4gBrWLIhUc8Bwnr4w97Je5e
         gwg4HC14d4JBmXXo5mYKQ5AVibMwOx3KOYqkoSqgfSh6OwxJOhPGxEClC9YBwnMwftDx
         c5rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=coMEcIyTRlZVxn/YrFMnXjgFQNJousZcpal2IsxfhpI=;
        b=nxFEDVgTiZEbU+6B4TLoJ+HXbrztQZdsYB9ZQZ3AU3wu1++M9nq92fJl0flLZ+u8oF
         1kQSAe1XXIYFCvlPKP9mmbAb6FeXe9FGJq9H6qfeKJnkJJvEn+jemU8zrff+qA6I/9d7
         3mVmADk/RPsREYaqtB/jHazw3vzXsp3Vj0yrDrjqC4Vu+IyZXFk1FL+QrZNmQF3iapGX
         tucyOxpmGNRUHG+ZJvwnb4rLNOunp9WBblfoEx3ggJhg/7UwIltdwE3o4sy1NSF07Jmn
         8g4hwOAOVAVVD0ydSegM7nSzHBXN9l7d9ZsMnhEbP5T2ol+aXSA85E/n5P8sq4yN9rWd
         WqSw==
X-Gm-Message-State: AGi0PuaK/ETO6oEb9/SorBzXBNecXkHVuH18PPuT4KoH5UuBB2nu5kzW
        7ZTDemmCVtaiQ/Uqh5ha7pScAZKSjhImT7VCqgxA
X-Google-Smtp-Source: APiQypKcqroVepNq1tHFoSBUfdoatzZlF5411vRIgEksTjn3xX/Xrk/JYRP6igds8Jq2Xth4Qg2lwx6D/zFvZvriHiRK
X-Received: by 2002:a0c:fcc5:: with SMTP id i5mr23159365qvq.14.1588008519526;
 Mon, 27 Apr 2020 10:28:39 -0700 (PDT)
Date:   Mon, 27 Apr 2020 10:28:37 -0700
In-Reply-To: <20200426011044.GF877@gmail.com>
Message-Id: <20200427172837.62068-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20200426011044.GF877@gmail.com>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
Subject: Re: [PATCH 2/2] fetch-pack: in protocol v2, reset in_vain upon ACK
From:   Jonathan Tan <jonathantanmy@google.com>
To:     jrnieder@gmail.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org, peff@peff.net,
        gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
> 
> Thanks.
> 
> As with the other patch, trace2 output from the server might be more
> stable.
> 
> Do these tests pass with protocol v0 as well?  (Forgive my laziness in
> not checking yet.)

Thanks for your review. Yes they pass with protocol v0 too (checked by
passing "-c protocol.version=0" when fetching).
