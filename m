Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1447C433E1
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 16:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 775A92067D
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 16:35:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qf9mezZL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395217AbgFSQff (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389262AbgFSQfd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jun 2020 12:35:33 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F654C06174E
        for <git@vger.kernel.org>; Fri, 19 Jun 2020 09:35:33 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id n2so4106803pld.13
        for <git@vger.kernel.org>; Fri, 19 Jun 2020 09:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=e/ZJZwaD0QVohQnHelo/89AhqOSFad5lCcyVg5VU1qg=;
        b=qf9mezZLNUSup5rTQmDiZkJ1kQXxEqXAJoYK+NPTCUPaOWWx2JT5okqD6VrRnCFCHW
         jkH+ImxLomCm3hs1RH2FxEFXZ2eGPtnPOvFMN751PzUO9K4E1a7kImiz6QbL4JZFek3U
         NK4+1BuaeaRandPGfgeG47ULXS+3wPnxv/3fGAy1AmhjIihtv13qtz6eDLmwm08H8G94
         hiQQ+36CEQRU2GsLk1Of6cAPUw7+Q1G5XI6mHzmy52XxQpl4UWtV7HqZdf+6FrnC3Gbv
         TTw8sdX0y7dtWMHo8TTLocf08VpmHgJpBwJu3Ad7QfLsWcbBn+Zl3Wn2zxqfSO8kOFqa
         428g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=e/ZJZwaD0QVohQnHelo/89AhqOSFad5lCcyVg5VU1qg=;
        b=B0fYjGXq8QvEJ01aRZmY4FP56LCtcYbnGi/9ZJCjgK+sRMWkt+h1jjB0BLUa7BGkBf
         mS99DboZEokyU0dmVQcFJ1Prf2+JxwmWv/3Pv5Q6bwtPMDA4z1VVOjQMWc3e9qlPTYy/
         aJ4lMllOoeqpJbANJqSTBVfUE4QRL92HfOPuKiJDOT5dqkQUGW7mni59oQmvg+bAdRez
         Cqr604RuJszF9uG5eMgUY5Bs8Epn7LiusHf+OdtfZBxPmycAwwst9LHrc0FVTCIDkhnQ
         qSOJqe1ylC2bjLr0ckpo/MxButKPeiSQL3H2bxTaZpNlCjuE7oC1bUn78V9NUD3/N3TL
         Mxtw==
X-Gm-Message-State: AOAM533jaIbvRIRKOgKYNBTyCjYGNE+iQmne/TIBBAz4/Kv0lqMzX0gQ
        Md7jl1oWM8CzDQb8WYtXkcU3rpqd
X-Google-Smtp-Source: ABdhPJzf1BiKefaCMzcJH++4l8bzOSLn31GuYKDGrPFId1qPmBgGjduKRpzoD3mrVcE1ECVcHNKChw==
X-Received: by 2002:a17:902:8208:: with SMTP id x8mr8524089pln.114.1592584532671;
        Fri, 19 Jun 2020 09:35:32 -0700 (PDT)
Received: from localhost ([2402:800:6375:a18c:ce1a:d70b:8a27:2927])
        by smtp.gmail.com with ESMTPSA id e143sm6406829pfh.42.2020.06.19.09.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 09:35:32 -0700 (PDT)
Date:   Fri, 19 Jun 2020 23:35:30 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     randall.s.becker@rogers.com
Cc:     git@vger.kernel.org, "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: Re: [Patch v1 1/3] bugreport.c: replace strbuf_write_fd with
 write_in_full
Message-ID: <20200619163530.GB5027@danh.dev>
References: <20200619150445.4380-1-randall.s.becker@rogers.com>
 <20200619150445.4380-2-randall.s.becker@rogers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200619150445.4380-2-randall.s.becker@rogers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-06-19 11:04:43-0400, randall.s.becker@rogers.com wrote:
> From: "Randall S. Becker" <rsbecker@nexbridge.com>
> 
> The strbuf_write_fd method did not provide checks for buffers larger
> than MAX_IO_SIZE. Replacing with write_in_full ensures the entire
> buffer will always be written to disk or report an error and die.
> 
> Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
> ---
>  bugreport.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/bugreport.c b/bugreport.c
> index aa8a489c35..bc359b7fa8 100644
> --- a/bugreport.c
> +++ b/bugreport.c
> @@ -174,7 +174,10 @@ int cmd_main(int argc, const char **argv)
>  		die(_("couldn't create a new file at '%s'"), report_path.buf);
>  	}
>  
> -	strbuf_write_fd(&buffer, report);
> +	if (write_in_full(report, buffer.buf, buffer.len) < 0) {
> +		die(_("couldn't write report contents '%s' to file '%s'"),
> +			buffer.buf, report_path.buf);

Doesn't this dump the whole report to the stderr?
If it's the case, the error would be very hard to grasp.

Nit: We wouldn't want the pair of {}.

> +	}
>  	close(report);
>  
>  	/*
> -- 
> 2.21.0
> 

-- 
Danh
