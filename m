Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A164C433E0
	for <git@archiver.kernel.org>; Mon, 18 May 2020 14:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA95120787
	for <git@archiver.kernel.org>; Mon, 18 May 2020 14:46:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u7ASrrD5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbgEROqt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 May 2020 10:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbgEROqs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 10:46:48 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69727C061A0C
        for <git@vger.kernel.org>; Mon, 18 May 2020 07:46:47 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id d7so8210093qtn.11
        for <git@vger.kernel.org>; Mon, 18 May 2020 07:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=nrhya3fmH5B6/4xcBERnVxsYbemJXyL/u1SQDF/FuGY=;
        b=u7ASrrD5VrgjYd0x7lNCOpfJvOwWAuYuQjnzqQrZ8pbOnLZuP4muWu83igi9ip/00Q
         nJhvZOf5FDlXjWJjghZEVdpW4oUWGglNuvNr/vreQOQm+Z3eD3FF139CdyPwgFpd2Q0S
         baVp+kKpNk3fVm2rXpecUtcZLeZUxoMBnpo3E8Vks/atIlrR9NNPE6QWu64W3hmykjgM
         2lxo49Dt3U1mrRhT486d89Zkj4g4UMqbZCHecVsdB/3ffRA/UHBU4I9RjixP3ofGryFF
         /7c9jbyMGbO0MDyRJL7iw6WJXvgJW/coK60cBxuj0CRQfAN7EgobDcibWw9mHaPaETz1
         34bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nrhya3fmH5B6/4xcBERnVxsYbemJXyL/u1SQDF/FuGY=;
        b=D8BTaYDznM2gFcNshVkfiC+T62OicBZ66eTs/8vDTenEm57RtGsU4IurbEQRxAexzt
         HVXlQZqPlAq9bSq0eP2BZ8Q0CXRBhSJ3575L4y0zBJZdD+g13HWM1MQoL09L4sf5fkOA
         8KVzaZYmdPS8Vw+4thgYMMS79adhSwaVXvrqzLUH7vOAh/i5DcwqxlR9wpzo7r0Aidou
         edr/TcWxRzLssVfP1MzL9artsXnt/GRoLWnCr4ob7P1f/Wbnd79SQ5exTeByty3Pe2oh
         Ni/wIYYPzlpmyPCpgRIxI4RXzn41N/3/2h2I03daKCa2G3bMlzu5lHat8pXnjHfqKZPL
         6hYg==
X-Gm-Message-State: AOAM5325DUNXZmOQPuEq3j/UGWcCB5z+lis/5rPfKMhrDScZbt6PX4LO
        66E5GvjLNlDXd4txOliJKJMVkNlLt8Q=
X-Google-Smtp-Source: ABdhPJxLvNHfpU4FzlEDR2nImEjC9J5EKEIE4P2AQ1B+RID/kDPMsC8TzkDfBqsf00KBQ0r1q+4DKw==
X-Received: by 2002:ac8:345a:: with SMTP id v26mr16774191qtb.253.1589813206393;
        Mon, 18 May 2020 07:46:46 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id a189sm4903461qkd.52.2020.05.18.07.46.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2020 07:46:45 -0700 (PDT)
Subject: Re: [PATCH 6/7] git-sparse-checkout.txt: add missing '
To:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        git@vger.kernel.org
References: <cover.1589739920.git.martin.agren@gmail.com>
 <69faf4d317547143f455321c5a70575cb7b0b0ad.1589739920.git.martin.agren@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <9d53f615-bb97-bd93-c72b-738a416c8217@gmail.com>
Date:   Mon, 18 May 2020 10:46:45 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:77.0) Gecko/20100101
 Thunderbird/77.0
MIME-Version: 1.0
In-Reply-To: <69faf4d317547143f455321c5a70575cb7b0b0ad.1589739920.git.martin.agren@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/17/2020 2:52 PM, Martin Ågren wrote:
> Where we explain the 'reapply' command, we don't properly wrap it in
> single quote marks like we do with the other commands: We omit the
> closing mark ("'reapply") and this ends up being rendered literally as
> "'reapply". Add the missing "'".
> 
> Signed-off-by: Martin Ågren <martin.agren@gmail.com>
> ---
>  Documentation/git-sparse-checkout.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
> index 1a3ace6082..7c8943af7a 100644
> --- a/Documentation/git-sparse-checkout.txt
> +++ b/Documentation/git-sparse-checkout.txt
> @@ -70,7 +70,7 @@ C-style quoted strings.
>  	`core.sparseCheckoutCone` is enabled, the given patterns are interpreted
>  	as directory names as in the 'set' subcommand.
>  
> -'reapply::
> +'reapply'::

Subtle! But good catch. Thanks!

-Stolee

