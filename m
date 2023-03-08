Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58879C64EC4
	for <git@archiver.kernel.org>; Wed,  8 Mar 2023 22:25:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbjCHWZT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Mar 2023 17:25:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbjCHWZR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2023 17:25:17 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92AC27D57C
        for <git@vger.kernel.org>; Wed,  8 Mar 2023 14:25:16 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id z42so18087911ljq.13
        for <git@vger.kernel.org>; Wed, 08 Mar 2023 14:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678314315;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=5rZ3l2vrcjdCrgZOnWl2UUlih2uetOOUa1w0hFuFucY=;
        b=KAxKmI4sBXqoeOJSRAZ1XYL/d7w1S5ykt7gxOqZmKixN972wfP3BgJpKXG/7jqFAZM
         1Cok0u3p2OeLrlKe9fuT9hAVeSHpRqKqmPfGe7+CY/AuwuFv8ZFh9uVcHoQm0JmGLfqc
         ZhlR6JW64wI3OesbwTyWnlrzbOqEYLGopB9mjZTj5tKmbktLBInFPPF9h4sChJiqEbd4
         lwyPC64hNI8mWQJXBmF4YfXgQwdkKncssiKsA1FNORFuZtyMfGPKZMSy21JgtjJdPIY2
         yQybddDHjTo3ViV1iLJvtRMixhaLFCaXORvhaL26lsJzocTvCy1qHD+o03OB1sI/q1Ul
         /upg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678314315;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5rZ3l2vrcjdCrgZOnWl2UUlih2uetOOUa1w0hFuFucY=;
        b=4YL3wr+n05O1d9HTZhXDlLF+3N62o87X2fxaJ2YIkZJJwzC3zbqaOk32GvMWlg9tb6
         cgdkwA42Ds1+tZprQRte2jxQbaWk/lZsylKdjCJtyScYgK30CJh6vNJW3NM/sHy3ZIZS
         qIKsbkGECwwn5ZNVX8312CPwaOEEijdE5bJzs0Sbemk0+RA3IsSkpLEJS+K8eAkn3PGE
         lzLZALXNZ32iKH7V13HZGH83XDZ1Cv2O9cq3jvaH/7b1+dNV8/u1V0pQS1WXyymngS5B
         xH7YMGjphQ8mWWpl6197iJjxsCSreTNMlvZgtV0tEpYkk/oLXhdkg4OO/vRhodc3/W90
         gy8Q==
X-Gm-Message-State: AO0yUKXoXvy2FMHbyY5fuM3LIPi6tr2C8C9G3Pc6CILKPmHxQnVLTeih
        eGpBeLGgzUim0adciRao080=
X-Google-Smtp-Source: AK7set+2J3488chE0iAnTF2lGKDudRGgv+Cvpse/3JovSRx1ZGE+Xj+kB3wLZueSYxPgi1yWoh8/sA==
X-Received: by 2002:a2e:be25:0:b0:295:c306:ec40 with SMTP id z37-20020a2ebe25000000b00295c306ec40mr7640449ljq.34.1678314314704;
        Wed, 08 Mar 2023 14:25:14 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id q22-20020a2e8756000000b002986f36dd6bsm373808ljj.59.2023.03.08.14.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 14:25:14 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     git@vger.kernel.org, tao@klerks.biz, gitster@pobox.com,
        newren@gmail.com, phillip.wood123@gmail.com,
        Johannes.Schindelin@gmx.de, chooglen@google.com,
        calvinwan@google.com, jonathantanmy@google.com
Subject: Re: [PATCH v6 1/3] rebase: add documentation and test for
 --no-rebase-merges
References: <20230225180325.796624-1-alexhenrie24@gmail.com>
        <20230305050709.68736-1-alexhenrie24@gmail.com>
        <20230305050709.68736-2-alexhenrie24@gmail.com>
Date:   Thu, 09 Mar 2023 01:25:13 +0300
Message-ID: <878rg6zxrq.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Henrie <alexhenrie24@gmail.com> writes:

[...]

> +When rebasing merges, there are two modes: `rebase-cousins` and
> +`no-rebase-cousins`. If the mode is not specified, it defaults to
> +`no-rebase-cousins`. In `no-rebase-cousins` mode, commits which do not have
> +`<upstream>` as direct ancestor will keep their original branch point, i.e.

I realize this is in fact unchanged from the original, so is not exactly
material of these series, but what is the meaning of "direct ancestor"?
Is it just "parent"?

> +commits that would be excluded by linkgit:git-log[1]'s `--ancestry-path`
> +option will keep their original ancestry by default.

Excluded when --ancestry-path is applied to what commit, exactly? To the
commit being considered for rebase, or to the <upstream>, or to the
'fork_point'?

Please notice that rebase claims to operate either on <upstream>..HEAD or
'fork_point'..HEAD range, and --ancestry-path without arguments applies
to the left commit of the range when used in "git log".

Looks like some clarifications are needed here, even though maybe not in
these series?

Thanks,
-- Sergey Organov
