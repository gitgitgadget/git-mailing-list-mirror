Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E384EC12002
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 23:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA4B5613C9
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 23:01:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237394AbhGNXEm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 19:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbhGNXEl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 19:04:41 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A65BAC06175F
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 16:01:49 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id a7so3235029iln.6
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 16:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=shE1uTdLRfhStPIjLju2TWasi7Pak8NTMSRzHxIRm0A=;
        b=UxYiAgZ/hL/DU44L25hlwd8S4trbEGCYecpCqbTB/qAoiVapGN6AkTV5Lmmo95/fNo
         Up6IkLK/Oghy4rXUWTBK04NgYwI1mk136tfazwxAb/ejEz9f4ftMuL1gKq1Uk15TEdjZ
         gx2rr/lnE2SMbt9oaqcgtzrxK+UCn7ZVb6uk78gHEA0m48llBTDkHVcFBqinsM1RFjiS
         9/wITVIWWGPqd/y0O3GMSceZ9Ee/SjAzqmMJeXnVt0yxVDAGS8xx1vtSWf+ciZePF0hf
         2XaG4H4p8ssjvPSO5wzG+FOxoQb3TOtGIpeabOynJaY4vUzwAvF53aBUI13lqeHd2Za5
         TDtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=shE1uTdLRfhStPIjLju2TWasi7Pak8NTMSRzHxIRm0A=;
        b=QS7pM8+jJaWyAXTAQQMQkANH5D7dZFNsOlRjHjkECz15dJuh+mAyEhqwNk8PUzieJq
         wRt/l7w9eMlI0woNPHqUqkYrczKxmXymRed5qYMXE00apVMmGB0bIxhnrjU4mOmsKMLB
         K5SodX9RXo0NxDwI19FltYVqyMZq9LTm5b5lAmM+75tQ4u0gFQ3fYZlif/Xi0+t9lWX6
         Jl4Xw+JVUCG0eEJVYBrccEuai4czXvm6gpZfIVOJQbZLEDb46vSmivPYSbe5ngFRkhal
         xsR46LVCiyHgumrE5dBChLkhD7GulUsNSWmsOIF1i9njXqs+/MVVo8M+ewMqYjnA+cwi
         3gvg==
X-Gm-Message-State: AOAM532qU97ML3OdE+RI7+Vt6J/HwjWMbuLJFa1jdPeV0wk/FrM39dPD
        H/WEXoV4ygsGTOkPitmjPNFVNg==
X-Google-Smtp-Source: ABdhPJzPyt/s70/5RclTnvXtlMW5qawXQlpphx2XM+lv3ADL0/srkJO+ftCrLidx6ZBVYa8UrqFLNA==
X-Received: by 2002:a05:6e02:1a8b:: with SMTP id k11mr178534ilv.136.1626303709078;
        Wed, 14 Jul 2021 16:01:49 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:3f15:e25d:cd63:d019])
        by smtp.gmail.com with ESMTPSA id t24sm2067059ioh.24.2021.07.14.16.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 16:01:48 -0700 (PDT)
Date:   Wed, 14 Jul 2021 19:01:48 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com,
        gitster@pobox.com, jonathantanmy@google.com
Subject: Re: [PATCH v2 06/24] midx: make a number of functions non-static
Message-ID: <YO9s3NM8CYtbbo82@nand.local>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1624314293.git.me@ttaylorr.com>
 <b3a12424d78e80553741f5c7a0672490a59b6f7d.1624314293.git.me@ttaylorr.com>
 <878s2yzv65.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <878s2yzv65.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 25, 2021 at 01:42:06AM +0200, Ævar Arnfjörð Bjarmason wrote:
>
> On Mon, Jun 21 2021, Taylor Blau wrote:
>
> > These functions will be called from outside of midx.c in a subsequent
> > patch.
>
> So "a number" is "two" and "a subsequent patch" appears to be 13/24. I
> think this would be clearer just squashed into whatever needs it, or at
> least if it comes right before the new use in the series.

Good suggestion, thanks. This was probably written at a time when the
number of functions I needed was larger (or perhaps when this and
patches 10-12 were all jumbled together).

In any case, I dropped this patch and squashed its contents into 13/24
where it is used.

Thanks,
Taylor
