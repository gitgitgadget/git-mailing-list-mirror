Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F28C8C00140
	for <git@archiver.kernel.org>; Thu, 18 Aug 2022 12:45:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244459AbiHRMpu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Aug 2022 08:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244180AbiHRMpt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2022 08:45:49 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A69E1647A
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 05:45:48 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id s11-20020a1cf20b000000b003a52a0945e8so872393wmc.1
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 05:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc;
        bh=renzpfUrfDoB2ClOk3eISjrbjGeaT7/oi/PtQ579Tvg=;
        b=Ny0nEe3OgXUJv0NVcimvvouWq6XapwiMDOysm+JzSOHvfSJJ/vNd4Kac8D6m7xY5RE
         1RIYyIiXwH2UWWSVSuRTmZY+chrsY0Dl8gCo+iMiLEtyVi9EATFk8yJ+kqT2Y/nGstap
         thbEaMUVM4reu94MFh9xSOPscwz5kQjpTLTt+RqoZ4uzpB9A55HuWkUY07nnBALQ8hJW
         T7izmTRN3tvjiXQOS/+5Am6pals2QULTgChi3gedQ9hN+CIcdfxbabHTtybzCtLUYOaR
         RbWyVafa9izufpbMFXI2p23Zc8+wTE2HCdd6mODoGJk1YKNbBzzJNQgRF2CPoPH1eH/z
         tRbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=renzpfUrfDoB2ClOk3eISjrbjGeaT7/oi/PtQ579Tvg=;
        b=O6Nfkdc2gAqCd367EVyNgW41xeqz4n5jUgKXv37uqtxTLuu/XjwEkE4POQ4nStOeKZ
         he9J++CukiomiPA55qPYupMYEZbHCdLCL7uW2fmMZI1uhO1q9Fcw+PP34GdSuXohX92d
         PNBUAKzQz275ZdhXav64a7eZREcn+HMcVmlPr0r+L8sI5CNRDlBAPeEem6P58eWNloGE
         LPUs8+s0HeayUp+HhDt7r4ZdEMGCo0H4O4jTyfUo/TXw2UnbgC6rlJUtkQt4JtcnvX8G
         j4SJpSf9RbHOuxJug73iQ5f3kAGqum1rxZNIvNb0w97H0k4ZQfZErqt0wxf3/fa8Hely
         Yf+A==
X-Gm-Message-State: ACgBeo3q+UaxybKTMNQc/oMb7imUHKaQ5K8RYJqBgAgKp9Zq+Fv1nzcq
        zy9JhTnQx+SezZ0uCc6aAhAXlfP3QWKvYA==
X-Google-Smtp-Source: AA6agR6EECGmEIgLTAzKRFq4d16kjgYTFHx3dS/vD3uUNcKF8cJqpKLqmUXmN/Lac7sqTbTca4s7Tg==
X-Received: by 2002:a05:600c:a43:b0:3a4:d07e:1151 with SMTP id c3-20020a05600c0a4300b003a4d07e1151mr5045644wmq.169.1660826747043;
        Thu, 18 Aug 2022 05:45:47 -0700 (PDT)
Received: from gmgdl ([213.220.124.15])
        by smtp.gmail.com with ESMTPSA id j14-20020a05600c410e00b003a50924f1c0sm2162513wmi.18.2022.08.18.05.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 05:45:46 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oOeu8-000DKk-0R;
        Thu, 18 Aug 2022 14:45:44 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>
Subject: js/bisect-in-c (was: What's cooking in git.git (Aug 2022, #06; Wed,
 17))
Date:   Thu, 18 Aug 2022 14:42:53 +0200
References: <xmqq7d36s31e.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqq7d36s31e.fsf@gitster.g>
Message-ID: <220818.86czcxafew.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Aug 17 2022, Junio C Hamano wrote:

> * js/bisect-in-c (2022-06-27) 16 commits
>  - bisect: no longer try to clean up left-over `.git/head-name` files
>  - bisect: remove Cogito-related code
>  - Turn `git bisect` into a full built-in
>  - bisect: move even the command-line parsing to `bisect--helper`
>  - bisect: teach the `bisect--helper` command to show the correct usage strings
>  - bisect--helper: return only correct exit codes in `cmd_*()`
>  - bisect--helper: move the `BISECT_STATE` case to the end
>  - bisect--helper: make `--bisect-state` optional
>  - bisect--helper: align the sub-command order with git-bisect.sh
>  - bisect--helper: using `--bisect-state` without an argument is a bug
>  - bisect--helper: really retire `--bisect-autostart`
>  - bisect--helper: really retire --bisect-next-check
>  - bisect--helper: retire the --no-log option
>  - bisect: avoid double-quoting when printing the failed command
>  - bisect run: fix the error message
>  - bisect: verify that a bogus option won't try to start a bisection
>
>  Final bits of "git bisect.sh" have been rewritten in C.
>
>  Expecting a (hopefully final) reroll.
>  cf. <20627.86ilolhnnn.gmgdl@evledraar.gmail.com>

The msgid here is typo'd, the correct one is
https://lore.kernel.org/git/220627.86ilolhnnn.gmgdl@evledraar.gmail.com/
(i.e. a "2" is missing from the front).

The more recent
https://lore.kernel.org/git/220817.86pmgzabv0.gmgdl@evledraar.gmail.com/
also has some more follow-up, and a proposed fix-up for one of the
issues I noted with the series (the completion helper interaction with
the new "bisect").
