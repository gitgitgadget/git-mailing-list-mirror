Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B067CC4167B
	for <git@archiver.kernel.org>; Sun,  1 Jan 2023 04:07:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjAAEHH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 31 Dec 2022 23:07:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjAAEHE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Dec 2022 23:07:04 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1235160F1
        for <git@vger.kernel.org>; Sat, 31 Dec 2022 20:07:02 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id 17so26062502pll.0
        for <git@vger.kernel.org>; Sat, 31 Dec 2022 20:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RQc+dRWyL8ktAF61WKJ/hf9uGBnWtRX/n2x36vZMtR4=;
        b=aBUkVWw4fRDRvrwHmH+XOjEcxC1/ZIsA5yLr6K2/fJ2ymqYoYYkqGqxvGlrj+kQ5DC
         a1DZd1yYITFjcrkPqfmsLVPGTmMzrF08jnTVAvzMz6W4vs9fGuWJtwlnCO54iwT8aysR
         DfU+Dfif+fWQaVJI5sq4wj6cOw46yB9CIWY4/lleMx//bRaRWjgoHbmKcm7wBSUwDQQl
         YLQfVcJPJPx6pmajSzkeV4b7tdTyjJ7mP7G2UM7ih2nEzmsPLZuArzI507WxCB7bMF4a
         /oaqJll9a0TTGl4T3nYeqBTr48CXOtcuDtl+oml7h9BDfgW6Xmz4Wk1xRsrPhs5T0Mpu
         eIsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RQc+dRWyL8ktAF61WKJ/hf9uGBnWtRX/n2x36vZMtR4=;
        b=ml5MDLYOjs8SfTIRuEt7K9ECizbvGR/ngg2KGgT4LndEmbnbVEtlqp+4BBCkiPq1Oo
         zWfT5nZfaDEJN3yLrCHl//+X7dDU6d42UzgJ7GN0cP9T69iCznZ3Fnqe43MxmN1yOJk3
         l2+Ut3iQH01GUaeMnYbh+Y6Ey14nwjmqu90kVqACbelKSPOgk+DtymtUgqDDraGYeVv9
         f3ZL67Qwwnua6UkS5xo8BJWIyVoiHlQ1hOmUb5Rh8XT+958pNzyRKnLB3Ua1h9t4G2Yw
         NuyQXRPoQjUS75pWgzzAuxX6U+9OZzop5tKT+CW38Lhxo23b8JELgBMOIMbuBueqnNDc
         AnYw==
X-Gm-Message-State: AFqh2kqyuJnN9URu2gWtaU9OemOJ0vuW5CoK/whcAt1U9JWDm56mS1LW
        5MbBjTs6pbxz8/FJXSouC11WIEsKiYJMBA==
X-Google-Smtp-Source: AMrXdXu4Sq6UxGnJX5SuEmyZkECpckCl0JJIT2QnBqxt8n0+HYiqNNhfPUXGmJLs18+/iLaLNz14HQ==
X-Received: by 2002:a17:902:cf02:b0:191:283d:5afb with SMTP id i2-20020a170902cf0200b00191283d5afbmr39466177plg.50.1672546021423;
        Sat, 31 Dec 2022 20:07:01 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id p15-20020a170902780f00b00189371b5971sm17522245pll.220.2022.12.31.20.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Dec 2022 20:07:00 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Samuel Wales <samologist@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: is this data corruption?
References: <CAJcAo8tjMLFisK5_13iD_JGo2xVQDJRX3wAC7wRD_V2GKFGevQ@mail.gmail.com>
Date:   Sun, 01 Jan 2023 13:07:00 +0900
In-Reply-To: <CAJcAo8tjMLFisK5_13iD_JGo2xVQDJRX3wAC7wRD_V2GKFGevQ@mail.gmail.com>
        (Samuel Wales's message of "Fri, 30 Dec 2022 17:17:51 -0700")
Message-ID: <xmqqlemmhp97.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Samuel Wales <samologist@gmail.com> writes:

> the problem that seems like data corruption is that a few lines appear
> twice as - and once as +.  but in the current version of the files,
> those lines exist only once.  here are the lines.  there are 2 -
> versions and one + version:
>
> +***************** REF bigpart is a partition
> +biglike and homelike are distracting nonsense i think except
> +to describe inferior filesets.  anomalous subset of home
> +might be called homelike or so.

Sorry, but I do not see any "-" versions in the above.  Simple and
minimum reproduction recipe would be useful for the list to help.

https://www.chiark.greenend.org.uk/~sgtatham/bugs.html

Thanks.
