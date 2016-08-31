Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 285681FBB0
	for <e@80x24.org>; Wed, 31 Aug 2016 05:42:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752236AbcHaFjQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 01:39:16 -0400
Received: from mail-it0-f41.google.com ([209.85.214.41]:35797 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751264AbcHaFjP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 01:39:15 -0400
Received: by mail-it0-f41.google.com with SMTP id e124so24213843ith.0
        for <git@vger.kernel.org>; Tue, 30 Aug 2016 22:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ujRWaU8S9EgTW4h0HNxjfNHE1aGmc0roXbqa0etb8YE=;
        b=YEEpcKZw6SXLiMLObSP8uxw9xcYqpamYf0BWNlIPXk4dAM9bPqrpweuas/tWuzA7bm
         VTie4Xhb2jo2KMH5LtHmKKtu6giJx7GOHQWR4NDlhdGN+oxVmtxfMt8fGL7y869iVm0Y
         mLiKPyg6StHowfouKAOTthQAAcXDBa5De2DpDHyhHQj7f5WAZpfci2F0Uqp/3pKM+8Cp
         vEqovheeW16ptuVS3Y6edC5L/3KyhwP4mlfAPJ5dhuY+C+VNikdCFNZNa8M38qigO2uh
         nc1zB+GsDpqsZUSFQRa/orflA7v1+SAlZ1Mdjjj2Jo3iXbuO0RKe4a8hdnevprN5I1Y1
         u7jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ujRWaU8S9EgTW4h0HNxjfNHE1aGmc0roXbqa0etb8YE=;
        b=Z963u31Sbt6oRnUtMibm53csRtBulYssKSj+6dt753YoA5a8O2DGGkWXf8VVPAF36b
         HgTGSHvU0P92uAUJu1MmDMsE1Z6eWu/0/1c22btXhPfa720YKUos4Yipr937I0UjY0H1
         ydPBz5dPV951jbxbkPJmCnAm3tXVuh6IBGJMAsJMmzPFqKUSkBlhbYWbU/2d2+8HFy0R
         pjt+EiUTG+ClXaLUxLEmwXLx6/TK5Zt71PQISRevx2XYOxPR56Zy+P+Kdoz/DCuKpc7W
         tNz8WU9MIAcyJ83v6EAWkjRPOD3Ha/XFg6Je9VkRtoynM/exMj/tkR+QSMnpXZH7CtJp
         kRGQ==
X-Gm-Message-State: AE9vXwOqdbMY9R9hifU4/x6G0q0efBm+WjQup9zKeAWl5cjEetW/REFFYRK4flAsfT9MeGy/7faBltotSwkQO65a
X-Received: by 10.36.227.11 with SMTP id d11mr10555602ith.97.1472621954455;
 Tue, 30 Aug 2016 22:39:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Tue, 30 Aug 2016 22:39:14 -0700 (PDT)
In-Reply-To: <20160829175509.69050-1-larsxschneider@gmail.com>
References: <20160829175509.69050-1-larsxschneider@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 30 Aug 2016 22:39:14 -0700
Message-ID: <CAGZ79kYv1o1M5KiR0yQeUUsZLo_VFbyDRNGSwPqjvV_s5HkFEw@mail.gmail.com>
Subject: Re: [PATCH v1] pack-protocol: fix maximum pkt-line size
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 29, 2016 at 10:55 AM,  <larsxschneider@gmail.com> wrote:
> From: Lars Schneider <larsxschneider@gmail.com>
>
> According to LARGE_PACKET_MAX in pkt-line.h the maximal length of a
> pkt-line packet is 65520 bytes. The pkt-line header takes 4 bytes and
> therefore the pkt-line data component must not exceed 65516 bytes.
>
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
>
> This patch was part of my "Git filter protocol" series [1]. Stefan
> suggested to submit this patch individually as it is not strictly
> required in the series [2].
>
> Thanks,
> Lars
>
>
> [1] http://public-inbox.org/git/20160825110752.31581-1-larsxschneider@gmail.com/
> [2] http://public-inbox.org/git/CAGZ79kaJn-yf28+Ls2JyqSs6Jt-Oj2JW-sAXQn-Oe5xaxSyjMQ@mail.gmail.com/
>
>
>  Documentation/technical/protocol-common.txt | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/technical/protocol-common.txt b/Documentation/technical/protocol-common.txt
> index bf30167..ecedb34 100644
> --- a/Documentation/technical/protocol-common.txt
> +++ b/Documentation/technical/protocol-common.txt
> @@ -67,9 +67,9 @@ with non-binary data the same whether or not they contain the trailing
>  LF (stripping the LF if present, and not complaining when it is
>  missing).
>
> -The maximum length of a pkt-line's data component is 65520 bytes.
> -Implementations MUST NOT send pkt-line whose length exceeds 65524
> -(65520 bytes of payload + 4 bytes of length data).
> +The maximum length of a pkt-line's data component is 65516 bytes.
> +Implementations MUST NOT send pkt-line whose length exceeds 65520
> +(65516 bytes of payload + 4 bytes of length data).
>
>  Implementations SHOULD NOT send an empty pkt-line ("0004").
>

This looks good,

Thanks,
Stefan

> --
> 2.9.2
>
