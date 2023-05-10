Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF3EC7EE23
	for <git@archiver.kernel.org>; Wed, 10 May 2023 02:18:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234919AbjEJCSH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 May 2023 22:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjEJCSF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2023 22:18:05 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0438213C
        for <git@vger.kernel.org>; Tue,  9 May 2023 19:18:04 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-b99489836aaso5775443276.0
        for <git@vger.kernel.org>; Tue, 09 May 2023 19:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1683685084; x=1686277084;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IaNS87uLRD/TLJlvmNwcOgENF3u4VIrSDWdQ2Y0UfBk=;
        b=VzUSHH1NI0yjo9OPXNRb5vQDuIWLXkz4wM/2u/BY+WwUpnE5qRHBwIQaCptCcsOJ6H
         Y9Thglstaw+AR2c1iYCXt/lnpRpUF61BvlGCsqqK03iGov4vvnXyQt5wENaqVDEHuM70
         q/fxNE5lk3cqc7TL+WxkCCZEyijgnPtSdVHqktYk54sVtMAShvz9HUXIOWm8hHsZZmOQ
         n1dEukyFnRnLYjFTlaGCCQz/VYNuMvFsuCChuG4tkVs4E0dUduuonp7XSCHCM2ZTeNhB
         Oa7cfSbpyRIs3rMazlrSR5YSpzHYAtEe46XFBbUU8B2Ruye3zJTFJTfZNCfGdsxDefMj
         nDzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683685084; x=1686277084;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IaNS87uLRD/TLJlvmNwcOgENF3u4VIrSDWdQ2Y0UfBk=;
        b=gfb9YZyMIP2IdDEHMzZT666zGlEDscxFBFT5QIO99/bjXqPmP1H0vdwnvF8xaU0mPo
         BXlmvChRLIJZfo1J0Y/4PV+syGZMcWhkNmLXLvHSNdmA16o71yM1ZvShHoSQ8oJODE8V
         ALPyr9oCFjz8Xqjlf+Cv03s0j4F4pNXmNHkFcfIwn4H6POahiat+DMAz/WAi/luh3CrW
         MyX7F7KGjmKoYtf+hOANMol8ceTOAcU3ExBfw26fdY6qY54xXxXsChYDHpuEL9jryy3E
         BPGwJMbkMezkg6G3myfQw7w1cpq3cK032GOmYLl8CqP63bZlOogh1ypiPJBoILhMEVzJ
         VIYw==
X-Gm-Message-State: AC+VfDx6sD/J2JAaxkx9xZAN7llngioapA2rCXMYGMvrLjFR4PotcXQp
        fThCgpX4JK9Lwur0Os8smGYIaXpXsjqSEqZPybsk9Q==
X-Google-Smtp-Source: ACHHUZ63Eyj7i+ZopZHQZPGeFWZDDNkxXhRmn9dISrtvxx4xBMz/NDNc07bkuhl8lmW6kFK9CsPIHQ==
X-Received: by 2002:a25:aea0:0:b0:b9a:7831:d280 with SMTP id b32-20020a25aea0000000b00b9a7831d280mr16226701ybj.5.1683685083973;
        Tue, 09 May 2023 19:18:03 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 144-20020a250596000000b00b8bfb4c4f1esm3411893ybf.62.2023.05.09.19.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 19:18:03 -0700 (PDT)
Date:   Tue, 9 May 2023 22:18:01 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: tb/pack-bitmap-index-seek
Message-ID: <ZFr+2dpfgkDUJFEK@nand.local>
References: <xmqqmt2d0x0f.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqmt2d0x0f.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 09, 2023 at 06:56:48PM -0700, Junio C Hamano wrote:
> * tb/pack-bitmap-index-seek (2023-03-20) 6 commits
>  - pack-bitmap.c: factor out `bitmap_index_seek_commit()`
>  - pack-bitmap.c: use `bitmap_index_seek()` where possible
>  - pack-bitmap.c: factor out manual `map_pos` manipulation
>  - pack-bitmap.c: drop unnecessary 'inline's
>  - pack-bitmap.c: hide bitmap internals in `read_be32()`
>  - pack-bitmap.c: hide bitmap internals in `read_u8()`
>
>  Clean-up the pack-bitmap codepath.
>
>  Kicked back to 'seen' out of 'next'.
>  There is a BUG() on data errors that needs to be fixed.
>  source: <cover.1679342296.git.me@ttaylorr.com>

Let's kick this one out for now. It is on my list of to-do's, but below
many higher priority items.

Thanks,
Taylor
