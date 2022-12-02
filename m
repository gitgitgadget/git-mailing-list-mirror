Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4024FC4332F
	for <git@archiver.kernel.org>; Fri,  2 Dec 2022 23:14:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234696AbiLBXOI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Dec 2022 18:14:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233947AbiLBXOG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2022 18:14:06 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204229585
        for <git@vger.kernel.org>; Fri,  2 Dec 2022 15:14:06 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id u10so4424341qvp.4
        for <git@vger.kernel.org>; Fri, 02 Dec 2022 15:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tYo+OIuWFiq1SsfInKar0UK7W0vrhhC2bZrTMCEFFhQ=;
        b=l4KIjRMu2+tFnEN5qCHBKYDy/Y8JQAPmLvJEBCfwfxLllOU94I7QTcSwaxFXUQtrNC
         n2QPPSkk+lX1WFL38PV/xJIv57V3TReu5wuR95fX9EERYg2ChlTtYnOEs8WcCz0bLAV7
         fjvNuwSFk2WXFXz92vPNudnaUNTulySXOznkOsfR8nDlQcRIDBnf1ngTHaqFdbWPKS71
         ebJbxv3Tb7NblNjRwo2FPFUuEuiFte1YPjXnO9S7c3RHjcxzoEHaZ3UqEtGF6i7fPFqM
         xCHuRATfCGUdpjg9pKyFlWo9NQpNiOZ7398ILyP/QC4sQL95Xw+g0/EKLUGWgxR0Ufhs
         v+VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tYo+OIuWFiq1SsfInKar0UK7W0vrhhC2bZrTMCEFFhQ=;
        b=qIk9B7F0LgSF+gZb60Tl5x3bw6HaYnyyT+ov0fAYONqiVfFr5TjkrFdfQiPHb5f9z0
         2dpK7geAJt6DODRmA+z/tg8AX8wdn+sybEQfW7GG0lC25xnARM+ywrB744kDbq/U+Fv8
         Ia6tA4xVSEGWmIne4fU9ZEgaSkAm1G3jRuJOQwSkV0F/B1Vnl8uyS3/ej1b+ZalrFLCN
         RDolMxk5dlIgxtI7ZOOO+vXEcGXW4os8oGyjOQhkpFbgXRGBudqKjFGbsALj8JhVBCoN
         twzPamZe7Gdko6jktZ4NLP8sXhAFiBoptsqq/dq+NxX1Fbpxmtw4rEz5Qg5Rv5OSTt6O
         xt0g==
X-Gm-Message-State: ANoB5pnBPFDN/iqPClBZMuU/Mx3hhUSzRpYezJvvxLASApiAOpo1QaNw
        swZ4MxkMM5INIPgq1uSFE54=
X-Google-Smtp-Source: AA0mqf4AZ4hCid1c7OTzwx55T12e+GmHLHDJVfhqgY6iRyCuE+bv53OW1f7sk/ZV1wrmSYFTKJryiA==
X-Received: by 2002:a05:6214:a0b:b0:4c6:f93f:1cfa with SMTP id dw11-20020a0562140a0b00b004c6f93f1cfamr27667136qvb.49.1670022845261;
        Fri, 02 Dec 2022 15:14:05 -0800 (PST)
Received: from [192.168.1.128] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id n16-20020ac86750000000b003a50248b89esm4947175qtp.26.2022.12.02.15.14.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Dec 2022 15:14:04 -0800 (PST)
Subject: Re: [PATCH 2/1] t3920: support CR-eating grep
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Johannes Sixt <j6t@kdbg.org>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
References: <febcfb0a-c410-fb71-cff9-92acfcb269e2@kdbg.org>
 <cbe88abc-c1fb-cb50-6057-47ff27f7a12d@web.de>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <cd92755f-de16-0df9-075e-2bd5ab0dd4fb@gmail.com>
Date:   Fri, 2 Dec 2022 18:14:03 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <cbe88abc-c1fb-cb50-6057-47ff27f7a12d@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi René,

Le 2022-12-02 à 11:51, René Scharfe a écrit :
> grep(1) converts CRLF line endings to CR on current MinGW:
> 
>    $ uname -sr
>    MINGW64_NT-10.0-22621 3.3.6-341.x86_64

I don't really know the conventions in this regards, but for me 
"MinGW" refers to the port of GCC to Windows. Here it would be more 
correct to refer to "the Git for Windows flavor of MSYS2" or something
like this, in my (maybe uninformed) opinion.

> 
>    $ printf 'a\r\n' | hexdump.exe -C
>    00000000  61 0d 0a                                          |a..|
>    00000003
> 
>    $ printf 'a\r\n' | grep . | hexdump.exe -C
>    00000000  61 0a                                             |a.|
>    00000002
> 
> Create the intended test file by grepping the original file with LF
> line endings and adding CRs explicitly.
> 
> The missing CRs went unnoticed because test_cmp on MinGW ignores line
> endings since 4d715ac05c (Windows: a test_cmp that is agnostic to random
> LF <> CRLF conversions, 2013-10-26). 

Reading that commit's messages, if I understand correctly it's more MSYS2's Bash
that is the culprit, rather than its grep, no?

> Fix this test anyway to avoid
> depending on that special test_cmp behavior, especially since this is
> the only test that needs it.

Do you mean the only test in that file, or in the whole Git test suite (which would
mean after this series we could completely remove the Windows-specific 'test_cmp' ) ?

> 
> Piping the output of grep(1) through append_cr has the side-effect of
> ignoring its return value.  That means we no longer need the explicit
> "|| true" to support commit messages without a body.
> 
> Signed-off-by: René Scharfe <l.s.r@web.de>
> ---
>  t/t3920-crlf-messages.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/t/t3920-crlf-messages.sh b/t/t3920-crlf-messages.sh
> index a58522c163..67fd2345af 100755
> --- a/t/t3920-crlf-messages.sh
> +++ b/t/t3920-crlf-messages.sh
> @@ -12,7 +12,7 @@ create_crlf_ref () {
>  	cat >.crlf-orig-$branch.txt &&
>  	cat .crlf-orig-$branch.txt | append_cr >.crlf-message-$branch.txt &&
>  	grep 'Subject' .crlf-orig-$branch.txt | tr '\n' ' ' | sed 's/[ ]*$//' | tr -d '\n' >.crlf-subject-$branch.txt &&
> -	{ grep 'Body' .crlf-message-$branch.txt >.crlf-body-$branch.txt || true; } &&
> +	grep 'Body' .crlf-orig-$branch.txt | append_cr >.crlf-body-$branch.txt &&
>  	LIB_CRLF_BRANCHES="${LIB_CRLF_BRANCHES} ${branch}" &&
>  	test_tick &&
>  	hash=$(git commit-tree HEAD^{tree} -p HEAD -F .crlf-message-${branch}.txt) &&
> --
> 2.38.1.windows.1
> 

apart from the minor things in the commit message, the 3 patches look good to me :) 
Here is my Acked-by: for all 3 :

Acked-by: Philippe Blain <levraiphilippeblain@gmail.com>

Thanks for detailed messages as always, it definitely went over my radar at the time
that both 'grep' and  'test_cmp' acted differently on Windows.

Cheers,
Philippe.
p.s. I wonder what happened for format-patch to generate these 2/1, 3/1 and 4/1 patch prefixes :P
