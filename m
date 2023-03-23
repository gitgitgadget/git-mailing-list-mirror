Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4679AC6FD1C
	for <git@archiver.kernel.org>; Thu, 23 Mar 2023 16:19:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbjCWQTw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Mar 2023 12:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231954AbjCWQTY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2023 12:19:24 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 922D33608E
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 09:19:18 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id h12-20020a17090aea8c00b0023d1311fab3so2592134pjz.1
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 09:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679588358;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p8da9sC+0MbSkCvTa+uzwcTB3/TLzv5N02/YlObs0SY=;
        b=SUnsX6xWif+wPv+oAExZgBxO6ub087zJOs5fkd97Cl5/+gxoZzUKM1DVknOrTG8fCK
         2SSsrPrEgkng9wW/UYUqCIGLokv4Z5ZWiitFpopfYGVvXo8yCUFgMurOBsOLDRvR5WHy
         RwXJjKn6Yh22to2CndLTxfORszsqoMfWAJGvv7rG0aAZfZ7Y+Hx5mqY47V+c+0k9ibWZ
         zBKm65ZJ8DUUs2MahlQrsvNQ5A3BzxbCDiJuonfGplViY2M+4D1RgHmGnrPfLD5FW733
         qi2mk1l2rrsdXwEeb2VEnzlBKp9EF2DMtnlL/3SmodxVPZZG5+f/LrP+7QWBUq9sDl3e
         wVnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679588358;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=p8da9sC+0MbSkCvTa+uzwcTB3/TLzv5N02/YlObs0SY=;
        b=a3/XSNGDg1xj/8ePIfdBveTEoX5rMhGC4z0BgD2Uc5CsWVn+8xLy69BUn3Dfc8W5Ex
         2M8tmfbEcm3Zd302Nu9wevym9kuVevMlZHugsK6ilQqyYypr+cnq/ha9d8B3/uz5Hxse
         QYnOKW+iRMS2Q+56CbAU76fCA6ijVNcuU/t/6CMauDqmyVRFnfRXinRiDtKeCRQ1E3sU
         xCrfFb5SnhZWtxBhRHmjZBdeyJkeGAigNJ3DprqVFjLGkBEKYeFqkf2fubVvl/iYh1d5
         BtZczVMjtFCwPYxul2ihNGfHIe3lM5cGjL1C7KAvcD/VeBfoBYxUmXg23G1qU48TrNzV
         FdkA==
X-Gm-Message-State: AO0yUKVmhqsWnjTVaNh+z4JHrsb8bctoQC1swYl/SB4RHLx6SyrUv/SY
        7A75WIVQA6Jtl+1V6X2uUnc=
X-Google-Smtp-Source: AK7set+QSgUSyIB4LwDWZG53ihYf+bsW8uNCfVohYWGtsSkW0T1mv22Gcj0NkebZ4CqD2J4SGlLW7w==
X-Received: by 2002:a05:6a20:8b9b:b0:cd:a358:bb7 with SMTP id m27-20020a056a208b9b00b000cda3580bb7mr98201pzh.37.1679588357806;
        Thu, 23 Mar 2023 09:19:17 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id x5-20020aa79185000000b0062612b97cfdsm12127199pfa.123.2023.03.23.09.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 09:19:17 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Mathias Krause <minipli@grsecurity.net>
Cc:     git@vger.kernel.org, Stephane Odul <stephane@clumio.com>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: Suspected git grep regression in git 2.40.0 - proposed fix
References: <7E83DAA1-F9A9-4151-8D07-D80EA6D59EEA@clumio.com>
        <xmqqttyejc7y.fsf@gitster.g>
        <b0f4b588-9871-8e59-e5a2-3f8745a7c4cd@grsecurity.net>
        <51078D7E-C325-4F57-96C1-601B4E102DD9@clumio.com>
        <4a103812-c4c6-a010-c2e5-4e42e9855c2e@grsecurity.net>
        <20230323144000.21146-1-minipli@grsecurity.net>
Date:   Thu, 23 Mar 2023 09:19:17 -0700
In-Reply-To: <20230323144000.21146-1-minipli@grsecurity.net> (Mathias Krause's
        message of "Thu, 23 Mar 2023 15:40:00 +0100")
Message-ID: <xmqq355va1a2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mathias Krause <minipli@grsecurity.net> writes:

> ... or fall-back to the previous behaviour and
> ignore Unicode properties (and reintroduce the bug commit acabd2048ee0
> ("grep: correctly identify utf-8 characters with \{b,w} in -P") wanted
> to fix).
>
> I went with the second option and could confirm the below patch fixes
> the segfault on Ubuntu 20.04 which is shipping the broken version.
>
> Junio, what's your call on it? Below patch or simply a revert of commit
> acabd2048ee0? Other ideas?

Thanks for all the investigation and a prompt fix.  Very much
appreciated.

As you identified where the breakage ended in the versions of pcre,
I think that the approach the patch I am responding to takes is more
sensible than a straight revert.

But I somehow suspect that it may be better to have the "workaround"
independent of the line acabd204 (grep: correctly identify utf-8
characters with \{b,w} in -P, 2023-01-08) touched, more like how we
"Work around ... fixed in 10.36".

IOW, not like this

>  		options |= PCRE2_CASELESS;
>  	}
> -	if (!opt->ignore_locale && is_utf8_locale() && !literal)
> +	if (!opt->ignore_locale && is_utf8_locale() && !literal) {
>  		options |= (PCRE2_UTF | PCRE2_UCP | PCRE2_MATCH_INVALID_UTF);
> +#ifndef GIT_PCRE2_VERSION_10_35_OR_HIGHER
> +		/*
> +		 * Work around a JIT bug related to invalid Unicode character
> +		 * handling fixed in 10.35:
> +		 * https://github.com/PCRE2Project/pcre2/commit/c21bd977547d
> +		 */
> +		options ^= PCRE2_UCP;
> +#endif
> +	}

but more like

 	if (!opt->ignore_locale && is_utf8_locale() && !literal)
 		options |= (PCRE2_UTF | PCRE2_UCP | PCRE2_MATCH_INVALID_UTF);
 
+#ifndef GIT_PCRE2_VERSION_10_35_OR_HIGHER
+	/*
+	 * Work around a JIT bug related to invalid Unicode character
+	 * handling fixed in 10.35:
+	 * https://github.com/PCRE2Project/pcre2/commit/c21bd977547d
+	 */
+	options ^= PCRE2_UCP;
+#endif
+
 #ifndef GIT_PCRE2_VERSION_10_36_OR_HIGHER
 	/* Work around https://bugs.exim.org/show_bug.cgi?id=2642 fixed in 10.36 */
 	if (PCRE2_MATCH_INVALID_UTF && options & (PCRE2_UTF | PCRE2_CASELESS))

That way, no matter how we ended up setting the UCP bit in the
options variable, we would avoid broken UCP handling on problematic
versions, no?

>  #ifndef GIT_PCRE2_VERSION_10_36_OR_HIGHER
>  	/* Work around https://bugs.exim.org/show_bug.cgi?id=2642 fixed in 10.36 */
> diff --git a/grep.h b/grep.h
> index 6075f997e68f..c59592e3bdba 100644
> --- a/grep.h
> +++ b/grep.h
> @@ -7,6 +7,9 @@
>  #if (PCRE2_MAJOR >= 10 && PCRE2_MINOR >= 36) || PCRE2_MAJOR >= 11
>  #define GIT_PCRE2_VERSION_10_36_OR_HIGHER
>  #endif
> +#if (PCRE2_MAJOR >= 10 && PCRE2_MINOR >= 35) || PCRE2_MAJOR >= 11
> +#define GIT_PCRE2_VERSION_10_35_OR_HIGHER
> +#endif
>  #if (PCRE2_MAJOR >= 10 && PCRE2_MINOR >= 34) || PCRE2_MAJOR >= 11
>  #define GIT_PCRE2_VERSION_10_34_OR_HIGHER
>  #endif
