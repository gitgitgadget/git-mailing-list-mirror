Return-Path: <SRS0=WOg5=AS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A59C433E2
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 06:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2950220739
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 06:05:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V4ILxsAV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728210AbgGGGFJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jul 2020 02:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbgGGGFG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jul 2020 02:05:06 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506BFC061755
        for <git@vger.kernel.org>; Mon,  6 Jul 2020 23:05:06 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id o38so30903175qtf.6
        for <git@vger.kernel.org>; Mon, 06 Jul 2020 23:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sgo7WNu2r3te8+uwmFrMuip8L4ZIsuLTKZ/ygE5LUj0=;
        b=V4ILxsAVyaFUZLKot4PmigxsqRsbIWnSqFUmEjvhQ0iXOW551qLbLylgpGDLobITN4
         /k6oOGeKQ23pFuWsK8xia3MMxTLY/n8KdRpmQ1a58wVlhEo/4SykaE+WRREtOKsgTUiD
         6a9a3M/HZpDyrw1HymKdLgjrIkhd5YaVPQ2V3NT8orPqnlRof+fOtJe74L4/WrooU5fS
         7x0lRYibECoRetILF79DN4yVFVH90OiWhXldjxpAfr+2wneMaqJoex/QXG7R/Tutyu2Q
         OxtJuIXepAn+PTOrGTP7udrKb2DZTmnxkoMbwL5jLE00Ii82xJO/Zzl1+vd0sXY9lO0e
         LIrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sgo7WNu2r3te8+uwmFrMuip8L4ZIsuLTKZ/ygE5LUj0=;
        b=Yp7zK520WW1G7A3FNt1I7MjAo/sYGVyO4FjpYWbuCeykNR4fqGmT+jdUhAoG5YaFjC
         UmsPKQ8leU0I6czfKViOL1MZiCChYX0POdLSdUGef0xZk+WxNxCuo+CIL3xZb/sGCSan
         dGSzbMdap7lBizhoBxDz8SULJow0l1UkIpSb31Ox6RM2VRFDVJ50bDcLeT+yDDv5pT7s
         9tR4XYNZC773hV2nW0ptEZvq6d8GFdbimMkKTXjoLxk2sss18OSomzk4QE1alDcOaZOd
         lc3igL2eyKaa1BuH5doXypvvFFZTbP07FwAsDGLekfGrWVll19oD8aQlIStE6r6+lM6d
         IXlQ==
X-Gm-Message-State: AOAM532y1EmaEvU1H96C3i46BuNQwu0eXDq985TCqMcs8FLJ8UKCqgnw
        a2s4IPflopiV4yDd6aYZYkJf4keNMU4=
X-Google-Smtp-Source: ABdhPJxLVRhYwlIpD2R4tAXNjNZds4nGgn0re/KW/0U7Qw67VA1MBd/RweE3vvZMSlFOouLuqii2FQ==
X-Received: by 2002:ac8:c4e:: with SMTP id l14mr38520966qti.106.1594101905303;
        Mon, 06 Jul 2020 23:05:05 -0700 (PDT)
Received: from archbookpro.phub.net.cable.rogers.com (CPEc05627352ede-CM185933998587.cpe.net.cable.rogers.com. [174.112.146.193])
        by smtp.gmail.com with ESMTPSA id k197sm23446778qke.133.2020.07.06.23.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 23:05:04 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [RESEND PATCH v2 2/5] t5324: reorder `run_with_limited_open_files test_might_fail`
Date:   Tue,  7 Jul 2020 02:04:35 -0400
Message-Id: <9ba997f7c126ed0838ca7a72f33d87f40e173fd8.1594101831.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.27.0.383.g050319c2ae
In-Reply-To: <cover.1594101831.git.liu.denton@gmail.com>
References: <cover.1593576601.git.liu.denton@gmail.com> <cover.1594101831.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the future, we plan on only allowing `test_might_fail` to work on a
restricted subset of commands, including `git`. Reorder the commands so
that `run_with_limited_open_files` comes before `test_might_fail`. This
way, `test_might_fail` operates on a git command.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t5324-split-commit-graph.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
index 269d0964a3..9b850ea907 100755
--- a/t/t5324-split-commit-graph.sh
+++ b/t/t5324-split-commit-graph.sh
@@ -399,7 +399,7 @@ test_expect_success ULIMIT_FILE_DESCRIPTORS 'handles file descriptor exhaustion'
 		for i in $(test_seq 64)
 		do
 			test_commit $i &&
-			test_might_fail run_with_limited_open_files git commit-graph write \
+			run_with_limited_open_files test_might_fail git commit-graph write \
 				--split=no-merge --reachable || return 1
 		done
 	)
-- 
2.27.0.383.g050319c2ae

