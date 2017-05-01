Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E26821F78F
	for <e@80x24.org>; Mon,  1 May 2017 18:06:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750944AbdEASGO (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 May 2017 14:06:14 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:35794 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750733AbdEASGN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2017 14:06:13 -0400
Received: by mail-pf0-f181.google.com with SMTP id v14so77501500pfd.2
        for <git@vger.kernel.org>; Mon, 01 May 2017 11:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8LGLMIqL3+KwI4aaV7+0gW08+wMvp1Ddmj25uoyZY/8=;
        b=VGK7TMP41+7p9FKALulV1fQ9wh3dfbp8nVgb1W0Lfpbn6fJC1NPFr1i3FHXXnfU1YR
         7d2h1W/2VbJ87MgWDFhX4A/nT8bI8STfoDksOoQCRf2Qk3yHDsLravbBnlqWE2kLs8TZ
         JndCOIBe2ZPvlofR79iGylXpHPtW4yLFW6l1UkuixcZMJ+zWA5X2Ck1v2/xN9HR2J5x1
         DLrIgZ9Ibh5TS6j2rONJ04ZxjfhfK5hvhMuV9jOQie+WFPGiJjlpSPrRFbGCSK6spHT4
         1HpJY173M63nbBjimgx4Vqbj4kpDiWMCCBK8HplOegcE1EKs6hGXYm+9iRCXCxrJ0vMQ
         DbJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8LGLMIqL3+KwI4aaV7+0gW08+wMvp1Ddmj25uoyZY/8=;
        b=jIaWwdm9W777jXoIxt36GVSOGhlNR46wuwaCvA7kn1zPbAFgciAuTK5jiWAF2ymThh
         D3KMk0HwCQx+w2u++6uuN7sO+o2P0aLgrmV2GyZfkPAVRHLPdcFvaXEEuyJqST/3VXQ7
         blSpk8JRVdkEfQM6HPawp8tveFDBHtBshKBs8jOkJCR28nuGv6mPAhQTo/GQ0Itc9AnU
         rGplO4mX2e5y9RHyQVoRzt1j8x+UNb+mCZ8TgGpdNdRRFkjUMQ5V60AkQBtzJnhxTgLp
         ZgwBDL9GWZ7/kPEvcLfg9Seb/wwrSycVFCsVhcfrn8BL+YF4YdyLX/kU8pRQLK/eKf/+
         KvhA==
X-Gm-Message-State: AN3rC/6wsIHiS4uaKL1/+5UsVSGAN9kMqZ/pVVR48doaXMlDptPBGyvM
        VPWQUNv2GIJWZZNS
X-Received: by 10.99.174.75 with SMTP id e11mr28488055pgp.177.1493661972632;
        Mon, 01 May 2017 11:06:12 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:6d87:7989:6a8d:cab9])
        by smtp.gmail.com with ESMTPSA id 128sm24531431pgi.49.2017.05.01.11.06.11
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 01 May 2017 11:06:11 -0700 (PDT)
Date:   Mon, 1 May 2017 11:06:10 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     jrnieder@gmail.com, git@vger.kernel.org
Subject: Re: [PATCH 1/5] submodule_move_head: fix leak of struct child_process
Message-ID: <20170501180610.GF39135@google.com>
References: <20170501180058.8063-1-sbeller@google.com>
 <20170501180058.8063-2-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170501180058.8063-2-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/01, Stefan Beller wrote:
> While fixing the leak of `cp`, reuse it instead of having to declare
> another struct child_process.
> 
> Signed-off-by: Stefan Beller <sbeller@google.com>

This shouldn't be needed as 'finish_command' does the cleanup for you by
calling 'child_prcoess_clear()'.


> ---
>  submodule.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/submodule.c b/submodule.c
> index d3299e29c0..cd098cf12b 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -1466,17 +1466,19 @@ int submodule_move_head(const char *path,
>  		goto out;
>  	}
>  
> +	child_process_clear(&cp);
> +
>  	if (!(flags & SUBMODULE_MOVE_HEAD_DRY_RUN)) {
>  		if (new) {
> -			struct child_process cp1 = CHILD_PROCESS_INIT;
> +			child_process_init(&cp);
>  			/* also set the HEAD accordingly */
> -			cp1.git_cmd = 1;
> -			cp1.no_stdin = 1;
> -			cp1.dir = path;
> +			cp.git_cmd = 1;
> +			cp.no_stdin = 1;
> +			cp.dir = path;
>  
> -			argv_array_pushl(&cp1.args, "update-ref", "HEAD", new, NULL);
> +			argv_array_pushl(&cp.args, "update-ref", "HEAD", new, NULL);
>  
> -			if (run_command(&cp1)) {
> +			if (run_command(&cp)) {
>  				ret = -1;
>  				goto out;
>  			}
> @@ -1492,6 +1494,7 @@ int submodule_move_head(const char *path,
>  		}
>  	}
>  out:
> +	child_process_clear(&cp);
>  	return ret;
>  }
>  
> -- 
> 2.13.0.rc1.1.gbc33f0f778
> 

-- 
Brandon Williams
