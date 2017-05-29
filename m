Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 991D91FD09
	for <e@80x24.org>; Mon, 29 May 2017 06:07:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750971AbdE2GHG (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 May 2017 02:07:06 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33141 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750838AbdE2GHF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 May 2017 02:07:05 -0400
Received: by mail-pg0-f66.google.com with SMTP id s62so5426379pgc.0
        for <git@vger.kernel.org>; Sun, 28 May 2017 23:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=WvaYdMyHKBgaxXQjzLD48vJDs7bKz12Epey5DMkLDFk=;
        b=mHEUXGmB1hgf5KVjG1x/VJC3feGpJNP5wVihgPpUiMHERC/zcitsr904iOfYcBC2Pf
         PE7v/2o2Zdv/YYK+O0SEwwlkxY1KmNEKfD/tsTnooUm6Fo/HctZ43xoZ+Rz3KYMDiSVH
         S6bUEN1oOdpav0jx/NSwMm4D8ShyEoFZDWd1zkQRgxTXxxqHT0TsfQlooBu99pSbWbSz
         np4Eww0u8tRyW6jJq4pMt0zFNnOfNiWYTfrmvVwT8XHABc+XtF2OaEL82Qbg81wjAHf0
         s0ZKMYF9YMbNxImCWjJ/KsGBJnpnBqOlNrBfD/+mQRqbCAgl6lbZaFE9b+v/86UDhPLm
         uGvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=WvaYdMyHKBgaxXQjzLD48vJDs7bKz12Epey5DMkLDFk=;
        b=UzJMWCeHkLq9ulQs2FdMKW+EndPZKvAZrwESCsVNZz6DK4yI763RSO5SqvXyGwMlQ6
         bFgUF6jMfUx9+ojLDgkIHEFYluP6XMWeQ8cTXdlxzbnupyXdsqib/jaK+Kp99GbuRrab
         56VtsKdHclb15h2dA1uBqTdrA2DRJRQSwBO+PhPjnnPLcGiL5kTupQ3Gyi8iUmk18G53
         zXrWTmyWOoXMP/zp5pjRCMiT1S65lZtSFDNpFDH1bmHxmL5ibU8S8ekDUDUa8ncG7xRf
         0vtRicEjSfz4g6w7kotESIZJ1f+PNov2ZzmYhpX3UlTnGxQxRR6cbiPqCaEZrRlqWrSt
         H+bg==
X-Gm-Message-State: AODbwcAPkDpGupXHTdFtYZRkKPrxYuns5nDIIiebU6BvGt5w/8QAdwMQ
        tlOHECk0tkQlEDIdG1w=
X-Received: by 10.84.241.77 with SMTP id u13mr72751603plm.28.1496038024521;
        Sun, 28 May 2017 23:07:04 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:393e:d787:9be9:17cc])
        by smtp.gmail.com with ESMTPSA id r69sm14782547pfi.33.2017.05.28.23.07.03
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 28 May 2017 23:07:03 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Philip Oakley <philipoakley@iee.org>,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v4 02/10] rebase -i: generate the script via rebase--helper
References: <cover.1493207864.git.johannes.schindelin@gmx.de>
        <cover.1493414945.git.johannes.schindelin@gmx.de>
        <e173445d9a6321f80053967e50375400c0a61764.1493414945.git.johannes.schindelin@gmx.de>
Date:   Mon, 29 May 2017 15:07:02 +0900
In-Reply-To: <e173445d9a6321f80053967e50375400c0a61764.1493414945.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Fri, 28 Apr 2017 23:31:37 +0200
        (CEST)")
Message-ID: <xmqq60gk8ad5.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> diff --git a/sequencer.c b/sequencer.c
> index 130cc868e51..88819a1a2a9 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -2388,3 +2388,52 @@ void append_signoff(struct strbuf *msgbuf, int ignore_footer, unsigned flag)
>  
>  	strbuf_release(&sob);
>  }
> +
> +int sequencer_make_script(int keep_empty, FILE *out,
> +		int argc, const char **argv)
> +{
> +	char *format = NULL;
> +	struct pretty_print_context pp = {0};
> +	struct strbuf buf = STRBUF_INIT;
> +	struct rev_info revs;
> +	struct commit *commit;
> +
> +	init_revisions(&revs, NULL);
> +	revs.verbose_header = 1;
> +	revs.max_parents = 1;
> +	revs.cherry_pick = 1;
> +	revs.limited = 1;
> +	revs.reverse = 1;
> +	revs.right_only = 1;
> +	revs.sort_order = REV_SORT_IN_GRAPH_ORDER;
> +	revs.topo_order = 1;

cf. <xmqq4lx5i83q.fsf@gitster.mtv.corp.google.com>

This is still futzing below the API implementation detail
unnecessarily.
