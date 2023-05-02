Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11667C77B7E
	for <git@archiver.kernel.org>; Tue,  2 May 2023 15:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234658AbjEBP4h (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 May 2023 11:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234650AbjEBP4f (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2023 11:56:35 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC05E10FE
        for <git@vger.kernel.org>; Tue,  2 May 2023 08:56:27 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1aae5c2423dso32204605ad.3
        for <git@vger.kernel.org>; Tue, 02 May 2023 08:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683042987; x=1685634987;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k4i0a5fy/rGKalkaYLw68S/KU544BMsb9kKTW1njW3k=;
        b=IOpbUBkiN8OwmCREe0LzsL22QqTHEFAOKw/D2OZqahBZIBDmW02SLTuBtVDBHgORlf
         IHubO9Mmcc7A9hRLaR5JrIcH9ooEDobnhZUVqlEF4ciuB0mD0w9st51tbOR0/i5Z+dGO
         Bo85cp56KWc69eJrGRotk3rm8GVSm52+NsEms/ZfcgZuEpDxeuMGW/orLM3ae5Ta3drm
         KExGliBHytIpUu6ZJJj+ZWRQiBoGoeQVnCviPMS5HH+tgR0BTOE3kSpOchzvNW+jcE2O
         v0DlQmbzDzTOiJzYrsEe42dmand22GjImZ9PYhPEGYGvhD51zk056UCvlrBxVNEsZSk4
         d/vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683042987; x=1685634987;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k4i0a5fy/rGKalkaYLw68S/KU544BMsb9kKTW1njW3k=;
        b=QzfS7clL3BQV/EG8nsmUuhdJSmOuDK81HCJeYzMTXch1acnvs57Ntl8r5cc/9gGUUT
         OpUj9VnR35wH0eXWO4/mqgBxyy3Oz+UR/7QyQTdXoeWkAyr4KaJ6Lk+0HtcZDlUGQMzp
         y8arQ9f2tThr4Bi3+awxLNoIh/xWjbdPmAZx6FsLx2mLK+vdzsO7VAf1zIoFqbRQt8lO
         sgXi3zdxQp/DysmshV137GYawBj2I6ftYmRoIwgwl1qpcsLv6wtcJHl0hJFV1Eg+x5hj
         L0FR8NgGrNtGnMUVF87XiupINKNjh8qaN7uVjyaZP2GYTz8OTLr7aEI8jz8MCZk76EJe
         7koQ==
X-Gm-Message-State: AC+VfDwKSXhHW6t806NDTI3+qMCnpVYQdHBsktoOP5xZzSzb9RcmrhCk
        GSwcB023hAFll3gb1gk+Q1I=
X-Google-Smtp-Source: ACHHUZ6xdR83FxUrraCUB+9gY+mut5p21IOioL6EQvIQcFQpXBgFMVpFUZ84xqwhTZcv01BrFZVMfQ==
X-Received: by 2002:a17:902:ab92:b0:19a:a520:b203 with SMTP id f18-20020a170902ab9200b0019aa520b203mr16890498plr.25.1683042987004;
        Tue, 02 May 2023 08:56:27 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id z12-20020a170902834c00b001ab05835b4fsm2174348pln.130.2023.05.02.08.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 08:56:26 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Calvin Wan <calvinwan@google.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Glen Choo <chooglen@google.com>
Subject: Re: [PATCH v2 12/22] tree-diff.c: move S_DIFFTREE_IFXMIN_NEQ define
 from cache.h
References: <pull.1517.git.1681614205.gitgitgadget@gmail.com>
        <pull.1517.v2.git.1682194649.gitgitgadget@gmail.com>
        <7b55f82e62ecf761b804432c8d08dffabbb7605f.1682194651.git.gitgitgadget@gmail.com>
        <230501.86zg6ohuw7.gmgdl@evledraar.gmail.com>
        <CABPp-BEPy4R1R1X1o1oMs6sEECVjEoLeRXripEi7k8ZO-CrbuA@mail.gmail.com>
        <CABPp-BHymt9COEjnTRTbg_vHa4s6-CL7Bh+9q0PfoiE0SRcRrg@mail.gmail.com>
Date:   Tue, 02 May 2023 08:56:26 -0700
In-Reply-To: <CABPp-BHymt9COEjnTRTbg_vHa4s6-CL7Bh+9q0PfoiE0SRcRrg@mail.gmail.com>
        (Elijah Newren's message of "Mon, 1 May 2023 22:00:14 -0700")
Message-ID: <xmqqr0ry20d1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> Although maybe I'll have to do it in a follow-on series?  Junio merged
> the series to next today, so...I guess I'll just add it to my "header
> cleanups" notes.

I am not Ævar, but it is so small a thing that is local to a single
file, we can wait until the dust settles to avoid distraction.
