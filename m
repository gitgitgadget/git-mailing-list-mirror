Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 029EBC71153
	for <git@archiver.kernel.org>; Sun, 10 Sep 2023 18:41:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232284AbjIJSl4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Sep 2023 14:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjIJSl4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Sep 2023 14:41:56 -0400
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D0DD18F
        for <git@vger.kernel.org>; Sun, 10 Sep 2023 11:41:52 -0700 (PDT)
Received: by mail-vk1-xa31.google.com with SMTP id 71dfb90a1353d-48feedb90d2so1336755e0c.1
        for <git@vger.kernel.org>; Sun, 10 Sep 2023 11:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1694371311; x=1694976111; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BEI9oxZDmA84C1rkR0fET9zRRWbJWaQg82UQ9hR7F0o=;
        b=mGVez/c2l5MRAAyqL2K+eeUuX9QDtBgXhWMu+Ozl6cqGSO9yv1zzl+WaFs2djt/rsN
         ZHjDwSl4Y5ucQGTev2VJq/8YYyBKgGj5e9P54NndKORk1DLFvgmy38Y7vMPR3D96K/zc
         XDKYrKDYJyqthfSKiGxJOsFuXgC4pRiC9F+fpRwrqJn/VtwgQWTf0cXlZOPwFsmAnidB
         MNoLDrRQlWaJKTzjt0MNr3ewqzTa+HrTdjYJLowKghu3P0cxIsTv0u2bY9SOtD+mnNxq
         08cb4gB8PAdrBkLtT/dGgXa+gUpaSiKon0lCWvOlOjpzbw7xtI9oRsomNjxX4uOLHNoM
         6lig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694371311; x=1694976111;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BEI9oxZDmA84C1rkR0fET9zRRWbJWaQg82UQ9hR7F0o=;
        b=pDJhMGfOy2duTDXfXvP6b+058MYGQJdQhlACGx9cmfRWpZcp1hF9FmWdpaVgIdZwGM
         T6r9B+Bha+oU6gbQDuQIWb18qvJLd2UxerJJx9WVBdrK5DrB0or+ERMYmujrHur4Bghb
         Ns85rJyAjbRHNK5E3inyB8knZBGp8tFlC2n+wAZUgwwAEkNkU2YL0nUVf7tZOxBQ2eMT
         82L1JDRuXA+IyX25jPR6coyaOHKxz7DZQdOqOUE9G6b/ASnOUsDmc8loc3HpRrN6UBMU
         hPUlP95Vqr8ZdVCeliiNH5Qv3bLTmBOz4n3g/w2/vm2oIzBSGaTpeOdxL6eufXdOIlfr
         2sUA==
X-Gm-Message-State: AOJu0YzwAxxFVzQdiMUFJrfv9/RlMUwUaKPM6lAFMe8fdDvpTgu3nRuv
        sEYTGkYN7pArN63fgQk0Du+rxA==
X-Google-Smtp-Source: AGHT+IGVzQ3xWSCNTKsx3qxg8eCBMAj5B5flen+P1KbxnO4u91x4MULtw5frsPXLSPN8N506DDqwxw==
X-Received: by 2002:a1f:e683:0:b0:48d:a91:1271 with SMTP id d125-20020a1fe683000000b0048d0a911271mr5723149vkh.0.1694371311055;
        Sun, 10 Sep 2023 11:41:51 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d1-20020a5b00c1000000b00d20d4ffbbdbsm1282439ybp.0.2023.09.10.11.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Sep 2023 11:41:50 -0700 (PDT)
Date:   Sun, 10 Sep 2023 14:41:49 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Martin =?utf-8?Q?Storsj=C3=B6?= <martin@martin.st>,
        git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diff --no-index: fix -R with stdin
Message-ID: <ZP4N7c92ra5ZOKl8@nand.local>
References: <d42579a0-f438-9b4c-97e4-58724dbe4a4@martin.st>
 <22fdfa3b-f90e-afcc-667c-705fb7670245@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <22fdfa3b-f90e-afcc-667c-705fb7670245@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 10, 2023 at 12:12:52AM +0200, René Scharfe wrote:
> When -R is given, queue_diff() swaps the mode and name variables of the
> two files to produce a reverse diff.  1e3f26542a (diff --no-index:
> support reading from named pipes, 2023-07-05) added variables that
> indicate whether files are special, i.e named pipes or - for stdin.
> These new variables were not swapped, though, which broke the handling
> of stdin with with -R.  Swap them like the other metadata variables.
>
> Reported-by: Martin Storsjö <martin@martin.st>
> Signed-off-by: René Scharfe <l.s.r@web.de>
> ---
> Great bug report, thank you!

Great patch ;-). LGTM!

Thanks,
Taylor
