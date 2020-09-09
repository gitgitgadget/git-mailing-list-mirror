Return-Path: <SRS0=gV3S=CS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8970C43461
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 09:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70BDF216C4
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 09:33:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LIIOofh0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbgIIJdX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Sep 2020 05:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbgIIJdV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Sep 2020 05:33:21 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F6C1C061573
        for <git@vger.kernel.org>; Wed,  9 Sep 2020 02:33:20 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id e16so2185521wrm.2
        for <git@vger.kernel.org>; Wed, 09 Sep 2020 02:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=0WOzhSpzgc/CnwT1503MxDFZaAq3KBaYzU0B5OAVXSs=;
        b=LIIOofh0XncJwbvZP1t1UaFamx2XHqwH2RSZIJ5SCMt/uu1OxIfB0tsNk+2gkZ67H2
         1OEzWFwIP+ChL0FCA+tIkuF3JZsqa+NIs0ETqjYjpBqiqsxUjLcrpDxRBjqlXYNbigmd
         qxpHi/1loajQ9onvq+CtXS7gxWWnN+QX8RDHRXYdzp573zBnNMBMyUrqxdbBJJDpkQRp
         yW7OvbwX81B6mTtCGFn1VMEuoUoaTz0pphVyRTNkRzpdUA5+yriWM1gBP3wWuQzxboiU
         qpdD8rlYSDxEgO6Rj9g/sW9/wq1ARluBs7L4WY78ukJTaF2l1cXeQRbWN5LfO0p8xM9i
         U+DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0WOzhSpzgc/CnwT1503MxDFZaAq3KBaYzU0B5OAVXSs=;
        b=hLGZiHFpFBH+w/taBI5G+wVbfp/j/Frt8zT61OrMvTD0Zg+JlEFw6f57sve5geV5NM
         4gHddH74ChKxUd6IsTzVvUZ2Xh9UeJ6urPrWyuOFsmGOjk2RL69E72bRFgTif7x4plTF
         4DQH05d+DJs3mNCn+VUr6hU0R6WB6ke1cYQJ78rasLAW3xIpe2gC220N0J90qc5OI+km
         a8BCvRrh27YeMB3TDTooMnKOT0QjMH0SpOD9M1PyaLbQvtGHeOpu2scbaIsgUCJcMb20
         hSlK+HibHl48ri7qnchEsY2kUbieRbzadAgWR1wyshlODoUsUSf6S64My399g4K/JwCD
         /P0Q==
X-Gm-Message-State: AOAM533qIetX37zipJDnfqRYKfW1/K6ysdFTOEl6M1AOuvEzto9Vjiys
        27c07FOOZPoDpvt4VKxmaZ6gkEbXLxk=
X-Google-Smtp-Source: ABdhPJwd7sTUb8XjYxYi8wWS+e/kndyopA7Svh+yEOSwXXUDNh0cEtTqIP+PerMnLwIVPveBTK/AMQ==
X-Received: by 2002:a5d:4ccb:: with SMTP id c11mr2883933wrt.159.1599643997708;
        Wed, 09 Sep 2020 02:33:17 -0700 (PDT)
Received: from [192.168.1.201] (151.252.189.80.dyn.plus.net. [80.189.252.151])
        by smtp.googlemail.com with ESMTPSA id a74sm3171722wme.11.2020.09.09.02.33.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2020 02:33:17 -0700 (PDT)
Subject: Re: No edit option when "git add --patch" a new file
To:     Yuchen Ying <ych@google.com>, git@vger.kernel.org
References: <CAF6j4hcSEhNvS-DYgNLNn3TdH1vkhgHZRC0fqWer_XM0PQxgYA@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <4eb2c8ec-3ee3-5097-9cff-b650caf2c888@gmail.com>
Date:   Wed, 9 Sep 2020 10:33:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAF6j4hcSEhNvS-DYgNLNn3TdH1vkhgHZRC0fqWer_XM0PQxgYA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/09/2020 17:16, Yuchen Ying wrote:
> Hi list,
> 
> I was attempting to "add --patch" a newly created file but the "edit"
> option is not provided.
> 
> Steps to reproduce this problem:
> 
> $ echo "test\ntest" > test
> $ git add -N test
> $ git add -p test
> 
> Expected: e is an option
> Got:
> 
> $ git add -p
> diff --git a/terraform/test b/terraform/test
> index 0000000..992533b
> --- /dev/null
> +++ b/terraform/test
> new file mode 100644
> @@ -0,0 +1,2 @@
> +asdf
> +asdf
> (1/1) Stage addition [y,n,q,a,d,?]? e
> Sorry, cannot edit this hunk

Thanks for taking the time to report this issue. I'm currently working
on a fix which I hope to post later today as the issue was previously
reported at
https://public-inbox.org/git/CAB+jsAW_+NTJjDLG9uMrf4cc5rcwHLD5kTLk7QgvFCgryb22Gw@mail.gmail.com/
I'll Cc you on the patch

Best Wishes

Phillip

