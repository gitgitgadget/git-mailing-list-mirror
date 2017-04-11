Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 386E420970
	for <e@80x24.org>; Tue, 11 Apr 2017 16:29:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752401AbdDKQ3Y (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Apr 2017 12:29:24 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:34096 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752359AbdDKQ3X (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2017 12:29:23 -0400
Received: by mail-pf0-f181.google.com with SMTP id c198so983496pfc.1
        for <git@vger.kernel.org>; Tue, 11 Apr 2017 09:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HkMvYXeVHcoIDrG3LUWegrQtjC/6T/0rt0Y2ZOeR96I=;
        b=Vmi2/wYnp2ghd9vMNFj8qQsdDWR2uVVrt1Qe0+o+HehM0LzpN/Xu4jGUaCGm+WwgaG
         T/IgeC6Q0CMx0HM5ZYM5u/9UKicCO/Ctb8nKxiBU82RZWEowsRIaXOVWfkvm907+zVD6
         N7QvUVZuH73pXT37AVrJKv6HwGMgvWTZXnC+bg32XH6q6GScl1F7TYJtvgu5mWI4OHV1
         pgMHFXoDKyon0JKt7xkKcD/oSeBN0G5Xol8Qu9OJBBUzbhFuFiVKpsF2bpVBldo8V2e3
         2YsF2eqBsZ4IGDlO3woy78HjAp7dW8XsH6oYgOrPQeBgiGUpGAcpjglHuVUKYYSiwHXk
         rAyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HkMvYXeVHcoIDrG3LUWegrQtjC/6T/0rt0Y2ZOeR96I=;
        b=S1nC1OUT74v0B0DpUdplibHLZ5K+YcPpToB3V0oDsy+ZJFj7BYz0veRMrbjwkSBP/Z
         6c1zbqUhLUqpwmgRUQHnadVIPZRS0HTktYcCjSgKj946bjiRMmBHhv0Pyh5tkoApnCc5
         1mnxsXsfwcgbdUd7984bz+DMuq8W+pbAyeiCR4tC9wnsi8mLQ7gZeOgpdZY3xNjH/IJX
         e94CcOkgkujKQZhQSAPiTt9MbQS96LhBxQ6t/i5uab9To3pfZtqKFHIv1XuNYOWnA5yx
         yWgtbCgcjrdVq5nC5uy2prYwag3Js2SwQEZOk8w4rX30LF2nS94WEMpPKH1pCmbsE/ic
         VirA==
X-Gm-Message-State: AFeK/H2RF0XNaGxIJURRzT2IvY/FjiS+0vRBijCzaDoiqv1Ld9x5bymT4tQA+CyqRGZAzHxT
X-Received: by 10.98.110.193 with SMTP id j184mr62195686pfc.228.1491928162507;
        Tue, 11 Apr 2017 09:29:22 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b10:9591:6d62:26a:6d59])
        by smtp.gmail.com with ESMTPSA id 189sm31582054pgd.30.2017.04.11.09.29.21
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 11 Apr 2017 09:29:21 -0700 (PDT)
Date:   Tue, 11 Apr 2017 09:29:20 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Eric Wong <e@80x24.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 6/5] run-command: avoid potential dangers in forked child
Message-ID: <20170411162920.GA36152@google.com>
References: <20170410234919.34586-1-bmwill@google.com>
 <20170411070534.GA10552@whir>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170411070534.GA10552@whir>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/11, Eric Wong wrote:
> Hi Brandon, this series tickles an old itch of mine, so I
> started working off of it.  I'm only somewhat concerned
> with the path resolution in execvp(e) pontentially calling
> malloc on some libcs; but I suppose that's a separate patch
> for another time.
> 
> Only lightly-tested at the moment, but things seem to work...

Thanks Eric! I'll spend some time looking at this patch later today.  As
for the path resolution in execvp(e), I guess we could completely avoid
that if we did the path resolution ourselves, prior to forking, and then
just use execv(e) since it shouldn't have any calls to malloc in them
correct?

-- 
Brandon Williams
