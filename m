Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7302C2BA19
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 00:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A654921473
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 00:06:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Afb3nTed"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728195AbgDXAGB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Apr 2020 20:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727913AbgDXAGB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Apr 2020 20:06:01 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B001C09B042
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 17:06:01 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id k18so3070914pll.6
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 17:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GjcPmh96NX5T+78n7E/eBt58p0Jtxspg6FzgZax8vjk=;
        b=Afb3nTedk0uTcuX7jiKz7g9Isk0qg38WmGbS/uFQEBqUx2389kamzdeH9gmgbWw8Mt
         VTTTosmlXc8K0ymkmJCPJbFmmfKlNGix5sf0e7XQ+3B6zELqs9LDOiDFPC6jzmw19DT7
         1EwguEa2/CjRAzSkip3t2R4R/FoyEUEB8FjcTbUIoItPLiW77uf4MCrzhd/zSEWTuhNf
         atYAMSAYCbcoxzQTqZMKXCUva3n1DiMJMLRK5a/n34Crm+i0cnPfKOF0dJZZB8v+XHDN
         Bl4IVPSeXkOpS2uuM/MPUSsHb3C9tBPRDuMmmn0TLCgw3yLXg5qcGXvCW0CKXjiyqbM6
         tdWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GjcPmh96NX5T+78n7E/eBt58p0Jtxspg6FzgZax8vjk=;
        b=WXcvLZSuESIubHA27xU2i+VDT1MOdb2BhRxDonIOBHqq4EMhYVhzOqdsWfDI8J5qjL
         OOUqu5GoGa/A+bD9LfAXdzR3zQSb0zyCOiFaFskf3v/JsB1Cff3gdumdtMsmKO3RIm+K
         5saYLGk9F9C22tUp/r9gElDyTqSePOZBE7o8XW0aqK2QhaprqCzWrEM9JB6RzuYijdVR
         +Lt+9TMrRbLLQXzaLkPzgJLvPbZsBWC5Y7x0fFhRk/yDfkXJdRsRXjXI7cHX82a4DR1+
         E17/wsL68h7AHW8CTBPAAlnQZ4o8Q4xexe7hljWGdVzZdyB3CohvUaVwFRjR8kdB/8iv
         WptQ==
X-Gm-Message-State: AGi0PuZ1YIQRFLZr0slULP8iU6acLLjIU1dtPIxLNJtmPU18fpgbJFoQ
        VNIXpC/213OopXk2WhRf8XM=
X-Google-Smtp-Source: APiQypKNkC7ePI7yqtZwXdps9T7v2D56CFAFR7eBBLsy6cfJf8pq2/7JUurH3++vKg2aaCDuA3RF7w==
X-Received: by 2002:a17:90a:17ed:: with SMTP id q100mr3585885pja.80.1587686760747;
        Thu, 23 Apr 2020 17:06:00 -0700 (PDT)
Received: from Carlos-MBP (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id e196sm3755919pfh.43.2020.04.23.17.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 17:06:00 -0700 (PDT)
Date:   Thu, 23 Apr 2020 17:05:58 -0700
From:   Carlo Marcelo Arenas =?iso-8859-1?Q?Bel=F3n?= <carenas@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Ilya Tretyakov <it@it3xl.ru>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 3/3] credential: handle
 `credential.<partial-URL>.<key>` again
Message-ID: <20200424000558.GB20669@Carlos-MBP>
References: <pull.615.git.1587588665.gitgitgadget@gmail.com>
 <pull.615.v2.git.1587685397.gitgitgadget@gmail.com>
 <daedaffe960581733c25383a2a1b30056a415594.1587685397.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <daedaffe960581733c25383a2a1b30056a415594.1587685397.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 23, 2020 at 11:43:17PM +0000, Johannes Schindelin via GitGitGadget wrote:
> diff --git a/credential.c b/credential.c
> index 52965a5122c..3505f6356d8 100644
> --- a/credential.c
> +++ b/credential.c
> @@ -53,7 +53,13 @@ static int credential_config_callback(const char *var, const char *value,
>  		char *url = xmemdupz(key, dot - key);
>  		int matched;
>  
> -		credential_from_url(&want, url);
> +		if (credential_from_url_gently(&want, url, 1, 0) < 0) {

definitely not worth a reroll, but just wondering if would make sense to call
credential_from_url_gently(!quiet) here, just for consistency?

other than that this series is looking great, under the assumption that there
is going to be some more followup with non essential changes.

will chip in with an test helper for that series so we can hopefully keep our
sanity next time someone touches that function again.

Carlo
