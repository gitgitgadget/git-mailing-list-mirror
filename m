Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B91AC433FE
	for <git@archiver.kernel.org>; Sat, 29 Oct 2022 18:26:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbiJ2S0f (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Oct 2022 14:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiJ2S0d (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Oct 2022 14:26:33 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77BBE303EB
        for <git@vger.kernel.org>; Sat, 29 Oct 2022 11:26:32 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id z3so7010419iof.3
        for <git@vger.kernel.org>; Sat, 29 Oct 2022 11:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PtMi9U4MBeVft5L8KuGEbA+tXWKhc5m9CqHMr9p13M8=;
        b=dlwG62wFF+2c+Ev+AEzeEsTKei5nENJxfF6zeTJnYIQYmnhLlwax11K2UZ7mxFkKxN
         uXTIhN2aK1nrVDVWMkYw/E1BcDg+9LTQjrdy45yBPkv+n1YkYLhD7QKc7z0O72p9obzK
         ruBiAjVZ9B19vN9u3Z/zfL4zsu+uM7e2aSDFeXA6QqzEnKlzQuSMlSZ4ZYg4Kicvarx4
         3/zO4BPgL1zaPeWDdJ8oPxqBmjJ8qn+ZTiL1fMouo2YjYD/myztU6skGJXsFEj6qN6o3
         9nrJzvEZMlTJLfhdyLWaJEdlD0bbfXFbrDo0XWHqmU/5Mxi77/FA/DoHatIxfIrQjoJT
         Su7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PtMi9U4MBeVft5L8KuGEbA+tXWKhc5m9CqHMr9p13M8=;
        b=ykAN75W9GVekW9j1k/+fZ2nCE9Ndi1GBzQjTxS9v2Rkf2PNGVN2LUHSZT7soP6xwyy
         /4QwcgL8miBDwrTrWRJU/uXxPFdJbU6uqvRb5sMwvAOChk+ps1Tci5g12EgdvdeYpunN
         0fcqNmZfJqVuuvaN7QH4d8E/9zDloRJgAVXNBjudB5glrKNB9talqB1oNgkrAWe3EAm7
         EvK6gaytTAmcmfvEfnPbkGK1GGlKcpieLo4aoFYQ6HtA0YLqkT4hnYAT2SetbHRsWCr4
         RIuwGlkzFD91/vx2tauqzxnB1wysNIf+WYfDH2SIFwdNPpSPFx/oiFvuKTV44WPnjS57
         Rv4w==
X-Gm-Message-State: ACrzQf0S6881BYwNMrdArFkqFMMmmw4vP0BugLR8qANQ8RFg36Dt27yq
        OfLXhJiWYVu8nf2Yo+PsKvcerg==
X-Google-Smtp-Source: AMsMyM6vImk11EUd/ny3Kvgr9BzUlfGBGbYyl5/6o3LXxgRc0p7c9ruiElONDpGoGHCB9aC9kXWmfg==
X-Received: by 2002:a05:6638:13cc:b0:35b:a3e1:3ccf with SMTP id i12-20020a05663813cc00b0035ba3e13ccfmr2673157jaj.317.1667067991778;
        Sat, 29 Oct 2022 11:26:31 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d124-20020a026282000000b003640dc54d5asm878787jac.14.2022.10.29.11.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Oct 2022 11:26:31 -0700 (PDT)
Date:   Sat, 29 Oct 2022 14:26:30 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 4/8] use child_process member "args" instead of string
 array variable
Message-ID: <Y11wVpgoD0KrHm55@nand.local>
References: <7407e074-4bd8-b351-7fa4-baf59b41880c@web.de>
 <0e889c96-6004-96e4-9505-19ce1e7f9900@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0e889c96-6004-96e4-9505-19ce1e7f9900@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 27, 2022 at 06:37:52PM +0200, René Scharfe wrote:
> @@ -729,20 +727,22 @@ static int is_expected_rev(const struct object_id *oid)
>  enum bisect_error bisect_checkout(const struct object_id *bisect_rev,
>  				  int no_checkout)
>  {
> -	char bisect_rev_hex[GIT_MAX_HEXSZ + 1];
>  	struct commit *commit;
>  	struct pretty_print_context pp = {0};
>  	struct strbuf commit_msg = STRBUF_INIT;
>
> -	oid_to_hex_r(bisect_rev_hex, bisect_rev);
>  	update_ref(NULL, "BISECT_EXPECTED_REV", bisect_rev, NULL, 0, UPDATE_REFS_DIE_ON_ERR);
>
> -	argv_checkout[2] = bisect_rev_hex;
>  	if (no_checkout) {
>  		update_ref(NULL, "BISECT_HEAD", bisect_rev, NULL, 0,
>  			   UPDATE_REFS_DIE_ON_ERR);
>  	} else {
> -		if (run_command_v_opt(argv_checkout, RUN_GIT_CMD))
> +		struct child_process cmd = CHILD_PROCESS_INIT;
> +
> +		cmd.git_cmd = 1;
> +		strvec_pushl(&cmd.args, "checkout", "-q",
> +			     oid_to_hex(bisect_rev), "--", NULL);

I was wondering if this part of the conversion was right, since
oid_to_hex() uses a ring of output buffers (see hash_to_hex_algop()).
But we do call xstrdup() on the argument from strvec_push(), so we are
OK here.

Thanks,
Taylor
