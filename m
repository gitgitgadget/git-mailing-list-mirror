Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D310C07E95
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 20:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D733613E0
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 20:41:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231800AbhGBUoM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jul 2021 16:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231792AbhGBUoL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jul 2021 16:44:11 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0872BC061762
        for <git@vger.kernel.org>; Fri,  2 Jul 2021 13:41:38 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id 11so12783685oid.3
        for <git@vger.kernel.org>; Fri, 02 Jul 2021 13:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=3HxBWdsiv4/9tyLcuuQsK4ILAOsbRTOqv83h9+Nk9vE=;
        b=uNoNab9VtLYYBr6+gUAeXZI97MfpPzhl65QVFDg2TUmNwlpDZUci83Mx7zJLYhvkiC
         IpJ8b6vVXKh3BdoPndie/WogN3F3TPjnYxuiXNvW+EJvecqs0o7mG6KW7ws5q/FOS+c2
         X8kjtTOUviYmZBuOuIu/iuNNfew0GjCkSgsuXMIWNfvmOe3sy95NFhmLybQ4U4byZWBJ
         WK4Y1dOs8SbgnuBF/eoUQ5QimKePQ3MYRm9pywzsUVPkkww+etd8voX3a/55fJsMKs0G
         zF2imuCyZLsr8c1whYwXpVdgFIyufb/l2nm4tLts0GJeqkqAT/lEAdI4vygH8p8CBKg9
         +e9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=3HxBWdsiv4/9tyLcuuQsK4ILAOsbRTOqv83h9+Nk9vE=;
        b=cViL0fLt1IntQcjFb1zGiQso1Oo8qNKG+Iq0LImc2RTCWwTofZ+mCqcuT0sDUFnvFW
         V4oXa6reg8H69e3BaLjjyleYMSwt+XnWEtfJf+IPbwb+e3c5brzRzrapnIhlT4wVIpg6
         GY5NE4uA+rP3m7Tc81cTynYY1lDdAA9+hPFb+tl06gl3zO5Hle1wM+2NIhgHp6Sb/lIW
         UuNUZjsaEigFFKXvlZmH7QtQenvs+20oOHd9yHQcKw1t1bI7LEULNhnXpPPcHjQVn1NH
         9jlb9Tu6zYrbz/8+njk7TOfzHGyr0RLYsMawwU2GSs6pgS+f/jvhhr3RP/gRT86oWRwB
         OHdg==
X-Gm-Message-State: AOAM531oHC8bi6jlH8/9U/ZlTaGX9g6wvrNKMSTPWoPrgC10a26kksti
        UyksaYYLMwa1t+hUdob/tViufSx3b47Hrg==
X-Google-Smtp-Source: ABdhPJysOG2hhUhzCfxk70gx7OVbF0BVUP0E1OPYYzmHz+ISIewhH86ovLPzQVLohzwyYq+yGFPPLg==
X-Received: by 2002:aca:493:: with SMTP id 141mr1284494oie.10.1625258497333;
        Fri, 02 Jul 2021 13:41:37 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id 2sm786469ota.58.2021.07.02.13.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 13:41:36 -0700 (PDT)
Date:   Fri, 02 Jul 2021 15:41:35 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     'martin' <test2@mfriebe.de>,
        'Felipe Contreras' <felipe.contreras@gmail.com>,
        'Andreas Schwab' <schwab@linux-m68k.org>, git@vger.kernel.org,
        =?UTF-8?B?J8OGdmFyIEFybmZqw7Zyw7AgQmphcm1hc29uJw==?= 
        <avarab@gmail.com>
Message-ID: <60df79ff7643b_28bb208ed@natae.notmuch>
In-Reply-To: <xmqqr1ggpvxc.fsf@gitster.g>
References: <20210702100506.1422429-1-felipe.contreras@gmail.com>
 <20210702100506.1422429-6-felipe.contreras@gmail.com>
 <871r8hauvi.fsf@igel.home>
 <60dee7d4e27bf_2964b20817@natae.notmuch>
 <65b1d215-c3ab-e0e3-f4ac-a30131541f9b@mfriebe.de>
 <60def07e686c7_7442083a@natae.notmuch>
 <3e82a574-fdcc-08b8-8fb5-1ff15f8ae564@mfriebe.de>
 <03a401d76f45$e1c6fce0$a554f6a0$@nexbridge.com>
 <xmqqr1ggpvxc.fsf@gitster.g>
Subject: Re: [PATCH 5/5] config: add default aliases
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> "Randall S. Becker" <rsbecker@nexbridge.com> writes:
> 
> > I am sorry if I am coming across too strongly on this subject, but
> > I do think we are overloading alias capability and intruding on a
> > domain that should be reserved for our users, not ourselves.
> 
> Well said.  The customization feature is for helping users, and we
> shouldn't get in their way by adding unnecessary ones ourselves.

Nobody is getting in their way, and if they are unnecessary why does
*everyone* have aliases?

> I wouldn't recommend us to force to our users even "co is for
> checkout" that everybody seems to have.

They are not being forced.

> One thing that might (or might not) help to help users and projects
> share the same set of aliases is to make it easier to audit shared
> configuration file before inclusion.  I wonder if would help to
> introduce "include.allow" and "include.block" configuration variables
> 
>     [include] ;; or [includeIf "<condition>"]
> 	path = /usr/share/git/contrib/svnlike.alias
> 	allow = alias.*
> 
> that tells us to only pay attention to the configuration keys that
> match these 'allow' patterns when reading from the given path.

contrib is a black whole where nothing comes out of, so I would rather
not doom yet another useful feature to that fate.

> But in practice, 'alias' is one of the riskier things you can set in
> the configuration file,

Why?

-- 
Felipe Contreras
