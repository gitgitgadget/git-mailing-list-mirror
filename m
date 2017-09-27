Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04429202A5
	for <e@80x24.org>; Wed, 27 Sep 2017 07:07:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751811AbdI0HHT (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Sep 2017 03:07:19 -0400
Received: from mail-pg0-f45.google.com ([74.125.83.45]:51319 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751136AbdI0HHS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2017 03:07:18 -0400
Received: by mail-pg0-f45.google.com with SMTP id k193so7284016pgc.8
        for <git@vger.kernel.org>; Wed, 27 Sep 2017 00:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=FtQnpjr3pNu4FeP0Py/bYpkl+Jvz2mZEcB9Chxg3h2I=;
        b=qV6KSsHNHSl4P0qmEtVsXyXBmQTs7eghRReSyAKwF/8UWLAfZKtVW49t+4Tfu2DQYE
         vCUw/ElBuFd7uVBAz0+X8I55cWaQtJ50Q2FEV62jsIKtJzI+9yWxt1v6rLNd6rtFjb3I
         lye7PsXHGZF2boM9BjNgz4Bn8n7/lVG30/LTS1kKoPdz0tFpO73m4XDnwdbHVb9Osi8r
         85Woni7zhZtyzReQSpQt0PeqqA3fochwnTrwOMbZ+WRwVTWJX5KawtxLSu1enk9cEqhg
         PR6pGhjr7SkWrdvimkLmWEcT7nd2J+CsWHnDQMfbF1wDAm/+/WHTIP+zpy3h0MZ4Xsx1
         Z3XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=FtQnpjr3pNu4FeP0Py/bYpkl+Jvz2mZEcB9Chxg3h2I=;
        b=S+LyD+okyjJ9vEooEkSxLPB/BJ9eXNROgKe2X14wJA+z83s5oULLPPH6rdyrb66BfU
         Rqj+y5obKLj8EJ+rUEisNR1SV0jAwH39yT/3qlEmn9NDGXcr/F+9fuMXD1QKbnuDb/z5
         VYYtzCutMpk5USug0UTRMr5zz5nac61ikG25Soa3cXVMWNyjdWVs7H0JiriU/K39+Faz
         wjGTicWvaJz0YJsdPZdzlBTXLEo7RgILhn8Ym1JZC9f6As0fTC2XhbzohKWueMsy6sCW
         CQVyWCQr1YiDQVxGN51q6DGXbctX5+teKPGq8XFAEC/5B4zDGtrqTl0Xb7dGtnCzjrhj
         nypQ==
X-Gm-Message-State: AHPjjUhOtLY98ubBGzZDBhG3sxBhfTaFiu6eDZBWiUQuwARj5OtEOQUy
        ymfsqOOKtnjmNTSlZkbRA7KT4jqh
X-Google-Smtp-Source: AOwi7QCuQ5ElP+v9jmkI5ViK2PKkSMrZoLuiAt43JO5z7vkvhKNl30+SB6OBaTwFPQcxqiRQt7MXwg==
X-Received: by 10.98.93.85 with SMTP id r82mr432740pfb.327.1506496037573;
        Wed, 27 Sep 2017 00:07:17 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:a541:226f:6d4c:7f7a])
        by smtp.gmail.com with ESMTPSA id y16sm17099394pfe.68.2017.09.27.00.07.16
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 27 Sep 2017 00:07:16 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/3] validate_headref: use skip_prefix for symref parsing
References: <20170927061644.gwlhxaiairiy2njp@sigill.intra.peff.net>
        <20170927061726.gat3ykqx4fdstzq6@sigill.intra.peff.net>
Date:   Wed, 27 Sep 2017 16:07:16 +0900
In-Reply-To: <20170927061726.gat3ykqx4fdstzq6@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 27 Sep 2017 02:17:26 -0400")
Message-ID: <xmqqa81g4o2j.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Since the previous commit guarantees that our symref buffer
> is NUL-terminated, we can just use skip_prefix() and friends
> to parse it. This is shorter and saves us having to deal
> with magic numbers and keeping the "len" counter up to date.

Ah, I should have read the whole thing before starting to type a
response to 1/3 ;-)

Looks good.
