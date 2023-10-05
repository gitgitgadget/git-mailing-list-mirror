Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C4C3E9271B
	for <git@archiver.kernel.org>; Thu,  5 Oct 2023 17:44:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbjJERoV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Oct 2023 13:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbjJERnr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2023 13:43:47 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2545C9E
        for <git@vger.kernel.org>; Thu,  5 Oct 2023 10:42:50 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-419787a43ebso7097191cf.1
        for <git@vger.kernel.org>; Thu, 05 Oct 2023 10:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1696527769; x=1697132569; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Gq6a8oMrNaZwUQppLZ/r+jid2JZDWlJeU77xlpR9Y68=;
        b=w4bL9yEoh7Dk4ziyXbLoCzHlKdPgTpCbyR3NO2fzNVh0Whvw9WdztmL1xMqivNJtM4
         Ru9kFLF8Wokir185Y9j/O7Bjc2PRL/BrCdxIpdzT94n/A2jtjoDSlniTxA1LdY7EL2K9
         07Yxngepagn9em8YX3mU1nvKWk9r/7sw1t/ui9N/J+b3QGHqyGvfFwjYkOQG7G19DHNr
         xYiybSAO/bljKqm3cLXPPmUB52R7XbbXhwRLlBXDdqj5fxYgb40d8R0DxWI4v+aXMUmz
         8jXcUZxo2mFf9zJHBUGAAHCW+QIWuESrMnbf4WBFxm9jspOBCy5zctMR8VqwkyXA1PMh
         1CuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696527769; x=1697132569;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gq6a8oMrNaZwUQppLZ/r+jid2JZDWlJeU77xlpR9Y68=;
        b=Z/WLtcj3jE7K/9vlBf1cdkuUAFjrJXbY/M6tBrrPTyxdoWyNJgySS+FHMy/1iyXyDN
         IZ85S98EzCScRD6nJ6zlvM3jIqaVs7jD4+7bwMJwCOTd5l5U8S4JwZjo5Ovn8bLE7wq2
         mWwJYvZM5I5J7lOU8a+11iqDllAoF5+1g+Rk4pkNfzu+8RRYgxP1ZnmbPPjO/B63Ns79
         x7vLgptsTNopRMsTEq5ctkgJ+dBCjRruN8saXH0+MpdvZLU70j4BpuJfCgCuu63MA0J4
         QzRVQdf5Bdg40oUXiFxQXHi0cudqH34Z2yfxAPbS+IyKzLXhrm/yAH72SfBja9dSq7j1
         YaPg==
X-Gm-Message-State: AOJu0YzU4oAPpUCclrFCpWkXdsW1KkA0jXAtghQ1tAkP/uoCygeJU9C3
        tgh8fqw8Mbax2GB3hVE9RKsxRw==
X-Google-Smtp-Source: AGHT+IHFpgdXVs8Ajysh10gs48f0ETxS7Hn32jfUbX6srARgOhz4nyjQe43x2QqV3lmubnSYJLKwCw==
X-Received: by 2002:a0c:ab06:0:b0:64a:a5f8:6314 with SMTP id h6-20020a0cab06000000b0064aa5f86314mr5744161qvb.0.1696527769178;
        Thu, 05 Oct 2023 10:42:49 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id s13-20020a0ce30d000000b0065b0d2f9121sm656654qvl.68.2023.10.05.10.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 10:42:48 -0700 (PDT)
Date:   Thu, 5 Oct 2023 13:42:48 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 04/10] commit-graph: move slab-clearing to
 close_commit_graph()
Message-ID: <ZR71mMhMMvEpVidN@nand.local>
References: <20231003202504.GA7697@coredump.intra.peff.net>
 <20231003202752.GD7812@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231003202752.GD7812@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 03, 2023 at 04:27:52PM -0400, Jeff King wrote:
> When closing and freeing a commit-graph, the main entry point is
> close_commit_graph(), which then uses close_commit_graph_one() to
> recurse through the base_graph links and free each one.
>
> Commit 957ba814bf (commit-graph: when closing the graph, also release
> the slab, 2021-09-08) put the call to clear the slab into the recursive
> function, but this is pointless: there's only a single global slab
> variable. It works OK in practice because clearing the slab is
> idempotent, but it makes the code harder to reason about and refactor.

Well reasoned and explained, this change makes perfect sense to me.

Thanks,
Taylor
