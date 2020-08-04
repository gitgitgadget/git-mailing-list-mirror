Return-Path: <SRS0=W4Po=BO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7960C433DF
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 22:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA3BF2086A
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 22:26:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="punM9f6d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbgHDW0e (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Aug 2020 18:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbgHDW0e (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Aug 2020 18:26:34 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA77C06174A
        for <git@vger.kernel.org>; Tue,  4 Aug 2020 15:26:34 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id t6so32469957ljk.9
        for <git@vger.kernel.org>; Tue, 04 Aug 2020 15:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=wib1dcx1M3fypPs0BHb2LVYLYYpDW1bn+f6NfGyGczA=;
        b=punM9f6dlb+cAIFPpJL7D0yyEcFzqQqPCLUaNJdU7yHtkmkefdMcvHL6N8ruQnRQWM
         /znCN9LKJm3hTwhyzGtG403ZkLde3LFnluODGdwZvyqmrgLcdfMzvPMfap+M6sl9a7j2
         8nN6zxNn2/ZodXV6DKpTiNfvQ0GsSTWlhzA2hu0UqGfEJzuF+cDZQVi1o7erigTiDF7x
         drgP/9StN2me2IQcWCpBX6RwtZ48drQUqnzP3JLAq9JcqkOmX8IjFZUTmtPZy3i2VjHH
         OqGbkae2hDmOFb/BOiozW6AVwaev5y59cpqlLdGhWgOhyvpXmpBV+hiVvrhRczlDqxxJ
         cKOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=wib1dcx1M3fypPs0BHb2LVYLYYpDW1bn+f6NfGyGczA=;
        b=RlGv1QfwtMZjhGsEhSKHRK8V45UnZsgUIqrnM4OuQE6DAKZlyWoi2JeLNrovPg3S/t
         GUEC+vtrUlSybqQxgqhj8eUWNScBLO7jjiD30jQdfyCZ07XQos0NJRx33Q7cxMPJNGf6
         +JnyrmThV2sECcmPwMzFPg9e1aJnNtEpVA/WhQ6EM6hYnH+0r8ZTDEoqFSoXSmWK8B7P
         4phyFprwksIk6KUn4DKzGMPR3FATMlE0CDBtDMZEGMqMK/2EA6vSRBAy+Ls2jnSNlJY7
         83YUc0Xhi5zT3Wda5ks7Z33o86jkbbfwkzQ/Vw1gwYOgRZ3e8oXDXJpVIbhouT/zyrIx
         EoHQ==
X-Gm-Message-State: AOAM5306POnlimsNA6350FvdqvSs64tQ+MEOGsKIs+l4iByfYuZifmak
        mDwVchALPKeKiRFqHjJncXTmZh+4
X-Google-Smtp-Source: ABdhPJxdQqqBuwnrSYl0GD2TnHtkaD3zYWYm+PYDfzRelAmUu59H8k1847wwcOhG/D5D9ifPWtNp1Q==
X-Received: by 2002:a05:651c:31b:: with SMTP id a27mr10643193ljp.455.1596579992132;
        Tue, 04 Aug 2020 15:26:32 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id 9sm146797lff.82.2020.08.04.15.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2020 15:26:31 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: [PATCH] revision: fix die() message for "--unpacked="
References: <20200729201002.GA2989059@coredump.intra.peff.net>
        <871rku3soc.fsf@osv.gnss.ru>
        <20200731230858.GA1461090@coredump.intra.peff.net>
        <87mu3drynx.fsf@osv.gnss.ru> <xmqqsgd5rlwi.fsf@gitster.c.googlers.com>
        <87o8nrybnb.fsf@osv.gnss.ru>
        <20200803180824.GA2711830@coredump.intra.peff.net>
        <874kpi47xj.fsf@osv.gnss.ru>
        <20200804195830.GA2014743@coredump.intra.peff.net>
        <87imdyxedw.fsf@osv.gnss.ru>
        <20200804220833.GB2022650@coredump.intra.peff.net>
Date:   Wed, 05 Aug 2020 01:26:30 +0300
In-Reply-To: <20200804220833.GB2022650@coredump.intra.peff.net> (Jeff King's
        message of "Tue, 4 Aug 2020 18:08:33 -0400")
Message-ID: <87sgd2vyi1.fsf_-_@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Get rid of the trailing dot and mark for translation.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 revision.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/revision.c b/revision.c
index 669bc856694f..d08cb5c0e9cd 100644
--- a/revision.c
+++ b/revision.c
@@ -2315,7 +2315,7 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	} else if (!strcmp(arg, "--unpacked")) {
 		revs->unpacked = 1;
 	} else if (starts_with(arg, "--unpacked=")) {
-		die("--unpacked=<packfile> no longer supported.");
+		die(_("--unpacked=<packfile> no longer supported"));
 	} else if (!strcmp(arg, "-r")) {
 		revs->diff = 1;
 		revs->diffopt.flags.recursive = 1;
-- 
2.20.1
