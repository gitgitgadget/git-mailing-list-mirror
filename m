Return-Path: <SRS0=cV3L=C2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E6A5C43461
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 18:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9131F206A4
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 18:15:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Drz2cQ7q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgIQSPY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Sep 2020 14:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbgIQSNU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Sep 2020 14:13:20 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A1BC06121D
        for <git@vger.kernel.org>; Thu, 17 Sep 2020 11:12:04 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id g4so3055340wrs.5
        for <git@vger.kernel.org>; Thu, 17 Sep 2020 11:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=oIbVZeD+rKTPRw8kMhl6aKlyG7opgOF8AOrpj9HWgls=;
        b=Drz2cQ7qpKhEI2uFItSvJA58G7Y2hlWHCWGTL+Z7Y46Vnmvb1G96bsN/+Z43WaYZ78
         sYXfZrDJJIMJFvnVMMJsVm2wAwzqrhWktgT6j5t0KWVRez1vpAhxwV26ttV02O/ZJMCI
         az2pbyxOVyOw3Dy51O2NFm1AgarZlZUsyCuCwK2Nh1CLncwXb3lmUwQBVLaY6lEBDsQE
         ivafnIpKOGD/46euEkrWDQu5XyBD3z7BDIaIuIkp15tsUUqFuNms0LeN/qLqg5GqOM6U
         E66epjjWoOTALEFJe9pu9i3qbQyNKFNKsqpCAyR6v2AV5JIS42BBAK4FdtHnJkSxmblU
         SVhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=oIbVZeD+rKTPRw8kMhl6aKlyG7opgOF8AOrpj9HWgls=;
        b=NVaGL4pkxMqVxCYFeBR4ZOBAhXkPVsbk4NEfWicgtc7vpMZA3TgpmgHheoLgJgyusk
         Q9ZtJGlkMknW3VUxDePNYY5Ly1t6cNlMNDVWmKyWNTk3t8vnqqFDIIChZBiiSF7GKp+O
         AjTGHErq+NCwRn4ISST8lP+hjEeDWwN9nzQV1vhMzDchApOjq74xm0w0xEEIf6wRRpTq
         tzfSs+DAYxQLaSxBmANjc9NoDP0fXPCHk3KxnVRxwlhOb4vG+pTdp54UTWcg9F8imCFW
         VlS+91E+iFSH+dOlb4ssdOXM44QylLyqMkJWuMo6toJcgEL+r7DDOo7HqJ86PQSfZteO
         XK8Q==
X-Gm-Message-State: AOAM5327mkSR3zNEvLmHagT4NvkJOOcdWB/SaKEF6V4fY2qs8bNgdQPE
        UJgR6bb0fUZ+1xDxqylnl0KNRvsM2Jw=
X-Google-Smtp-Source: ABdhPJwjeK2tIPq8FHheaAClCc2NJN9VnitwyDF+mgP0GwjbM2wKXGNM371yYMPsoaxSY4xSwDRwiA==
X-Received: by 2002:adf:b74b:: with SMTP id n11mr7912226wre.274.1600366323399;
        Thu, 17 Sep 2020 11:12:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b64sm413844wmh.13.2020.09.17.11.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 11:12:02 -0700 (PDT)
Message-Id: <20a74abd96795d66acc19ea780864cd5f4ea6a2b.1600366313.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.695.v5.git.1600366313.gitgitgadget@gmail.com>
References: <pull.695.v4.git.1599224956.gitgitgadget@gmail.com>
        <pull.695.v5.git.1600366313.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 17 Sep 2020 18:11:52 +0000
Subject: [PATCH v5 11/11] maintenance: add trace2 regions for task execution
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/gc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/gc.c b/builtin/gc.c
index 4db853c561..090959350e 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -927,10 +927,12 @@ static int maintenance_run_tasks(struct maintenance_run_opts *opts)
 		     !tasks[i].auto_condition()))
 			continue;
 
+		trace2_region_enter("maintenance", tasks[i].name, r);
 		if (tasks[i].fn(opts)) {
 			error(_("task '%s' failed"), tasks[i].name);
 			result = 1;
 		}
+		trace2_region_leave("maintenance", tasks[i].name, r);
 	}
 
 	rollback_lock_file(&lk);
-- 
gitgitgadget
