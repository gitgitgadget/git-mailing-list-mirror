Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3360CEB64D7
	for <git@archiver.kernel.org>; Wed, 21 Jun 2023 12:26:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231759AbjFUM0i (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jun 2023 08:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbjFUM0f (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2023 08:26:35 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02EB01717
        for <git@vger.kernel.org>; Wed, 21 Jun 2023 05:26:33 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5700401acbeso62749067b3.0
        for <git@vger.kernel.org>; Wed, 21 Jun 2023 05:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1687350392; x=1689942392;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FSra+FgsswSGRp3peifenLNMhPIz3+f+ee5hntJ1tI0=;
        b=g46hQLbACH6Wwsmiv+gEiN3RKPRRQgIoC0umQZgzDVOJeleT1m97585euSZJjxFF68
         db7wTUwuVnWDFZO7knWMNk2k7ozmgfPLAx8x3mqmXnUNR0bIyTEkJYEhFJZOp1f2qKnM
         fUfjpG71JP5V2SYR53MAEmhuMasu0r+tYEeMqd4zEfkqDJMGw7vZmzTBTOU18nNKtpUv
         KoLMLUOnP7rdFX7neohsuV2VvYgy0Y3fWiArnTmdX+7GtzHMrdLWzVr2NZtllbVfwePi
         HCvHEAHN/6gRRZyRl+WUpitwbVH02NO9AEAtVx7aTB2MP+gPQSfTGTyWYTWP9LUXpCRu
         7eHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687350392; x=1689942392;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FSra+FgsswSGRp3peifenLNMhPIz3+f+ee5hntJ1tI0=;
        b=CWGESBiSOcOLGVf9Sgdqhbv9lAyT+2zYkoUmtD0NHbWGkC5APc3W+0Frb0ndBEkE7x
         N895ZXpWeuV+NUe35T3knYYLKHqMjyraLZ4VKL2rC7b/f5tibsJ74li1Ipz80/Qo6hOW
         nx+N2c+VwPrwzjwX9pRo9Doxn5M+1l664FOjyh4Ftj27WIuyByYfWdgdOCwRCoXkvg8x
         En5FyQ5vYklQ53GByeFIt9GSD1HK53A91UVKafNyR3DFpogCPWFFdF6clj0aqY88NlwA
         pMaF3ElAZOMYaQ5X9XA9IqySRgycdym9tPyckmAReUbjYwqkNyakSXiWwyO+UJZQA452
         s9+g==
X-Gm-Message-State: AC+VfDwqSN8+WP33epWOybs0JGocbVSh2+PBhgnosxQeb2ncONsoVbLx
        g3hG9HVcFUD0jsROran+wswy5yvWC9ZAe9oUBSKDYM3y
X-Google-Smtp-Source: ACHHUZ4G8soNSFSPFUhvPUhIuwzXc9hkgDd6F3pPESDLahGUAOF6kuyLDtlhMha2C3HpnP04SzXUZA==
X-Received: by 2002:a25:c785:0:b0:bb3:ae54:9fcd with SMTP id w127-20020a25c785000000b00bb3ae549fcdmr12418533ybe.23.1687350392163;
        Wed, 21 Jun 2023 05:26:32 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id g30-20020a25b11e000000b00be5af499cfcsm898832ybj.61.2023.06.21.05.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 05:26:31 -0700 (PDT)
Date:   Wed, 21 Jun 2023 08:26:29 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH 2/5] strbuf: factor out strbuf_expand_step()
Message-ID: <ZJLsdZK+nT82zIAu@nand.local>
References: <767baa64-20a6-daf2-d34b-d81f72363749@web.de>
 <caf8e100-1308-cb4e-d61a-4e15ee3f47f7@web.de>
 <ZJB98Q6NHbK6D1uB@nand.local>
 <fe0db8cc-4d1b-3108-1d36-939b01a95244@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fe0db8cc-4d1b-3108-1d36-939b01a95244@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 20, 2023 at 06:25:30PM +0200, René Scharfe wrote:
> Am 19.06.23 um 18:10 schrieb Taylor Blau:
> > On Sat, Jun 17, 2023 at 10:41:44PM +0200, René Scharfe wrote:
> >> diff --git a/strbuf.c b/strbuf.c
> >> index 08eec8f1d8..a90b597da1 100644
> >> --- a/strbuf.c
> >> +++ b/strbuf.c
> >> @@ -415,19 +415,24 @@ void strbuf_vaddf(struct strbuf *sb, const char *fmt, va_list ap)
> >>  	strbuf_setlen(sb, sb->len + len);
> >>  }
> >>
> >> +int strbuf_expand_step(struct strbuf *sb, const char **formatp)
> >> +{
> >> +	const char *format = *formatp;
> >> +	const char *percent = strchrnul(format, '%');
> >
> > Can format be NULL here? Obviously formatp is never NULL since it is
> > `&s`, but we guarded the while loop in the pre-image with `while (*s)`
> > and I am not sure that **formatp is always non-NULL here.
>
> The "*s" in builtin/branch.c::quote_literal_for_format() that you quote
> dereferences "s", so we'd get a segfault if it was NULL.  A NULL (and
> NUL) check would look like "while (s && *s)".  The old code in strbuf.c
> passes the format to strchrnul(), which can't handle NULL either.  So
> no, format must not be NULL here, and this is not a new requirement.

Ah, thanks for catching: I agree with your reasoning.

> But now I noticed that builtin/branch.c::quote_literal_for_format()
> only ever gets called with "" or "remotes/", none of which needs
> quoting.  We could drop this function entirely, and add it back when
> needed, if ever.  But that's out of the scope of this series.

Yes, agreed.

Thanks,
Taylor
