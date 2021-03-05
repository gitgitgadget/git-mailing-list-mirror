Return-Path: <SRS0=rdad=ID=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCDFDC433E0
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 14:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A91586504E
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 14:24:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbhCEOXa (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Mar 2021 09:23:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbhCEOWy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Mar 2021 09:22:54 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CAD9C061574
        for <git@vger.kernel.org>; Fri,  5 Mar 2021 06:22:54 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id u125so1615939wmg.4
        for <git@vger.kernel.org>; Fri, 05 Mar 2021 06:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ipFFvPmj+Sw7Hh26v9N7VlvMrj586EFms9oz98MrIyM=;
        b=oL7BJlGMFn6kjbQepHxCovH8cw1S4lkl74am6Gm5ITkYEzs//orH0ca6mm+sppeeYY
         rVDamOdq1r3PjB8I4I+O0r9pOU7kuFPu1svZd5+Fxceqg8y8Fomp4dnbP3/Pc9iiDAJk
         JlWPD6ORx+v8mGDe84/n1Z87LUynWCcPrm8/+x5EbkkT0OKe58z9gx3f/IlXQZU99vG9
         nOEMPF5twBt7x41+vDGMmWsOGMupTJ95slbly5v5201NgXD58KZPmSzbGOPFfykOh52W
         Z6IYAWh1Z2q9bG8hIh4wJlA0WPc/3PKGqDjdnHtgyPNTepiwBkJ19eRJuntUtgO2cOEC
         VAGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ipFFvPmj+Sw7Hh26v9N7VlvMrj586EFms9oz98MrIyM=;
        b=g2yKrkzZQTN3daHKYnIS4veClA0FwUd3Q7wrlLNK0t2OQCiqYvfiQZRgyt8mP2BOeQ
         Y27/bmERjb71muj8d96pSAfNnc1v7Djv3sbOVmNCFANZz2ce5fbiuvUE4WBAx++xTJ7y
         tmotsub1qJ0LBruNFYz7HRa4AScvaJ4QGq0oahis4DHFNrebARvkyGLScK5APJ/uFfZy
         o9hDMwojG58ubiyVZB5g1f293sqFHQkrhDtEKg9bawnEq0xG3ADOeH/VG+MwPnIM96Q8
         EkfUPfZZ/xRbuQGW2Ap+NOvN1KoodQ1FivuIQ4fglSPYSF+YH+ARWAzuyOerQSqQFSaB
         9fSw==
X-Gm-Message-State: AOAM532Xs77XLdqJ3t6/oXwTWzF2ZyDQdWx9dzvgsnPkl/ruB3yDcfab
        1TIzD9ByiMXiWAkM9IiupWwvplgHNFICNsIMPGwd6mc=
X-Google-Smtp-Source: ABdhPJwpbPJOqiqNZ9NQ4u+ee/joRLumi3VA+H8JKpcqKAJc/Q07oMFujjshwJlqWFfQnDfMgjWUFZbavYT3YIhx2s4=
X-Received: by 2002:a1c:e341:: with SMTP id a62mr9373582wmh.152.1614954172922;
 Fri, 05 Mar 2021 06:22:52 -0800 (PST)
MIME-Version: 1.0
References: <CANXojczh98ax2KwsaJg4CkusgrUWvhH0yG-u6oSW9nwwMLz_iA@mail.gmail.com>
 <CAGyf7-HuBHC64rL-NBRS_HDD3dbyedV-LKOeP+=k2ZVxpDOLbA@mail.gmail.com>
In-Reply-To: <CAGyf7-HuBHC64rL-NBRS_HDD3dbyedV-LKOeP+=k2ZVxpDOLbA@mail.gmail.com>
From:   Stef Bon <stefbon@gmail.com>
Date:   Fri, 5 Mar 2021 15:22:42 +0100
Message-ID: <CANXojcymWsK4g7s5rx0_OPu_XSf4ZiKUbYgQ-h38cvF5WYQs=g@mail.gmail.com>
Subject: Re: Possible to use git over custom ssh libraries?
To:     Bryan Turner <bturner@atlassian.com>
Cc:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Bryan,

thanks for your reaction. Git itself can thus deal with a different
ssh implementation, only I cannot use that for
my fuse fs. I need I library which "talks" git.

What is libgit2 in this context? Is it a library which uses the git
internals, or is git self written in libgit2?
And can I use that to use custom ssh libraries and build a fuse fs with it?

Stef
