Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F4871FAF4
	for <e@80x24.org>; Tue, 14 Feb 2017 16:53:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754272AbdBNQxI (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 11:53:08 -0500
Received: from mail-it0-f45.google.com ([209.85.214.45]:35969 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754601AbdBNQxG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 11:53:06 -0500
Received: by mail-it0-f45.google.com with SMTP id c7so40619527itd.1
        for <git@vger.kernel.org>; Tue, 14 Feb 2017 08:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=F8zbDqdr6m+B2ZRBo6QkKmUCHKy3u0R5tWOgZHY6WCc=;
        b=v+3ARwetFw65jFz9SsAOO8W0a2EP7h99DqVNBSqx96ogiZdqXosrabTniWD2Do8znL
         XWsgrw5Pc0QtAztO5CTOSufB2pO+58hmJi5vAbScY5TWf/3Iln88FX/xUDG8QQP45gPW
         qS1qf/ybs9IEXAX4m98tfrPAH3xDWmbzpRO8T/uGj3AwK+yao8wh0Zbe3deTgiBCbGvC
         Zu1o3NWULO77DsmAFTG830KkdBraBgiKCVnHXi/fqr95o/vHHqkuuwANVaelv/B+4aYg
         d9YXWnjx73d2VK6a8T7gIWDwAVmNicS1QGqLNH4k8lGd/cfMUBRCpbRrRctUIC5ePvlY
         73lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=F8zbDqdr6m+B2ZRBo6QkKmUCHKy3u0R5tWOgZHY6WCc=;
        b=BYqmSHo2NlMsxAYr12uJCESKB3zw68N9cS7WVJB9wQaNFQ1pV15DS/GWvh89CoKUx7
         h4khFd8aBsfZDxiKhojPUgUyroZH/PaC8JOr6j4ICpTcZjCBDi1bpKgdH7wVg/4y+qTq
         JOrGXTL25PuTOCDwX9Sed4MDQyb6ge31ZTISWBgwevshdg5fjFRzg2yUmJ0rJHGDa6il
         RieTiZ6+CRM9RG0Djsoc9yehbVVaxafyecWjh1JfiLPun5tZPyb0q7V06ckxHLDLT3rw
         Jvk1qcTTLbNCMQDMWqczGY/XVvc3Z1cbbVxPDj+2dLwofwuUuj8cEaswdSuBuzqIIb/Q
         rEXA==
X-Gm-Message-State: AMke39mpOOR1+zSn8X7fTmUM8r6WVH7QTZaGQHjf8y8Mqu4Dwv56RGnvLycT4MRXocNCEmLi
X-Received: by 10.99.229.17 with SMTP id r17mr33569989pgh.81.1487091185794;
        Tue, 14 Feb 2017 08:53:05 -0800 (PST)
Received: from twelve2.mtv.corp.google.com ([2620:0:1000:5b10:55a2:e20d:aab0:fd6b])
        by smtp.gmail.com with ESMTPSA id u75sm2374376pgc.31.2017.02.14.08.53.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Feb 2017 08:53:05 -0800 (PST)
Subject: Re: [PATCH 6/7] grep: avoid resolving revision names in --no-index
 case
To:     Jeff King <peff@peff.net>
References: <20170214060021.einv7372exbxa23z@sigill.intra.peff.net>
 <20170214060729.v4r24y5tuaov3jrh@sigill.intra.peff.net>
Cc:     git@vger.kernel.org, gitster@pobox.com
From:   Jonathan Tan <jonathantanmy@google.com>
Message-ID: <eef97cc4-d616-b298-bc99-b2772b757190@google.com>
Date:   Tue, 14 Feb 2017 08:53:04 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <20170214060729.v4r24y5tuaov3jrh@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/13/2017 10:07 PM, Jeff King wrote:
> diff --git a/builtin/grep.c b/builtin/grep.c
> index e83b33bda..c4c632594 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -1176,6 +1176,12 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
>  			break;
>  		}
>
> +		if (!use_index) {
> +			if (seen_dashdash)
> +				die(_("--no-index cannot be used with revs"));

There is a subsequent check that prints "--no-index or --untracked 
cannot be used with revs." - maybe we should just expand this part to 
incorporate that case. (That is, write `if (!use_index || untracked)` 
instead of `if (!use_index)`.) This also allows us to preserve the error 
message, which might be useful for someone using a translated version of 
Git.

> +			break;
> +		}
> +
>  		if (get_sha1_with_context(arg, 0, sha1, &oc)) {
>  			if (seen_dashdash)
>  				die(_("unable to resolve revision: %s"), arg);
