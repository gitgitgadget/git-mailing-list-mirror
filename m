Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F51C77B75
	for <git@archiver.kernel.org>; Tue, 18 Apr 2023 09:05:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbjDRJFz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Apr 2023 05:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbjDRJFN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2023 05:05:13 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8658C7A91
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 02:04:36 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-187de655f15so165045fac.3
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 02:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681808667; x=1684400667;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lf6TperOs8/EFQTeoo8bPhPwpBY8kvM1XhNbW1NKpUI=;
        b=a+EYJ8YMMVEui7DkJ5Ww8a8TncirrmuLVVAvbrWuezC/cd0u8lAx+bfTdVGH4u2H9T
         8K5FZ7GdtsszLEv8lvriBoxVNFGMwisyKL3ir28ezDVYt8rh9SGnxAnA1std+HxwJT8N
         X+r8p9+FRViFbsH7QIvx06YyztSPd+NjXNJZ0JkzOyFyyMwLrCcQKEK26i6DlkFUu1hE
         ONSZ9QzCI8fjl0RgHGIsbugmed/MnJg/WIL+L8wXysHJ855ROCmwM5maPEXbRos3Q5Z2
         BUPqGNUcwYGdd0JlA8VJiHYGKxP5L61C2GBb0NW8hKk3+jFw0LU+KoCzFtTqBPN5ItBR
         fK0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681808667; x=1684400667;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lf6TperOs8/EFQTeoo8bPhPwpBY8kvM1XhNbW1NKpUI=;
        b=aDzosq44tUcaGO44U1N8Rk4dzs5VN/QrdKrhVCzGifF1l3wbDt92VV6HKoB6yWDQti
         u9m5glMtFCsvzUC2ao2LBLcYGsBfPviawLNzHzJELD2kNwJA1gUr7ZNgZG3wU2bKAAZf
         ZjigNPsP75/Q/mjAGpzVlhpp9uPY3mAijcKHDKiQ3ZNWD73hkEeo8RjBullNuMk0vlyG
         KibRpqrnbxRi6tNmRwY0mdq3jYPymSxyamvMVWKZBQlSp7K+0sXwZdtAk/pHOq6eUkbm
         +WuE9L+EKEZO7Y8ePDg0oFZoYpNh+np562nAugxRrUbpNSzc9Z1BwakTLlmoSppmRGzz
         hu5Q==
X-Gm-Message-State: AAQBX9ehvDlh1NvMRvW7tBBxjFG+3MIgGZdNiBGObFXNwnUQlgpozSFL
        KJfvwFMxJH5jTuDG9KgMFFbXYjlMygU=
X-Google-Smtp-Source: AKy350ZyJPCX8VYE5kBV/h0WU/77R/AtX71zxAUfGzMpStHSQW4b9FxwfDDLZgXf2yAvJlEfKcj8yw==
X-Received: by 2002:a05:6870:808c:b0:177:b55a:76c0 with SMTP id q12-20020a056870808c00b00177b55a76c0mr844353oab.10.1681808667507;
        Tue, 18 Apr 2023 02:04:27 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id yy21-20020a056871259500b0017ae1aede32sm5369919oab.46.2023.04.18.02.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 02:04:27 -0700 (PDT)
Date:   Tue, 18 Apr 2023 03:04:26 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Message-ID: <643e5d1a3db93_21c95429444@chronos.notmuch>
In-Reply-To: <20230406093602.GD2215039@coredump.intra.peff.net>
References: <d9cfad7caf9ff5bf88eb06cf7bb3be5e70e6d96f.1680689378.git.ps@pks.im>
 <20230406032647.GA2092142@coredump.intra.peff.net>
 <ZC6AdylF4TI41vnX@ncase>
 <20230406093602.GD2215039@coredump.intra.peff.net>
Subject: Re: [PATCH] t/lib-httpd: pass PERL_PATH to CGI scripts
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> On Thu, Apr 06, 2023 at 10:19:03AM +0200, Patrick Steinhardt wrote:
> 
> > > Does this fix the cases you saw, or are there others?
> > 
> > You know, let's just go with your patch. With PERL_PATH set it fixes all
> > the issues I have observed. At some point in time I saw more issues than
> > the one you fix here, but that's because my `config.mak` got lost
> > without me noticing. Oops, embarassing.
> 
> OK, that is good if there is nothing left to fix. :) Let us know if any
> of the others pop up again.

For the record: I applied both patches and I can attest that Jeff's patch fixes
all the problems, rendering Patrick's patch unnecessary.

However, in my opinion Patrick's patch is still desirable and should be
applied, even though after Jeff's patch it doesn't fix anything.

It's just a good practice.

Cheers.

-- 
Felipe Contreras
