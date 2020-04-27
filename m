Return-Path: <SRS0=mOGp=6L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C399C54FD0
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 12:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19872206B6
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 12:25:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sZbLBBE8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbgD0MZY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Apr 2020 08:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726821AbgD0MZX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Apr 2020 08:25:23 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A0CC0610D5
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 05:25:23 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id t4so6920066plq.12
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 05:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=uEPETo7Q8Uhz+j2zKOkYjKoSdN9ne/LIiLFGpfgwesI=;
        b=sZbLBBE8tNzGMe9387+KBcSGrLZXgX4S0dGXikjr8QZpOodMFStIjkSdgDPzKDzYOV
         S19iybhJN96CvJdumHTtO4Ax0LY3fz5mjhOVJaVeHJ9TgadBHO0JyffBGO4JHhGuTEvh
         KSXr+Ys82JOogdW7/oQSP26w8ViIzkKQZCDhl95XMhSGzq5tXBtgjVaJtp1tU8+CG2G7
         CsT6TYAqKJLN54b+zOpqe47MPBsdB2r4/kOlIGlC9n6mOwNb8uRajdcfQ5y8JL+Ahrmp
         YPK2KF2+hTBYCs0hzjFPBOrqIBfQXIA9dh/ttbjmEThBc50d8y8oof6iq4tjAU7qMEAH
         Iw5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=uEPETo7Q8Uhz+j2zKOkYjKoSdN9ne/LIiLFGpfgwesI=;
        b=ILsUSt/pFyFgeOMkUroLrbaZI//OGgsnznoUKr1din2QZowIxupgwh+TMyoiqHl3U1
         b2JLz55Y89uOGQx6fA4q5rVDvFAiXt8cU6indXLDHAmjGCyQ+q4/F7Z+cM9XyhVkS0B6
         BcwUGC8P+fYOZXQYzaqGlxlRVWQnq1e8S+cbeGIi+ZsVSHkwz6EXnQecPo7MOutzCaQj
         gHsyebpGW9ImiIQfN/1B9692ty3AnrUgzQAtjKtG4rpHYVVIItmYgRArwBjArPZWxOvr
         kpsvO/1yYLPDJQBj9s34vGMCGj1c3BiuPvKo6Obs0QwPsHvcN3DKXoIPvUqxXc+Jh24O
         jPug==
X-Gm-Message-State: AGi0PuYwpeve+HwSkm0KQLSWZ5ye9faneTGI3meRAhjJzP6xHQhNi1TJ
        L8x0+jYNpAwGirVEAqCIfjKN/mDe
X-Google-Smtp-Source: APiQypLUkHkPJdolk6ID14d5kGci00Kqxka9n59OQKBAFZG5FfHUFcx9oThNBlPIk3pFIqIZSuEzeQ==
X-Received: by 2002:a17:90a:1984:: with SMTP id 4mr9801576pji.36.1587990323255;
        Mon, 27 Apr 2020 05:25:23 -0700 (PDT)
Received: from Carlos-MBP (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id w75sm12418374pfc.156.2020.04.27.05.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 05:25:22 -0700 (PDT)
Date:   Mon, 27 Apr 2020 05:25:20 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, dirk@ed4u.de, sunshine@sunshineco.com
Subject: Re: [PATCH v2] git-credential-store: skip empty lines and comments
 from store
Message-ID: <20200427122520.GA61348@Carlos-MBP>
References: <20200426234750.40418-1-carenas@gmail.com>
 <20200427084235.60798-1-carenas@gmail.com>
 <20200427115223.GA1718141@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200427115223.GA1718141@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 27, 2020 at 07:52:23AM -0400, Jeff King wrote:
> On Mon, Apr 27, 2020 at 01:42:35AM -0700, Carlo Marcelo Arenas Belón wrote:
> 
> > with the added checks for invalid URLs in credentials, any locally
> > modified store files which might have empty lines or even comments
> > were reported failing[1] to parse as valid credentials.
> 
> Those were never supposed to work. I'm mildly surprised that they did.

agree on that, which is why I have to admit I couldn't find the right
wording for the previous paragraph, and also why I didn't pinpoint a
specific commit as the one that introduced a bug.

it was instead just meant to describe a "current state of affairs" and
I was hoping the documentation entry will help guide future users to be
more careful with this file.

> I guess I'm not really opposed to adding this as a feature, but I think
> the justification should be "because it is somehow useful" and not
> because it's a bugfix.

I think that is a matter of semantics, because for some users it seems
like a regression on the last bugfix and therefore might be used (albeit
IMHO incorrectly) as an excuse not to upgrade, which will be even worst.

so yes, I am implementint this "feature" to prevent them to have an
excuse but it also means we would most likely need to fastrack this
into maint.

> > diff --git a/t/t0302-credential-store.sh b/t/t0302-credential-store.sh
> > index d6b54e8c65..0d13318255 100755
> > --- a/t/t0302-credential-store.sh
> > +++ b/t/t0302-credential-store.sh
> > @@ -120,4 +120,23 @@ test_expect_success 'erase: erase matching credentials from both xdg and home fi
> >  	test_must_be_empty "$HOME/.config/git/credentials"
> >  '
> >  
> > +test_expect_success 'get: allow for empty lines or comments in store file' '
> > +	q_to_cr >"$HOME/.git-credentials" <<-\EOF &&
> > +	#this is a comment and the next line contains leading spaces
> > +	    Q
> > +	https://user:pass@example.com
> > +	Q
> > +	EOF
> 
> q_to_cr is a little weird here, as we wouldn't expect there to be CRs in
> the file. They do get removed by strbuf_trim(), even in non-comment
> lines. But perhaps "sed s/Q//" would accomplish the same thing (making
> the whitespace more visible) without making anyone wonder whether the CR
> is an important part of the test?

I know, but commiting a line with 1 tab and 4 empty spaces instead of
using Q seemed even worst and q_to_cr almost fits the bill and might
even make this test "windows compatible" for once ;)

will rewrite then using test_write_lines and I hope it is still as
readable without having to resort to the originl ugly chain of echo

Carlo
