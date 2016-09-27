Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2432F20986
	for <e@80x24.org>; Tue, 27 Sep 2016 19:12:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933380AbcI0TML (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Sep 2016 15:12:11 -0400
Received: from mout.web.de ([212.227.17.11]:58803 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751953AbcI0TMK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2016 15:12:10 -0400
Received: from [192.168.178.36] ([79.213.113.239]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0MI6C2-1bnJu63oUQ-003uz8; Tue, 27 Sep 2016 21:12:04
 +0200
Subject: [PATCH 2/2] use strbuf_add_unique_abbrev() for adding short hashes,
 part 2
To:     Git List <git@vger.kernel.org>
References: <b7a61c78-3c46-375c-4cc3-7c363e551bc6@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <29e75b7b-6dd0-8c52-e444-cad1ba613cd0@web.de>
Date:   Tue, 27 Sep 2016 21:11:58 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <b7a61c78-3c46-375c-4cc3-7c363e551bc6@web.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:Txm+rDW9QjiXddMMdNVyK98Bwt4CpaAHRLiKv4AB+T0bdhtMvGp
 jA3mp5BI5V9ZwWnOsZhMEh/OJQ5o40LNUUp7Lg8uZXpB8I3rA7miOmSRSz2upVcjbu8U0p4
 kBkWyY3yp849EZNoBPd7PKFz1NfQS0repiPVwS5NvpZnP/N2GIKHkoL0t8FdMXTFd/GcHdF
 4oqPoC59igaSyJl0kKi2Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:fclczl4YJy8=:8xMtxJnTZRP7I0yp4NFZ5b
 a4zguXLYotKkehqjRkhZy7hTbXa3CYBRr9dwmaB0tPMPqlszm7WLNtfjd2D62ZIXpS6WwMgB9
 pmr17QOj4Rnq1IoL4DgU6OXBXHNmqy82Z42QAk7FrsvNpAL72jy71XMlviljULoZKKrMZVunr
 QYIZsvqRF7PqdySSS6BIbUssAIOPQcvwUtBqE01dUCj933UwExzNVOQGPyR1I6klWSQ3VJU9S
 X8CwlRBqtwhKqdF6HrviRA3mTjIvKZxHc3pUJT73xWE1vpNdGjqX0Z6DbNe893Tkjyorn0h+f
 stQ+R7X23uKt8t8Xd98V77wGvlRXw1vyrZMRL7szr3ggnC9I/lK3u7Cd4ECy49HnR6YHRO99q
 YGviFEWUBtS+I23/mlEXPyPihl6ZNQQvA5HDyl0RzJxarEOndlZOECuKdm2zjCsy3v4YYl7PW
 9MZ4UoJTpP1t7QXrCQntRVIFZ+SEEWAurt/Yn5SCAUF5B5SHLy3My2A8heJA2HWq6uCSlRCKu
 2sIjlQFQa6XEer5nkwuaFdIVIGM45PHl00fc+fEy+b6aankJUyF2GEyY32vP1ndZIjNisEiqI
 +tZ6EmZRISjzv5+4fJZhaNvNc3dnMzaCeepUtgVX9661a/vq5CLiaeiIVcxcE6I5nR5vF/Dvf
 a5LNi7TIXF4xROjHu6nbwqtx/gjX6A3F4MC3FOZcx1siybHD3+Xgr0oieqIJpmKkvfrfLK0Ql
 mLsjodWxdJveVnvwH9yshTqH/sfMW7XVnxoli3XoaIXkCe/lQCVpA/B3dnVOA2fL5AvHJuCPd
 dy3sejH
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Call strbuf_add_unique_abbrev() to add abbreviated hashes to strbufs
instead of taking detours through find_unique_abbrev() and its static
buffer.  This is shorter and a bit more efficient.

1eb47f167d65d1d305b9c196a1bb40eb96117cb1 already converted six cases,
this patch covers three more.

A semantic patch for Coccinelle is included for easier checking for
new cases that might be introduced in the future.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 contrib/coccinelle/strbuf.cocci | 6 ++++++
 diff.c                          | 2 +-
 submodule.c                     | 2 +-
 wt-status.c                     | 3 +--
 4 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/contrib/coccinelle/strbuf.cocci b/contrib/coccinelle/strbuf.cocci
index 4b7553f..1e24298 100644
--- a/contrib/coccinelle/strbuf.cocci
+++ b/contrib/coccinelle/strbuf.cocci
@@ -9,3 +9,9 @@ expression E1, E2;
 @@
 - strbuf_addf(E1, "%s", E2);
 + strbuf_addstr(E1, E2);
+
+@@
+expression E1, E2, E3;
+@@
+- strbuf_addstr(E1, find_unique_abbrev(E2, E3));
++ strbuf_add_unique_abbrev(E1, E2, E3);
diff --git a/diff.c b/diff.c
index a178ed3..be11e4e 100644
--- a/diff.c
+++ b/diff.c
@@ -3109,7 +3109,7 @@ static void fill_metainfo(struct strbuf *msg,
 		}
 		strbuf_addf(msg, "%s%sindex %s..", line_prefix, set,
 			    find_unique_abbrev(one->oid.hash, abbrev));
-		strbuf_addstr(msg, find_unique_abbrev(two->oid.hash, abbrev));
+		strbuf_add_unique_abbrev(msg, two->oid.hash, abbrev);
 		if (one->mode == two->mode)
 			strbuf_addf(msg, " %06o", one->mode);
 		strbuf_addf(msg, "%s\n", reset);
diff --git a/submodule.c b/submodule.c
index dcc5ce3..8cf40ea 100644
--- a/submodule.c
+++ b/submodule.c
@@ -396,7 +396,7 @@ static void show_submodule_header(FILE *f, const char *path,
 			find_unique_abbrev(one->hash, DEFAULT_ABBREV));
 	if (!fast_backward && !fast_forward)
 		strbuf_addch(&sb, '.');
-	strbuf_addstr(&sb, find_unique_abbrev(two->hash, DEFAULT_ABBREV));
+	strbuf_add_unique_abbrev(&sb->hash, two, DEFAULT_ABBREV);
 	if (message)
 		strbuf_addf(&sb, " %s%s\n", message, reset);
 	else
diff --git a/wt-status.c b/wt-status.c
index 9628c1d..99d1b0a 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1383,8 +1383,7 @@ static int grab_1st_switch(unsigned char *osha1, unsigned char *nsha1,
 	if (!strcmp(cb->buf.buf, "HEAD")) {
 		/* HEAD is relative. Resolve it to the right reflog entry. */
 		strbuf_reset(&cb->buf);
-		strbuf_addstr(&cb->buf,
-			      find_unique_abbrev(nsha1, DEFAULT_ABBREV));
+		strbuf_add_unique_abbrev(&cb->buf, nsha1, DEFAULT_ABBREV);
 	}
 	return 1;
 }
-- 
2.10.0


