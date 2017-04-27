Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 388711FC3E
	for <e@80x24.org>; Thu, 27 Apr 2017 06:05:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162009AbdD0GFO (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Apr 2017 02:05:14 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36813 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938517AbdD0GFM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2017 02:05:12 -0400
Received: by mail-pf0-f193.google.com with SMTP id v14so6456328pfd.3
        for <git@vger.kernel.org>; Wed, 26 Apr 2017 23:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=HiraggHoGQa36G3zLRtCQC7o4Q4qezKlf/KEYwEzij4=;
        b=P8zUFKgptydu0/xEIma0llf0Rot7v39BQ5kcy/YA+COa8LQQRfXajE0jTyw8wHvfAt
         SlQIgT/EmEnYQHEYpRz/COBazY3Ujj5LVgAnv1aM7ll+xkjHA6kQ3EwiBq0iHXBIJbIv
         2dEZNudONBFGwsFIJmcvl7eDEsDLZbC4xyQs0hMVUKNAJP/+YqIC02C66kFDJA8150tZ
         hAqsV37bWW3xm1rAupI/zekgwzZo5Kr05h3hgeJfi/2dBu0VMZvYLdXENIz+R3m04r0w
         tgHfxgjZloMaa21uhLpYag+rtUN3Ngk6okyhCD2L3Ocl/cl13I+J/w3WUd9idirnwVOu
         1xsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=HiraggHoGQa36G3zLRtCQC7o4Q4qezKlf/KEYwEzij4=;
        b=pHf/e/hMMEIRAx8De5mctcq8nWwe6UdnugxPCmL15TNsPttXyHEECJUktpj9U1zoil
         bFem1W+qYd8LClFNjfziQCkBRuVnhyhCyrKPEhHzuiG8VmYLV2VmMjrAv6UWMbTzN72R
         LxaN7Hy13hp/2rxf6/CqFKB2puqGBqvD/VhxGkAgm4uvXnRQzp8jvmUhj7+0WDO7tcOH
         ASWuEQNJbflwQ8dLWQ0AlAtXWOjXWYsi+Qks9i87eMo81335c9TFdnI4yGnsGlxYYJLw
         ejPwZKK+4n1cpfUAoXmBMljYrqFXgfbdHr/7ILaMdG/2ubar+Y3FIU6XRsKqeMSDGuUb
         3pLQ==
X-Gm-Message-State: AN3rC/6IBlpAxYw68PPgnjXvG3cjV5jMytiZhrdgqzd6W0iOXcMtHl03
        5Hk4z6JiXL2jLQ==
X-Received: by 10.84.214.130 with SMTP id j2mr4831105pli.133.1493273112031;
        Wed, 26 Apr 2017 23:05:12 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:d550:ca2:cfe6:6d97])
        by smtp.gmail.com with ESMTPSA id v62sm1883455pfv.44.2017.04.26.23.05.11
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 26 Apr 2017 23:05:11 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 08/26] difftool: close file descriptors after reading
References: <cover.1493237937.git.johannes.schindelin@gmx.de>
        <c634ea5dad0ce1c1f424f54a12a5614e6fa4a847.1493237937.git.johannes.schindelin@gmx.de>
Date:   Wed, 26 Apr 2017 23:05:10 -0700
In-Reply-To: <c634ea5dad0ce1c1f424f54a12a5614e6fa4a847.1493237937.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Wed, 26 Apr 2017 22:19:53 +0200
        (CEST)")
Message-ID: <xmqqzif2mlm1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Spotted by Coverity.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  builtin/difftool.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/builtin/difftool.c b/builtin/difftool.c
> index 1354d0e4625..a4f1d117ef6 100644
> --- a/builtin/difftool.c
> +++ b/builtin/difftool.c
> @@ -226,6 +226,7 @@ static void changed_files(struct hashmap *result, const char *index_path,
>  		hashmap_entry_init(entry, strhash(buf.buf));
>  		hashmap_add(result, entry);
>  	}
> +	fclose(fp);
>  	if (finish_command(&diff_files))
>  		die("diff-files did not exit properly");
>  	strbuf_release(&index_env);

This one looks sensible.

> @@ -497,6 +498,7 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
>  		}
>  	}
>  
> +	fclose(fp);

The huge loop we see in the pre-context of this hunk has many
"return"s and "goto finish"es that can leave fp still open; while
this patch does not hurt, it is probably somewhat insufficient.

>  	if (finish_command(&child)) {
>  		ret = error("error occurred running diff --raw");
>  		goto finish;
