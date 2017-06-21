Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD,UPPERCASE_50_75 shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 770F020401
	for <e@80x24.org>; Wed, 21 Jun 2017 20:16:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751143AbdFUUQV (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Jun 2017 16:16:21 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35416 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751106AbdFUUQU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2017 16:16:20 -0400
Received: by mail-pf0-f196.google.com with SMTP id s66so32661872pfs.2
        for <git@vger.kernel.org>; Wed, 21 Jun 2017 13:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=7uiRSQIVuSG2hLXfWwZJWU8GlRk7QJoStg1bUu95HNM=;
        b=QSJ/a/HdqR7PtSbMANq8JOv/fPOoEQUBZ8YpFFnqCf0GNGmjnWDNdWB7MoAtdEn/nj
         YH+lntCLyigpbeKU7lVSGjBx+nJwZdaWnLdIg0BGYqbVmf2JifLlmdDBedzyLh3MyV1U
         NWr5xgpNXrRv0KhvEe5UDz4tkHKDfv/zavDm+nXnOqTQBsBal2284qDaoXVlbm/m+J/2
         3ynoftu6wz1VUGim8RuoYIcikY+/wM+ZXeGcZaiBg8e/9axW+bvA5vuUyEUA/KKCiOcJ
         9eMp5SSnzeIisVSa+nNkvbq6/YQhdMOGyonxeOiVoAkcFLllXJMBcDgW629UhP1FzrTv
         fPDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=7uiRSQIVuSG2hLXfWwZJWU8GlRk7QJoStg1bUu95HNM=;
        b=HwHHwAxp8IFAOE9d4trTlmh2u9ztAZJOCSw8IISKVzwalxPIImbTw8sRMJPpYX3/lI
         CLl5KVZKoztGWCxtk9Z041NjYvV0h2cOobBZbf86xpzBOa94NId1/hUXI/eWfI/5/upa
         0JlaeM7xyYcDeBz5qgycM/bNTsxC6ZDoM5+ikHOt+Mp9tsW83K8Vz8k3vp/O62X/IP+b
         i8VKUUUcXxYDBGs/fWI7OZHOcMb7sd/Sg0lq0ULzRly5xQYHBXT8k9l682sK2zIGts66
         W3GbKfcQz4EwtnRg0y9A0hjyrY2ETUOAqHo+B7J2i7zot/Tnae3JPmIFWBogRYVjvwh7
         cXvw==
X-Gm-Message-State: AKS2vOxggqeEKFR3ZFdlCkLUHamXcxydgsR/0jH63vBAEmmhPT/3TWoo
        cEmZ/ik81IDmXA==
X-Received: by 10.84.224.134 with SMTP id s6mr10943470plj.263.1498076180060;
        Wed, 21 Jun 2017 13:16:20 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b0bd:d7d3:4f2e:5016])
        by smtp.gmail.com with ESMTPSA id j24sm35270677pfk.78.2017.06.21.13.16.19
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 21 Jun 2017 13:16:19 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     bmwill@google.com, git@vger.kernel.org, jonathantanmy@google.com,
        jrnieder@gmail.com, mhagger@alum.mit.edu, peff@peff.net,
        philipoakley@iee.org
Subject: Re: [PATCH 16/26] diff.c: convert emit_binary_diff_body to use emit_diff_symbol
References: <CAGZ79kaqjQYmkt77kk5m=fdBfbZAvwd0YhhT7=O5b-FkQmDfHg@mail.gmail.com>
        <20170620024816.20021-1-sbeller@google.com>
        <20170620024816.20021-17-sbeller@google.com>
Date:   Wed, 21 Jun 2017 13:16:18 -0700
In-Reply-To: <20170620024816.20021-17-sbeller@google.com> (Stefan Beller's
        message of "Mon, 19 Jun 2017 19:48:06 -0700")
Message-ID: <xmqqmv91nlkd.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  diff.c | 66 +++++++++++++++++++++++++++++++++++++++++++++++++-----------------
>  1 file changed, 49 insertions(+), 17 deletions(-)
>
> diff --git a/diff.c b/diff.c
> index 42a9020d95..e6ade5fde0 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -573,6 +573,11 @@ enum diff_symbol {
>  	DIFF_SYMBOL_FILEPAIR,
>  	DIFF_SYMBOL_HEADER,
>  	DIFF_SYMBOL_BINARY_FILES,
> +	DIFF_SYMBOL_BINARY_DIFF_HEADER,
> +	DIFF_SYMBOL_BINARY_DIFF_HEADER_DELTA,
> +	DIFF_SYMBOL_BINARY_DIFF_HEADER_LITERAL,
> +	DIFF_SYMBOL_BINARY_DIFF_BODY,
> +	DIFF_SYMBOL_BINARY_DIFF_FOOTER,
>  	DIFF_SYMBOL_REWRITE_DIFF,
>  	DIFF_SYMBOL_SUBMODULE_ADD,
>  	DIFF_SYMBOL_SUBMODULE_DEL,
> @@ -581,6 +586,7 @@ enum diff_symbol {
>  	DIFF_SYMBOL_SUBMODULE_HEADER,
>  	DIFF_SYMBOL_SUBMODULE_ERROR,
>  	DIFF_SYMBOL_SUBMODULE_PIPETHROUGH,
> +

Line noise?

>  };
