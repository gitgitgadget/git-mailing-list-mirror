Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD396C433B4
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 01:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6766961455
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 01:44:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234554AbhD2BpW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Apr 2021 21:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231874AbhD2BpV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Apr 2021 21:45:21 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA33C06138B
        for <git@vger.kernel.org>; Wed, 28 Apr 2021 18:44:32 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id s9so16590334ljj.6
        for <git@vger.kernel.org>; Wed, 28 Apr 2021 18:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=PdOxf1tIrLw93BRsmIdBrY48hsQji5yCqW/1RUlxedc=;
        b=KD6r96bb3XeVxaSyUEBv5/bXib1Tod06BVFz9uA/Cr0KbMo0hTOAb/opurX/M26rEw
         0UnXzrOGq5QXJNimIyjbVzIaHaN5KCQINP0Pk+oRxnNO1enYv0qXrvKpL/cM/EKNYmSC
         +pcljGdJckClmluvoAgseL4bLoilN5JqpIZoX3E+NmjZFFn6fQPGwgn9/ERNLZcNwPZ7
         H82rZfgfsl2u4A1KX0IsmFH4i0U9XZ3SdwQAvvM6S3hrD6NHFsZAO6XFlDdwaErgFD8Y
         /5AhhPebz4WQI06cZyPOXAlQ5/19k9ARRLLwRkn4mfVilDoJlNDsNwnVpyG6Xoo28uYL
         hIkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=PdOxf1tIrLw93BRsmIdBrY48hsQji5yCqW/1RUlxedc=;
        b=GwWX1XXTp3AxPCNwZydjTLTdvXeo/SvT4IIeyaLcbaGPTDXH0+d4uwPZq1HMVo8JbI
         d1pnZgPJcybTBrGyK44761FoBknyoTQtooJi4KB95MPVz0IdjZC/fG65Mk37YBR07PQr
         MFowUNgwAfdu4bMFPygxIf2u+qILrYMwTdh/ubb+694spYwJJHAfADgMdak9hS4jUYqx
         qenaq6LYFeK6XrNgkltpaCW7NA40XYvRkHC9ylKMJIPn83Z4G/Av59tOYvF+YL5wzRZ4
         n6IHFIMOvI/irRDSM3m3/3K8p6/KNHfi+tCKbcUUZAV/zjvRoWv0moHbiSZzQ/Hjpm94
         NLgQ==
X-Gm-Message-State: AOAM530Ejd0KWiybaiY15g6yngUD4NLahtQeBdN8nlFB0wswgSpPP60N
        h1Vg4xDZh88WafKifAxRHyRL55Sey41Ca5nqI2knDCkoeAnM5Q==
X-Google-Smtp-Source: ABdhPJzo+y3StOqrwu+bi+0lIvKv2MPZEeL1rhwn8sk79Z153+MWjoLHuqS5m+AMbpkxIPZ+n8+aBlfI5iDydPOz8hE=
X-Received: by 2002:a05:651c:1314:: with SMTP id u20mr22936709lja.36.1619660670665;
 Wed, 28 Apr 2021 18:44:30 -0700 (PDT)
MIME-Version: 1.0
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Wed, 28 Apr 2021 19:44:19 -0600
Message-ID: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
Subject: Why doesn't `git log -m` imply `-p`?
To:     Git mailing list <git@vger.kernel.org>,
        Sergey Organov <sorganov@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I read the following in `man git-log` today:

--diff-merges=separate, --diff-merges=m, -m
    This makes merge commits show the full diff with respect to each of
    the parents. Separate log entry and diff is generated for each
    parent.  -m doesn't produce any output without -p.

--diff-merges=combined, --diff-merges=c, -c
    With this option, diff output for a merge commit shows the
    differences from each of the parents to the merge result
    simultaneously instead of showing pairwise diff between a parent and
    the result one at a time. Furthermore, it lists only files which
    were modified from all parents.  -c implies -p.

--diff-merges=dense-combined, --diff-merges=cc, --cc
    With this option the output produced by --diff-merges=combined is
    further compressed by omitting uninteresting hunks whose contents
    in the parents have only two variants and the merge result picks one
    of them without modification.  --cc implies -p.

Why do -c and -cc imply -p, but -m does not? I tried to use both `git
log -c` and `git log -m` today and was confused when the latter didn't
produce any output. Could we change this behavior in a future version
of Git?

-Alex
