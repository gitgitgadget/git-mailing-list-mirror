Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25CAD207B3
	for <e@80x24.org>; Sat,  6 May 2017 01:25:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750905AbdEFBZF (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 May 2017 21:25:05 -0400
Received: from mail-lf0-f51.google.com ([209.85.215.51]:33778 "EHLO
        mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750863AbdEFBZF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2017 21:25:05 -0400
Received: by mail-lf0-f51.google.com with SMTP id r17so11470175lfg.0
        for <git@vger.kernel.org>; Fri, 05 May 2017 18:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=VG2++Q5YKmlSbLSrFwpYUEM/A88l7Wb59gXpJU84c38=;
        b=or03xR1pqXCs5k6gigBynOR65DcbYPSjhY2OTb4Ktj1YJMHHa4MIfm8IcQA/XCSIfy
         aD3SKtgcmbVzDAO8BE0Nvj3RdVQJYkNNhGvOVDby55kd/zFs4vvV6QdeXHQ979Mmbs60
         Ul3cYl+E3XZ+HjKXz3v4b6lpQan3tMwH+7HRA1WA7x3euZI+zKJ/ToUrsTBHSelcvXXx
         UicgDdN9IyeAL7niRGTPhtLAAqoyZRXbt8JOXKkGFdskLLx58CuZz09FEdlxLAMWpoYN
         9604JBZ+8j66x49YJd0fGpsS69M8uBYheyqGuqlsFTzvNlGFdLPk9uDhUdwjs0REDEJH
         D+Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=VG2++Q5YKmlSbLSrFwpYUEM/A88l7Wb59gXpJU84c38=;
        b=aO0SqGNvJ+WmTlPN63C6hUGyuK3spEtH5f1p05P7bLaFQDn11tIjzk7avBOSsAz62J
         GRLAdXp/FxRxYpJXk58lG/jgXDbLHS2z3nT32p3D7/YMOXzv+8sljdgoKicRL4zhFpq8
         pa3UKHicDet54r4i7xnksJRAvFRwW6P7GxuQRvby+F8+6r0iVeZbU+mBBVRQIoQXNrJR
         zxXFUwyFWbUgJEslyJPjhDoklkw+4x8W+2tcsPnHYeXcGm85JuvLr6wlzNswk6+XysMM
         zj8tMyCTpzQyVUtITLZDTl3DhCq6USpp1MF8gsWRJFSDpiDwtNVhfSeEZ92NWj2e356Z
         IsZA==
X-Gm-Message-State: AN3rC/4XHZEEB03t5KhHSCPrDmrz71Gan/UvchTNulIMTsM4wOuDzoLU
        hsKpRBhVpP63dNtklm5yTYZoTsOAlA==
X-Received: by 10.25.196.66 with SMTP id u63mr6043330lff.88.1494033902972;
 Fri, 05 May 2017 18:25:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.32.133 with HTTP; Fri, 5 May 2017 18:24:42 -0700 (PDT)
In-Reply-To: <20170504214355.14179-1-sbeller@google.com>
References: <20170504214355.14179-1-sbeller@google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Fri, 5 May 2017 18:24:42 -0700
Message-ID: <CA+P7+xqMNiHGi=NVjTHCmnkk3u2BVC5Kfs6p6S3m+LwZr6vkaQ@mail.gmail.com>
Subject: Re: [RESEND PATCH] diff: recurse into nested submodules for inline diff
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 4, 2017 at 2:43 PM, Stefan Beller <sbeller@google.com> wrote:
> When fd47ae6a5b (diff: teach diff to display submodule difference with an
> inline diff, 2016-08-31) was introduced, we did not think of recursing
> into nested submodules.
>
> When showing the inline diff for submodules, automatically recurse
> into nested submodules as well with inline submodule diffs.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>
> This is a resend of
> https://public-inbox.org/git/20170331231733.11123-3-sbeller@google.com/
>
> In the cover letter of that patch, I said I would want to redo the tests with
> scrubbed output. However given the widespread use of unscrubbed output,
> I think this is fine as-is to include.
>
> Thanks,
> Stefan

Fix looks obviously correct to me. I would like to change the tests to
not use the unscrubbed output, but that's a problem for a separate
patch.

Thanks,
Jake
