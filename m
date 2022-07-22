Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3108C433EF
	for <git@archiver.kernel.org>; Fri, 22 Jul 2022 19:26:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235150AbiGVT0b (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jul 2022 15:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231784AbiGVT03 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jul 2022 15:26:29 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 054B37669
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 12:26:29 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id o12so6553957ljc.3
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 12:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g7Hgs0SU3P90j8Vxdl0YsGWNtffMcIbk5FTCKaoc3u8=;
        b=Tgd8btwAFTe2OPA+0WvEdrmDPm6fCkWKAlAKesbEnFcNILbkOh9xTSq2ADMkWmiRGV
         eMIf7MJ3KLv8BwekOo5vKTHKgs4fbfVRt6GLbFmgJKBPS2mJSDWv8uJ367fcaAJvJUpC
         6JNX1/j9r5VUe0C3GAihvSIrktVddR3jXAb0xYqqV5/dyvj5ozXAOLPEHHa55rmmQeR8
         4JNboAcWuTn4Qnw8nXYesesfIj3OnHudRosC5QJRHsS/4SnaLIKgBVnEvaII9NODweyS
         drEB9jYmFpZxRGUyL4bZ/lYA+9GmaqX14GX9G79K4giJXtwAG15z7E4zzK2yAUnixO1j
         vQFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g7Hgs0SU3P90j8Vxdl0YsGWNtffMcIbk5FTCKaoc3u8=;
        b=PL9E2jIRdFP5W215tY2pNjnhrY4oduqOU3Ni45cfazRcVd+qCKx0gpAHHbJYZgB3ET
         RthR2hGqRrmE7NRI5GOleRE9bdvWPjIrj7bLOH2wmtmyEC4WzDPA20QLTECbS505xukX
         yvRVl4GXOH1ly0fGAuJ18Dyh22H12fQkQNtKbM6kpYlPiUXeOoDe4j6vcq1QDoZbzf6Z
         XknMNwFWuqi2QUHoZB0qRYMMN+0ULTqjUKsnD6NGA+9/HGOcY+LCCgYQYUcg38NIhHIJ
         +FRK5r481FIYsA0hDw4GcyzQGHla541nLUrDrn+7tk8pjeKYxSY19B1/l/JrBAIpxefW
         8NXw==
X-Gm-Message-State: AJIora8FeIFiOkKW6d6vC0cOHxYbnQG9Z9Y8vlDBtFhRt2Ukt0hjz3+W
        hbIz5I2jXPI756xaDhxbGz8=
X-Google-Smtp-Source: AGRyM1sIUSEfQORaiLE8byEMQ8elZfe6GkeCRspih0nrWfHEzokKd67NV2NWTjEBAcJdrG2W9no0NA==
X-Received: by 2002:a2e:804d:0:b0:25d:d98a:a908 with SMTP id p13-20020a2e804d000000b0025dd98aa908mr541168ljg.4.1658517987040;
        Fri, 22 Jul 2022 12:26:27 -0700 (PDT)
Received: from localhost.localdomain (81-231-137-145-no600.tbcn.telia.com. [81.231.137.145])
        by smtp.gmail.com with ESMTPSA id t5-20020a2e8e65000000b0025bf4eddbb6sm1273317ljk.133.2022.07.22.12.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 12:26:26 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     Joey Hess <id@joeyh.name>
Cc:     git@vger.kernel.org, Tao Klerks <tao@klerks.biz>
Subject: Re: git write-tree segfault with core.untrackedCache true and nonexistent index
Date:   Fri, 22 Jul 2022 21:25:59 +0200
Message-Id: <20220722192559.718264-1-martin.agren@gmail.com>
X-Mailer: git-send-email 2.37.1.455.g008518b4e5
In-Reply-To: <YtrdPguYs3a3xekv@kitenet.net>
References: <YtrdPguYs3a3xekv@kitenet.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 22 Jul 2022 at 20:20, Joey Hess <id@joeyh.name> wrote:
>
>         joey@darkstar:/tmp>git init emptyrepo
>         Initialized empty Git repository in /tmp/emptyrepo/.git/
>         joey@darkstar:/tmp>cd emptyrepo/
>         joey@darkstar:/tmp/emptyrepo>git config core.untrackedCache true
>         joey@darkstar:/tmp/emptyrepo>git write-tree
>         Segmentation fault
>
[...]
>
> Bisecting, e6a653554bb49c26d105f3b478cbdbb1c0648f65 is the first bad commit
> commit e6a653554bb49c26d105f3b478cbdbb1c0648f65
> Author: Tao Klerks <tao@klerks.biz>
> Date:   Thu Mar 31 16:02:15 2022 +0000
>
>     untracked-cache: support '--untracked-files=all' if configured

Thanks for a clear description, and for bisecting.

`repo` is NULL in `new_untracked_cache_flags()` and we're not prepared
for that. The diff below fixes this in the sense that your reproducer
stops failing, but I'm not sure it's the best approach.

I can't help but think that e6a653554b was just unlucky enough to
dereference `istate->repo` and that the real issue is that we're missing

	if (!istate->repo)
		istate->repo = the_repository;

in some strategic place a fair bit earlier. It seems to me like the diff
below is just papering over the real bug. It's not obvious to me where
that check would want to go, though. Tao, do you have an idea?

Martin

--- a/dir.c
+++ b/dir.c
@@ -2752,6 +2752,9 @@ static unsigned new_untracked_cache_flags(struct index_state *istate)
 	struct repository *repo = istate->repo;
 	char *val;
 
+	if (!repo)
+		repo = the_repository;
+
 	/*
 	 * This logic is coordinated with the setting of these flags in
 	 * wt-status.c#wt_status_collect_untracked(), and the evaluation
-- 
2.37.1.455.g008518b4e5

