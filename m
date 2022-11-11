Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD56C43219
	for <git@archiver.kernel.org>; Fri, 11 Nov 2022 02:37:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232602AbiKKChC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Nov 2022 21:37:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232885AbiKKCgj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2022 21:36:39 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C861A67133
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 18:35:14 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id 63so2746243iov.8
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 18:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jfjXX8Gq59a8oftGemabHWH4XDRmjGKXIjSc2tPN1fk=;
        b=Ng+j9KLyulIJaA05YW7jjsYStyhLyBxml17B+p2K8wh76Y8ZaXL7AoRy7k1Ap2PYI4
         k2EzJpKGX7N/horYxL5KkAhV8IFwbbmCQs8gSkGdAjaKA2L32/5QdtNWQ5jBJfV8asFI
         CIRIXD4lAzGSM4ABZBzOfWx7PSi8iDeEXff1J6ZXhFx9fv/zlpKmA78nGaJmO2+Fo/IU
         xuhuZLtbS6GB2kS1765VoIzlcA//7Qop6lnX5TkXXYDCFwi8JVFF/JlpZyT80WSlU8gz
         EfdkWoD6BpW17C8DcD4VVXXesUHO7h7qReNG01L/r4S/k73+aVJ8B/SIcDSdHtHnpEhk
         2NIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jfjXX8Gq59a8oftGemabHWH4XDRmjGKXIjSc2tPN1fk=;
        b=cvjvzKdnAaIgUo2dxUJG/3pndPWEGvt/DdVZLPf1AVN+RqNZEaR9NmiYTD6Ijl8R0S
         eqkeI+5++WcUhcJ53lZ3WbvEsi94tCH84RxCqvZJhz28y8NShFWKIqYoNSQgVfc/174B
         BtpCkhLqL2asvAP3vidAtTHhSd4bB3HRTBqf9yowHaykFR8YZti4yz/gi198KsVOYn/q
         LKT/vc78iJ1I+WFNCT/tkpAmuhwDItkI7cpBj5EVsSWSADcT98dHydNRT7rt5tGQOYTU
         lei6a6ymQaKCEs2pHfBQDTdyMfe9tWKkbKREOB2y3D5fLnsh68xs3MLwmiYrjaKgZK4d
         NwyQ==
X-Gm-Message-State: ANoB5pmpL/pku766/YqabQTvb/WReKdaeo/XsMwojk1UK5WwnvASmOzk
        1E++VzdkNQOJmf53TATAhgjoCgaZG4rRdg==
X-Google-Smtp-Source: AA0mqf66ohvD/MzRfGnsm/7qAfLzYDDbb+NGE1QJCKaso3Pfl30nm9KaGFM2AamfgSoRHGlbeMjiSg==
X-Received: by 2002:a05:6638:41a:b0:375:bdba:52b with SMTP id q26-20020a056638041a00b00375bdba052bmr4036121jap.271.1668134113340;
        Thu, 10 Nov 2022 18:35:13 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id cx12-20020a056638490c00b003733e2ce4e8sm403531jab.59.2022.11.10.18.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 18:35:12 -0800 (PST)
Date:   Thu, 10 Nov 2022 21:35:11 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Glen Choo <chooglen@google.com>
Cc:     Emily Shaffer <nasamuffin@google.com>,
        Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] http: redact curl h2h3 headers in info
Message-ID: <Y22038eJwS6sQN/y@nand.local>
References: <pull.1377.git.git.1667955151994.gitgitgadget@gmail.com>
 <Y21zz1HYXzyyfwqy@google.com>
 <kl6lmt8y31ak.fsf@chooglen-macbookpro.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <kl6lmt8y31ak.fsf@chooglen-macbookpro.roam.corp.google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 10, 2022 at 02:14:11PM -0800, Glen Choo wrote:
> >> @@ -560,8 +560,10 @@ static void set_curl_keepalive(CURL *c)
> >>  }
> >>  #endif
> >>
> >> -static void redact_sensitive_header(struct strbuf *header)
> >> +/* Return 0 if redactions been made, 1 otherwise. */
> >
> > Does it make sense to reverse the retval here?
> >
> > `if (!redact_sensitive_header())` sounds like "if not redacted, ..." -
> > but here it means the opposite, right?
>
> I struggled with this for a bit since I wasn't sure what the convention
> is here. Enumerating some off the top of my head, we have:

For what it's worth, the "return zero if redactions were made" is what I
would have expected. I think of it as returning zero if we didn't
encounter an error (and returning a negative, non-zero value if we did).

> - For functions that don't fail we have "0" for "nothing was done" and
>   "1" for something was done (e.g. skip_prefix()).
>
> (Tangent: from a readability perspective, this is pretty poor. I need to
> know beforehand whether or not the function may fail with error before I
> know what the return value means?)
>
> This probably falls into the last category, so for consistency, I think
> this should return "1" for "redactions have happened" (as you
> suggested).

...But I don't really care that much ;-). As long as you choose
consistently, and document your choice where it is unclear, it is fine.

> >> +/* Redact headers in info */
> >> +static void redact_sensitive_info_header(struct strbuf *header)
> >> +{
> >> +	const char *sensitive_header;
> >> +
> >> +	if (trace_curl_redact &&
> >> +	    skip_iprefix(header->buf, "h2h3 [", &sensitive_header)) {
> >> +		struct strbuf inner = STRBUF_INIT;
> >> +
> >> +		/* Drop the trailing "]" */
> >> +		strbuf_add(&inner, sensitive_header, strlen(sensitive_header) - 1);
> >> +		if (!redact_sensitive_header(&inner)) {
> >> +			strbuf_setlen(header, strlen("h2h3 ["));
> >> +			strbuf_addbuf(header, &inner);
> >> +			strbuf_addch(header, ']');
> >
> > I'd really like some more comments in this function - even just one
> > describing the string we're trying to redact, or showing a sample line.
> > Navigating string parsing is always a bit difficult.
>
> Ah yes, I should include a description of the string.

Eh. To be honest, I probably wouldn't have documented it any more than
you did. At most, I would add an example "before" and "after" string
that shows what we're trying to generate.

I agree that string manipulation can end up with some fairly convoluted
code. But I think what is written here is straightforward, and that
any attempt to comment it more than suggested would end up just
repeating what the code does in English.

Thanks,
Taylor
