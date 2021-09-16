Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A2A5C433EF
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 05:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6265E611C8
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 05:21:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234292AbhIPFWk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 01:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbhIPFWh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Sep 2021 01:22:37 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F70C061574
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 22:21:17 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id m11so6449323ioo.6
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 22:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=CWxad40VGEDRSrKOfYM4C58FLRGMyJcu/CRPV1ALpys=;
        b=FHBGEbu76GDpUZDdI+rE1R6AM/kOCGsoo2tehHDCAZGxdXc0Vaw7dKa4URbthDK9u0
         nyJc69BNa5kqNP4DOf06jnS47sLKV7yxdH386owovxeGUBXYJzWTxGZphmjXwau9+StO
         HI/gK2WuaWjZXxSwe2Pjhq71nJeySHKrN+hpiF0JjsMUJlfrCEKVF03xSO0ivvvDN4Or
         CLOSRmGRsPysbHyKuRzVEqCLvNXd6mtvwiTBqvU232lQSuj/jg1AJALsNM0x+15MVdg6
         aD/vwsvYOw64tsbHoEQbVwaOQHvs0JHWv4p6zlDIv3mixDklfOO8vwWRIT/xiY9+VvlP
         EXig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=CWxad40VGEDRSrKOfYM4C58FLRGMyJcu/CRPV1ALpys=;
        b=rhWth/vf0qCsfg1tlPf/QahE478Fg/xyLHQqNSgdygNqTun5BnBnEUx4JQLOEqHl7l
         aiirrraEdPl4GCBpD+8vAMbUX6/QbTk669rnt43tMAsFrQdu6YnahPGUkRpx9mrUnKzE
         RD6l9TN1R4mJpO0f+8KXXEALKkrpVvPMy13nUHbkebtXP8/0TQY/NVDsv+LK/mO0g2WN
         eFY1wtmEiOqYD61VhWBUz1CYhPYJ5bM3+CtZJ+6b85iJUx6bPylefJBuuj76vCIvyttC
         aan0nXP1zHU3pfOO4/QfoF1dLhVvHZpAIxx2SOq069oqyv9Zsl/DjCHk0Wv+SAzd7WkO
         VG1Q==
X-Gm-Message-State: AOAM53054gZfWLHSftzY5DCHwRsIcn711IrIrX5b91dvNz2RGlq4yvJ/
        XODKPNYDOtpF54gnu1qzjPNuhg==
X-Google-Smtp-Source: ABdhPJxS8QyrYp58JXaoLdji2LlU2UBejx1tfLTAabAjltQOy22LLGfTJPzeAgWkKppq2w5/MsigJw==
X-Received: by 2002:a6b:1d0:: with SMTP id 199mr2960979iob.20.1631769676787;
        Wed, 15 Sep 2021 22:21:16 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id t25sm1050148ioh.51.2021.09.15.22.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 22:21:16 -0700 (PDT)
Date:   Thu, 16 Sep 2021 01:21:15 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, gitster@pobox.com
Subject: Re: [PATCH 2/2] t0000: avoid masking git exit value through pipes
Message-ID: <YULUS3kYkB4RXv2K@nand.local>
References: <20210916023706.55760-1-carenas@gmail.com>
 <20210916023706.55760-3-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210916023706.55760-3-carenas@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 15, 2021 at 07:37:06PM -0700, Carlo Marcelo Arenas Belón wrote:
> 9af0b8dbe2 (t0000-basic: more commit-tree tests., 2006-04-26) adds
> tets for commit-tree that mask the return exit from git as described

s/tets/tests

> diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
> index cb87768513..545ff5af13 100755
> --- a/t/t0000-basic.sh
> +++ b/t/t0000-basic.sh
> @@ -1270,26 +1270,31 @@ test_expect_success 'no diff after checkout and git update-index --refresh' '
>  P=$(test_oid root)
>
>  test_expect_success 'git commit-tree records the correct tree in a commit' '
> -	commit0=$(echo NO | git commit-tree $P) &&
> -	tree=$(git show --pretty=raw $commit0 |
> -		 sed -n -e "s/^tree //p" -e "/^author /q") &&
> +	echo NO | git commit-tree $P >out &&
> +	commit0=$(cat out) &&
> +	git show --pretty=raw $commit0 >out &&
> +	tree=$(cat out | sed -n -e "s/^tree //p" -e "/^author /q") &&

In this and the below tests which had a similar transformation, the
first invocation does not mask its error, since it's on the right-hand
side of a pipe.

But piping "git show" to sed will mask the exit code of the former. So
that makes sense. But I would like to see us avoid an unnecessary
cat-into-pipe and instead redirect out into sed, like "sed -n -e ...
<out".

Thanks,
Taylor
