Return-Path: <SRS0=FxFb=2J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D501C43603
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 02:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3300B21D7D
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 02:07:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lI1YAcKn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbfLSCHQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Dec 2019 21:07:16 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:43377 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfLSCHQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Dec 2019 21:07:16 -0500
Received: by mail-yw1-f65.google.com with SMTP id v126so1601744ywc.10
        for <git@vger.kernel.org>; Wed, 18 Dec 2019 18:07:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=S0WbM/pfHL9cNdOimD7J6/Txmnhy/AAomSe2NUZWV/k=;
        b=lI1YAcKnlnGYvpvqq4yCfm8z+E3R1z60XEiiUFzyPfDxodXEKpgUVU9OtzzHoth4YQ
         uBLWKvHdzdEhx6BQYsMKgnNiiUD3WS1xIRYcXk2vtTvFS6CPZMaQUlQLO+o0lCdgpgd4
         tFsGCjvp6EsSJKlJ3H7iKI6oajlNgVN45uUDsJeQQOX69IhCdqh9YLp8JWwO0SS+2/o4
         fGSSg0IBx7qXqSn9GqlRp/Iob4c43e56cRvAsUFHUDY9l1Mngt6vWgiK+2sRH33lDNUi
         FTKeL1VPa6ZxZPqSRDR2WQIUiaC7clcOqtkf+r83EwJv+FwxqdARgFXchaNl8pMZjtIT
         nNyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=S0WbM/pfHL9cNdOimD7J6/Txmnhy/AAomSe2NUZWV/k=;
        b=Copv0QCubXzky+M98RMpOdb1c6fBBP6nbG/O7s6oxEaDJFu5zJye1O5T0JrEkkm9tQ
         Zj5uJusAgp3wQF0dYxPTrnjfcJz3OeveR3/nQKcSSSqBRCxtCTG6ju5UW9dfx80ZB8vx
         0GpXc6IUIjRan28Os7j1ok4v4vgf1il9teNY/3D/JLKsFBh7vViZb770VNB6e4cSzfUB
         Rzifh/3XKjq3RnHsQfcBaZ40WmMs9G0hbivnF+1vkKkAaLiRGzOEBnW6eYE+m3o8GFFm
         tzXdikjsR/gXAaLG4JJ2dqqKdvEqGAYutY1LebrmvO9fv4rignZ1PiFjteZ6U6qcWwdo
         vsQQ==
X-Gm-Message-State: APjAAAUvwI0ZQsm1pIBjBda6Q5/AVTNCsT6MwVTUNOQkiXXUNKdoiDWl
        HCamkxLUHR/OBJwME8IO0rE=
X-Google-Smtp-Source: APXvYqwG5XpikBMQg9jnCjKGRFX+F459D+wNFPodOagNw9pEe+tjBVbDK2eORycnwacWk8smbZvTnw==
X-Received: by 2002:a0d:fd42:: with SMTP id n63mr4533168ywf.422.1576721234920;
        Wed, 18 Dec 2019 18:07:14 -0800 (PST)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id k6sm1840637ywh.56.2019.12.18.18.07.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Dec 2019 18:07:14 -0800 (PST)
Subject: Re: [PATCH] sparse-checkout: improve OS ls compatibility
To:     Ed Maste <emaste@FreeBSD.org>,
        git mailing list <git@vger.kernel.org>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
References: <20191219015833.49314-1-emaste@FreeBSD.org>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <46d9f9dd-b278-bade-af48-3a3bd2e4aa5e@gmail.com>
Date:   Wed, 18 Dec 2019 21:07:13 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:72.0) Gecko/20100101
 Thunderbird/72.0
MIME-Version: 1.0
In-Reply-To: <20191219015833.49314-1-emaste@FreeBSD.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/18/2019 8:58 PM, Ed Maste wrote:

Thanks for the report!

It was a little unclear from the get-go what exactly the issue is.

> On FreeBSD, when executed by root ls enables the '-A' option:
> 
>   -A  Include directory entries whose names begin with a dot (`.')
>       except for . and ...  Automatically set for the super-user unless
>       -I is specified.

It appears that the "ls" commands in the sparse-checkout tests are
reporting the ".git" directory when executed on FreeBSD as root. Is this
only as root?

> Pipe ls's output to grep -v .git to remove the undesired entry.  Also
> pass the -1 option to ensure one entry per line.

What if we instead ran "ls -a" and added .git to our expected output
(when appropriate)? Would that be simpler (and reduce the process
count that this solution introduces).

Thanks,
-Stolee
 
> Signed-off-by: Ed Maste <emaste@FreeBSD.org>
> ---
> There are several different ways this could be solved; this approach
> felt cleanest to me, but there are at least two other reasonable
> alternatives:
> 
>   * Add -a to the invocations and .git to the expected output
> 
>   * Add LSFLAGS and set it to -I on BSDs, to turn off the special dot
>     behaviour
> 
> I'll submit a new patch if a different approach is preferred.
> 
>  t/t1091-sparse-checkout-builtin.sh | 33 +++++++++++++++++-------------
>  1 file changed, 19 insertions(+), 14 deletions(-)
> 
> diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
> index cee98a1c8a..3a3eafa653 100755
> --- a/t/t1091-sparse-checkout-builtin.sh
> +++ b/t/t1091-sparse-checkout-builtin.sh
> @@ -4,6 +4,11 @@ test_description='sparse checkout builtin tests'
>  
>  . ./test-lib.sh
>  
> +ls_no_git()
> +{
> +	ls -1 "$1" | grep -v .git
> +}
> +
>  test_expect_success 'setup' '
>  	git init repo &&
>  	(
> @@ -50,7 +55,7 @@ test_expect_success 'git sparse-checkout init' '
>  	EOF
>  	test_cmp expect repo/.git/info/sparse-checkout &&
>  	test_cmp_config -C repo true core.sparsecheckout &&
> -	ls repo >dir  &&
> +	ls_no_git repo >dir  &&
>  	echo a >expect &&
>  	test_cmp expect dir
>  '
> @@ -73,7 +78,7 @@ test_expect_success 'init with existing sparse-checkout' '
>  		*folder*
>  	EOF
>  	test_cmp expect repo/.git/info/sparse-checkout &&
> -	ls repo >dir  &&
> +	ls_no_git repo >dir  &&
>  	cat >expect <<-EOF &&
>  		a
>  		folder1
> @@ -90,7 +95,7 @@ test_expect_success 'clone --sparse' '
>  		!/*/
>  	EOF
>  	test_cmp expect actual &&
> -	ls clone >dir &&
> +	ls_no_git clone >dir &&
>  	echo a >expect &&
>  	test_cmp expect dir
>  '
> @@ -119,7 +124,7 @@ test_expect_success 'set sparse-checkout using builtin' '
>  	git -C repo sparse-checkout list >actual &&
>  	test_cmp expect actual &&
>  	test_cmp expect repo/.git/info/sparse-checkout &&
> -	ls repo >dir  &&
> +	ls_no_git repo >dir  &&
>  	cat >expect <<-EOF &&
>  		a
>  		folder1
> @@ -139,7 +144,7 @@ test_expect_success 'set sparse-checkout using --stdin' '
>  	git -C repo sparse-checkout list >actual &&
>  	test_cmp expect actual &&
>  	test_cmp expect repo/.git/info/sparse-checkout &&
> -	ls repo >dir  &&
> +	ls_no_git repo >dir  &&
>  	cat >expect <<-EOF &&
>  		a
>  		folder1
> @@ -154,7 +159,7 @@ test_expect_success 'cone mode: match patterns' '
>  	git -C repo read-tree -mu HEAD 2>err &&
>  	test_i18ngrep ! "disabling cone patterns" err &&
>  	git -C repo reset --hard &&
> -	ls repo >dir  &&
> +	ls_no_git repo >dir  &&
>  	cat >expect <<-EOF &&
>  		a
>  		folder1
> @@ -177,7 +182,7 @@ test_expect_success 'sparse-checkout disable' '
>  	test_path_is_file repo/.git/info/sparse-checkout &&
>  	git -C repo config --list >config &&
>  	test_must_fail git config core.sparseCheckout &&
> -	ls repo >dir &&
> +	ls_no_git repo >dir &&
>  	cat >expect <<-EOF &&
>  		a
>  		deep
> @@ -191,24 +196,24 @@ test_expect_success 'cone mode: init and set' '
>  	git -C repo sparse-checkout init --cone &&
>  	git -C repo config --list >config &&
>  	test_i18ngrep "core.sparsecheckoutcone=true" config &&
> -	ls repo >dir  &&
> +	ls_no_git repo >dir  &&
>  	echo a >expect &&
>  	test_cmp expect dir &&
>  	git -C repo sparse-checkout set deep/deeper1/deepest/ 2>err &&
>  	test_must_be_empty err &&
> -	ls repo >dir  &&
> +	ls_no_git repo >dir  &&
>  	cat >expect <<-EOF &&
>  		a
>  		deep
>  	EOF
>  	test_cmp expect dir &&
> -	ls repo/deep >dir  &&
> +	ls_no_git repo/deep >dir  &&
>  	cat >expect <<-EOF &&
>  		a
>  		deeper1
>  	EOF
>  	test_cmp expect dir &&
> -	ls repo/deep/deeper1 >dir  &&
> +	ls_no_git repo/deep/deeper1 >dir  &&
>  	cat >expect <<-EOF &&
>  		a
>  		deepest
> @@ -234,7 +239,7 @@ test_expect_success 'cone mode: init and set' '
>  		folder1
>  		folder2
>  	EOF
> -	ls repo >dir &&
> +	ls_no_git repo >dir &&
>  	test_cmp expect dir
>  '
>  
> @@ -256,7 +261,7 @@ test_expect_success 'revert to old sparse-checkout on bad update' '
>  	test_must_fail git -C repo sparse-checkout set deep/deeper1 2>err &&
>  	test_i18ngrep "cannot set sparse-checkout patterns" err &&
>  	test_cmp repo/.git/info/sparse-checkout expect &&
> -	ls repo/deep >dir &&
> +	ls_no_git repo/deep >dir &&
>  	cat >expect <<-EOF &&
>  		a
>  		deeper1
> @@ -313,7 +318,7 @@ test_expect_success 'cone mode: set with core.ignoreCase=true' '
>  		/folder1/
>  	EOF
>  	test_cmp expect repo/.git/info/sparse-checkout &&
> -	ls repo >dir &&
> +	ls_no_git repo >dir &&
>  	cat >expect <<-EOF &&
>  		a
>  		folder1
> 

