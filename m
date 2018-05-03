Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43538200B9
	for <e@80x24.org>; Thu,  3 May 2018 15:30:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751371AbeECPai (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 11:30:38 -0400
Received: from mout.gmx.net ([212.227.17.22]:45419 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751133AbeECPaf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 May 2018 11:30:35 -0400
Received: from virtualbox.mshome.net ([37.201.195.116]) by mail.gmx.com
 (mrgmx103 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0Lcjdr-1eWduc26dj-00k42h; Thu, 03 May 2018 17:30:29 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 01/18] Add a function to solve least-cost assignment problems
Date:   Thu,  3 May 2018 17:30:26 +0200
Message-Id: <3f51970cbc44bfe34133c48c0844ed3723e83808.1525361419.git.johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.17.0.409.g0f525fc0ba7
In-Reply-To: <cover.1525361419.git.johannes.schindelin@gmx.de>
References: <cover.1525361419.git.johannes.schindelin@gmx.de>
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:N0QkoOaDsY+LlmyZosiEYYNljDTS1Z6f19ceRA62bjLAjph+/YA
 w6Ds+WXiwx4GJiyzrmQT1aXzfX5V3HdpbZj3fDMmg5I2DH/KenmIqAZG9yW3dEFROqUOp99
 iHNg7sKDfv/8n4MUO07i4pBeMZucZCB6bKGxEw9e4xCntx2QDNAo135VBlP/apKEGwT3OuC
 H8l8aGod07MtDesHsdDpQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:QHNCwega4GE=:PXciRVAgCQ3S/9BEaJtuwZ
 BmZAVeI5GK+ESGptygKTodP1E9Gggzhe8tPeLUnlOMs+Zn9PDJsPVLRwFHbRZhgtoakpqUtz1
 wu8Y+zOQ69WKIIs0lmzRZXlpEqysBBvsAlIuWNNcN591vLtbxHYU+hJfY7Lo8hcWyfgaQmlZH
 FPtxhRzBBoUzHDI9SG/4knRbwhvZPtEzhQyrjz3wrTm5BFxPBwhhJ1Ttuks0Epq4i1Sxlm9iX
 wMwMuT3h6muorFH/pDr4ohWn0sTvByrUs28D3mR5cN9tf4R85yCgGYCTNZgcd3wuNz0J3Mtx9
 OvZgqANG819pBpLxwHGoDGrzaNERf3iIAYLyU7tt+9SUtFulFAmInaerk2I9YmGG0u36bGjyh
 zFFjdVUJHycDYHKk48PJqiHk8W32mqfiy/9dgT70nG3afNxaKwJ6Xl6E6hU6MoKx93+B3kaUV
 lzSi6T21D4Tu9VULLDr37VGVpCrhVwbG/r4wDmjUroKx77rtD2XJWALEi2Nbj0AOfadxXSdXE
 apb34on+tNV+yyo36QcFhDWI37X/mLtAOqnNYO1/peouAaXgu6zlwuS4ApOK6wqctbrU3UE7C
 CLAHlBrU9GYxiw0PFUevJpH5uJWEKFnhG0jBvnrzFUi+1ff9Nc5MHPtZZH+yQJGnbgIhpyN0p
 MkTUMsqC/SZvhvkRW9tPQ0BZ1igp/ExaxNWL1Coktf0THLlrue8RyfEL/2Yguc0wcz8PGjyr1
 WlPt/j0ATS6KrU+snf1W65i4JwHDRwSMUmkXGED10whJoNhgGcno0oMuMNs4rn5McIFUAT7n8
 rMgzgDC
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The Jonker-Volgenant algorithm was implemented to answer questions such
as: given two different versions of a topic branch (or iterations of a
patch series), what is the best pairing of commits/patches between the
different versions?

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Makefile    |   1 +
 hungarian.c | 205 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 hungarian.h |  19 +++++
 3 files changed, 225 insertions(+)
 create mode 100644 hungarian.c
 create mode 100644 hungarian.h

diff --git a/Makefile b/Makefile
index 50da82b0169..96f2e76a904 100644
--- a/Makefile
+++ b/Makefile
@@ -829,6 +829,7 @@ LIB_OBJS += gpg-interface.o
 LIB_OBJS += graph.o
 LIB_OBJS += grep.o
 LIB_OBJS += hashmap.o
+LIB_OBJS += hungarian.o
 LIB_OBJS += help.o
 LIB_OBJS += hex.o
 LIB_OBJS += ident.o
diff --git a/hungarian.c b/hungarian.c
new file mode 100644
index 00000000000..346299a97d9
--- /dev/null
+++ b/hungarian.c
@@ -0,0 +1,205 @@
+/*
+ * Based on: Jonker, R., & Volgenant, A. (1987). <i>A shortest augmenting path
+ * algorithm for dense and sparse linear assignment problems</i>. Computing,
+ * 38(4), 325-340.
+ */
+#include "cache.h"
+#include "hungarian.h"
+#include <float.h>
+
+#define COST(column, row) cost[(column) + column_count * (row)]
+
+/*
+ * The parameter `cost` is the cost matrix: the cost to assign column j to row
+ * i is `cost[j + column_count * i].
+ */
+int compute_assignment(int column_count, int row_count, double *cost,
+		       int *column2row, int *row2column)
+{
+	double *v = xmalloc(sizeof(double) * column_count), *d;
+	int *free_row, free_count = 0, saved_free_count, *pred, *col;
+	int i, j, phase;
+
+	memset(column2row, -1, sizeof(int) * column_count);
+	memset(row2column, -1, sizeof(int) * row_count);
+
+	/* column reduction */
+	for (j = column_count - 1; j >= 0; j--) {
+		int i1 = 0;
+
+		for (i = 1; i < row_count; i++)
+			if (COST(j, i1) > COST(j, i))
+				i1 = i;
+		v[j] = COST(j, i1);
+		if (row2column[i1] == -1) {
+			/* row i1 unassigned */
+			row2column[i1] = j;
+			column2row[j] = i1;
+		} else {
+			if (row2column[i1] >= 0)
+				row2column[i1] = -2 - row2column[i1];
+			column2row[j] = -1;
+		}
+	}
+
+	/* reduction transfer */
+	free_row = xmalloc(sizeof(int) * row_count);
+	for (int i = 0; i < row_count; i++) {
+		int j1 = row2column[i];
+		if (j1 == -1)
+			free_row[free_count++] = i;
+		else if (j1 < -1)
+			row2column[i] = -2 - j1;
+		else {
+			double min = COST(!j1, i) - v[!j1];
+			for (j = 1; j < column_count; j++)
+				if (j != j1 && min > COST(j, i) - v[j])
+					min = COST(j, i) - v[j];
+			v[j1] -= min;
+		}
+	}
+
+	if (free_count ==
+	    (column_count < row_count ? row_count - column_count : 0)) {
+		free(v);
+		free(free_row);
+		return 0;
+	}
+
+	/* augmenting row reduction */
+	for (phase = 0; phase < 2; phase++) {
+		int k = 0;
+
+		saved_free_count = free_count;
+		free_count = 0;
+		while (k < saved_free_count) {
+			double u1, u2;
+			int j1 = 0, j2, i0;
+
+			i = free_row[k++];
+			u1 = COST(j1, i) - v[j1];
+			j2 = -1;
+			u2 = DBL_MAX;
+			for (j = 1; j < column_count; j++) {
+				double c = COST(j, i) - v[j];
+				if (u2 > c) {
+					if (u1 < c) {
+						u2 = c;
+						j2 = j;
+					} else {
+						u2 = u1;
+						u1 = c;
+						j2 = j1;
+						j1 = j;
+					}
+				}
+			}
+			if (j2 < 0) {
+				j2 = j1;
+				u2 = u1;
+			}
+
+			i0 = column2row[j1];
+			if (u1 < u2)
+				v[j1] -= u2 - u1;
+			else if (i0 >= 0) {
+				j1 = j2;
+				i0 = column2row[j1];
+			}
+
+			if (i0 >= 0) {
+				if (u1 < u2)
+					free_row[--k] = i0;
+				else
+					free_row[free_count++] = i0;
+			}
+			row2column[i] = j1;
+			column2row[j1] = i;
+		}
+	}
+
+	/* augmentation */
+	saved_free_count = free_count;
+	d = xmalloc(sizeof(double) * column_count);
+	pred = xmalloc(sizeof(int) * column_count);
+	col = xmalloc(sizeof(int) * column_count);
+	for (free_count = 0; free_count < saved_free_count; free_count++) {
+		int i1 = free_row[free_count], low = 0, up = 0, last, k;
+		double min, c, u1;
+
+		for (j = 0; j < column_count; j++) {
+			d[j] = COST(j, i1) - v[j];
+			pred[j] = i1;
+			col[j] = j;
+		}
+
+		j = -1;
+		do {
+			last = low;
+			min = d[col[up++]];
+			for (k = up; k < column_count; k++) {
+				j = col[k];
+				c = d[j];
+				if (c <= min) {
+					if (c < min) {
+						up = low;
+						min = c;
+					}
+					col[k] = col[up];
+					col[up++] = j;
+				}
+			}
+			for (k = low; k < up; k++)
+				if (column2row[col[k]] == -1)
+					goto update;
+
+			/* scan a row */
+			do {
+				int j1 = col[low++];
+
+				i = column2row[j1];
+				u1 = COST(j1, i) - v[j1] - min;
+				for (k = up; k < column_count; k++) {
+					j = col[k];
+					c = COST(j, i) - v[j] - u1;
+					if (c < d[j]) {
+						d[j] = c;
+						pred[j] = i;
+						if (c == min) {
+							if (column2row[j] == -1)
+								goto update;
+							col[k] = col[up];
+							col[up++] = j;
+						}
+					}
+				}
+			} while (low != up);
+		} while (low == up);
+
+update:
+		/* updating of the column pieces */
+		for (k = 0; k < last; k++) {
+			int j1 = col[k];
+			v[j1] += d[j1] - min;
+		}
+
+		/* augmentation */
+		do {
+			if (j < 0)
+				BUG("negative j: %d", j);
+			i = pred[j];
+			column2row[j] = i;
+			k = j;
+			j = row2column[i];
+			row2column[i] = k;
+		} while (i1 != i);
+	}
+
+	free(col);
+	free(pred);
+	free(d);
+	free(v);
+	free(free_row);
+
+	return 0;
+}
diff --git a/hungarian.h b/hungarian.h
new file mode 100644
index 00000000000..e7cee4bb039
--- /dev/null
+++ b/hungarian.h
@@ -0,0 +1,19 @@
+#ifndef HUNGARIAN_H
+#define HUNGARIAN_H
+
+/*
+ * Compute an assignment of columns -> rows (and vice versa) such that every
+ * column is assigned to at most one row (and vice versa) minimizing the
+ * overall cost.
+ *
+ * The parameter `cost` is the cost matrix: the cost to assign column j to row
+ * i is `cost[j + column_count * i].
+ *
+ * The arrays column2row and row2column will be populated with the respective
+ * assignments (-1 for unassigned, which can happen only if column_count !=
+ * row_count).
+ */
+int compute_assignment(int column_count, int row_count, double *cost,
+		       int *column2row, int *row2column);
+
+#endif
-- 
2.17.0.395.g6a618d6010f.dirty


