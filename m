Return-Path: <SRS0=05is=6N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTTP_ESCAPED_HOST,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82163C83003
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 07:31:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AB96206D6
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 07:31:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FTByWVlQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbgD2HbT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 03:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbgD2HbT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Apr 2020 03:31:19 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB73C03C1AD
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 00:31:19 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id x15so703491pfa.1
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 00:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=vLlOo9vsRQQcq1tjpIPOtkEFU2a0gFPfFuGy5NjXGJw=;
        b=FTByWVlQai7md4nU6whJ5eDJOF82PZOadf4OAqO1OO5uImtg3jsvvUzx+4ziOGhrp/
         Ma1V1gWov8Kzs0itZ48YkgL3dIgRcHr94dG919EtTJyh83G9cDpso2Boit+ga6d0EYPe
         YlciCzJB536zhI6vDePGbMIbePqwa7s1qNQjIWTdBj5cBW3SQbnSboYZBJLdSKMz/Xo5
         ySMiljGqmVzrEXy5ctZxJQzhoyq1RX5tq4vTArPvXtLWUX5AbrRTfgIZZBkymxLeWJod
         lUhKGPni4iFvJE4RNRAzf9ZufT2g5fFZ564dggbKywsgf5ORr4S8JAU3tCK22YgA90fj
         Di1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=vLlOo9vsRQQcq1tjpIPOtkEFU2a0gFPfFuGy5NjXGJw=;
        b=n1hJe+WAaQJKzLoUnwgc2nxbdDMlJ9H6jDipz+cZH0tH2RrI0R+wSHS80krZc2NHK3
         MJu06RIyWYJ4ZtztIs61c69rhIbThjn4AFOz8cz5xnNuzT0AtY5C1MHGk7Q7vwuCFOHv
         Kbue7RLb+cB91S9x/3bHpTOmB3z1ej+X0OIQ094S1NMR+cb/8HkdFStXGilpg/UEkuib
         OA0f/sE0gXyXvoeoivUaOCbf7BSFrKoDcjug11p7d+Vrhzyn04J+CqpUDt0UPf3WpbX/
         cbUDqZOPcgOwWJdAKAX8Ynr0lr+988ffIv9clJ2VX3PXYfCdkos1ch8g/2h3Qdm45Knq
         muYA==
X-Gm-Message-State: AGi0PuZobXME+V0bfTCAiEymT6togP9bRwjeFaCCOBNMe03BHblUix/4
        dkfOIyjl5yFmTNfzVjquRO0=
X-Google-Smtp-Source: APiQypJNwMgMGcURCw4cyFUdQk9T2pthqD5xVUSTZh6cyz1tWMPQECCuAd9E/fEgpULcPUn9WUMHGg==
X-Received: by 2002:a63:310:: with SMTP id 16mr31112302pgd.287.1588145478505;
        Wed, 29 Apr 2020 00:31:18 -0700 (PDT)
Received: from Carlos-MBP (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id f136sm379890pfa.59.2020.04.29.00.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 00:31:18 -0700 (PDT)
Date:   Wed, 29 Apr 2020 00:31:16 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, dirk@ed4u.de, sunshine@sunshineco.com,
        peff@peff.net, jrnieder@gmail.com
Subject: Re: [PATCH v5] credential-store: warn instead of fatal for bogus
 lines from store
Message-ID: <20200429073116.GA94208@Carlos-MBP>
References: <20200428104858.28573-1-carenas@gmail.com>
 <20200429003303.93583-1-carenas@gmail.com>
 <xmqqd07qzz67.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqd07qzz67.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 28, 2020 at 09:36:00PM -0700, Junio C Hamano wrote:
> Carlo Marcelo Arenas Belón  <carenas@gmail.com> writes:
> > +static char *redact_credential(const struct strbuf *line)
> > +{
> > +	struct strbuf redacted_line = STRBUF_INIT;
> > +	char *at = strchr(line->buf, '@');
> > +	char *colon;
> > +	int redacted = 0;
> > +
> > +	if (at) {
> > +		strbuf_addf(&redacted_line, "%.*s",
> > +			(int)(at - line->buf), line->buf);
> > +		colon = strrchr(redacted_line.buf, ':');
> 
> Just showing my ignorance, but ...
> 
>  - Is the above strrchr() that forbids a colon in the password
>    intended, or should it be strchr() that only forbids a colon in
>    the username instead?

neither; that ":" is the separator we put in there between username
and password (unless it was edited out), as any original ":" in both
is already urlencoded.

strrchr() was used in purpose to back only as much as it is needed
from the string to hopefully find the beginning of the password.

indeed, most of the uglyness of the code comes from the fact it tries
really hard to only redact the password so the rest of the credential
is still useful for context and do so without changing the original
line.

>  - Would it hurt to redact both username and password as sensitive?
>    If not, it would certainly make it simpler to unconditionally:
> 
>                 int i;
>                 for (i = 0; i < redacted_line.len; i++) {
>                         if (redacted_line.buf[i] != ':')
>                                 redacted_line.buf[i] = 'x';
>                 }

that would leak the length of the password which might also be considered
sensitive

IMHO if we are redacting both might as well not print anything and let
the user find the offending credential by line number instead ;) after
all I got a feeling most of those entries are empty lines or "comments".

for example with the current code merged in pu we get :

$ cat secretfile

://u:p@example.com
http://user:some%3apass@example.com

$ git credential-store --file secretfile get
protocol=http

warning: secretfile:1 ignoring invalid credential:
warning: secretfile:2 ignoring invalid credential: ://u:<redacted>@example.com
username=user
password=some:pass

Carlo
