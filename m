Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D869220401
	for <e@80x24.org>; Wed, 21 Jun 2017 20:05:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751842AbdFUUFK (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Jun 2017 16:05:10 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33915 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751106AbdFUUFK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2017 16:05:10 -0400
Received: by mail-pf0-f196.google.com with SMTP id d5so32633794pfe.1
        for <git@vger.kernel.org>; Wed, 21 Jun 2017 13:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=0EPuCo4oJ2G4pxSr4bYomtfA9SX2dKsJfThfcVl5H5Q=;
        b=ZKtKc6llnqA6OsRAbnZILJNZQ08EPtgBSxToxrmQPgMFXWJpm+Tkq54TLJuT37SvVa
         tKPwVl677/CDTCubvjNOnD8Q0yMUNrnPxWz0C9s3Gdv5sVXnHFNKpUnz9APLlCnAq8r6
         iKb/RFYThOhk56q5LLx5NJWzOqJedV6DzuLpoEUFJOP0BsvQtLG5K61e6zypmMCDM+vH
         R8sM6KuxCE46a7k1CKIwrFyF8gUWDhbKtygbZhOVGEqKj7N5GoOMdGWlrmvo42kISLEc
         cBSie5Nc8zmnJjd39d0+77mH6huZR5KMQPD8O0T23qByZWmOlHk1zzTCJvRnY7jj4MU0
         iWYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=0EPuCo4oJ2G4pxSr4bYomtfA9SX2dKsJfThfcVl5H5Q=;
        b=WQxW4QtUuWcjnmNIANz8XT1u/4eacQ49GpF6jam54CjxB3XbW/IwRBOsaVx/DOxyFE
         Jf8U2HCdIoBYSJwkxAGbhIZ2Qn1pqWm730Hh9RaMpvtq7fidmz9SViAyeecrCa3KsdtW
         rRLdCn2QKH2GWfKFHKqLb/uvo47WKIPwrtNt8R79RKOOSdsd3OXb2IpW8pM0qvZpKJKd
         kc0OX9Qwm5WVOtx7hmRsQ/NVTFhcPA3no67vQkL9D4rfOjw/LNnlohys408lnL9EKEJr
         5708Kr+KH6C+W5I6KNgfhF0ddnxtiBbLqNNmFk5CxmP/F3UGxRsVioVNU5O6tNvi8SGe
         A/nw==
X-Gm-Message-State: AKS2vOz+8cIGNESziDME9CNCuFx7/eBFJkYjvPcpQ+D+HSZhKal/nvgV
        LOGXLzmfu1aUxA==
X-Received: by 10.84.254.78 with SMTP id a14mr33074715pln.69.1498075509131;
        Wed, 21 Jun 2017 13:05:09 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b0bd:d7d3:4f2e:5016])
        by smtp.gmail.com with ESMTPSA id k70sm35420097pfg.72.2017.06.21.13.05.07
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 21 Jun 2017 13:05:08 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     bmwill@google.com, git@vger.kernel.org, jonathantanmy@google.com,
        jrnieder@gmail.com, mhagger@alum.mit.edu, peff@peff.net,
        philipoakley@iee.org
Subject: Re: [PATCH 08/26] diff.c: migrate emit_line_checked to use emit_diff_symbol
References: <CAGZ79kaqjQYmkt77kk5m=fdBfbZAvwd0YhhT7=O5b-FkQmDfHg@mail.gmail.com>
        <20170620024816.20021-1-sbeller@google.com>
        <20170620024816.20021-9-sbeller@google.com>
Date:   Wed, 21 Jun 2017 13:05:07 -0700
In-Reply-To: <20170620024816.20021-9-sbeller@google.com> (Stefan Beller's
        message of "Mon, 19 Jun 2017 19:47:58 -0700")
Message-ID: <xmqq37atp0ng.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>  static void emit_add_line(const char *reset,
>  			  struct emit_callback *ecbdata,
>  			  const char *line, int len)
>  {
> -	emit_line_checked(reset, ecbdata, line, len,
> -			  DIFF_FILE_NEW, WSEH_NEW, '+');
> +	unsigned flags = WSEH_NEW | ecbdata->ws_rule;
> +	if (new_blank_line_at_eof(ecbdata, line, len))
> +		flags |= DIFF_SYMBOL_CONTENT_BLANK_LINE_EOF;
> +
> +	emit_diff_symbol(ecbdata->opt, DIFF_SYMBOL_PLUS, line, len, flags);
>  }

This is a bit unsatisfactory that the original code didn't even have
to make a call to new_blank_line_at_eof() at all when we know we are
not checking for / coloring whitespace errors, but the function is
called unconditionally in the new code.

> diff --git a/diff.h b/diff.h
> index 5be1ee77a7..8483ca0991 100644
> --- a/diff.h
> +++ b/diff.h
> @@ -148,9 +148,9 @@ struct diff_options {
>  	int abbrev;
>  	int ita_invisible_in_index;
>  /* white-space error highlighting */
> -#define WSEH_NEW 1
> -#define WSEH_CONTEXT 2
> -#define WSEH_OLD 4
> +#define WSEH_NEW (1<<12)
> +#define WSEH_CONTEXT (1<<13)
> +#define WSEH_OLD (1<<14)

Hopefully this is a safe conversion, as everything should come from
parse_ws_error_highlight() that uses these constants.

But this is brittle; there must be some hint to future readers of
this code why these bits begin at 12th (it is linked to 07777 we saw
earlier); otherwise when they change something that needs to widen
that 07777, they will forget to shift these up, which would screw
up everything that is carefully laid out here.


