Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD29EC48BE5
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 18:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88985611CE
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 18:09:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbhFOSL6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 14:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbhFOSL5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 14:11:57 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED4BEC061574
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 11:09:52 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id t40so19158395oiw.8
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 11:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=ouKeLTrytQEx1hzSUCOGB5wJYpjHB+Sh44WKS4R6cEs=;
        b=fPejEm5nvU30JgOHORsvikoLZ2aUmA55Wv2OFI1v3jN6/UDlzXgX8ZJ3+NS7aNt2za
         5lFsUDYBbJ2qcWHxPVC8ISuRcj8iItUwm9Ovpsu8fqvME8AzWeutXHKRRb+LFE3zHHr4
         FWfRfFVv+hriZpEuKqggNMzS/j8F8Y0OmQk7c7sLifcRVmQ+mtLU8ftk1cIkfmcAnGfC
         vcY6eI50XtuArAGPuU6ffxC7EQ1XjKBCsS52BiXq1hLO7lbR8P+tWvaw8Gd8Z0ojtVhv
         +BVAEmSbwWYrTLnLSMtORWSFXc5ReVfEPdr31d0kAIsPaSl2qDeBR5KXFtf0cWnh9Wan
         kPHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=ouKeLTrytQEx1hzSUCOGB5wJYpjHB+Sh44WKS4R6cEs=;
        b=LIX7GqfAtKzJ0QY+K6IJwYuWwjYMMh6Q5H8qa8EAkD2PBJugFxmDz4T3rXkztC6j4+
         bZL2MLveSZ/D/kh0CYkemDj7G5Kt5LZ1BNII0Dyy9Ca8i+jFxqXPIgHJH6xXsBWHVTAG
         MCnzVocViyGC8Ezvqg7sIpbUCk5lNpOsebGY7F16KJ0G+mz4VAUytR067M/Q46mteARv
         TXfKRuTmoI7CbxRSUmK7PONDB49mT5IaAgWzVRWs/GaXW7KtLVnqU0duhPL4so0+3OTq
         MrL0TfeOkSs4Dv2WZlJ+w46hL/O/4tG7yK+kkmWITIZp0nqvYG1NhizFQW+Yodii0Qa3
         Kwbw==
X-Gm-Message-State: AOAM531bOHvlNCtI7u7nVr8xAud+e5gRJsSKU3+6kklgI8kxbgTlOYv0
        v4vimB0sj0yS8m+fmIXy8RM=
X-Google-Smtp-Source: ABdhPJyiMuXq82uKpsVDRis4hjVVCoS3YpEtMz+I2/eqiNXyjkSdi3HtX4Ih2cDiuTUOs83sppa1GA==
X-Received: by 2002:a05:6808:14c8:: with SMTP id f8mr280670oiw.7.1623780592396;
        Tue, 15 Jun 2021 11:09:52 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id p25sm3971415ood.4.2021.06.15.11.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 11:09:51 -0700 (PDT)
Date:   Tue, 15 Jun 2021 13:09:50 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Q2FybG8gTWFyY2VsbyBBcmVuYXMgQmVsw7Nu?= 
        <carenas@gmail.com>, John Keeping <john@keeping.me.uk>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Message-ID: <60c8eceeae8e8_12c2820895@natae.notmuch>
In-Reply-To: <YMiKlmY3B/1cDrr8@coredump.intra.peff.net>
References: <20210609170520.67014-1-felipe.contreras@gmail.com>
 <YMWMuDbctae7tF6J@coredump.intra.peff.net>
 <60c627cac29b3_41f45208a7@natae.notmuch>
 <YMcIv7q1ctyJ0EZn@coredump.intra.peff.net>
 <60c715dd9939e_436208f3@natae.notmuch>
 <8735tk22if.fsf@evledraar.gmail.com>
 <YMdm5XayUfp4/atY@coredump.intra.peff.net>
 <87r1h4z8k0.fsf@evledraar.gmail.com>
 <YMiKlmY3B/1cDrr8@coredump.intra.peff.net>
Subject: Re: [PATCH] test: fix for TEST_OUTPUT_DIRECTORY
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> On Mon, Jun 14, 2021 at 06:55:03PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:

> > >   mkdir: cannot create directory =E2=80=98/dev/null=E2=80=99: Not a=
 directory
> > >
> > > or similar.
> > =

> > Yeah that error sucks, but nobody will see it unless they're hacking =
on
> > the guts of this $TEST_NO_RESULTS_OUTPUT, and I think it beats being =
fragile.
> =

> I think that's a good point. You're unlikely to stumble into
> accidentally using TEST_NO_RESULTS_OUTPUT, so it might not be worth
> caring about too much.

But check_sub_test_lib_test() cares:

  test_must_be_empty err =



  'err' is not empty, it contains:
  mkdir: cannot create directory '/dev/null': File exists
  /home/felipec/dev/git.git/git/t/test-lib.sh: line 1133: /dev/null.count=
s: Permission denied
  not ok 5 - pretend we have a fully passing test suite

-- =

Felipe Contreras=
