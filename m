Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25212C433E1
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 14:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC58E20855
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 14:57:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kQTSsa7V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728282AbgHNO5u (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Aug 2020 10:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726662AbgHNO5s (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Aug 2020 10:57:48 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1BF0C061385
        for <git@vger.kernel.org>; Fri, 14 Aug 2020 07:57:48 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id f193so4670338pfa.12
        for <git@vger.kernel.org>; Fri, 14 Aug 2020 07:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BPWozSpgsrolVU5sU/dA4Yr+zTsQl1ivham+IosnadE=;
        b=kQTSsa7VF76ApbHzFZFVx7JnriG0Gd8cewsDKHbPtCnBni4RCjXmCIvuXZUjuveX/N
         7RndrIfpTxgfLaO64tT4z4OqcDBiPml3jbVLfYPG8BM6RdBwrN0s78gLHjcKyQ6jo6tY
         3lU40laIwCoOrG5ZbfVw1/wPi8nWubPXpx1vd1CtCQbrRVscPPywrNzMNCCOZBA8c0Ag
         LdKhR0iK7aepRdW8D33zfTFepYbgYs/BD7VrKxzyZn+b2G7atJzDGUCkqh6e+Q9Yph+Y
         Mzzifp9VBVU/KeF2o0faDgA0O5N1WzieFk7gAB2Gvoglrh+LGbrOW9A19T8m7XA1WG+h
         FlGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BPWozSpgsrolVU5sU/dA4Yr+zTsQl1ivham+IosnadE=;
        b=ZfmNgWz2KrXXfpaVpGdvlk+FJ8ohVEWSFK4SSwNIUn9P4L7fqU90bgIUbY69NQo6X6
         Xhg86OajKkXKI4rbm4tcTMI3cLcKVeMBWwc7z0UtgZavVKz8rTdkd2piC2eYpESuSHbb
         i3OtWxiC9mckYRfMu3l4lqxr3lVtAIDHYLp/Y2vm38rmSb9fz9lf410qdW/gcKOy/Px3
         qtO+zUL49j2b3ATffcFnqnZd6CTeDdxMV/fmo8uRuaJ7HLiUNvoPpBvDxRm33DxnrsNA
         WJPTqwo6R0ZcAYDKFWSNE1exDSe8kD06cI/XCo+DZGtummY4x6njNPGRIftfY/9YgiZk
         452g==
X-Gm-Message-State: AOAM533LIfCr407lVECrNqO2YCeDpEQc+v5s9M8wEkWAG2i4IwB2F+wM
        nQlNqvjk/o7Zxh/1bMRFB5I=
X-Google-Smtp-Source: ABdhPJxH23O2WBKA71QFLqg85WFridIpAN4XNTcEGGjXOxXhhgN65p9okKVaVYNTKhHoeN7YwZIvKQ==
X-Received: by 2002:a63:5fc9:: with SMTP id t192mr2056279pgb.269.1597417068241;
        Fri, 14 Aug 2020 07:57:48 -0700 (PDT)
Received: from konoha ([45.127.46.174])
        by smtp.gmail.com with ESMTPSA id b185sm9590707pfg.71.2020.08.14.07.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 07:57:47 -0700 (PDT)
Date:   Fri, 14 Aug 2020 20:27:41 +0530
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     christian.couder@gmail.com, git@vger.kernel.org,
        Johannes.Schindelin@gmx.de, kaartic.sivaraam@gmail.com,
        liu.denton@gmail.com, me@taylorr.com
Subject: Re: [PATCH v2 2/4] t7401: change test_i18ncmp syntax for clarity
Message-ID: <20200814145741.GA147891@konoha>
References: <20200805174921.16000-1-shouryashukla.oo@gmail.com>
 <20200812192737.13971-1-shouryashukla.oo@gmail.com>
 <20200812192737.13971-3-shouryashukla.oo@gmail.com>
 <xmqq1rkb60ql.fsf@gitster.c.googlers.com>
 <xmqqwo234lya.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqwo234lya.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/08 02:02, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Shourya Shukla <shouryashukla.oo@gmail.com> writes:
> >
> >> Change the test_i18ncmp syntax from 'test_i18ncmp actual expected' to
> >> 'test_i18ncmp expected actual' to align it with the convention followed
> >> by other tests in the test script.
> >> ...
> >> @@ -285,7 +285,7 @@ EOF
> >>  
> >>  test_expect_success '--for-status' "
> >>  	git submodule summary --for-status HEAD^ >actual &&
> >> -	test_i18ncmp actual - <<EOF
> >> +	test_i18ncmp - actual <<-EOF
> >>  * sm1 $head6...0000000:
> >>  
> >>  * sm2 0000000...$head7 (2):
> >
> > This one does more than what the proposed log message explains, but
> > it does not do enough at the same time.  
> >
> > If "actual vs expected order" is what this commit wants to fix, then
> > "<<EOF" vs "<<-EOF" is outside the scope of it.
> >
> > Personally, I think it is a good idea to update the end-of-heredoc
> > marker to "<<-EOF", ...
> 
> It seems that the theme of your [3/4] is exactly about fixing the
> "end-of-heredoc marker is prefixed with dash, but the heredoc is not
> indented for readability", so perhaps you'd want to stop this step
> at turning the line to
> 
> >> -	test_i18ncmp actual - <<EOF
> >> +	test_i18ncmp - actual <<EOF
> 
> i.e. "compare expected vs actual in this order", and then in the
> next patch [3/4], edit the line further to
> 
> 	test_i18ncmp - actual <<-EOF
> 
> *and* indent the here-doc at the same time?

Ohh okay okay. I understand what you are saying. I wanted to fix the
heredoc markers and indent the tests for better readibility but actually
I fixed the heredoc marker in [2/4]. Therefore, the change in [2/4]
should in fact be:

    -	test_i18ncmp actual - <<EOF
    +	test_i18ncmp - actual <<EOF

And in this patch [3/4], it should become:

    -	test_i18ncmp - actual <<EOF
    +	test_i18ncmp - actual <<-EOF

As well as the indentation fixes I did in the patch already. Now I
understand the exact use and significance of the heredoc. Thank you.

