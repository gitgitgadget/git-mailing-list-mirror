Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3556C64EC4
	for <git@archiver.kernel.org>; Mon,  6 Mar 2023 23:57:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbjCFX5I (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Mar 2023 18:57:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjCFX5H (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2023 18:57:07 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F386B324
        for <git@vger.kernel.org>; Mon,  6 Mar 2023 15:57:06 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id y2so11553046pjg.3
        for <git@vger.kernel.org>; Mon, 06 Mar 2023 15:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678147026;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=02D1rmefu4NpPIh2NkIpHFQ5g9fRa/HVJ3Xijf5Nxhg=;
        b=Li6p6wORINnBQn5cVVjL/LHuIxbn5HN7HTxrrE7djBPSN1fd4WD36RaLRprNxFhWFE
         Ztsou7PzAjTeQ4OmvZDNgSMsERmQcRiLo1BFeUUbCVB1FziZqO05IjII8d3V3K3MLPQp
         8tif+f72DAn2VX681K/Y0uJBHQnZPebED/wrN4xQ/VguMUOLLBye/zadjgRbpwtCTGDZ
         eb59n3viZpfnPimSLAgnLd1/I9Qlh+DT+kGNEoiWF1/na/rAbtt3oHPmrzIMAV6pbamr
         gTVrgDt90cgVFlAv9geizLGxpUXHDweRqF1AHSfSuSLk0xI+r+rStttVy1qCbj4a9Gpl
         mPOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678147026;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=02D1rmefu4NpPIh2NkIpHFQ5g9fRa/HVJ3Xijf5Nxhg=;
        b=H6FhhKrgyQ8hrB9JqNrg5tonv5Ero5HSYtT2Hnau/cQtJ2b7/es5/5X8K+wYA6VvDQ
         T44JEageuQgdHCsCDIxyy0QNECBpUs7ggnaV6WVqSBgLnf6FDMLGX15iJkPGxC+pMHS3
         Ur7v8md2X5US5vk3MfAoa7aWSnsmUlRxnWS9KWd43H6mfCz9EZsxMNNNaM+lU38wBp4W
         brN/uo0WzY+6oLIuBZ5Ej7SKdjBkM+XxMerX3SUvC+CCcaee/VVHbM6sh0VcZFFav7mA
         meECnnLl+rJfDK0WN22wG9K3Ur9Xi1tXMpYup3tv67YGtlm3m5GU6yD84TmmkLUnEVQy
         44UQ==
X-Gm-Message-State: AO0yUKU+3ruAj3+y7+ZhQfNWxS6UxXK3QF6851ThNTs89m3Ip4mPk6eY
        siDyukdY+ZzrE9MvJvyvor36lkTXn0Y=
X-Google-Smtp-Source: AK7set+frmqKrlps5veCJqi/XRCfeNnL1lU2jG85GWjkq0vsNyX4ToIvSU0rxbCrQgzL5NiDrgkFmw==
X-Received: by 2002:a17:903:22cf:b0:19a:bbd0:c5cc with SMTP id y15-20020a17090322cf00b0019abbd0c5ccmr15352865plg.60.1678147025863;
        Mon, 06 Mar 2023 15:57:05 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id kp11-20020a170903280b00b0019e53dd4f2bsm7246806plb.245.2023.03.06.15.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 15:57:05 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     Calvin Wan <calvinwan@google.com>, git@vger.kernel.org,
        Josh Steadmon <steadmon@google.com>, peff@peff.net
Subject: Re: [PATCH v2 3/6] tests: use `git submodule add` and fix expected
 diffs
References: <20230213182134.2173280-1-calvinwan@google.com>
        <20230228185642.2357806-3-calvinwan@google.com>
        <kl6lsfehihdv.fsf@chooglen-macbookpro.roam.corp.google.com>
Date:   Mon, 06 Mar 2023 15:57:05 -0800
In-Reply-To: <kl6lsfehihdv.fsf@chooglen-macbookpro.roam.corp.google.com> (Glen
        Choo's message of "Mon, 06 Mar 2023 15:34:20 -0800")
Message-ID: <xmqqlek977se.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> E.g. we could have ignored .gitmodules during the diff like so
>
>   test_expect_success 'added submodule' '
>           git submodule add ./sm1 &&
>           gitmodules_hash1=$(git rev-parse --short $(git hash-object .gitmodules)) &&
>   -       git diff-index -p --submodule=log HEAD >actual &&
>   +       git diff-index -p --submodule=log HEAD -- :!.gitmodules >actual &&
>
> and then we wouldn't have to adjust the diff. That would be my preferred
> approach, since it keeps the irrelevant details out of the test.

Yes, it certainly does make the diff simpler to read, but the
reasoning cuts both ways.

The end-goal of the topic is to propose that updating .gitmodules is
an integral part of "adding a submodule" and to make it impossible
to just add gitlink without a command line option using "git add",
so from that point of view, readers would expect that the diff after
"adding a submodule" to have both new gitlink and also a modified
(or if this were the first submodule, added) ".gitmodules" file.
