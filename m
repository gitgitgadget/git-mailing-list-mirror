Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30D032082E
	for <e@80x24.org>; Fri, 23 Jun 2017 04:57:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754368AbdFWE5B (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Jun 2017 00:57:01 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35983 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751230AbdFWE47 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2017 00:56:59 -0400
Received: by mail-pg0-f67.google.com with SMTP id e187so4902808pgc.3
        for <git@vger.kernel.org>; Thu, 22 Jun 2017 21:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=m88TBU1eSL6aQHtYMHwfNBYAsJDA7lngOBJEdIzYZ1Y=;
        b=Xy7B4dTtU1Vbe020cHbN8uWIvd8bqcUr/eS8jshmQ1kg5PPterkhmihmchr5pfIWy+
         ZJd11ZXHBUQ3KIxGzqBNmiIUvkS9TybW8XP9xiKOyAkFiFOZ1U6R09aNA1WvNNTNE3De
         uZxSh9fkeTQB7GV/NHVa47sIO9A3TcvalK1lOuGDuh57PSv+yBngq8p+9KCJO8MlTkwc
         67rcp5vYmzJXUosApygmP2uh+fzdJZLa04LwuEUlor2tiZ/aFQWRiUNm1/thhgGURrMt
         PIBGI5FKYiqd2mQVT0s1BIS7g9YbpSP4O+MZfqIbaAqX1nIRf5NOWqFIwrunZw98CwWI
         Ulcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=m88TBU1eSL6aQHtYMHwfNBYAsJDA7lngOBJEdIzYZ1Y=;
        b=Fr9TMAhiB1GmgrihPTw56RRu+y4Pt0T9txlQoqXRgnAbGSMaPuH0g6rAhN0D0e6eFu
         r0uQlIdhWAp49aKAfZaDHwK3Uhydf/0KNn6IjtP06XkjRdIe69R4ea7B078GmBai80m0
         ggNQMNo31da98Yq/QZgiSmNuC9A6/eev21GgmRABUGCZ4Jmch6ocK3TqckZNTn3Nj0Ip
         XcBI8R00LbyJ1Lg+w7VlULA0Le8q5c03OY4Xiy3e1Cs6ZVLcPiAhXGz6cPQbLJGA38yj
         0T9b9ccP6hb9yS+QcKryxRkAHDxiQfmN426G6KziwROwLNK0WJY10JlYif4OrdbPfwb/
         Ax6A==
X-Gm-Message-State: AKS2vOykZjfng1c7LJTDi2cXnuyKwoCFKZJKidqUAMhGIWaxmlsGJVMy
        +gPnG9dY4y5liw==
X-Received: by 10.99.0.212 with SMTP id 203mr6078364pga.259.1498193819244;
        Thu, 22 Jun 2017 21:56:59 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:20f6:6e44:6707:50bd])
        by smtp.gmail.com with ESMTPSA id t77sm6984630pfg.102.2017.06.22.21.56.58
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 22 Jun 2017 21:56:58 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Brandon Williams <bmwill@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.org>
Subject: Re: [PATCH 08/26] diff.c: migrate emit_line_checked to use emit_diff_symbol
References: <CAGZ79kaqjQYmkt77kk5m=fdBfbZAvwd0YhhT7=O5b-FkQmDfHg@mail.gmail.com>
        <20170620024816.20021-1-sbeller@google.com>
        <20170620024816.20021-9-sbeller@google.com>
        <xmqq37atp0ng.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kY46UGwBt2A20bwX_CFNuVP8hy_inCqh6hqiA5VfcfSxA@mail.gmail.com>
        <CAGZ79kben16T9nUpOjsq5-Sv8q7z+C1Nrq++jn2aO17CzqToHw@mail.gmail.com>
Date:   Thu, 22 Jun 2017 21:56:57 -0700
In-Reply-To: <CAGZ79kben16T9nUpOjsq5-Sv8q7z+C1Nrq++jn2aO17CzqToHw@mail.gmail.com>
        (Stefan Beller's message of "Thu, 22 Jun 2017 16:37:33 -0700")
Message-ID: <xmqq1sqbgv3a.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Actually that function already has some quick return:
>
> static int new_blank_line_at_eof(struct emit_callback *ecbdata, const
> char *line, int len)
> {
>     if (!((ecbdata->ws_rule & WS_BLANK_AT_EOF) &&
>          ecbdata->blank_at_eof_in_preimage &&
>          ecbdata->blank_at_eof_in_postimage &&
>          ecbdata->blank_at_eof_in_preimage <= ecbdata->lno_in_preimage &&
>          ecbdata->blank_at_eof_in_postimage <= ecbdata->lno_in_postimage))
>                   return 0;
>     return ws_blank_line(line, len, ecbdata->ws_rule);
> }

I wouldn't call the first if() statement "quick return".  It
probably weighs as much as ws_blank_line() itself, which is not that
expensive.  

Even though new_blank_line_at_eof() may have been coded efficiently
and not very expensive as a whole, the fact remains that it didn't
get called when we know it was unneeded, and it now will get called
before we figure out if it is necessary.

And that is why I said it is a bit unsatisfactory (as opposed to
"horrible" or with other more severe adjective).


