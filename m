Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D48E7C77B60
	for <git@archiver.kernel.org>; Fri, 28 Apr 2023 10:01:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346025AbjD1KBP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Apr 2023 06:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346000AbjD1KAw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2023 06:00:52 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42DFA5FDD
        for <git@vger.kernel.org>; Fri, 28 Apr 2023 03:00:24 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1a682eee3baso71029455ad.0
        for <git@vger.kernel.org>; Fri, 28 Apr 2023 03:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682676002; x=1685268002;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VrHkHd0eGZSXWXtw2dIzyeEcDhXL6Msk+x1v6KMtbGg=;
        b=plWwl7VCp/oe0kcLOaByE/WiMeLhFqrPUyC2H/EI8juQqdPkSk0rZdBGCL0wpC6MMW
         svA/zNa6yO/ovj4DoAHiSapyhj5QB9tM/7xwzLkxAQuVgvG5N0Pi3eCTr9MeaSKH8/9Q
         1ayq+RkDkwVPoqczv1kbJNr6TotaKvQmzI31KfaakbY0tG9FuZFBc6P9f+RF2mf2u+Eg
         YWO2ioxlqJFVNitsWzvoxTzpLv0B787O4ywkOu3arS1A6pjGEYa2xOBwdTX3UGOp9IOa
         pNJUMstF+8WYPkwl8OzlYcnFx+fY+hGrpr4qRi6oBA+8CJ5K35zQbT+5f7MgTT0tzzLZ
         M8aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682676002; x=1685268002;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VrHkHd0eGZSXWXtw2dIzyeEcDhXL6Msk+x1v6KMtbGg=;
        b=QLccSZ15Jeb8w0D/SccQejAPfC17DaRA0wYlrZAcvObxV4TDVnX5k0Ev/hDXaZPSDB
         +3DA0T0EW/1en3kGMLVOIEBEmJo4g+lHnTFS+7REJeZ7SLU90IdYRNzLLSeYl3FlU1Z+
         edrvlZ3Asc2+MptHA2adVYJ7xyEW83NzSsfS2AsdV2fAXaatd/zWv93HOyVR79jqwcrd
         al3lhb5yIkOk6fwwtNdKznoxuGLK1B53Hir8jd+UR0kEgMA+1W7VomrgDtlWgF7NbUak
         DfKjAZGtYoGIuh9RA8E57KhMnZNvZvVVRp2oLsbM3dEpCixTSIxIrHyOdJw7121Ha+Gv
         XWwg==
X-Gm-Message-State: AC+VfDzssry6iHiDzb1cnKlpC6Z0BnLMoLxwTuHuJjIaIGsvpqonGIHW
        NvAsDO2YyMs71UaJMXr9ubk=
X-Google-Smtp-Source: ACHHUZ5TC6axN+kbFXadhIRLqBOOSOoj5+xHCBOu3SQsK3IND1rCGsF+jbcsMWG5Q/lbGPU2Xu8SAg==
X-Received: by 2002:a17:902:a50f:b0:19a:9880:175f with SMTP id s15-20020a170902a50f00b0019a9880175fmr4281683plq.51.1682676002058;
        Fri, 28 Apr 2023 03:00:02 -0700 (PDT)
Received: from localhost.localdomain ([47.246.101.51])
        by smtp.gmail.com with ESMTPSA id ju18-20020a170903429200b001a526805b86sm12968364plb.191.2023.04.28.02.59.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Apr 2023 03:00:01 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     gitster@pobox.com
Cc:     --cc=avarab@gmail.com, dyroneteng@gmail.com, git@vger.kernel.org,
        me@ttaylorr.com, tenglong.tl@alibaba-inc.com
Subject: Re: [RFC PATCH 0/1] push: introduce '--heads' option
Date:   Fri, 28 Apr 2023 17:59:55 +0800
Message-ID: <20230428095955.66292-1-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.40.1.445.gf85cd430.dirty
In-Reply-To: <xmqqilippgp2.fsf@gitster.g>
References: <xmqqilippgp2.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>My knee-jerk reaction is to avoid "--heads" and instead use
>"--branches", if this is about pushing all local branches.  The
>option "--heads" may still remain in some commands added to the
>system in the earliest part of our history, but soon we started
>to use "branch" over "head", as it is a more commonly used word.
>
>How should it interact with --follow-tags?  Just as if you listed
>all local branch names on the command line?  I.e. is
>
>    git push $URL --heads
>
>equivalent to the long-hand
>
>    git push $URL $(git for-each-ref --format='%(refname)' refs/heads/\*)
>
>and because of that, does
>
>    git push $URL --any --other --option --heads
>
>behave identically to the long-hand with these other options added?

ZheNing Hu mentioned me that could use "OPT_ALIAS" instead, it seems
like could be better than OPT_BIT in this scenario. If so, are problems
that may arise from interactions shielded? If not, I'm willing to add
extra test about it (some relevant advice if possible).

Thanks.
