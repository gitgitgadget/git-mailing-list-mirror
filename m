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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB9F0C433E0
	for <git@archiver.kernel.org>; Tue, 29 Dec 2020 00:13:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2BF3207CF
	for <git@archiver.kernel.org>; Tue, 29 Dec 2020 00:13:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730306AbgL2ANM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Dec 2020 19:13:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730287AbgL2ANK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Dec 2020 19:13:10 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B41E8C0613D6
        for <git@vger.kernel.org>; Mon, 28 Dec 2020 16:12:30 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id 15so13127488oix.8
        for <git@vger.kernel.org>; Mon, 28 Dec 2020 16:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=GZ9EOrxGCEAR6etw4wcmXjdNokZPINgiobrj0kzjgms=;
        b=rZ654/l34TkoE6VQRcZTNFs6aruOu8DTQHDVKSwNrRBoH8LGlAqgwZrH2uWACo37xs
         KXZGK9QxoF0I5z27CegDWAwTblsdB+8xZbWQ4m9Or21QACtyewU4PpPlt61FEzbRQLmc
         kUx33l08OevLmUaaNkGdSifdbPajvzCWLfXc2ZbUUSLUQUVIv6pCxYhACwpPPWHAz5Kr
         bFyCUQrEnzLlP/uLPXR/4dWEYqNCrijJPKiD+Dw/L2D+l6NdauE0PDQTtq0nbpVShHPa
         PctN3wlYrpX6RUHRrJMj5rXvaOeFl0XdchbJmbJqG9l3W+aR3sHfvYoZcmQNw6q7qFJ6
         R7Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=GZ9EOrxGCEAR6etw4wcmXjdNokZPINgiobrj0kzjgms=;
        b=MUh5MvmxMp2LTLgAJA9xodT/OecufSVTOikKpuY5cFeZb80wS3cLHfbhB5vFrNmm2U
         jic8fMUrLgIThxZu5P83jH0QjGngj/ogTWcwDXyROu419QAz5aKpsG3G06tJsMecgx47
         gX7ZwsIk7WgDtwbg4/pL71oGJ2DqkJEtDHOyqNduyJIa/8VGB42myZ7K7M6sI+W9lMyg
         JDJ+DHa7SuFoH6YWkIG+xnwc8BQHiZcyYNXTlakj1Ys7ULskPGtkoDuBBsCoV40/pSrx
         LVwsPrUWaDexXE7lrh5k/crwmp1VupTTv8elizlVW1WRSQoLmQRzg96YOCPeP1+gI/wJ
         gU7w==
X-Gm-Message-State: AOAM533dYOV0kDChjApmweXYM+zFXQteVEesy5Gr4xRKEPiN7KCTKs/R
        Lbnn/fEwxx5CIJcxXb65jKA=
X-Google-Smtp-Source: ABdhPJwzaauR3S44ST1fX1lj0dGESIv5JggRrdISCC8GQ3Celn9hhlFXYdq09mrkgPD8Jyo8rurUcg==
X-Received: by 2002:aca:5204:: with SMTP id g4mr898700oib.91.1609200750201;
        Mon, 28 Dec 2020 16:12:30 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id a14sm5985267oie.12.2020.12.28.16.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Dec 2020 16:12:29 -0800 (PST)
Date:   Mon, 28 Dec 2020 18:12:28 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Denton Liu <liu.denton@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?U1pFREVSIEfDoWJvcg==?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Message-ID: <5fea746c536c0_22b892087a@natae.notmuch>
In-Reply-To: <X+pi4NoR116Js/XI@generichostname>
References: <20201228192302.80467-1-felipe.contreras@gmail.com>
 <20201228192302.80467-2-felipe.contreras@gmail.com>
 <X+pi4NoR116Js/XI@generichostname>
Subject: Re: [PATCH 1/2] test: completion: add tests for __git_complete
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu wrote:
> Hi Felipe,
> 
> On Mon, Dec 28, 2020 at 01:23:01PM -0600, Felipe Contreras wrote:
> > Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> > ---
> >  t/t9902-completion.sh | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> > index a1c4f1f6d4..2e59fe4de0 100755
> > --- a/t/t9902-completion.sh
> > +++ b/t/t9902-completion.sh
> > @@ -2380,4 +2380,11 @@ test_expect_success 'sourcing the completion script clears cached --options' '
> >  	verbose test -z "$__gitcomp_builtin_notes_edit"
> >  '
> >  
> > +test_expect_success '__git_complete' '
> > +	__git_complete foo __git_main &&
> > +	test "$(type -t __git_wrap__git_main)" == function &&
> 
> s/==/=/ for this and the other patch.

Sure, I'll include that in the next version.

But I expect people will make further comments on the whole method to
find out if a function exists.

-- 
Felipe Contreras
