Return-Path: <SRS0=ZiOn=25=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D4BC33C9B
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 04:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEFBA2072B
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 04:28:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xh4b/psU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbgAHE2A (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jan 2020 23:28:00 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35401 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbgAHE17 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jan 2020 23:27:59 -0500
Received: by mail-wr1-f65.google.com with SMTP id g17so1916814wro.2
        for <git@vger.kernel.org>; Tue, 07 Jan 2020 20:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=myL8Q/TJzLXKfcx0l/eXApOWXq54GMh0+GflgwcuL9g=;
        b=Xh4b/psUs15mMXl6iOSMXJewm8mbNrgNir1DQB7Q4FTHiBq56BDj78Mo0mUe4VWGPf
         8FC9HHKYW8Mh3A4vYGND0C6nyyiOojyVGU3rvkxLEzaJknRp+R9kiPW6/JcJun+ez+S5
         ID2is8fNkylKrbkWaW3u7rXkSL2IhaQkkczvnn4sAlY0ltInI5s5HDvYAKsSoFCh3Pq4
         2AVA9z99htzfJI72uT3FjwhzjgksUjDU9bT4fqDjRYHBsH2Fst/ecjEuj32rVIqHyT7Q
         SXIcMQtqmdaTiZTP3z+di44jfrCgeuJUV2dHyZaHVELge3FKQ81y/XtE8yNBZFBq50bT
         PQLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=myL8Q/TJzLXKfcx0l/eXApOWXq54GMh0+GflgwcuL9g=;
        b=LaK4hUGIHM1p8lWxeXldwT96wpfIUf67fh/fbgzXekhIKSr0LQhnnzLx/l6V3JOZ8E
         wgORfFShpT+kKCjM7rFdKfDJU4oA2/tXHpp8vLkDYUAIOuxzKmKFi9OMNvZ5Y5pxwxgT
         VDy9iEr7f9X5X4iHdcBgpZ6IGPZVH6A0DJWFh+iEoA2nV1DXYdH/cZzfSS6OvO9VpwUR
         3WVCLKb+vJi2n9k4T/R6tWuL4MVrY2lUq9+uGLs7w4kNtJ4GMPQzveeBAXZkAhxWba/E
         2DDYi7lbxWFodL6pY4iV734KzQbdr2qXeG1AGGMZyf6WSzmZukmVlOGAACefTuacuIbw
         /9ag==
X-Gm-Message-State: APjAAAX+l9tTvqQ+h5fEdMBeaMwG94g5pwAMpi+1SkYhZmICqLZD6PNq
        fzUJF8CqgsjRSF+QXUvGddgN9lQF
X-Google-Smtp-Source: APXvYqz6giTPWI0ORjNefJ0AMyGrkqRWz5tz6aDDa3OYuAOHsIsGDnREsy9E/eyOV+lQV/gJi1rl2A==
X-Received: by 2002:adf:f803:: with SMTP id s3mr2115474wrp.7.1578457677778;
        Tue, 07 Jan 2020 20:27:57 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x17sm2498948wrt.74.2020.01.07.20.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 20:27:57 -0800 (PST)
Message-Id: <12abb32531ed7125293986dc139a7ffed3839065.1578457675.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.518.git.1578457675.gitgitgadget@gmail.com>
References: <pull.518.git.1578457675.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 08 Jan 2020 04:27:55 +0000
Subject: [PATCH 2/2] graph: fix collapse of multiple edges
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, jcoglan@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

This fix resolves the previously-added test_expect_failure in
t4215-log-skewed-merges.sh.

The issue lies in the "else" condition while updating the mapping
inside graph_output_collapsing_line(). In 0f0f389f (graph: tidy up
display of left-skewed merges, 2019-10-15), the output of left-
skewed merges was changed to allow an immediate horizontal edge in
the first parent, output by graph_output_post_merge_line() instead
of by graph_output_collapsing_line(). This condensed the first line
behavior as follows:

Before 0f0f389f:

	| | | | | | *-.
	| | | | | | |\ \
	| |_|_|_|_|/ | |
	|/| | | | | / /

After 0f0f389f:

	| | | | | | *
	| |_|_|_|_|/|\
	|/| | | | |/ /
	| | | | |/| /

However, a very subtle issue arose when the second and third parent
edges are collapsed in later steps. The second parent edge is now
immediately adjacent to a vertical edge. This means that the
condition

	} else if (graph->mapping[i - 1] < 0) {

in graph_output_collapsing_line() evaluates as false. The block for
this condition was the only place where we connected the target
column with the current position with horizontal edge markers.

In this case, the final "else" block is run, and the edge is marked
as horizontal, but did not back-fill the blank columns between the
target and the current edge. Since the second parent edge is marked
as horizontal, the third parent edge is not marked as horizontal.
This causes the output to continue as follows:

Before this change:

	| | | | | | *
	| |_|_|_|_|/|\
	|/| | | | |/ /
	| | | | |/| /
	| | | |/| |/
	| | |/| |/|
	| |/| |/| |
	| | |/| | |

By adding the logic for "filling" a horizontal edge between the
target column and the current column, we are able to resolve the
issue.

After this change:

	| | | | | | *
	| |_|_|_|_|/|\
	|/| | | | |/ /
	| | |_|_|/| /
	| |/| | | |/
	| | | |_|/|
	| | |/| | |

This output properly matches the expected blend of the edge
behavior before 0f0f389f and the merge commit rendering from
0f0f389f.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 graph.c                      | 10 ++++++++--
 t/t4215-log-skewed-merges.sh |  2 +-
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/graph.c b/graph.c
index aaf97069bd..4fb25ad464 100644
--- a/graph.c
+++ b/graph.c
@@ -1233,8 +1233,14 @@ static void graph_output_collapsing_line(struct git_graph *graph, struct graph_l
 			 * prevent any other edges from moving
 			 * horizontally.
 			 */
-			if (horizontal_edge == -1)
-				horizontal_edge = i;
+			if (horizontal_edge == -1) {
+				int j;
+				horizontal_edge_target = target;
+				horizontal_edge = i - 1;
+
+				for (j = (target * 2) + 3; j < (i - 2); j += 2)
+					graph->mapping[j] = target;
+			}
 		}
 	}
 
diff --git a/t/t4215-log-skewed-merges.sh b/t/t4215-log-skewed-merges.sh
index 099e4b89b4..1d0d3240ff 100755
--- a/t/t4215-log-skewed-merges.sh
+++ b/t/t4215-log-skewed-merges.sh
@@ -311,7 +311,7 @@ test_expect_success 'log --graph with multiple tips and colors' '
 	test_cmp expect.colors actual.colors
 '
 
-test_expect_failure 'log --graph with multiple tips' '
+test_expect_success 'log --graph with multiple tips' '
 	git checkout --orphan 7_1 &&
 	test_commit 7_A &&
 	test_commit 7_B &&
-- 
gitgitgadget
