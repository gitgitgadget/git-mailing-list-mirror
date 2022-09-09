Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 690E1ECAAA1
	for <git@archiver.kernel.org>; Fri,  9 Sep 2022 22:52:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbiIIWwN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Sep 2022 18:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbiIIWwM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2022 18:52:12 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FBEB25F0
        for <git@vger.kernel.org>; Fri,  9 Sep 2022 15:52:11 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d12so3089396plr.6
        for <git@vger.kernel.org>; Fri, 09 Sep 2022 15:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=Nhfy3batfC1f1FTQjk6WfYiI5Ym9vAMeiciqiEpyRPY=;
        b=nvXqAwSlrPpO/N/XNF9meYlyVH12fAu/ff+MTaqZBNwPPu/ljw79yrcsOzz9kMzFiK
         zK+LjqYFCP0HuUYemSaaL41+PBgM4t+IcUc+VPXJg8lAzjM7h92aVgByp36ks0gGk4Xj
         kuWtXJz0N6/ZRzUq2m+WnPVGdG5j2nlyBr56d+hiLaX3uhwD9+rUMxj15oPzVCbmd7io
         f2w4KUUpc6Qm3h66nMS87VavBaGCDbO6PkTbktlF8azrtTTeEc32sRmY9wN3M1cF0c+8
         lSXNZf12mYboiwXOEvK45hK5vlM1ICLeFOAxAYb0W5ncXizb947A1HT/LOgGEeG3QpWp
         +2kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date;
        bh=Nhfy3batfC1f1FTQjk6WfYiI5Ym9vAMeiciqiEpyRPY=;
        b=pROAgxrHjQjrD51OUXkUG98zz7Q+YFdrrWdVA5E9o3mlZEjh9+PUfEUX3vSe0AcP0M
         +c0JjL8+z2Nrc7b0VHOZ4PiOGi2YHO4hdBa94BSR5M9LfFox5aUAnT5Nx1P9fLx7cfzX
         Kxy+YACyCW/PluE+UnDUq9c7m+3HMyWaImOoo9Z9wzr0IS0ynvXlctPRA7tjOGh4vkzb
         8c25CtUiWIncyxitRQzkQUjhgwfZGn/N6sDM4RgYE1r5vygkHQjBp+kgomjDblX7rq3H
         GvWjofBEXI2MG8ue52Fu7DvFwdiX3hiz+VNfl8s0JARy7lIl8qZONglP7VoBeJh5RENx
         QkNQ==
X-Gm-Message-State: ACgBeo2djuxhns5B9KEOMnAwlFMOgFHHR/eMAgAOvUAH99ssVsFWh11y
        16CV1WP4UVsAqoS53oFKDj0=
X-Google-Smtp-Source: AA6agR6XUGlVUyBZi+wu+qWmAqKyk4MBnfb2iNXGekDHK1sOa+C3NNrlyv7iOZBiWc7g+kJ/18kpJw==
X-Received: by 2002:a17:90b:1e47:b0:200:b9b4:ba0f with SMTP id pi7-20020a17090b1e4700b00200b9b4ba0fmr11996434pjb.245.1662763930507;
        Fri, 09 Sep 2022 15:52:10 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id q17-20020a17090311d100b00177f5eb0718sm983105plh.115.2022.09.09.15.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 15:52:10 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Cc:     derrickstolee@github.com, git@vger.kernel.org, peff@peff.net,
        vdye@github.com
Subject: Re: [PATCH v3] builtin/mv.c: fix possible segfault in add_slash()
References: <20220908230223.239970-1-shaoxuan.yuan02@gmail.com>
        <20220909222736.279362-1-shaoxuan.yuan02@gmail.com>
Date:   Fri, 09 Sep 2022 15:52:09 -0700
In-Reply-To: <20220909222736.279362-1-shaoxuan.yuan02@gmail.com> (Shaoxuan
        Yuan's message of "Fri, 9 Sep 2022 15:27:36 -0700")
Message-ID: <xmqqczc4i2jq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shaoxuan Yuan <shaoxuan.yuan02@gmail.com> writes:

> A possible segfault was introduced in c08830de41 (mv: check if
> <destination> is a SKIP_WORKTREE_DIR, 2022-08-09).

This iteration looks good to me (v1 was sufficiently readable
already but an extra explanation made it easier to grok).

Thanks, will queue and let's merge it to 'next'.
