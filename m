Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBFA3C433E0
	for <git@archiver.kernel.org>; Wed, 13 May 2020 21:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0D6E2054F
	for <git@archiver.kernel.org>; Wed, 13 May 2020 21:04:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mpfVOMRY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbgEMVEg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 May 2020 17:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725952AbgEMVEg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 May 2020 17:04:36 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79BC0C061A0C
        for <git@vger.kernel.org>; Wed, 13 May 2020 14:04:36 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id 23so278338pfy.8
        for <git@vger.kernel.org>; Wed, 13 May 2020 14:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=hnY0yuLUlgf0eOz4DRt4dJNaDn8jwTW/Xa32nY2jt4Y=;
        b=mpfVOMRYi3uIRvBsMAyxuz4vvtbMpSlQIEFmSuCyeunQAX3fCsr3r+9dQFtze0nBa3
         kcMZYbTsiwmw3vX33x+bBb6J7oNfGDNDS81zkyzuQjxEQ2In2b9LtfTouepQoVXf+Cpf
         Ji+mu0OP6o9PQd8v07znDIeh8SkAWv+oehriPQX8ltgwMZXHl5FvBMKyL6FVJboyZS1+
         nLW+4F7S1Rl47bK5vnpiTkzouWHgSHCS47Z+p9J01j+Rxff7hJD5tOiBBjLzVEt//iK8
         rDFKUdWlR21TwWvr0xbYlya+AOPE3+IdgTbxIEbykAlzweBxqVeM1f7N2SJl0kyFwtbY
         6BfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=hnY0yuLUlgf0eOz4DRt4dJNaDn8jwTW/Xa32nY2jt4Y=;
        b=cqoRZCqVp8FXD1vGA5GdFymfCzEbSuGAQWZ/qV3vtnkiKgWpFrIBQTS1yuVvGY+Lve
         bPxqD97wM0QiZcWrbTXwAhDWhQ0drcBKAJbA7MLdqeWSCWPlr4beBORwOLvSMzcIQsPP
         eQYfdVJaPxHqcBoJSE9yTSCYy9oDCI4hDmTvESGIMXjmeZj3ABShNtXWvRdlTYNoQy9F
         vFaP3HFRpSrW0aLN40ElXYK7Cf5FbNBGPCBPwQirVgv3yTEH3O2k7hXGMJ40ICIDI8Ah
         ns9hICnlfib7LTnceI7wa2NtW6i0IeygRm8VY89I+dRkQRaXhnsPr/0mE7OdUP7rMiGF
         RHVQ==
X-Gm-Message-State: AOAM531RbgJoFwX3ZwygSAoGuHgtU73SYypMLXhL4/TGczBEkCuPtaaj
        cTOmDXCaGcHj6LxC27YCacAx8SZC
X-Google-Smtp-Source: ABdhPJwWhVEbmfxYNPPN20aWUa5AiZsigygp1RUcICCHGOn1jloWUojIzBPtkaGeXYIIAfkUzDN9+A==
X-Received: by 2002:a65:6854:: with SMTP id q20mr1072345pgt.448.1589403875739;
        Wed, 13 May 2020 14:04:35 -0700 (PDT)
Received: from Carlos-MBP (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id v1sm489228pgl.11.2020.05.13.14.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 14:04:35 -0700 (PDT)
Date:   Wed, 13 May 2020 14:04:33 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>, Ed Maste <emaste@freebsd.org>
Subject: Re: [PATCH] t4210: detect REG_ILLSEQ dynamically
Message-ID: <20200513210433.GA38566@Carlos-MBP>
References: <20200513111636.30818-1-carenas@gmail.com>
 <CAPig+cTUc2-ddWQ+oww5Ez7_N9qKgCuErk8OuOgPkXNrACdppw@mail.gmail.com>
 <20200513201851.GA30804@Carlos-MBP>
 <xmqqsgg3sh9v.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqsgg3sh9v.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 13, 2020 at 01:37:32PM -0700, Junio C Hamano wrote:
> Carlo Marcelo Arenas Belón <carenas@gmail.com> writes:
> 
> > indeed, I would rather go away with the whole prereq and set a variable
> > with a nice sounding name and use it below to `if test` the right tests,
> > would that be ok?
> 
> In a sense, a prerequisite is an overkill if the tests that need to
> be guarded are very well isolated and in a single place.  Do we
> expect other tests outside the context of this script may have to be
> guarded by REG_ILLSEQ?

IMHO in the long term we probably should get rid of those tests (including
the need to look for REG_ILLSEQ), because the root cause of this failure is
that the test is really relying in undefined behaviour which happen to be
common to both glibc and our own compat regex, but that was relevant at that
time, because of a bug on the way UTF-8 was being detected.

POSIX regcomp[1], specifically mentions that returned and error is a valid
response to a badly encoded pattern, but the test cases were created to
specifically ensure no error is ever generated, and to make sure the response
(which is undefined, as per POSIX) was consistent for all engines:

"The regcomp() and regexec() functions are required to accept any null-terminated string as the pattern argument. If the meaning of the string is "undefined", the behavior of the function is "unspecified". IEEE Std 1003.1-2001 does not specify how the functions will interpret the pattern; they might return error codes, or they might do pattern matching in some completely unexpected way, but they should not do something like abort the process."

Carlo

[1] https://pubs.opengroup.org/onlinepubs/009695399/functions/regcomp.html
