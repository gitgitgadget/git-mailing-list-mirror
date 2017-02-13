Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1F161FC44
	for <e@80x24.org>; Mon, 13 Feb 2017 21:53:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753108AbdBMVxg (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Feb 2017 16:53:36 -0500
Received: from mail-ot0-f195.google.com ([74.125.82.195]:34713 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753083AbdBMVxf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2017 16:53:35 -0500
Received: by mail-ot0-f195.google.com with SMTP id 73so13750853otj.1
        for <git@vger.kernel.org>; Mon, 13 Feb 2017 13:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=kv92ZMWh3z8E0wQ4ux2RfSOz/6+ISUgxPrcBbEPh0B8=;
        b=fdK8tzkEzDBCXfPjG6nVShglcOAXG6rZQTajz31JR+JNQODJ2UQ9Ve04fxdclBCQaD
         L1WlmS783SUT+3Na5wDUis2YcEscI2qlMCTDmXvntkT49xmKLUu2qXk1ybl847v2D8v/
         +BlA73DxVYa4+zhta85ODNSvxmKLIzfxcCZSKZGOuqw4GZZFSCvlEbMssA7/mFIQKAyw
         4aLo4Wm8aIoWXUmlijA4NWugjOWU7bhbbMuzEU0cqBGhYHNR05c4Rzv9gfDi+QajnndF
         q/KZ2iGyQ5myy02X1JndmifNJ4eqhWfKl0HoBLjLGYBVl3ugPPLm5ezKbSvEzzzW0Oqh
         AeuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=kv92ZMWh3z8E0wQ4ux2RfSOz/6+ISUgxPrcBbEPh0B8=;
        b=AUpGmfeJqVl+U1Ojv9cEusx7g4sy40kHPlc7pv67in1IoXb92RgJrZJcmbf5qfcj+P
         0jtAXcFVk/kheBdyzerzkjbhcre85uAj1cZhqqQB18Q8hWP6JyChRqtWx57PmvQz0SO9
         5duVJ78e8w0mbPTbuVZJTSJtK4ARSaJZeeUH2WS+zEVFXrqZ3SXgQY8Ei0zJg+dmpkas
         V5/3T3O0sCOpSdPHMcgTvNgwm3RdoPAPYH7YftSMYan7Hd9QJelF4UURvvY4WEpwkbDs
         B3nfuC4bGoSpl7yt79tPfYqbveyJEC7nqGoMNQa4RuzrapeHh7GXo2Q/9TB3/MJ0G8Wx
         YJ6g==
X-Gm-Message-State: AMke39m1DK6fEgMKr97KG1Lf/gUbbn4NPYjNDQ3lwM4Opeb03qgGsHcjNNGIgYj/ynTkkg==
X-Received: by 10.99.133.65 with SMTP id u62mr29175683pgd.70.1487022814875;
        Mon, 13 Feb 2017 13:53:34 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:d0e0:42a7:601f:5154])
        by smtp.gmail.com with ESMTPSA id f3sm22727412pfd.10.2017.02.13.13.53.34
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 13 Feb 2017 13:53:34 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] clean: use warning_errno() when appropriate
References: <20170213092702.10462-1-pclouds@gmail.com>
        <xmqqwpcudjoh.fsf@gitster.mtv.corp.google.com>
        <20170213191433.muwhz7zem64p3rxr@sigill.intra.peff.net>
        <xmqqk28tddwo.fsf@gitster.mtv.corp.google.com>
        <20170213211051.vsnnrtcsvuvfcwyk@sigill.intra.peff.net>
Date:   Mon, 13 Feb 2017 13:53:33 -0800
In-Reply-To: <20170213211051.vsnnrtcsvuvfcwyk@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 13 Feb 2017 16:10:52 -0500")
Message-ID: <xmqqy3x9bvvm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> IOW, I think this may be a case where we should be optimizing for
> programmer time (fewer lines of code, and one less thing to worry about
> in the callers) versus squeezing out every instruction.

Fair enough.

Unless we do the save_errno dance in all the helper functions we
commonly use to safely stash away errno as necessary and tell
developers that they can depend on it, the code in the patch that
began this discussion still needs its own saved_errno dance to be
safe, though.  I do not have a feeling that we are not there yet,
even after we teach xmalloc() and its family to do so.

