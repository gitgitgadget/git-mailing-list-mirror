Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22ECEC4332F
	for <git@archiver.kernel.org>; Fri, 16 Dec 2022 22:52:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbiLPWwQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Dec 2022 17:52:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiLPWwP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Dec 2022 17:52:15 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5D9BF5B
        for <git@vger.kernel.org>; Fri, 16 Dec 2022 14:52:12 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id t11-20020a17090a024b00b0021932afece4so7508511pje.5
        for <git@vger.kernel.org>; Fri, 16 Dec 2022 14:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VuvYaIdlV2RA+9a+sIr4DjoO9fvXsBAJMdy5SYxK44Y=;
        b=ohB8MXpww9czRmNnxOVv+xBuuPXhduKuG+uUECaHKUpWeg6w6Id9toajkcjiKkGdmB
         s4+shIbJSnYNekqLp4m4DmaBisrAcMjXBweXSUj+luw//bAV34rCHFKzWj99RwtJ4cQx
         iY4Y7lbydB7Z65ywTnGKmGyhjHnhzaCrAsuwYh6b5cLeNptTc0B3eq/7nYoHQaU3evOp
         bZPlVZHHxqoaJtTU3cD9/qJYAlTwQA5uWpTBEFBpGtrdr8lhoyvuAwG009w3IOkVgNLH
         A5JcHyqm3oALuc3MfmQY1VTVtv2zE5mXoUVGnn/Dk1Cq+vEZ/X3NUrKXsvyUR+v1tNG2
         o8Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VuvYaIdlV2RA+9a+sIr4DjoO9fvXsBAJMdy5SYxK44Y=;
        b=siLGYy9z+uGUQvkXu4qOg8PZGbVMHxygNwKWz6jTQZicZiAER0cfM3F09J4GWeMCiK
         rA7imNZW+PlQOPk9Whlq0uubyH89Hlwr/KhpPjlu1sgitbw323KDduIkr6B+JrNlw7AV
         Xgxx1QpQGg5tZdJ/NGNlgWL0Y3r584t/rC11tqfhn/QHy6WL9A+hg/6J6oAP5rhPAI9i
         YjeDzQteZEfdUZbwX2VQdljrw5ZoamUJhjtDCGYr84hH+2XaLLsnnXI3FZGiMYPzb6ga
         nervSqdXByR9TIzGkM1jDZJOfshOan3AMKwd7lG/QzszhWFz7GZwFhQo/ZMiRXgtGOtw
         rD1w==
X-Gm-Message-State: ANoB5plNf3rMwiW96O3Qc3aAri/uycgBF25pLGlw2r0afdEC5LpL/Vn7
        AvcH/b7DzSCAMWkgLPatZIo=
X-Google-Smtp-Source: AA0mqf6Gjn4kXeFvTGMFD5gSxBsnD1LwZkIgD565vPko7LKQblgw0xkDO0e5fk2l78w7xBF/nQ5JvA==
X-Received: by 2002:a17:903:2051:b0:189:d4c5:f155 with SMTP id q17-20020a170903205100b00189d4c5f155mr31464075pla.63.1671231131795;
        Fri, 16 Dec 2022 14:52:11 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id b6-20020a1709027e0600b00174f7d10a03sm2117456plm.86.2022.12.16.14.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 14:52:11 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Mathias Krause <minipli@grsecurity.net>
Cc:     git@vger.kernel.org,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: Re: [PATCH] grep: fall back to interpreter mode if JIT fails
References: <20221216121557.30714-1-minipli@grsecurity.net>
Date:   Sat, 17 Dec 2022 07:52:11 +0900
In-Reply-To: <20221216121557.30714-1-minipli@grsecurity.net> (Mathias Krause's
        message of "Fri, 16 Dec 2022 13:15:57 +0100")
Message-ID: <xmqq359fm06c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mathias Krause <minipli@grsecurity.net> writes:

> Such a change was already proposed 4 years ago [1] but wasn't merged for
> unknown reasons.
>
> 1. https://lore.kernel.org/r/20181209230024.43444-3-carenas@gmail.com

This part does not belong to the log message but should go below
three-dash line.  If you have a more concrete "it was rejected
because ...", to help judging why this version improves upon the
previous attempt and it is clear the reason for past rejection no
longer applies, that is a very different story, though.

The way I read the original thread (assuming that the lore archive
is showing all relevant messages there) is that RFC was reviewed
well and everybody was happy about the direction it took.  It even
received fairly concrete suggestions for the real, non-RFC version,
but that never materialized.

It is very clear that the posted patch was not yet in a mergeable
state as-is; "for unknown reasons" is less than helpful.

Now, we learned a more concrete reason, i.e. "it got tons of help
improving the draft into the final version, but the help was
discarded and the final version did not materialize", does the
attempt this time around improve on it sufficiently to make it
mergeable, or is it sufficiently different that it needs a fresh
review from scratch?  If the latter, then "for unknown reasons"
becomes even less relevant.

The rest of the proposed log message, and the change itself, both
look very reasonable and well explained, at least to me.

Thanks.


> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
> Signed-off-by: Mathias Krause <minipli@grsecurity.net>	# tweaked changelog, added comment
> ---
>  grep.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/grep.c b/grep.c
> index 06eed694936c..f2ada528b21d 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -317,8 +317,21 @@ static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt
>  	pcre2_config(PCRE2_CONFIG_JIT, &p->pcre2_jit_on);
>  	if (p->pcre2_jit_on) {
>  		jitret = pcre2_jit_compile(p->pcre2_pattern, PCRE2_JIT_COMPLETE);
> -		if (jitret)
> -			die("Couldn't JIT the PCRE2 pattern '%s', got '%d'\n", p->pattern, jitret);
> +		if (jitret) {
> +			/*
> +			 * Even though pcre2_config(PCRE2_CONFIG_JIT, ...)
> +			 * indicated JIT support, the library might still
> +			 * fail to generate JIT code for various reasons,
> +			 * e.g. when SELinux's 'deny_execmem' or PaX's
> +			 * MPROTECT prevent creating W|X memory mappings.
> +			 *
> +			 * Instead of faling hard, fall back to interpreter
> +			 * mode, just as if the pattern was prefixed with
> +			 * '(*NO_JIT)'.
> +			 */
> +			p->pcre2_jit_on = 0;
> +			return;
> +		}
>  
>  		/*
>  		 * The pcre2_config(PCRE2_CONFIG_JIT, ...) call just
