Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F18C433B4
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 19:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62E3361360
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 19:32:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240387AbhDSTcj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Apr 2021 15:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239355AbhDSTcj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Apr 2021 15:32:39 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6053EC06174A
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 12:32:07 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id u20so40713969lja.13
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 12:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kslvRUywrPF86RKL/2MieJkefxvXxb/hOOK9KngXw8I=;
        b=QURRKSBP9lcBkhmUefaEGu3sT9L7XNFs40npTOAMMT8+yGDOXYHMYF0BQYAPh3rHiQ
         dQB9G23axrpCQgF03XnhbhFoGVCafooTohOpJC+zSxRqf9nzTXMXuxPqQAh7YFdFZg3x
         0EDuk3WQPv98dW1l4wO1fWW6IgfV8NExg0VeCvbw5cqaATNMdeMhDDINvd/lUtyILNYJ
         tIC5mNoe8dhjtT6rmQhl3H3Et7TJN1ScLwE2wMtyoJEyzyPeKI+Cr8heUxzPazO+r7Gd
         VVi08+WFXao09QEpKWFl7SjlnsH5n7Qm/oP5d5e94ymFP+K9UmXfEz88kpTWpnpw9Gsd
         ILRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kslvRUywrPF86RKL/2MieJkefxvXxb/hOOK9KngXw8I=;
        b=DOSg3BrHAowebceYVVHZqmysjELncD676ZAjIa5+deaiTlfwhrHkaOfMSZNyvBVmiy
         kYvxKoR1V8TXwCmOVEuxhlCwN72pl0Ypzp2VcqEU1NBisAV6uOP4CWF0lnDlyV7tQ7PV
         qPAh2KgiNhYqtYaV8qg5nKiAZExZt+kqelLVvxsqK/Tt+442/3/d8wbvPgWs+Q7fh98r
         Q8OCBF6iRDC0v1h+tCGUAaG/uTAa1ImHaGw7CM2Gd92BnRjXQ9EGBY45YQq7dHu2L0nf
         G6tHnvUfi1ot5XIczZysLnuZwOdskXsyG6XjYYrI9mhV47I7CFHqHEGGnlaLsxdpy7jt
         F+FQ==
X-Gm-Message-State: AOAM531yEcLAkm8Up+SSUHfbHTgrxEWfnEVujf5ivzrWYKS828U0Nexs
        H395zWWzopUqEpDRTzMbvjEFUWgeSHbZvg==
X-Google-Smtp-Source: ABdhPJx+oBRPFpeny8WVZ/CGIpovRiIzOCCbLPIzO34o9+L4WQdF1T7Q9vbNdq6IWigOAnCQ+hikJQ==
X-Received: by 2002:a2e:968f:: with SMTP id q15mr2083924lji.464.1618860725811;
        Mon, 19 Apr 2021 12:32:05 -0700 (PDT)
Received: from aaberge.net (kramer.samfundet.no. [2001:67c:29f4::72])
        by smtp.gmail.com with ESMTPSA id v7sm1159857lfo.297.2021.04.19.12.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 12:32:05 -0700 (PDT)
Date:   Mon, 19 Apr 2021 21:32:03 +0200
From:   Trygve Aaberge <trygveaa@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: Using --term-* with bisect breaks skip
Message-ID: <20210419193203.GE10839@aaberge.net>
References: <20210418151459.GC10839@aaberge.net>
 <xmqqlf9e9k9d.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqlf9e9k9d.fsf@gitster.g>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 19, 2021 at 11:55:42 -0700, Junio C Hamano wrote:
> Can you "bisect" the problem?  There aren't that many commits that
> touched bisection code during the period.

Yes, I ran it now. The commit introducing the regression is:

commit e4c7b33747dccc6600bc528b51e91c11b474eb04
Author: Pranit Bauva <pranit.bauva@gmail.com>
Date:   Wed Feb 3 22:54:37 2021 +0100

    bisect--helper: reimplement `bisect_skip` shell function in C
    
    Reimplement the `bisect_skip()` shell function in C and also add
    `bisect-skip` subcommand to `git bisect--helper` to call it from
    git-bisect.sh
    
    Using `--bisect-skip` subcommand is a temporary measure to port shell
    function to C so as to use the existing test suite.
    
    Mentored-by: Lars Schneider <larsxschneider@gmail.com>
    Mentored-by: Christian Couder <chriscool@tuxfamily.org>
    Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
    Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
    Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
    Signed-off-by: Miriam Rubio <mirucam@gmail.com>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

-- 
Trygve Aaberge
