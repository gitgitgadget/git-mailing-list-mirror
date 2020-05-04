Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C335DC3A5A9
	for <git@archiver.kernel.org>; Mon,  4 May 2020 20:20:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FE7020707
	for <git@archiver.kernel.org>; Mon,  4 May 2020 20:20:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XhIi2h1H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgEDUUr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 16:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbgEDUUr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 May 2020 16:20:47 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D2CC061A0E
        for <git@vger.kernel.org>; Mon,  4 May 2020 13:20:47 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id o24so7875182oic.0
        for <git@vger.kernel.org>; Mon, 04 May 2020 13:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=sKIn5n9L0P8AUyThEvB+94VD/WX0WfGMuVUwiY5CXM0=;
        b=XhIi2h1H10AnKGs4cdRCdjnsOxlUMGyE6wBtGQmL49o/kgZXeaVGLpfvNDdltb8yWl
         nEd6Ws7g+zebQDLgF3enDR7yqSUNChKB/j8EJEFr3P60Cl1Nr7uMrBc4kyIPReWFSyIV
         khhk5diQzYqUD9Yugam2xogId5WRMEcYRA6oDDcVWzQExOI6wj7sOIZUqNVBARVu8ZRC
         rVhJEvi/MZNvhwyafih9E+YnzU3A0vwYrbeFDbtMw8NokbprWzJ5uRgW9snubvt0iYU8
         nLjNrxwqtiwKTU/C8zcekAYDJ4Skmp9AW6Z+XfkZTKgjiCds8oLMlqAX4NGqU4vu8UpN
         zvmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sKIn5n9L0P8AUyThEvB+94VD/WX0WfGMuVUwiY5CXM0=;
        b=YVIDSTTE1eKYy3tbY0e6MsONYuZDhMyM1AZ+T/X2g6jmkngqTuR5y/wKwgdVKJDfS/
         RgF1TumTlOuJ598Ai3mT0/JNYUISPaLJ869Whadj50Cfw5G8hsh2BMrd+NyCU1fl0l72
         a8gOrUVbRL2aJrQ9rRQbmnrtIlfYOiN2qpINNLV7RMDNRTiNQ3oEVVJ2yJwGZoHiXvX7
         EGoKTvoeLWqHFVIfF3htW1cQx35kLTG5Cy/5jnCBhQ9gCLUgnutt7eD+NSOirZBJqr/z
         cJWmXuH0yMnLJsh9+q7DM4Hx+fQjSvcJ/atvs7o2r08pnAvkjf4TVOLj9wJfk3HccdYt
         rwYA==
X-Gm-Message-State: AGi0PuZf6bGx7Wp32Y7chvKNu8kOk1KTI85baYMnt5hGm3fM0ruL0Yqp
        aSWEmd7EDwb6BrK64CITQ0ryqIGhOTM=
X-Google-Smtp-Source: APiQypJ00/imadA8rqd4uSg9A/j8LBx9z+eR7hEbYDyFiIITQh3DO0YIJ5YRUm4AX7NVXFKDqvzkkg==
X-Received: by 2002:aca:2807:: with SMTP id 7mr118704oix.15.1588623644359;
        Mon, 04 May 2020 13:20:44 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id d18sm11157otk.63.2020.05.04.13.20.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2020 13:20:43 -0700 (PDT)
Subject: Re: [PATCH] commit-graph: avoid memory leaks
To:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
References: <20200504191324.201663-1-jonathantanmy@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <16be6de4-3453-2fc2-2881-7068bf674517@gmail.com>
Date:   Mon, 4 May 2020 16:20:41 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:76.0) Gecko/20100101
 Thunderbird/76.0
MIME-Version: 1.0
In-Reply-To: <20200504191324.201663-1-jonathantanmy@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/4/2020 3:13 PM, Jonathan Tan wrote:
> A fuzzer running on the entry point provided by fuzz-commit-graph.c
> revealed a memory leak when parse_commit_graph() creates a struct
> bloom_filter_settings and then returns early due to error. Fix that
> error by always freeing that struct first (if it exists) before
> returning early due to error.

This fuzzer is an excellent tool that I hope can continue to be
extended to other features. Here is a case where it found an error in
a feature long after the integration was introduced.

> While making that change, I also noticed another possible memory leak -
> when the BLOOMDATA chunk is provided but not BLOOMINDEXES. Also fix that
> error.

Thanks for discovering these issues, and for fixing them!

Reviewed-by: Derrick Stolee <dstolee@microsoft.com>

Thanks,
-Stolee
