Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 228221F404
	for <e@80x24.org>; Tue, 10 Apr 2018 02:57:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751940AbeDJC5N (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 22:57:13 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:52112 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751629AbeDJC5M (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 22:57:12 -0400
Received: by mail-wm0-f65.google.com with SMTP id u189so22900991wmd.1
        for <git@vger.kernel.org>; Mon, 09 Apr 2018 19:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=1YWyeq2XuJ8Y64QvTZ7KVqREBgLebEGtz5VJk0nP0fo=;
        b=XOg8QQTUYmD8PjX+n0ZVBvq7zff+RHwiHwj6DGdDvfJJsXR8gGjUcKYmIPX70QoXdD
         fPNivNDhKW5EWiy7Yu4Prqxrm2VIbp/08HnWIQcv3+Adu/vDqpnwcPywL7QJVMz8Cmom
         syDC74o2H92mXDX3Ij9UELw+36CxofXvCpE7k8oXwhG6/L1Dx0XoEv685tfCxsJeyJyr
         BWeHdr18HxeOakO7S6uGujKXXTXAB5EtEERwM5/y2Z4C5oIw8hQC4lg9BVn2o0/my2+w
         YZiuPp2eitBfppLGFcaUH/raJZtHAAeCFSXBLqqyYlzjRbpM1kriR9+LnLViO2ullH6e
         MFmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=1YWyeq2XuJ8Y64QvTZ7KVqREBgLebEGtz5VJk0nP0fo=;
        b=GTPX3rQTzNBlSjnF1ICRreIngGKZ007s6vGdVsax6dMksPvPM2ElCL9Y/aj9+05kVH
         KqDQ+Y0ZRUK+BNg7FThCzk/Fj/kyoeGvYKDckKGzIVZz6xR5fcgmuCx8BefMJdQv7r2h
         Ipx3nVpLhUypOpHWwdIRArk0NInZQkmaZ9+Q9JUroHvJau/RUfXeFJMSTK6DwKfD+4Me
         EzDGvjfALiAXHMiXW9oljZ84jhgbXwBLh/EmcXD5CrLuFBYQNGCRBvw6MVBz2a/yyS5a
         xO2RHZdA0CXLxF/+PuWzguFa8Hz6OF12zikXhQXPM+AVIEPFPOfBZupJBfDEE0UulHCe
         ejVQ==
X-Gm-Message-State: ALQs6tB78MPDybK6OrlBAxU9IpiBrgtNJu5Sx0KJQFJ7BgI+wVQSoq14
        w9WG3dN9FGpCuA9Vkp5y4YU=
X-Google-Smtp-Source: AIpwx486LfgoYFeYQDc5g6R27it45gCf656LnIDJRp/eZfnafThQjk/3OWcj3bCPIq3EpiOaerNJYQ==
X-Received: by 10.28.145.205 with SMTP id t196mr198491wmd.110.1523329031564;
        Mon, 09 Apr 2018 19:57:11 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id p19sm2506233wrb.75.2018.04.09.19.57.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Apr 2018 19:57:09 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com,
        sunshine@sunshineco.com, pclouds@gmail.com, l.s.r@web.de,
        sandals@crustytoothpaste.net
Subject: Re: [PATCH 01/16] replace_object: use oidmap
References: <20180406232136.253950-1-sbeller@google.com>
        <20180409224533.17764-1-sbeller@google.com>
        <20180409224533.17764-2-sbeller@google.com>
Date:   Tue, 10 Apr 2018 11:57:08 +0900
In-Reply-To: <20180409224533.17764-2-sbeller@google.com> (Stefan Beller's
        message of "Mon, 9 Apr 2018 15:45:18 -0700")
Message-ID: <xmqqfu434vln.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> -static struct replace_object {
> -	struct object_id original;
> +struct replace_object {
> +	struct oidmap_entry original;
>  	struct object_id replacement;
> -} **replace_object;
> -
> -static int replace_object_alloc, replace_object_nr;
> +};

The oidmap key can also serve as the original side, which is good
;-)

> @@ -84,7 +44,7 @@ static void prepare_replace_object(void)
>  
>  	for_each_replace_ref(register_replace_ref, NULL);
>  	replace_object_prepared = 1;
> -	if (!replace_object_nr)
> +	if (!replace_map.map.tablesize)
>  		check_replace_refs = 0;

The original checks _nr (i.e. how many do we actually have) as
opposed to _alloc; on the other hand, .tablesize is not about the
number of contents in the table.

But before or after the patch, what the code really wants to check
is if the table is _initialized_, so from that point of view,
checking .tablesize is good enough.

So, I guess this step is quite right ;-)
