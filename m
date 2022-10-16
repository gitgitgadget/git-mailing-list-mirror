Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF55CC433FE
	for <git@archiver.kernel.org>; Sun, 16 Oct 2022 20:19:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbiJPUTi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Oct 2022 16:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiJPUTf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Oct 2022 16:19:35 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F2ADF77
        for <git@vger.kernel.org>; Sun, 16 Oct 2022 13:19:34 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id b2so20817215eja.6
        for <git@vger.kernel.org>; Sun, 16 Oct 2022 13:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks.biz; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LVXu7FXvbbkClDfyhqhOUOktEndjkyaR4J+GkT631mk=;
        b=SFjfISLHYnV0zUg2geFjuYgap95uY0qhk/xps7l0d7bPGlzriyM2zPactnOUIPcbaf
         KUBZmVJ/dBKPziD8kc5Q/73uMaxsqMUR3wEkfLxjtN7fnbjpOkgBWBovUtRvATKEUzJF
         k8yTc73jyhQCkB9H2NEOXMJzeAAQ09wT77KMM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LVXu7FXvbbkClDfyhqhOUOktEndjkyaR4J+GkT631mk=;
        b=fU4YQkMuAuS/UuiJ1+wC2pYwe56/+myVHCBAfFMhDTI2iUCMfbboBiK9RVIDZLBBoE
         Hg4Fod03DVnPWh0BfoqkAvVZDtD5VqPPFbhO7hNXdK7tSh0OZtC7KVMyNASFp5p3eWSS
         OhoLrRzPrSnj5cdXyv+BCDTmd587/z242tzXz5GnCJhJDypUywXiW2gleV61HvBaFMZN
         R//R1K0sgLYXWmPRycyKxP/pj1FejrPvRiVVfY7/hYPLC/7HDRpNHblK4/KckJfNNTg3
         o75azCZXhwtohXYvRs1JScakTzHYExNgRX2855Jpf5n/IbVUtNUmKOYeHgps/pfBVJDr
         SQqA==
X-Gm-Message-State: ACrzQf2XHHzOxc8f1IEAJ/RZDp2SdKgnOKuL/9mtV14aqeKUaIzNpS+R
        7+oWI8ullPf5TEtzdT1BOqe3CxITY0BHXCCdhyClfcDIvtGQdLOo
X-Google-Smtp-Source: AMsMyM5ASrW8KngH6zHhALVfOT24tHVvrJyYquWz0ojVtR3QzkQwj5kq72YxkUdEtn7Fxp6g8LQJM/1sJfWzRLUuJh8=
X-Received: by 2002:a17:907:2672:b0:734:a952:439a with SMTP id
 ci18-20020a170907267200b00734a952439amr5934261ejc.539.1665951572560; Sun, 16
 Oct 2022 13:19:32 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1381.git.1665590389045.gitgitgadget@gmail.com>
 <pull.1381.v2.git.1665734440009.gitgitgadget@gmail.com> <xmqqczaube8o.fsf@gitster.g>
In-Reply-To: <xmqqczaube8o.fsf@gitster.g>
From:   Tao Klerks <tao@klerks.biz>
Date:   Sun, 16 Oct 2022 22:19:22 +0200
Message-ID: <CAPMMpohWE17xk4fF+uQja0jfn53bjgVtg75FKEC1w0Km7U8Dvg@mail.gmail.com>
Subject: Re: [PATCH v2] RFC: mergetool: new config guiDefault supports
 auto-toggling gui by DISPLAY
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 14, 2022 at 5:45 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> >      * In git-mergetool--lib.sh the way I implemented the "auto" special
> >        value means that if you put an arbitrary value in the config, eg the
> >        typo "uato", you get an error about it being an invalid boolean
> >        config value; is that OK? Is there a better way to handle "boolean or
> >        special value" config validation? Are there any examples?
>
> I think the ideal behaviour would be:
>
>  * Unless running difftool and difftool.guiChoice has a wrong value,
>    or running mergetool and mergetool.guiChoice has a wrong value,
>    we should not even complain.

This is how it behaves right now, yes.

>
>  * If the command line says --gui or --no-gui that makes the setting
>    irrelevant, it is OK for us to give a warning to remind the user
>    that they may want to fix the spelling of the variable, but
>    otherwise go ahead and perform the action as they asked us to.

In the current implementation, there is no warning if the choice has
been explicitly made - there is no reason to check the configured
default under such circumstances.

>
>  * If the command line lacks --gui or --no-gui, we do need to have a
>    usable value in the configuration, and we should error out
>    without spawning either gui or no-gui tool backend.

This is *not* the current behavior - currently an error is printed,
but execution continues with a no-gui default. I will correct this.

>
> It may be usable without the second one and always fail difftool and
> mergetool until the setting gets fixed, but that is less than ideal.
> We do allow less than ideal code in, as long as it is an improvement
> over the status quo, and its presence does not make it harder to
> later get closer to the ideal.

Thanks for the logic table, sounds good.

However, my concern was with the precise form of the error if a
configured value is neither trueish, not falseish, nor a case-tolerant
form of "auto": under such circumstances, instead of a dedicated error
message along the lines of "fatal: bad config value 'autod' for
'difftool.guidefault' - must be boolean or 'auto'", we get the
*default* error message for *boolean* config settings: "fatal: bad
boolean config value 'autod' for 'difftool.guidefault'". This can of
course be corrected, I just need to work out how, and exactly what
form the error message should then take.

Should we be elaborating an error message for this specific tristate
config value, or is it "normal" fail with a slightly-misleading
message suggesting it is a simple boolean config in such cases?

Thanks,
Tao
