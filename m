Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F9B4C4338F
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 23:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7C3F61037
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 23:39:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235633AbhHDXjT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Aug 2021 19:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233775AbhHDXjS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Aug 2021 19:39:18 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8462EC0613D5
        for <git@vger.kernel.org>; Wed,  4 Aug 2021 16:39:04 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id y12so5725445edo.6
        for <git@vger.kernel.org>; Wed, 04 Aug 2021 16:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=EFC+i/y2X4dwqwIY7yvxgo9WVD61FNkRAaAMoqWIqms=;
        b=Hw4gSggZo0Sl5jkAmaBqKT2fBigQYz+CbiU1eBBJF9QEDd32Y1ZI0JVZqlw/jOuX7Y
         +5ptd0uQvwJY2pHdsZQ/7AphG58Zleoaprov1t3NlhRupfNVELoLEeXLnpf/93CtjokL
         cTh99A3R/p1iN9OSosbtzCu63pRx57cGs2/Bu/oRL6ugJhx2xckr6b2aJMQ/u7a3oCeo
         xiTJ6cG9K0iuHR23WiXFnk/a/yvB+e7WGw84f5wovugZUeND5Xg3A46i0rfyyG2sKpZ5
         1rHSBHoFCPTuKVZmTsFsAZ2IilnLZUEBHmW1zp2cHC0ns8dLDi9SbH3dRxr7jGEIF2BB
         1MiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=EFC+i/y2X4dwqwIY7yvxgo9WVD61FNkRAaAMoqWIqms=;
        b=HmwyUqJo8ICawpLVPWaRZKZeGwyf143JTN0fQMvxKmdEFv8KpOtrcmhYyafwI/5Zz+
         M8stF/YiTdsbCyfeed3FKcdZXrrxcS467JL30vWqVZCywq2rRSdixOFEFm2UIY1rHX9T
         feauUwt2XTk0qEwCcAkwantxJB36aVzPg6K8J/GLqHP7sSZyiLoOGkxCAlNIb8g2dsh8
         ZQXqH0OtCUfKERT76V03ggltsJtSHts0kQPLYHpYJUd5CEcNGwjwbIP+QRk437a+CgG/
         oYsGMTq9ITrsD19JggQDuo82+LO5sVEjRt6RR3ocXqWQV97t0XjGzt2FWqHJj4AO9/UM
         qeFw==
X-Gm-Message-State: AOAM531eP7P+oaw+yO5k48WsDr+RtaDOIzz/02fxMoO9F37AqOw42b+Z
        7HYwQiHhe8pB9REBsRRIzlw=
X-Google-Smtp-Source: ABdhPJwWdZrHF7157VN+6v7WKm38/nKUY1yzp3OuwamJG7DZA7q4sEEmPv2uSvq8FzaGnblAKbDeEg==
X-Received: by 2002:a05:6402:31e6:: with SMTP id dy6mr2646958edb.36.1628120343126;
        Wed, 04 Aug 2021 16:39:03 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id ck3sm1511773edb.80.2021.08.04.16.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 16:39:02 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com
Subject: Re: [PATCH v2 1/2] protocol: add protocol version formatting function
Date:   Thu, 05 Aug 2021 01:32:00 +0200
References: <cover.1628115064.git.steadmon@google.com>
 <63f98062788a7c5d44fafecfde78077bdce2af73.1628115065.git.steadmon@google.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <63f98062788a7c5d44fafecfde78077bdce2af73.1628115065.git.steadmon@google.com>
Message-ID: <87czqsn5k9.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Aug 04 2021, Josh Steadmon wrote:

> Add a function to get human-readable names for the various wire protocol
> versions.
>
> Signed-off-by: Josh Steadmon <steadmon@google.com>
> ---
>  protocol.c | 14 ++++++++++++++
>  protocol.h |  6 ++++++
>  2 files changed, 20 insertions(+)
>
> diff --git a/protocol.c b/protocol.c
> index 052d7edbb9..7ec7ce896e 100644
> --- a/protocol.c
> +++ b/protocol.c
> @@ -14,6 +14,20 @@ static enum protocol_version parse_protocol_version(const char *value)
>  		return protocol_unknown_version;
>  }
>  
> +const char *format_protocol_version(enum protocol_version version)
> +{
> +	switch (version) {
> +		case protocol_v0:

Don't indent "case" one more than "switch".

(Looking at CodingGuidelines we only have that advice for *.sh, but we
follow it for C too).

> +			return "0";
> +		case protocol_v1:
> +			return "1";
> +		case protocol_v2:
> +			return "2";
> +		default:
> +			return "UNKNOWN_VERSION";

Using the "default" case like that is an anti-pattern, i.e. you
enumerted all arms except protocol_unknown_version, which is implicitly
covered by your "default" case.

Just list it, and don't have a "default" case, then the compiler will
complain if we ever add a new case that's not covered.

As an aside, and not strictly needed here: More generally between this
and parse_protocol_version() it seems like this would benefit from just
declaring the bidirectional mapping beween the enum fields and string
values, and then have this and that function use that. See
e.g. object_type_strings and associated functions in object.c for
another enum that has such a bidirectional lookup.
