Return-Path: <SRS0=1oE7=AU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1435BC433E0
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 02:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D777D20772
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 02:25:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NhZQ1jqq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726122AbgGICZY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jul 2020 22:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbgGICZX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jul 2020 22:25:23 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D4BEC061A0B
        for <git@vger.kernel.org>; Wed,  8 Jul 2020 19:25:23 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id n11so1101690ybg.15
        for <git@vger.kernel.org>; Wed, 08 Jul 2020 19:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=9obCBFPgQ57ufZYZ5j92wFNQLLeIzSXD2ItwRv0fxBk=;
        b=NhZQ1jqq4e9DCIJ0apKWZFr+n+8W5tKNWxsS8J+/TgSJ6CWhq59xKBRFtxjTweV0nI
         lN0yV86VMsqknSue4LqkIFP3Jbn8ugA9mZ2oVjsMl0LF0QcrHpLguwCecJg4cwHIbvmh
         psijOPeb9vGuQVjwcZ8kqsXevHUWLG7qNpaAYHt4TWf3JmULL3Q4LKpi8hRMZEWPnPWj
         j33ZmBtfO3jeZ/8pQ0mENVwIK6ILb7JGZ/mbWyrdn2c4ghtl8eUnWqalvTxG9DUyIzKo
         BtK0RCHuw8Gs6ZmTORfxAY0shMswtpJ02WtUA5dquR24yNbLEijQFPOJKC+nffLhGQu0
         +djw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=9obCBFPgQ57ufZYZ5j92wFNQLLeIzSXD2ItwRv0fxBk=;
        b=aU02cYWkGVMeAOaYY9WyazbntFbzgbCB+3A59/TvvuUnR3LMgLX/Woe75EmGDdfqW3
         x7Xp3HUcBmqlSOd2XfNoGWoLnEsKUJxv7DN+jROPr03Z12YGsX8XfmXqKPOd04cpGbez
         N1686AzojFz1mDedK0oCQkrqhKrL1ENuPdBQXHKtHPhQZEs3jDUzNcUO2aFxxUNhMKa+
         Vkck055fCT7rgFp+GEqGae/gKUrRKuIEbZCcGlz+CziRIShs9kc7YYfVK7lzYysBpESI
         C7b6QT2CalspekJCjI9ZYEaLa391fQ2HF5H2sx+fWr4RsvrKvAVGHkq9RYBj4b9dZbeq
         oG9w==
X-Gm-Message-State: AOAM530ixr8oU0NhMCEuYr3H1pJKFUoAjsAH+oaDpr4xh/0qWFw8JQHT
        gVzX0cZ5zOjImE62gDy7cgIvvADn3HLxvVZ217ww
X-Google-Smtp-Source: ABdhPJxbNO7Ur7KZp0adTL9VeeRIqIqnDOXUjSSQ+W5hEK5c6sRWgcHrnkUvVW9hUR+HrDALRyvaWXvMNFZLK6LUyt+C
X-Received: by 2002:a25:338a:: with SMTP id z132mr37666058ybz.316.1594261522756;
 Wed, 08 Jul 2020 19:25:22 -0700 (PDT)
Date:   Wed,  8 Jul 2020 19:25:19 -0700
In-Reply-To: <5cdd38afa60cdf768dd194f90ae0b2190123fdea.1594131695.git.gitgitgadget@gmail.com>
Message-Id: <20200709022519.38407-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <5cdd38afa60cdf768dd194f90ae0b2190123fdea.1594131695.git.gitgitgadget@gmail.com>
X-Mailer: git-send-email 2.27.0.383.g050319c2ae-goog
Subject: Re: [PATCH 08/21] maintenance: initialize task array and hashmap
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

> This list is also inserted into a hashmap. This allows command-line
> arguments to quickly find the tasks by name, not sensitive to case. To
> ensure this list and hashmap work well together, the list only contains
> pointers to the struct information. This will allow a sort on the list
> while preserving the hashmap data.

I think having the hashmap is unnecessarily complicated in this case -
with the small number of tasks, a list would be fine. But I don't feel
strongly about this.
