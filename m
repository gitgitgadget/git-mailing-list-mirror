Return-Path: <SRS0=ZAU+=3M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4263DC2D0DB
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 19:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 187A221569
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 19:00:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="j3KcLiMA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728842AbgAWTAu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jan 2020 14:00:50 -0500
Received: from mail-qk1-f180.google.com ([209.85.222.180]:41142 "EHLO
        mail-qk1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727022AbgAWTAu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jan 2020 14:00:50 -0500
Received: by mail-qk1-f180.google.com with SMTP id s187so2458855qke.8
        for <git@vger.kernel.org>; Thu, 23 Jan 2020 11:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6TQ1Ypx2wFRlQn1hNH8dG1a4Ug8i0NP9i/83tbSSM/E=;
        b=j3KcLiMAaudB/YDnMp0DKjplfoktzWoOd8/ysHtfX1FojOq1tYf4yVX7ROHsCu+KIw
         30480Xd6g632PhSV9T+mhmJ0+/WWAkmRxAYFI2eGSfJ4+oUXF70HWaPU4adl0dqbPykU
         13wSw7k3ctIEmF1czloXVwfTmQz3QyT8L+N2/8ymeI6agUyGyycBawkuX0q/r5hoedB3
         fhKDEuZQq3yagGINcPF4YHa9dsIQd78JSbo2E7JRaSX2dEt6ma3m2v20PrVdLQSnEK5t
         BKB8k4y740MMsoZEXUptLG+sOBvmUtjgp/fQ9y21aerWwJ8BQYvCfKyrlPzOVe5dbAeU
         Yo0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6TQ1Ypx2wFRlQn1hNH8dG1a4Ug8i0NP9i/83tbSSM/E=;
        b=Rp9PJkXFOyEde7zzlgJZyqo6K7E1kWeTtbX9ymw6Z1Pc0ZcFJOHxvavCuh0FQU8xAs
         wvaYNZ5wSuGmXCqtNQQtab9OOB+yqnGOg6qeicYyjUS7D0dmY8gWfd6t9mwQMOs4+ftV
         vSlX6AWbJpoXZGjmwlAeRtNRtnZFfXvdEIyTGsE6Rmwz9V+IKMMDZQnnCc1I1LKTrYiE
         U21u2GdLnKndEnYbZj8DhFkzhOa6fg4+OSw9Qlnzm8PRO4hVWJrLNBnpu3VtrjDlMVYB
         lOpjFBjnndKCUf+mLBzv0JuZ6KxnkDqEPObSJBOn4noHATl+uGAy1BX+6AFsFVdjJ7vx
         3wCw==
X-Gm-Message-State: APjAAAWiAo5f5KITxTk0X1grgZmkQbwkTEuC6cm7w27jURZKj1zdyB4Q
        cMX4P4KT6MAARL1cinbPEfjc4XlQ8tY=
X-Google-Smtp-Source: APXvYqwnkGhfm+m1vzG8Mz9ajMRbJSObbDHrsHyoD+hQkiwwca/qst83KQM4VOA5YNc9L7rCeYFWtg==
X-Received: by 2002:a37:905:: with SMTP id 5mr8582164qkj.404.1579806048838;
        Thu, 23 Jan 2020 11:00:48 -0800 (PST)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::1])
        by smtp.gmail.com with ESMTPSA id l6sm1363821qkc.65.2020.01.23.11.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 11:00:48 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Denton Liu <liu.denton@gmail.com>,
        Paul Wagland <paul@kungfoocoder.org>
Subject: [PATCH 2/2] completion: add support for sparse-checkout
Date:   Thu, 23 Jan 2020 16:00:03 -0300
Message-Id: <79f6aa1411c1bba3ee2c55a7532e78ffccb1edea.1579805218.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1579805218.git.matheus.bernardino@usp.br>
References: <cover.1579805218.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 contrib/completion/git-completion.bash | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index e4d9ff4a95..cb1f1b5e20 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2718,6 +2718,27 @@ _git_show_branch ()
 	__git_complete_revlist
 }
 
+_git_sparse_checkout ()
+{
+	local subcommands="list init set disable"
+	local subcommand="$(__git_find_on_cmdline "$subcommands")"
+	if [ -z "$subcommand" ]; then
+		__gitcomp "$subcommands"
+		return
+	fi
+
+	case "$subcommand,$cur" in
+	init,--*)
+		__gitcomp "--cone"
+		;;
+	set,--*)
+		__gitcomp "--stdin"
+		;;
+	*)
+		;;
+	esac
+}
+
 _git_stash ()
 {
 	local save_opts='--all --keep-index --no-keep-index --quiet --patch --include-untracked'
-- 
2.25.0

