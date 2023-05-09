Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 159BFC77B75
	for <git@archiver.kernel.org>; Tue,  9 May 2023 19:11:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235027AbjEITL4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 May 2023 15:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234562AbjEITLx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2023 15:11:53 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE1732710
        for <git@vger.kernel.org>; Tue,  9 May 2023 12:11:50 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-55a14807e4cso112258647b3.1
        for <git@vger.kernel.org>; Tue, 09 May 2023 12:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1683659510; x=1686251510;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CLBZv+EAn+SWsKZ2bfosCg918wl/kYfXIfpW4fy2Y0M=;
        b=uVNdlNAKbPNaneAdBZusKQYrLy2cq7aejIXLCjt7vF0iw7Fp783EAxAHVgbMDxld2y
         ZlV72KB7Dljk/15IO+NqdFBNfHgdQoHRna5jdsKZo8vYCM+kB8yztvc5KG9sU3/JJ5Ob
         xmy1SdVh457fmUh1pixlhkLp9LYPm9UlhZonSxMi+2bsIBBTt06gWCHlYC9G5x9EhT20
         74mofdpJKK9ff9B72f0AwfJEgagBZiBu9wWYx0GihJiBdGgVb+hIeKEZ2sxOPhl58r/p
         S6Udzpr1L0vfXKELWbzsK0uFzimuSgV1LLpK/j3VI8LEjA6PwdGVpi6UP/XLHJMQ35dR
         Jq+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683659510; x=1686251510;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CLBZv+EAn+SWsKZ2bfosCg918wl/kYfXIfpW4fy2Y0M=;
        b=lyULqitesxgagFHMBVbBMjL6byLWXUAN9OV7G8sPoIFV3XuJLwYF7qNfoWNtFBa/dh
         /K4hIHhM748rdD1hH5C8zIkBcB3aFtll1YEvs+KYjl5NeEKx5grBNhbQt9fnsZPsBCK3
         1vF+1KCjZ303B0kYjn9z6HzzpaVW0EPNmXRTYcWlL1CYZO64UQEorfBuXW8gje5Q9wMw
         xkkJmV4R1/YRw9MI5FfcetVbSDMavAe+3T8zBj1DW3brDi4N/7X1xMQjvPvVw6mwBXE1
         vODBtJdLcODZGfvhQUvdeyctvmUESMEPzCvfUIvlpd1hznwgljKOyW6V6FInYR+UHM8q
         haPw==
X-Gm-Message-State: AC+VfDwikjFXK3e1aE3BGLaASIpiIPY+zQnZl5myeBIydTiRFtD4D288
        TtBgTYCIGKqGfcrlaKYW0yUrSw==
X-Google-Smtp-Source: ACHHUZ6ofgIKVIpiCKpQ3/vNOa7lfVKvL94IBoxy6kbecVkFG5nErKCzTLDlOI0O4rhieVO32gHeMA==
X-Received: by 2002:a0d:d955:0:b0:55a:ad0a:766 with SMTP id b82-20020a0dd955000000b0055aad0a0766mr16613230ywe.10.1683659509987;
        Tue, 09 May 2023 12:11:49 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id z129-20020a0dd787000000b0055a416529bbsm3457204ywd.24.2023.05.09.12.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 12:11:49 -0700 (PDT)
Date:   Tue, 9 May 2023 15:11:48 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 04/15] ref-filter: add ref_filter_clear()
Message-ID: <ZFqa9OYBr6l7UVg6@nand.local>
References: <cover.1683581621.git.me@ttaylorr.com>
 <c804ba3620476713bd0535a315876378149ad7dd.1683581621.git.me@ttaylorr.com>
 <ZFpjaUaDl7eUCh8N@ncase>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZFpjaUaDl7eUCh8N@ncase>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 09, 2023 at 05:14:49PM +0200, Patrick Steinhardt wrote:
> On Mon, May 08, 2023 at 05:59:52PM -0400, Taylor Blau wrote:
> > From: Jeff King <peff@peff.net>
> >
> > We did not bother to clean up at all in branch/tag, and for-each-ref
> > only hit a few elements. So this is probably cleaning up leaks, but I
> > didn't check yet.
>
> Nit: it sounds like there still is the intent to check whether this does
> fix leaks. How about updating the commit message to either not mention
> the intent or perform the check?

Oops. Thanks for the reminder. Peff sent this patch to me while we were
working on this topic together, and I forgot to come back and actually
perform this check.

Luckily, it helps out quite a bit:

   t/t0041-usage.sh                          |  1 +
   t/t2016-checkout-patch.sh                 |  1 +
   t/t3402-rebase-merge.sh                   |  1 +
   t/t3407-rebase-abort.sh                   |  1 +
   t/t4058-diff-duplicates.sh                |  2 ++
   t/t5407-post-rewrite-hook.sh              |  1 +
   t/t5811-proto-disable-git.sh              |  2 ++
   t/t6001-rev-list-graft.sh                 |  1 +
   t/t7008-filter-branch-null-sha1.sh        |  1 +
   t/t7408-submodule-reference.sh            |  2 ++
   t/t9502-gitweb-standalone-parse-output.sh |  1 +

11 new leak-free tests! I'll take it ;-).

Thanks,
Taylor
