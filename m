Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F2BB1F42D
	for <e@80x24.org>; Fri,  1 Jun 2018 02:01:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751168AbeFACBd (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 May 2018 22:01:33 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:32843 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750868AbeFACBc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 May 2018 22:01:32 -0400
Received: by mail-wm0-f68.google.com with SMTP id z6-v6so3672272wma.0
        for <git@vger.kernel.org>; Thu, 31 May 2018 19:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=a9oeIrvJtgISPwQnjjS1q//rSVoc57XzBMkrGK/VP0s=;
        b=Qy0JgVWd/rCxq9JRNQ5X9QOtiOZK+M0rofVmmCEyqS30hU+W64X9+13kfUndq4zYtw
         /JOI5wgeC1Qx3BNgaZoem/MSTnvhVPKhPfJSAULyI5gNRRFTDS/sDLCAqpVk+p848vwG
         uDN0UgszBWVX9jeDcGcUjC5jlIn/CCRj8WVokt7aDJ8Ky8tg9ihyWs73hzLTqBmDyg0I
         KR4PePE5by1FCgInSlClDzU4n+HemrrC2kn+wvMyoPEysZUZI5aLZ0rvdHg3fkReSW3/
         +jXT6FKhe03wpe28a7rSoes1zIwiauuvOFZjqiZttU0CVq0YRaXHJbpAB+zxs2ezh6oT
         ZUAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=a9oeIrvJtgISPwQnjjS1q//rSVoc57XzBMkrGK/VP0s=;
        b=aZUJDIAj8ikm+ElKnRFB1SuIfP/jtTQy3I66cME9qLRQYnIrRPPqQuv+oTist++rTN
         bi/onCxshVsHSmAIYVA3Fh45bOBO9MR0Dku0ApQpOteWrldjqgdd9BDc66MY4cByREKS
         gTDLaU8CcuIv1sU1LG02+AfyANAb1b2nHvaIVRmleCXADUsiPo98CHVgFEuR6axJlcPL
         t+V12FeP0gSbTVf7+HbApXSn+t4Xcmg0ZoSXnRorkKrP4UPKboEYboA3kEKkWVe3BrnL
         UnLQ22vDev8IoqkvFVu2sU/9Aq8JgpHQtTyiJ2B2h+mNDIWlbdtdpHyyF3FoXs1LD1oM
         01tg==
X-Gm-Message-State: ALKqPwcDYMiLW4t4k9x1BZiYrQuDuDE3FozxqIWeN5aN8edtUZ+UFfZb
        OVnb7FYu6/8cDDOEVMxvPzs=
X-Google-Smtp-Source: ADUXVKL7+bmmzc0dCqtOdkBqozfyrCyKiX+xTtkzGrPQDJGYRKKCTNAHNVhTT5dr+JU07ouoBGSGiQ==
X-Received: by 2002:a1c:6c09:: with SMTP id h9-v6mr1374318wmc.138.1527818491275;
        Thu, 31 May 2018 19:01:31 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id k28-v6sm52245459wrk.46.2018.05.31.19.01.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 May 2018 19:01:30 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, bmwill@google.com
Subject: Re: [PATCH 5/5] refspec.c: use rhs in parse_refspec instead of potentially uninitialized item->dst
References: <20180530170433.191495-1-sbeller@google.com>
Date:   Fri, 01 Jun 2018 11:01:29 +0900
In-Reply-To: <20180530170433.191495-1-sbeller@google.com> (Stefan Beller's
        message of "Wed, 30 May 2018 10:04:33 -0700")
Message-ID: <xmqqzi0f9see.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> 'item->dst' has not been assigned if '!rhs' is true. As the caller is allowed to pass in uninitialized
> memory (we don't assume 'item' was zeroed out before calling), this fixes an access to
> uninitialized memory.

Did I miss the other 4 patches that this might depend on it?

> diff --git a/refspec.c b/refspec.c
> index c59a4ccf1e5..ea169dec0d3 100644
> --- a/refspec.c
> +++ b/refspec.c
> @@ -108,7 +108,7 @@ static int parse_refspec(struct refspec_item *item, const char *refspec, int fet
>  		 * - empty is not allowed.
>  		 * - otherwise it must be a valid looking ref.
>  		 */
> -		if (!item->dst) {
> +		if (!rhs) {
>  			if (check_refname_format(item->src, flags))
>  				return 0;
>  		} else if (!*item->dst) {

Perhaps a better fisx is to explicitly assign NULL to item->dst when
we see there is no right-hand-side.

Aside from the "uninitialized" issue, the original if/else cascade
around here makes a lot more sense than the updated version.  If we
do not leave item->dst uninitialized, the control (and the readers'
understanding) can flow without having to carry the invariant
"item->dst is set ONLY when rhs != NULL" throughout this codepath,
in order to understand that this if/else cascade is asking: is
pointer NULL?  then do one thing, otherwise is pointee NUL? then do
another thing, otherwise we have a non-empty string so do something
on it.



