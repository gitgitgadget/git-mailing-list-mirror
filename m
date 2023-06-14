Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E65ECEB64D9
	for <git@archiver.kernel.org>; Wed, 14 Jun 2023 16:03:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbjFNQDi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jun 2023 12:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjFNQDg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2023 12:03:36 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB6AEA
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 09:03:34 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1b3cc77ccbfso22780235ad.1
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 09:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686758614; x=1689350614;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=zQcIwgm2k1sxEQMIru114GHJ/3f22SsDKgakk0ORHz8=;
        b=NIWp8g6GF5HAqkNPuAri8CgxEwfBtmYRle686qkFpDXosGdV00cGp4Vsv2GOygSMd3
         ZR1jzeJ/TeMVoqUqkexsEDRBBr9wOSYdzI4Mlf7s7fJABbBnPNgLAOI77pD6JRQFZqVO
         +nbOuNj8BIQ1ytSxuqkOdC+kJvQogw+J3z9EiyoWpG21N+g5lNLBb2rUzvUDVy+x7D7T
         /6yR4wrnrQ5nr4LZ9XPOdnGZekjT+cZwCsIGAsM+uEceB9fv4rS70ZSyM0lNLax6Yc2u
         v0JBiVjvH1v8UchU341Q8r1Gy/qmyciGm1JjAEIm82cU9PUcnfQR5s/O1jxm7OBWglSI
         ZtuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686758614; x=1689350614;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zQcIwgm2k1sxEQMIru114GHJ/3f22SsDKgakk0ORHz8=;
        b=C4/tXnHFtrgGSwVL2cRm5wTMOVOuMWcCvVDT8s7zspV3TT9FKmorwBpl1N4af5mMzC
         vlad6W04z7A8XgsntioRuBAvGoV2ighvx8j3lCTx1jALmHUlWooFmxELYHmtMhVBIrqI
         pbCUEH6JaH4f/pF9OYKyPzVdLkdhvb8Yr9tTXtIwYaBInVIocs7BvuYoKhHwsuc5LCop
         tqw+6vg1Q6aoZ1bboHgx+HreYotgjqjr57+SUnou5Mz1mCk8hwMcbzMuOoHGLpqZzUyE
         IdWgFTihX2mVHrJ1YNLB4R+/F5gva6evoHE6YufOn2tJuatDyo3Iq9VwPQQa3NlxIR4f
         LEyQ==
X-Gm-Message-State: AC+VfDwClr8PPeNzznTj0UF4bnkDaZ7qPrAkijKF8Vc4Vxo383Tsqemq
        k1uxv2RM9pf4VLGpfhB3asc=
X-Google-Smtp-Source: ACHHUZ7EeOpEzx9JGjOAAJCmEiCIkQYuQD0xPRAPbwh+86aTZR5uzNyojZI+k4P/d4u41AMDFhZekQ==
X-Received: by 2002:a17:902:c40c:b0:1aa:ff24:f8f0 with SMTP id k12-20020a170902c40c00b001aaff24f8f0mr13588896plk.4.1686758613960;
        Wed, 14 Jun 2023 09:03:33 -0700 (PDT)
Received: from localhost (128.65.83.34.bc.googleusercontent.com. [34.83.65.128])
        by smtp.gmail.com with ESMTPSA id f13-20020a170902ce8d00b001b0358848b0sm5714585plg.161.2023.06.14.09.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 09:03:33 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/3] revision: small readability improvement for reading
 from stdin
References: <cover.1686744685.git.ps@pks.im>
        <38c0415ee9074276e9832bbbafdee8833cd7ddb9.1686744685.git.ps@pks.im>
Date:   Wed, 14 Jun 2023 09:03:32 -0700
Message-ID: <xmqqh6raxc8b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> The code that reads lines from standard input manually compares whether
> the read line matches "--", which is a bit awkward to read. Refactor it
> to instead use strcmp(3P) for a small code style improvement.

It is unclear if it is an "improvement".  We've already checked the
first byte to be "-" and we only need to check the second one (and
the length of the string) to see if we have a double-dash, instead
of checking the first byte again.

I am not sure if these excessive blank lines are helping, either.

The only reason I would be inclined to support the main change in
this patch (but not additional blank lines) is because I will be
suggesting to lift the logic to detect double-dash from the "line
begins with dash" block in my review of the next step.  Once that is
done, double-dash detection cannot rely on the fact that we have
already checked the first byte.

I do agree with the change to remove the temporary variable "len",
if we were to remove the "len == 2" comparison, as it makes "len"
less useful.

Thanks.

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  revision.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/revision.c b/revision.c
> index cc22ccd76e..dcb7951b4e 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -2795,16 +2795,18 @@ static void read_revisions_from_stdin(struct rev_info *revs,
>  
>  	strbuf_init(&sb, 1000);
>  	while (strbuf_getline(&sb, stdin) != EOF) {
> -		int len = sb.len;
> -		if (!len)
> +		if (!sb.len)
>  			break;
> +
>  		if (sb.buf[0] == '-') {
> -			if (len == 2 && sb.buf[1] == '-') {
> +			if (!strcmp(sb.buf, "--")) {
>  				seen_dashdash = 1;
>  				break;
>  			}
> +
>  			die("options not supported in --stdin mode");
>  		}
> +
>  		if (handle_revision_arg(sb.buf, revs, 0,
>  					REVARG_CANNOT_BE_FILENAME))
>  			die("bad revision '%s'", sb.buf);
