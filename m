Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78B692076C
	for <e@80x24.org>; Mon, 29 Aug 2016 08:06:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932682AbcH2IGK (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 04:06:10 -0400
Received: from mout.gmx.net ([212.227.17.20]:53822 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932511AbcH2IGI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 04:06:08 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MLS74-1bdjcF2AKI-000flF; Mon, 29 Aug 2016 10:06:05
 +0200
Date:   Mon, 29 Aug 2016 10:06:05 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 15/22] sequencer: introduce a helper to read files written
 by scripts
In-Reply-To: <cover.1472457609.git.johannes.schindelin@gmx.de>
Message-ID: <c0c7caa40a452ed9328c21302e4399562d40ec12.1472457609.git.johannes.schindelin@gmx.de>
References: <cover.1472457609.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:0r9WwEp2xi8LFHuJJRdQRyRMnjV2pLZj+HuGNsifdkbe+v8ncVg
 bmdndG18+bcaLTMHOLXxaCM5WvamikD/Q8jG0dnVVU0y2N2VHX7M4GCD4YzR98nZUWCBjpI
 1jXVIrvBh/PAcWeRjoNO1ul3koODnu5nwPtaP46sWjOJbBJrjyB98c86K/rkCrWVn83Ecoz
 /0XXq5gdPqwsW2N7WFK3Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9HiG2+IJJlo=:Y+EEBPdUtGv+8h2WqxR+HO
 awmYd+qv+44pWU2HYw3z1pKXBCeenH5ukPxD8PjRirYZwavFlUYXZmo/7H5rdYwR6AZJVTZMq
 bA0HE/CWp5pmaBXzrUHCL0IBlrbEG1hCpg4ypZBoyqHLub0uH0bV/JVxfEpgp0y5wPTQgkLVH
 xin/WLUELbBWRmmscXw3ChwhHj/VuUNEdlOcbnW98m3xCKJlJAA/LsFFFPLJXoJ2B0UJHViUh
 Zio/m4zs3KDilmENsU0tNLfYXVAjRhEXLupojh8tAYJVei0QmZBAdMYQNKDsJshMv7fkGR3X3
 TRVNhJtInO4tgQVWUyHfwqVByyR4W3sNwxLmR8E/o1afagOteF2oyPCH/qH3LjnFVk9Dh+dJg
 Ma2Doq/hvLFsh8NLpKcKZ4nxvZbgBZCM+81mWMwUrlqf4FsXm7pQupvHDZukXzTDnpeH+cf42
 K4PM7HDesAg1UozGZwuN3p1H0k7yF5l5dZwGbKgQxZl1V3fxfwmJH7XuyXA/7AmStQexG0VWc
 2AakOcuSRjJ+i/ABknabRDFZ+i8Jxs+qa9BDR42voEdn95AiliyhCp7/UClWjoVBGAa0FwXNz
 Y0qPW4QgxcyIqEPZgekqZKKxVHK+VlZW9EsIQnW/DuPbB8VmBHaQWim80NzpvlJInoWSgRH1h
 rGXYi3TBFci9zVFFqBn1LBYCHgmOZgbp/yWRaqFvRCbpPwe+1LPJaXcy+nAmkZ58LVwVs1iRL
 PPtWY4nlXZHQLMbpS86sgOgzhq+8xLlX1zTCIi1iPSoabcwcxluugHVlIhxsSQI8wqeWQpWZL
 GpYdK7n
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As we are slowly teaching the sequencer to perform the hard work for
the interactive rebase, we need to read files that were written by
shell scripts.

These files typically contain a single line and are invariably ended
by a line feed (and possibly a carriage return before that). Let's use
a helper to read such files and to remove the line ending.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index b124980..4204cc8 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -239,6 +239,37 @@ static int write_message(struct strbuf *msgbuf, const char *filename)
 	return 0;
 }
 
+/*
+ * Reads a file that was presumably written by a shell script, i.e.
+ * with an end-of-line marker that needs to be stripped.
+ *
+ * Returns 1 if the file was read, 0 if it could not be read or does not exist.
+ */
+static int read_oneliner(struct strbuf *buf,
+	const char *path, int skip_if_empty)
+{
+	int orig_len = buf->len;
+
+	if (!file_exists(path))
+		return 0;
+
+	if (strbuf_read_file(buf, path, 0) < 0) {
+		warning_errno("could not read '%s'", path);
+		return 0;
+	}
+
+	if (buf->len > orig_len && buf->buf[buf->len - 1] == '\n') {
+		if (--buf->len > orig_len && buf->buf[buf->len - 1] == '\r')
+			--buf->len;
+		buf->buf[buf->len] = '\0';
+	}
+
+	if (skip_if_empty && buf->len == orig_len)
+		return 0;
+
+	return 1;
+}
+
 static struct tree *empty_tree(void)
 {
 	return lookup_tree(EMPTY_TREE_SHA1_BIN);
-- 
2.10.0.rc1.114.g2bd6b38


