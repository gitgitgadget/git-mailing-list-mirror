Return-Path: <SRS0=R9sp=CF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76318C433E1
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 15:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 540332087D
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 15:46:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PLopA3oG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbgH0PqE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Aug 2020 11:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbgH0Pp6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Aug 2020 11:45:58 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 229ACC06121B
        for <git@vger.kernel.org>; Thu, 27 Aug 2020 08:45:57 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id d19so3644116pgl.10
        for <git@vger.kernel.org>; Thu, 27 Aug 2020 08:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tbXxr4CXDsZDPkUlKvg9CPClPydJ3COxrTzi9kfvhHc=;
        b=PLopA3oGaEXTWQLtyOfpuTLS8LW+GRODloG87UfuvOMTTGzSILFyXizUOOAhTichgz
         eLIp0Q/KNTH2z6ojm6+tXb9elFXpJuhMD2WmKOjrQIs1OzKi/JqEUFqFBgep3GviMz5O
         iA59314/8kcMUIVZIRbpOBke0PaMRpAY825d/chGw+b9C72PK5GkoeqV7PRv53nOxbXS
         KLze3JsGDqfHse9g47hdzGw429oNfsu6RP31qLukmE1ENPEBFsxTynXAR7QTGbyIPlCk
         nvhHYY15yvCgw7I/9RT5e7A9fWkSH6GqhAQbbzJJ26oSGjL05odKwly2vUUU5n6cglT6
         QfJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tbXxr4CXDsZDPkUlKvg9CPClPydJ3COxrTzi9kfvhHc=;
        b=mj9ffqFayryQdaTBiK6la2IqiY4NA9Ehbd24ARhpP+3g60p5Kb/vgPKmf2B0uo1QVq
         1d1Gufj9XktBO8xmbcaC9qNz8dJf9WeKFGIppxAnmHd38IMi/Qrzpzg6RhVXMDSVjbEB
         BQ91++JYJQvg1zy+J/XfsS7zBotJn3K8BcnnWz0Thb4XVHIhiV5Jj+0prTEoCqZ9ueW5
         AQM3q+tCuAxpYbk05oXVeOvvzPDCSZ6TKIXYg1QoEtKXtkKoYADDe80LJJi13Tn030Ud
         C9jyoWyHdiwZEGkuwr8nNx4prvS9qEgbwppbwA1SKCb0DaWhl/tj8ldf9WeWQtaBNjqd
         Fe+w==
X-Gm-Message-State: AOAM532TuewUvlVwhgQcZ+wfYKs3UxQShaSdDIRmW1IdUxwLUUaeHL+9
        1JvUDEDTnJ8OaBf5NrxdqLw=
X-Google-Smtp-Source: ABdhPJxH5TIoJH3qHhkXLxCVJx4tBAj0TaDKO8WmHQhQjzx5ch+swKnbGIQD1ygl41Un9LSHXP1XBw==
X-Received: by 2002:a63:d10a:: with SMTP id k10mr15033204pgg.382.1598543156736;
        Thu, 27 Aug 2020 08:45:56 -0700 (PDT)
Received: from tigtog.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id x5sm3129218pfj.1.2020.08.27.08.45.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Aug 2020 08:45:56 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v19 01/10] transport: not report a non-head push as a branch
Date:   Thu, 27 Aug 2020 11:45:42 -0400
Message-Id: <20200827154551.5966-2-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <20200824174202.11710-1-worldhello.net@gmail.com>
References: <20200824174202.11710-1-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

When pushing a new reference (not a head or tag), report it as a new
reference instead of a new branch.

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 t/t5516-fetch-push.sh | 2 +-
 transport.c           | 9 ++++++---
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 36ad20a849..d11382f769 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1039,7 +1039,7 @@ test_force_fetch_tag "annotated tag" "-f -a -m'tag message'"
 test_expect_success 'push --porcelain' '
 	mk_empty testrepo &&
 	echo >.git/foo  "To testrepo" &&
-	echo >>.git/foo "*	refs/heads/master:refs/remotes/origin/master	[new branch]"  &&
+	echo >>.git/foo "*	refs/heads/master:refs/remotes/origin/master	[new reference]"  &&
 	echo >>.git/foo "Done" &&
 	git push >.git/bar --porcelain  testrepo refs/heads/master:refs/remotes/origin/master &&
 	(
diff --git a/transport.c b/transport.c
index 419be0b6ea..84ec80447b 100644
--- a/transport.c
+++ b/transport.c
@@ -500,9 +500,12 @@ static void print_ok_ref_status(struct ref *ref, int porcelain, int summary_widt
 				 porcelain, summary_width);
 	else if (is_null_oid(&ref->old_oid))
 		print_ref_status('*',
-			(starts_with(ref->name, "refs/tags/") ? "[new tag]" :
-			"[new branch]"),
-			ref, ref->peer_ref, NULL, porcelain, summary_width);
+				 (starts_with(ref->name, "refs/tags/")
+				  ? "[new tag]"
+				  : (starts_with(ref->name, "refs/heads/")
+				     ? "[new branch]"
+				     : "[new reference]")),
+				 ref, ref->peer_ref, NULL, porcelain, summary_width);
 	else {
 		struct strbuf quickref = STRBUF_INIT;
 		char type;
-- 
2.26.2.543.g44b58e439b

