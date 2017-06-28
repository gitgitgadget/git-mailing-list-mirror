Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BF1F20209
	for <e@80x24.org>; Wed, 28 Jun 2017 00:57:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753524AbdF1A5F (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Jun 2017 20:57:05 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:33517 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752856AbdF1A5B (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2017 20:57:01 -0400
Received: by mail-pf0-f169.google.com with SMTP id e7so24712407pfk.0
        for <git@vger.kernel.org>; Tue, 27 Jun 2017 17:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZelfeEzhAqdO73iiU7jS8sQ3lck+cKRXoRVTF0E9yJg=;
        b=Cpd1fPaTGZ9hGQA1gUkCVdCX/jSVqkN6sG7o4Uq6nvZzu8JdRC2Esxhdq3zti9jB3v
         oaR0YUdAmLP9Wjw2DHyjn6IUnJUCsZbkMGEuHNEYQeLgEEOMUR1Z8LGiA1k4MaxKdVkn
         /n4eigbqTHx6r3HWZkb9O+Rx0Ye6H3ZpWOED+8zMrC3Ov00vxIaDDFYMZd+aAJe+F1AU
         AIZoM7pdl2BVl76eyGZUw1bHIZeU8X7+VXcBk9Bh2wmmao/3YazWZYV6WKt5qwddI0Z9
         Fzp0EQw5dnzE69CDlaTZH6PvH3JUyeTvimayQLUIjmqGJMrdPzAS1JBSB0L4pGSZm6XF
         KF2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZelfeEzhAqdO73iiU7jS8sQ3lck+cKRXoRVTF0E9yJg=;
        b=CerDsa6vffyQJducG6riGLiV86Qe9tWb7FMfRW9zDPNCaMob+utB8RB6fiuC2Ajj66
         jyBjM0XqR+JrqjX2jgqvp3HR1oQ/HirsvJCIEsc0wufH1faGRUJCE+FjNWtY76fFVn45
         J3lE4k1/iWMRRLPraJEptxEKDRv+Y96gnTQEDySstW40QMFDOiRcaQvoiuAt7zgGTuJ2
         j4kWIyrFWxaQ8bR0p1zZvFStwsHHc0y8QlW4ime78H/fwlHLpZ8iEQcmqImGJb2Q3D6w
         cr8rcG8PhpnVTi/9xjbqBIRn92ew4F5wECTvQXELjcrbIwsxSUBfK57ONy9Z5BSBwBoL
         WZ4Q==
X-Gm-Message-State: AKS2vOwWVEG3K5ilicBTdXAiZ/kg9MkJMCFeOMBGvIH+T65/IrxxJ7WZ
        YwxB954emGrSAQZG
X-Received: by 10.84.213.144 with SMTP id g16mr8763927pli.202.1498611420640;
        Tue, 27 Jun 2017 17:57:00 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ac62:ae13:b066:f242])
        by smtp.gmail.com with ESMTPSA id b7sm723287pgr.11.2017.06.27.17.56.59
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 27 Jun 2017 17:56:59 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, avarab@gmail.com, peff@peff.net,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/6] diff.c: change the default for move coloring to zebra
Date:   Tue, 27 Jun 2017 17:56:47 -0700
Message-Id: <20170628005651.8110-3-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.31.g9b732c453e
In-Reply-To: <20170628005651.8110-1-sbeller@google.com>
References: <20170628005651.8110-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Introduce a new mode COLOR_MOVED_DEFAULT, which is the same as
COLOR_MOVED_ZEBRA. But having two different symbols allows us to
differentiate them in the code.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/diff-options.txt |  3 +++
 diff.c                         | 13 ++++++++++++-
 diff.h                         |  1 +
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 058c8014ed..d2c6a60af2 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -243,6 +243,9 @@ endif::git-diff[]
 --
 no::
 	Moved lines are not highlighted.
+default::
+	Is a synonym for `zebra`. This may change to more sensible modes
+	in the future.
 plain::
 	Any line that is added in one location and was removed
 	in another location will be colored with 'color.diff.newMoved'.
diff --git a/diff.c b/diff.c
index 5311dcf133..31cdec05ac 100644
--- a/diff.c
+++ b/diff.c
@@ -256,12 +256,23 @@ int git_diff_heuristic_config(const char *var, const char *value, void *cb)
 
 static int parse_color_moved(const char *arg)
 {
+	int v = git_parse_maybe_bool(arg);
+
+	if (v != -1) {
+		if (v == 0)
+			return COLOR_MOVED_NO;
+		else if (v == 1)
+			return COLOR_MOVED_DEFAULT;
+	}
+
 	if (!strcmp(arg, "no"))
 		return COLOR_MOVED_NO;
 	else if (!strcmp(arg, "plain"))
 		return COLOR_MOVED_PLAIN;
 	else if (!strcmp(arg, "zebra"))
 		return COLOR_MOVED_ZEBRA;
+	else if (!strcmp(arg, "default"))
+		return COLOR_MOVED_DEFAULT;
 	else if (!strcmp(arg, "dimmed_zebra"))
 		return COLOR_MOVED_ZEBRA_DIM;
 	else
@@ -4654,7 +4665,7 @@ int diff_opt_parse(struct diff_options *options,
 		if (diff_color_moved_default)
 			options->color_moved = diff_color_moved_default;
 		if (options->color_moved == COLOR_MOVED_NO)
-			options->color_moved = COLOR_MOVED_ZEBRA_DIM;
+			options->color_moved = COLOR_MOVED_DEFAULT;
 	} else if (!strcmp(arg, "--no-color-moved"))
 		options->color_moved = COLOR_MOVED_NO;
 	else if (skip_prefix(arg, "--color-moved=", &arg)) {
diff --git a/diff.h b/diff.h
index 98abd75521..9298d211d7 100644
--- a/diff.h
+++ b/diff.h
@@ -192,6 +192,7 @@ struct diff_options {
 		COLOR_MOVED_NO = 0,
 		COLOR_MOVED_PLAIN = 1,
 		COLOR_MOVED_ZEBRA = 2,
+		COLOR_MOVED_DEFAULT = 2,
 		COLOR_MOVED_ZEBRA_DIM = 3,
 	} color_moved;
 };
-- 
2.13.0.31.g9b732c453e

