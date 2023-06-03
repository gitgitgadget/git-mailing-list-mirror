Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4172DC7EE24
	for <git@archiver.kernel.org>; Sat,  3 Jun 2023 10:01:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjFCKB2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Jun 2023 06:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjFCKB0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Jun 2023 06:01:26 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767F6197
        for <git@vger.kernel.org>; Sat,  3 Jun 2023 03:01:25 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id e9e14a558f8ab-33b22221da6so11889355ab.1
        for <git@vger.kernel.org>; Sat, 03 Jun 2023 03:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685786485; x=1688378485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q4DcQlqG8EKiNnGG7TBPP2QrkWHFDeCTbCON7xf8+fI=;
        b=mCiAhI/3Oe1+60qOl/Vas9CNG9ZpoGiBT2dWBVYdwVngyehsY4XL1Er5IezWyOxTVg
         iayONATPyeNQg1HO8GvGWhg/W23K8fgd/dTAl8JcOpGXEZzbmBApQDRlBsFfA5r4NLem
         HZQxck9PCoXRURkvP0PbPc79zDlsbvX/ymG04fu/q6NDi7r+aL+x3d5u4kffe86uwMtx
         3maKzPEfeI3x0cOYFqovQVyh4YGFfPfbXKDv0iOxMfqXQShXdpE2v6kUMc42XiMJEO1I
         jVfjL/SkipuiE9kUW8UPXlL5LJFniQvumzLYhLKv9xASzctYIS4ADzJM6/HzeIDh+6Ro
         t7/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685786485; x=1688378485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q4DcQlqG8EKiNnGG7TBPP2QrkWHFDeCTbCON7xf8+fI=;
        b=YyueONksdA/GJKcIZguqvUcnuHy855J3OHJuGOnzN+vwW7io5thB5V1HGrgX/T6L/3
         +R5eVv/vfp2cFNbeSimWKLhkju3Us6/rm/zBvvfFziBvaw7hvTKvzN3pqmnmj6iu4gn+
         GcH8DnHIJTRTw5wvM6DhC9IgoNmWePBNAuY+hy9S4Cs1BFfC5ytDHGj2fk63Le7fyB0t
         pmPGHgEb/u38mVQ6GwsgvVSuumcud2KLHveMq90z3KxITz9C3ddWRBWlV0SdYzUUyGri
         zzft6yjC5gPWJgljQo92OXLbJujXuzyESKbed2ULgJwZ0pd65PPNwPiMkAW7KuBAI8j8
         DiEw==
X-Gm-Message-State: AC+VfDw02Teyv1imFLlD6tVmck7H+CI+5rxsQoySLYLLZU1jx2bFDD1v
        4HR90XggqAhCVKbRpH7CkbU=
X-Google-Smtp-Source: ACHHUZ6d6DIsVzF97/TcRZB2ZboAQZSt5j2qfPfMbPDTC2Xat1asyZtbUYns7hxSPkFU+pKVkVZeTQ==
X-Received: by 2002:a92:d34a:0:b0:32b:50d1:3403 with SMTP id a10-20020a92d34a000000b0032b50d13403mr12162107ilh.7.1685786484689;
        Sat, 03 Jun 2023 03:01:24 -0700 (PDT)
Received: from localhost.localdomain ([47.246.101.56])
        by smtp.gmail.com with ESMTPSA id j5-20020a62b605000000b0063b6451cd01sm2173517pff.121.2023.06.03.03.01.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Jun 2023 03:01:24 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     gitster@pobox.com
Cc:     avarab@gmail.com, code@khaugsbakk.name, dyroneteng@gmail.com,
        git@vger.kernel.org, peff@peff.net, sunshine@sunshineco.com,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v11 0/7] notes.c: introduce "--separator"
Date:   Sat,  3 Jun 2023 18:01:17 +0800
Message-ID: <20230603100117.2276-1-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.41.0.rc2
In-Reply-To: <xmqqjzwnd93w.fsf@gitster.g>
References: <xmqqjzwnd93w.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> In a more perfect world, you would have sent the "--separator" thing
> that already supported "--no-separator" from the get-go.  You would
> also have sent the 4th step that does not need ubsan fix.  You do
> not have the luxury to do so when your series hit 'next'---you need
> to live with your earlier mistakes.
> 
> Until we cross the release boundary, that is.

OK, I hope to make the commit more cohesive before they release, but
I ignored that the 'next' branch is already in the release period
(because I think it might be possible to replace it in the 'next', but
actually it shouldn't be done), sorry for the trouble it may cause you.

> I'll revert the whole thing out of 'next'.  Once the next cycle
> opens after the dust from the release settles (i.e. around 10th of
> June or so), ...

OK.

> ... please resubmit the series that does not need "oops, we
> probably should have added '--[no-]separator' from the get-go" or
> "oops, we had undefined behaviour here, and here is a fix", as if
> you are a more perfect developer than you were when the version that
> has been queued in 'next' was written (and in fact, you are, after
> discussing the design and UBSan issues and stuff during the review).

I think the v11 should be a version which is acceptable if there is
no incoming review conversitions (The current v11 that separates
'--no-separator' as a individual commit OR make 7/7 into 4/7, both
approaches seem fine)?

Thanks.
