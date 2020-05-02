Return-Path: <SRS0=N0vB=6Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC0B9C3A5A9
	for <git@archiver.kernel.org>; Sat,  2 May 2020 21:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5ACE205C9
	for <git@archiver.kernel.org>; Sat,  2 May 2020 21:23:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nnNtulSU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728533AbgEBVXj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 May 2020 17:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728521AbgEBVXj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 May 2020 17:23:39 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37A10C061A0C
        for <git@vger.kernel.org>; Sat,  2 May 2020 14:23:39 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id r14so3476433pfg.2
        for <git@vger.kernel.org>; Sat, 02 May 2020 14:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=mwrgWrhGn1sF4/SYdliJDwu5rvPQzs+yffEUbUnleas=;
        b=nnNtulSUo6CK6Vtonz6PMOttbH2CJKzSRJuaKtboJkOUA+Aur3EcUbQ24U2y+votVE
         xttUjYubf6NKDJNJ6RcGWNdWm7Efto8jgeG4i/mavGXDo7809519mFdwgxI35LD6iTB/
         +LwX1l4hb+8B9XCIJWVTLBSJ5VmB9fUn3MSJVt/b7EpfV8r/FDpEznBhx17ZzSJh2DMW
         mDp/rlstc5cLIJd3bZK0jEm+8O7bd37IXWwHs4+rmT8RMsj7cfThDEvQoRovyfOssTOb
         8DHczG9dyOsH4FkJ5Dq0n2ruS1zUwYasPA2N/4cHLxu1L851bnuEr/OB2hN3JM/sSlOu
         qSuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=mwrgWrhGn1sF4/SYdliJDwu5rvPQzs+yffEUbUnleas=;
        b=NrQ0vSFnnv4SbjojBRCa5v6dFQnAeL/q1pHT06erXNTvi6jjtMjOPrHsJER0gHBpHa
         J0gpMb9higdyPb+RkEeBQScMSTipXGcP2EG3px8fBWh43Iwk86YzJk4F8Kcz98/IroJi
         sGcTbJoSQspE/eg/d1StPaJQ/bBJiwnziPxGSZ+V02fwVxkk0I5DsKSjyFU9TyNYcgIP
         5KYVCKeEqdrQCF5p6COY5NyzILU8vycS5yeFxXhFwbdZKsMAv9gKc8mVFpn4Oj5DgrOF
         9Byt62GT3KzucIGtdL+ZlXUAWBJuANlrEkxOUX2vwufV5qTqgaGNhW34mrUF9rtptCr3
         no6g==
X-Gm-Message-State: AGi0PuY8JiSganZkHEej7nypGIDb1AXy/YorC2+Y6D4G3oiwhbyYPLhJ
        LPlTPb5nx/E9hRMDXBXPTU8=
X-Google-Smtp-Source: APiQypLhmvK9be7P7IuYP5IK81Nr0LiX2W1NDrGoePSWlsaY78QkRXb7cRF5KQAjAPTMmMHQORCxBw==
X-Received: by 2002:aa7:9297:: with SMTP id j23mr10017945pfa.15.1588454618496;
        Sat, 02 May 2020 14:23:38 -0700 (PDT)
Received: from Carlos-MBP (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id 13sm5174988pfv.95.2020.05.02.14.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2020 14:23:38 -0700 (PDT)
Date:   Sat, 2 May 2020 14:23:35 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, dirk@ed4u.de, sunshine@sunshineco.com,
        peff@peff.net, jrnieder@gmail.com, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v10] credential-store: ignore bogus lines from store file
Message-ID: <20200502212335.GB41113@Carlos-MBP>
References: <20200430160642.90096-1-carenas@gmail.com>
 <20200502181643.38203-1-carenas@gmail.com>
 <xmqqo8r6jc8i.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqo8r6jc8i.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 02, 2020 at 01:47:09PM -0700, Junio C Hamano wrote:
> Carlo Marcelo Arenas Belón  <carenas@gmail.com> writes:
> 
> > With the added checks for invalid URLs in credentials, any locally
> > modified store files which might have empty lines or even comments
> > were reported[1] failing to parse as valid credentials.
> >
> > Instead of doing a hard check for credentials, do a soft one and
> > therefore avoid the reported fatal error.
> >
> > As a special case, flag files with CRLF endings as invalid early
> > to prevent current problems in credential_from_url_gently() with
> > handling of '\r' in the host.
> 
> I do not think it hurts to silently ignore a line that ends with CR,
> but only because I do not think credential_from_url_gently() would
> not match such a line when asked to match something without
> complaining.  

for a credential like the one in the testcase (meaning no url), it will
append \r to the hostname, which would cause havoc if that credential
is printed (meaning you will end up without a host line) and be back
in the die() in credential_apply()

> In other words, isn't the new "!strchr() &&" in the condition a
> no-op?

you are correct that it will be unlikely (but not imposible) to get an
embedded CR from the other side to match, which is what I want to
address in the next patchset.

IMHO adding the proposed early check gives us space to fix the other
issues at our own leasure and it is meant to be gone eventually. 

> > diff --git a/credential-store.c b/credential-store.c
> > index c010497cb2..fdfb81e632 100644
> > --- a/credential-store.c
> > +++ b/credential-store.c
> > @@ -24,8 +24,9 @@ static int parse_credential_file(const char *fn,
> >  	}
> >  
> >  	while (strbuf_getline_lf(&line, fh) != EOF) {
> > -		credential_from_url(&entry, line.buf);
> > -		if (entry.username && entry.password &&
> > +		if (strchr(line.buf, '\r') == NULL &&
> > +		    !credential_from_url_gently(&entry, line.buf, 1) &&
> > +		    entry.username && entry.password &&
> >  		    credential_match(c, &entry)) {
> >  			found_credential = 1;
> >  			if (match_cb) {
> 
> In any case, among the ones we discussed, this probably has the
> least chance of unintended regression, I would think (with or
> without the added "!strchr() &&" check), so let's queue it and
> quickly merge it down thru 'next' to 'master'.

considering the only line that I wrote was the strchr and the other one
was written by Jonathan and reviewed by Peff I definitly agree.

don't forget this is also a good candidate for maint (most likely all
the way to maint-2.17)

Carlo
