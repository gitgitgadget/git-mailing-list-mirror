Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3582EC7EE22
	for <git@archiver.kernel.org>; Tue,  9 May 2023 22:29:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234872AbjEIW2w (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 May 2023 18:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbjEIW2v (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2023 18:28:51 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A042697
        for <git@vger.kernel.org>; Tue,  9 May 2023 15:28:48 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6439e6f5a33so3630469b3a.2
        for <git@vger.kernel.org>; Tue, 09 May 2023 15:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683671328; x=1686263328;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pMXYBD9jC2McG2Legqur7dKRkgXwkmqFIpaljMqCOJU=;
        b=nWRERzQIQnCWakSjBtOA47saUBr/IbiejX5FU5bkaZbuCgCJriDtPfgMaydnBy4l8h
         jqECdE4vRzPf4haRX1R+fw0cj/z7Z0rDVBgIflkr2Y6y9zk5OPqmLTxwiz8YALNlPI63
         hEL8OHhl1h54ulv7mRs59DD+pkKk8XgfuQ+T2oInwtWyqtWimG5+2/Lz+irNulJdwtyF
         Tp8IGVBzbbNj9YuypZN3ZVYyriQd/nKLHsRZjbapoEk3tknlB28Gauo7HRks2uTik5yP
         JN9l8t6Cgd9e4lLb3UlW4+UaFGMU5Uygk6+mTM3t0EA/6bv76oh7DzsrnIDZUde2LFTF
         ibYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683671328; x=1686263328;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pMXYBD9jC2McG2Legqur7dKRkgXwkmqFIpaljMqCOJU=;
        b=HJk3eI9L4MU+9Fz+rMLa04zWfNhoa/G6P+QHctkWn1hNOTjiz87h/wfT6qlHjYvDXA
         32s6il4NL2T3oQNlHO3DsI+K2BbUomsl0XgiGsjFpW+A6fLIxfhea7UbJLiNaRO6mdza
         FQhe3zHsYDVw6pNFW1fFXomIql+LUIKzHtd72T4WMk1p7O6lJA46iqka/pIqi5EsSg3w
         LuddPIz7e9DZW7T06SMQDG90ZEgG41pIP//P9xR2517vmNj3C8918Wt6hJtY+110F6P4
         rpaJvKHj08TmwZ1Gh5v4DpT6mYneJJStlfRg2tg3JkpZWh8xEFx4YnSVNVcqmi18pW8f
         RHXw==
X-Gm-Message-State: AC+VfDwlEW4DvwHpGrEIh1lEqktfs4YfVk6lBTM1KFGk3m+IJQEMvErT
        GOGO0q345FfUTSLr5H9xlZE=
X-Google-Smtp-Source: ACHHUZ4QG1M5CvFNpog2Jl5arLfKplRS0obWlEBGmnXSXBla0BYqvCINoavIAgHeDbfhD4sjxyHPnQ==
X-Received: by 2002:a05:6a20:4326:b0:100:3258:d163 with SMTP id h38-20020a056a20432600b001003258d163mr12193330pzk.35.1683671328212;
        Tue, 09 May 2023 15:28:48 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id w187-20020a6362c4000000b0050bd9c8c53dsm1905381pgb.23.2023.05.09.15.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 15:28:47 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Calvin Wan <calvinwan@google.com>
Subject: Re: [PATCH v2 00/15] Introduce new `git replay` command
References: <20230407072415.1360068-1-christian.couder@gmail.com>
        <20230509175347.1714141-1-christian.couder@gmail.com>
Date:   Tue, 09 May 2023 15:28:47 -0700
In-Reply-To: <20230509175347.1714141-1-christian.couder@gmail.com> (Christian
        Couder's message of "Tue, 9 May 2023 19:53:32 +0200")
Message-ID: <xmqq8rdxuokg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> # Intro
>
> `git replay` has initially been developed entirely by Elijah Newren
> mostly last year (2022) at:
>
> https://github.com/newren/git/commits/replay
>
> I took over a few months ago to polish and upstream it as GitLab is
> interested in replacing libgit2, and for that purpose needs a command
> to do server side (so without using a worktree) rebases, cherry-picks
> and reverts.

It would help to include the following in future updated rounds, as
Elijah is shuffling the header files around agressively and these
patches do not build when merged into 'seen'.  When these two new
includes are added, the series would compile both standalone
(i.e. applied on top of 'master') and in 'seen' (i.e. with shuffled
headers).

Thanks.

 builtin/replay.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git c/builtin/replay.c w/builtin/replay.c
index 7699d28f93..62dd1f7fff 100644
--- c/builtin/replay.c
+++ w/builtin/replay.c
@@ -15,6 +15,8 @@
 #include "refs.h"
 #include "revision.h"
 #include "strmap.h"
+#include <oidset.h>
+#include <tree.h>
 
 static const char *short_commit_name(struct commit *commit)
 {
