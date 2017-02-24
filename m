Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9317201A9
	for <e@80x24.org>; Fri, 24 Feb 2017 21:27:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751301AbdBXV1T (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Feb 2017 16:27:19 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35037 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751320AbdBXV1S (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2017 16:27:18 -0500
Received: by mail-pg0-f67.google.com with SMTP id 1so4386334pgz.2
        for <git@vger.kernel.org>; Fri, 24 Feb 2017 13:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=fhetYCmfnY6cAZohDFgovZA6iUI1pBBwxWneflFUXug=;
        b=de+93avb0BdBy4M5p4jRYEzTAZ0RhMeAaCk7jKlb1r3glaZR2DTdjR4sQUJpQXO63Z
         w6NvC95pZBoRidoA5WxFggZGopugoUAOjc8Gj27sDW6aory7A82u1Li/R3L8cLOiDXeg
         2CxCCVJhBMcjfjOzEvXl6j/+i+Q4iu0Bb37V5YhPtBtwuwCEaZiXJ0AcogyolGe/x4Wr
         eHMWBBXmaj7kRG2PoG8GMZ8mc4LdQJ+MtJ9eB1G60xo3IzOtKiZP1wXlYgal6ugxl4ro
         L75K7EEhZKsOCLGLOkR26I0ijs9WTWo7M3/idjvFj2uVTETxZIgpUOzRSkwm7TVwh4SC
         Ol/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=fhetYCmfnY6cAZohDFgovZA6iUI1pBBwxWneflFUXug=;
        b=PgVO/evOubUGpagnXah+oplqCnqGF8vKrT9Gixi3xCVmyYb/Lds/UFHsaHim7ZZcdW
         5UcJVjfRuOH6aHa8zifMXgAaUH9346NylI0CJgcYt2JgoyF00a/qjkhbcwlWhwWYh91u
         q+27s3WbJcoG0xmREqFXMdx+dSQvEvxpL+NgH3sDIaENguT0Bd+NlnAEq2l2GlVSjTu/
         EHAUy0YxIncFlhHJqoIzamNAnb5Z56gwCpDNMgdzUu86kKWipTGzb4vREvLdD+r93myG
         XnVoavuh1kF3JfS+c0vzhYBUFGOrA9atQTonQhy+gyZPhpXop6rM2MiZdr1dINyPyD2F
         Zr0g==
X-Gm-Message-State: AMke39nvxiUi4Z1pqVCypTYS2HlJVOAecFi1Ehgq69hC7748G1daEU90A1LFewqIJGTpRw==
X-Received: by 10.84.232.9 with SMTP id h9mr6764133plk.102.1487971549726;
        Fri, 24 Feb 2017 13:25:49 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:f06c:2e0c:850d:31b4])
        by smtp.gmail.com with ESMTPSA id 143sm16733528pgb.66.2017.02.24.13.25.48
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 24 Feb 2017 13:25:49 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/3] parse_config_key: allow matching single-level config
References: <20170224210643.max6z2ykm3gbg7lw@sigill.intra.peff.net>
        <20170224210802.rpr5vdpqhsp3pt5v@sigill.intra.peff.net>
        <xmqqzihbz3nz.fsf@gitster.mtv.corp.google.com>
Date:   Fri, 24 Feb 2017 13:25:48 -0800
In-Reply-To: <xmqqzihbz3nz.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Fri, 24 Feb 2017 13:20:48 -0800")
Message-ID: <xmqqr32nz3fn.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> The parse_config_key() function was introduced to make it
>> easier to match "section.subsection.key" variables. It also
>> handles the simpler "section.key", and the caller is
>> responsible for distinguishing the two from its
>> out-parameters.
>>
>> Most callers who _only_ want "section.key" would just use a
>> strcmp(var, "section.key"), since there is no parsing
>> required. However, they may still use parse_config_key() if
>> their "section" variable isn't a constant (an example of
>> this is in parse_hide_refs_config).
>
> Perhaps "only" at the end of the title?

which still stands.  My initial reaction was "eh, I didn't know it
was an error to call the function for two-level names".

> After grepping for call sites of this function, I think we can
> simplify quite a few instances of:
>
> 	if (parse_config_key(...) || !name)
> 		return ...;

This is false.  Sorry for the noise.
