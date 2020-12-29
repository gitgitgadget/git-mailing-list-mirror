Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A96ADC433E0
	for <git@archiver.kernel.org>; Tue, 29 Dec 2020 00:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68DC0207CF
	for <git@archiver.kernel.org>; Tue, 29 Dec 2020 00:37:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729309AbgL2AhA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Dec 2020 19:37:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbgL2AhA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Dec 2020 19:37:00 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A26C0613D6
        for <git@vger.kernel.org>; Mon, 28 Dec 2020 16:36:20 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id f132so13117309oib.12
        for <git@vger.kernel.org>; Mon, 28 Dec 2020 16:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=/8W2YW+WQBaZ568bwts2SQlR+UsSA5TFj41i8xDBH0Y=;
        b=MQyUsTHgbnOYVsnutrjwRXFi5v8nKpBWjAzaPiYaPPNl/84TJEZ9W5wcUXSrNDnjaI
         Et/lsZ9nzQP7auc9N6mxoFdnIerQ2msrjbQccM3qNHj1Nl8gPQQOvHWVxnR8pCNMD6Oq
         H2Cdvnu77AN1bR67ijf/w96uxmtmNFpRjrDB9yQ1t64mHNdsn823i1DN0qJF/lNGqNJI
         yg105IjjhyKtC+zi4hkEH8b5ekZ3KrsovSO8hg61H371EBub6CEltHjJjiyNOKgl4WNC
         W9FvCmiqQtV3TDdlE9yhhYQQ2KRvRALwCQdrsQHicZXHCgpgaNSQwL0BiU2oFESzKtNA
         Uftg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=/8W2YW+WQBaZ568bwts2SQlR+UsSA5TFj41i8xDBH0Y=;
        b=ua1nfN6HjXs3znx4qOs18MZJeu9BHYmdq0L7yLca+pvqRpIHVcislIdC5ZAl0MSZax
         UocJnBJTdYCtiyi4+qpwjPHjEPee/EmAo7466hhkiUO43BYG3S8LzDtg5UyXNXU0AQNq
         pBHdvfRAMzRj5eEW111spDWBKZUbz1JQBTbW7joH38p9fz0xPU9tQl59EtspJTPDznbJ
         lMLAf9P6wmJ6jIaoFJVLYwHOwn6bPCEM+A30mJQ20MEtB1HsPfdAwvFPfZnCeDxhXzq4
         wsKBpCcI0hF0PGvHSapVyfFex/QQtaOjZ6XL6MCxml3i9wcH+Lz6kdxypEuRAvhuqTFM
         kPFA==
X-Gm-Message-State: AOAM533dQEc0ylgxjtNdvujvtTo1FCuX+7r1bC9yEZL6wDteanOUlMo8
        CDschseKq3xoJnHt8LnduaY=
X-Google-Smtp-Source: ABdhPJyN2LfoPwgt4+W9DI3u7B4w7Kc/4smcjiqYu9M7dl8vo8knLFDjKEUEM7zeaqE1jf1KV4scUw==
X-Received: by 2002:aca:1917:: with SMTP id l23mr953018oii.64.1609202179180;
        Mon, 28 Dec 2020 16:36:19 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id v13sm9390270ook.13.2020.12.28.16.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Dec 2020 16:36:18 -0800 (PST)
Date:   Mon, 28 Dec 2020 18:36:17 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?U1pFREVSIEfDoWJvcg==?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Message-ID: <5fea7a017271f_22e4c208a5@natae.notmuch>
In-Reply-To: <5fea746c536c0_22b892087a@natae.notmuch>
References: <20201228192302.80467-1-felipe.contreras@gmail.com>
 <20201228192302.80467-2-felipe.contreras@gmail.com>
 <X+pi4NoR116Js/XI@generichostname>
 <5fea746c536c0_22b892087a@natae.notmuch>
Subject: Re: [PATCH 1/2] test: completion: add tests for __git_complete
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras wrote:
> Denton Liu wrote:
> > Hi Felipe,
> > 
> > On Mon, Dec 28, 2020 at 01:23:01PM -0600, Felipe Contreras wrote:
> > > Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> > > ---
> > >  t/t9902-completion.sh | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > > 
> > > diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> > > index a1c4f1f6d4..2e59fe4de0 100755
> > > --- a/t/t9902-completion.sh
> > > +++ b/t/t9902-completion.sh
> > > @@ -2380,4 +2380,11 @@ test_expect_success 'sourcing the completion script clears cached --options' '
> > >  	verbose test -z "$__gitcomp_builtin_notes_edit"
> > >  '
> > >  
> > > +test_expect_success '__git_complete' '
> > > +	__git_complete foo __git_main &&
> > > +	test "$(type -t __git_wrap__git_main)" == function &&
> > 
> > s/==/=/ for this and the other patch.
> 
> Sure, I'll include that in the next version.
> 
> But I expect people will make further comments on the whole method to
> find out if a function exists.

I just noticed there's already a check for that in git-completion.bash:

	if declare -f $completion_func >/dev/null 2>/dev/null

I suppose that's prefered to: if test "$(type -t func)" = function

-- 
Felipe Contreras
