Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10177C4332F
	for <git@archiver.kernel.org>; Tue, 22 Nov 2022 18:28:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234530AbiKVS22 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Nov 2022 13:28:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234492AbiKVS2T (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2022 13:28:19 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D14E5DB93
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 10:28:16 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id d8so10850508qki.13
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 10:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QVxfPiJB4q4biDcquivz60BPLb1uw+VEaO8o8ANGqHI=;
        b=DflcGeBStQ2FSyilhXM6fmRl0hUOivPMtK8PP9roWgL28Oj1NVoRdXADh5yhv0k+8/
         egtbNRPz+fcZR9p3GVETHtW2YREqiJcPtmocHZPs9LdtLT/8WrWIVwvEKjXzJpDb5HDv
         LnUTAsmKAlNn7Q0Wcski4w1zBLkxofnmqdDrs2JqKwODRvaYDnHZEEbduO4wwWNNxfyU
         crlPHLLhKOG2JXYD1U+857Szmgm+MQ3JtyurC/f2hl4E8/5cskMD3lMiDUCyQHKMIDpP
         rKGB8DyYyDDNS5ro6cYwDzh3JbAoXZdEeuGqmajcJoLn+7eeGghahbxFx+XzoJjgUski
         urMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QVxfPiJB4q4biDcquivz60BPLb1uw+VEaO8o8ANGqHI=;
        b=NH7uKMbWbnq81pYtoxCAM6GCp0G8Lt6VVR+XSpgQKjZFSXZZe91m1tlGhh8KqshxZJ
         X4GpTXB2k4PwshQ1xUKBy/J59RFn99AfC4KnDKS14hXjhnkahmQOKRjvvTjjX3D6HUkB
         /3Xz58LcwoJOX0qyougIH8PPAamSdrEtcyYXO41JUSxZuGfVidHfb2/Mu5Nmn8VMvHZe
         Y/X/irlS+yHoyX85xpqfQr6eaj6fQUG7V4jWy6Qcmr3fLh2QvWQ/P/K1Mbi6qFONg28a
         DOozZNOgBlt30ytNbYrLzr/iJj0EpDhGxosSNvFp/0O+l3cXcjjQ2+TTc80jyHMdglPT
         CtEQ==
X-Gm-Message-State: ANoB5pkcJdxiFLHXwbXbcmcM7/xmtZLem79RHDJ4FSl1G9hcOgw5VRQJ
        LKEzBROaxVBd5wU5Hzw48+AD02FqhtQ=
X-Google-Smtp-Source: AA0mqf7Zy98tNg3pi6QMWwwFRMLYoxoiyktWIiOwhcNjG3y0j4N48m7QKTGDsQa1w+xMbPK1s848Ww==
X-Received: by 2002:a37:9a56:0:b0:6fa:156:ef1 with SMTP id c83-20020a379a56000000b006fa01560ef1mr21900884qke.227.1669141695469;
        Tue, 22 Nov 2022 10:28:15 -0800 (PST)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id ay34-20020a05620a17a200b006b929a56a2bsm10651534qkb.3.2022.11.22.10.28.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Nov 2022 10:28:14 -0800 (PST)
Subject: Re: [PATCH] t3920: don't ignore errors of more than one command with
 `|| true`
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Git Mailing List <git@vger.kernel.org>
References: <febcfb0a-c410-fb71-cff9-92acfcb269e2@kdbg.org>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <a8cf5ba2-0593-b8df-a795-c50511fcb38a@gmail.com>
Date:   Tue, 22 Nov 2022 13:28:13 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <febcfb0a-c410-fb71-cff9-92acfcb269e2@kdbg.org>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

Le 2022-11-21 à 12:58, Johannes Sixt a écrit :
> It is customary to write `A || true` to ignore a potential error exit of
> command A. But when we have a sequence `A && B && C || true && D`, then
> a failure of any of A, B, or C skips to D right away. This is not
> intended here. Turn the command whose failure is to be ignored into a
> compound command to ensure it is the only one that is allowed to fail.
> 
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
>  t/t3920-crlf-messages.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/t/t3920-crlf-messages.sh b/t/t3920-crlf-messages.sh
> index 4c661d4d54..a58522c163 100755
> --- a/t/t3920-crlf-messages.sh
> +++ b/t/t3920-crlf-messages.sh
> @@ -12,7 +12,7 @@ create_crlf_ref () {
>  	cat >.crlf-orig-$branch.txt &&
>  	cat .crlf-orig-$branch.txt | append_cr >.crlf-message-$branch.txt &&
>  	grep 'Subject' .crlf-orig-$branch.txt | tr '\n' ' ' | sed 's/[ ]*$//' | tr -d '\n' >.crlf-subject-$branch.txt &&
> -	grep 'Body' .crlf-message-$branch.txt >.crlf-body-$branch.txt || true &&
> +	{ grep 'Body' .crlf-message-$branch.txt >.crlf-body-$branch.txt || true; } &&
>  	LIB_CRLF_BRANCHES="${LIB_CRLF_BRANCHES} ${branch}" &&
>  	test_tick &&
>  	hash=$(git commit-tree HEAD^{tree} -p HEAD -F .crlf-message-${branch}.txt) &&
> 

Thank you for making that function more robust.

Philippe.
