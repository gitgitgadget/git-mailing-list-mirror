Return-Path: <SRS0=lIKx=5L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB188C43331
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 09:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADED020714
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 09:29:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OJ3FqaH7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbgCZJ3j (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Mar 2020 05:29:39 -0400
Received: from mail-wm1-f42.google.com ([209.85.128.42]:36264 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbgCZJ3j (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Mar 2020 05:29:39 -0400
Received: by mail-wm1-f42.google.com with SMTP id g62so6171168wme.1
        for <git@vger.kernel.org>; Thu, 26 Mar 2020 02:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9DuhEvnONCUh17Vdxzc5iSLBsqaYPifwhtv8me7VqOw=;
        b=OJ3FqaH7T0ZEIXmOapwG8lYNbk/5yIy4eraypifMxO0xRiI2Io0SRfFHL1VyLDecCA
         Awp+iTdD5TCBNaXFpGaUsOYEJtWJs1jnHrlJBhCJx1ZAJTYy+3Y4wR6i2/7oPN+MmHlM
         46AuxHbNP6DDn+1CzRt2RSxuwC0oB+bZmv10+pUfLV6fkB8WOqst9nL5w5zZAmpE1+mb
         1690hI50cmcsKqYvKsDKPveTbSwZsM9sf2eCdKxAv714l/Vc2RVmRAfSYyf5t0c9rZ0q
         GOf7GEV1CA6VhHTA7TT6S3qtjnx/a7jOYpHw4Zqbr3EK5BqZHSm4CZM6BcbTmHFfGMR2
         602Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9DuhEvnONCUh17Vdxzc5iSLBsqaYPifwhtv8me7VqOw=;
        b=HQ3vmpz0qLxRpfXe+ZH5e43pio1h0Y+f5ypeeVup+4yM4Xn3osARZMxxwkokwXdo4O
         YXij1yHGxY5FUchAsmjvYi1GxrK90OLfOQ5C8AHaJprDXahE8zJPcxGMn4U29fVGEBDB
         iuEK+1xY1pPreuFVUTSHpy8dBS8eyA2BhNV5EoiHyESwlN0EJS14FBTxhN3F8Olxsm15
         1BT3SSpTUdYnA7v0J6HNnQWCPDzphecEN/D+H5jYPcoJdPj29Xcba9wzOiAbcJn5w9Om
         MfyczUzacNSwnQEhCvYUzbE8scpy+kGS+cJwa/fgsAKM+mc7ma6QqO1PEuMU3JIyENlq
         k/+g==
X-Gm-Message-State: ANhLgQ3jpVAP+Vqst+NVJ3R7Ja+jB0nST8i/h3G6Zh+KqryeM41xo3F8
        d8LL2CQSvveAEC0TvUBlbhQ=
X-Google-Smtp-Source: ADFU+vvQQuN3Ta4Kk+4GkzAfbuh/11e+8DeZYdgGK8HcxOPosn9fMKLY7QPyRjdLp0pDwAMmoDDxTg==
X-Received: by 2002:a1c:b356:: with SMTP id c83mr2292798wmf.10.1585214977118;
        Thu, 26 Mar 2020 02:29:37 -0700 (PDT)
Received: from localhost ([2.28.70.205])
        by smtp.gmail.com with ESMTPSA id k84sm2774182wmk.2.2020.03.26.02.29.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 26 Mar 2020 02:29:36 -0700 (PDT)
Date:   Thu, 26 Mar 2020 09:29:35 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Mar 2020, #08; Wed, 25)
Message-ID: <20200326092935.GB157628@cat>
References: <xmqq7dz8w0tv.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq7dz8w0tv.fsf@gitster.c.googlers.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/25, Junio C Hamano wrote:
> * tg/retire-scripted-stash (2020-03-05) 2 commits
>   (merged to 'next' on 2020-03-05 at 8e82eb9dec)
>  + stash: remove the stash.useBuiltin setting
>  + stash: get git_stash_config at the top level
> 
>  "git stash" has kept an escape hatch to use the scripted version
>  for a few releases, which got stale.  It has been removed.
> 
>  Will cook in 'next'.
>  cf. <20200306172913.GF1571684@cat>

Now that 2.26 is released, I think this can be safely merged down to
master.
