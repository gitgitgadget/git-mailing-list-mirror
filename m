Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54AC4C433B4
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 00:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B03E6113C
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 00:41:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbhDTAmF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Apr 2021 20:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbhDTAmF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Apr 2021 20:42:05 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD21AC06174A
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 17:41:34 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id g125so8104010iof.3
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 17:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=syQNIrol7LuAfNEzbkGQivrhYhFsPSAN5IILwGdRFNg=;
        b=rW9rKIINMsjKn/rC6ihmcog/GNrHevmcBrm3p+9O1TZ/7NrCL0MFlFPB6xB4xfaHqg
         UwRpEnosc4CCjZU4+VQlsB3JMOLROrFjlmfDsndiCe9NIWdgKCv1/ved6eNqDhpPsIRC
         RsEhJIPl3tiEd5pE7NFTqiTssXL1Wkorw3G85T2XUQ3W0Rla55Rcbc3QYXtU3zq538yu
         S+MF/YkbnSD5+z3NsMi1vTOyqbmwrG3RUYIzYPhM0wUXWyI2Is9T2i13EQmOgr7ltALa
         tg8tVxwbDkEEmTCNfsgVyKhoyEaHewB87rjrwdICIAxC9WMrhwhsRPhdD4/ZCnFX78UQ
         IzQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=syQNIrol7LuAfNEzbkGQivrhYhFsPSAN5IILwGdRFNg=;
        b=bm2/6M1IwQn6g8/RHYYU/RbJfaFCuXu6mcoSmUIkFqU1l4TkfocVW91b3qdFK9OkpF
         YtM8yu5OmfhGzOigdROfw40D1mONJwpQBksjawCsVNFrnaDIfAlO6JklcVwyx+uaBwYl
         JncOhyuLnEkoeR4rgp1/rsbUYUbvkGSjnetUx/NMfuLmhGk9pplUC6mwsyY6TZhAzy4B
         7Kg2qRS7AjT6lSFad/fl1p2qwrZpWjqbtWCBM5x/UEYcenD4ScdpJh1R3ktQP1tdPrSq
         MZ2uib+TPJFLhd4yApX8R9dWeD8ZIHmFNLqPZbODGNziZzSdow9ieInW/Arz6UoDLNGx
         MCTw==
X-Gm-Message-State: AOAM532wqXqXqpEC1PAroINpbAcl4GUe6sWKEFwHXUOdzdsgmJVD7fcT
        CgxCFbSo091EcXgxlB8wWMqw2A==
X-Google-Smtp-Source: ABdhPJwIpKbWyf6IoKwpgDRrhiZN+5OYGeoyHbrxIuDwGrz+QMcp9xig+i3GczeOJ7+vwdQhGcYQIQ==
X-Received: by 2002:a5e:8a0c:: with SMTP id d12mr7560239iok.152.1618879294157;
        Mon, 19 Apr 2021 17:41:34 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:6e34:2cc5:33ff:681d])
        by smtp.gmail.com with ESMTPSA id d7sm7695854ion.39.2021.04.19.17.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 17:41:33 -0700 (PDT)
Date:   Mon, 19 Apr 2021 20:41:32 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        git@vger.kernel.org
Subject: Re: Random GitHub Actions added to git/git???
Message-ID: <YH4jPMPrLA+a85RH@nand.local>
References: <xmqqmttt7q8f.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqmttt7q8f.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 19, 2021 at 05:29:36PM -0700, Junio C Hamano wrote:
> I suspect that these other ones come from "pull requests" random
> people threw at us that never hit our tree, with changes to the
> .github/workflows/ directory in these PR.
>
> I find them quite distracting.

That's what I'd expect, too, but I'm not sure. I asked the people who
would know, and I'll reply back here once I have an answer.

> Thanks.

Thanks,
Taylor
