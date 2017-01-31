Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FEA31F437
	for <e@80x24.org>; Tue, 31 Jan 2017 13:52:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752059AbdAaNwJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jan 2017 08:52:09 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34614 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751964AbdAaNwJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jan 2017 08:52:09 -0500
Received: by mail-wm0-f65.google.com with SMTP id c85so84061334wmi.1
        for <git@vger.kernel.org>; Tue, 31 Jan 2017 05:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gU6AKFwVpTDI0enrYNOOW8QGxJ/4kzbWE2G9ASTdlWg=;
        b=hU4ZuThd6HQOZNZU+ZBf7GFPKhyNEAqlhBb6i6UpVowhWuW7jetzS7eiqSMDPhEu7/
         veKkEfsTZqFC/uxm6fySRN9VvUIkc1PkpRmlu6YlhkmzYU1JdahGBhx6/ZbI0gwwPJ/4
         LlhcA0lPHh7PNHXv6z/2pwO18XUjBCQwBcLa9XirDRbYU/2YiqIIYEByKkPGRmCzXB+i
         mzWB6N4hqKpXJ8yYTpGmLD8XEuKxP/EGUQEql6T3qVJ7bQc+tfe65Yo4PnbBhg1+3vQT
         pF0JiK/iCDF8/SpfY24xYTDuQQrU0SU1ICZ/RrPVHXcnCZ/IMjgwY6SMrbEhoDlOMnu1
         L1WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gU6AKFwVpTDI0enrYNOOW8QGxJ/4kzbWE2G9ASTdlWg=;
        b=sf1kHmQZEBN8yZUQQhKjYj4Y6hBdaiX5H+fNkq0qDjVj+dSi4kPl/1LzrzNmWybJM9
         6+1/Pz2QOodnST6BR3xH73voeX0ilgqfyq8Zxelyi+xawOfjlX+KsRArpyeV7ZNFbzua
         ZaQ1fSEC6aWw1WV0/xRkCEH6HaUm9R/OU2qgWMk4FmhTQwjOSApUmdd4wV9qU6TfELgC
         Xe7mKJbB5IEBTtukFwCtifZLS9YywyeK/koC3JPnBjLZbcmpmdv3DWH33hk7Dzw5JKEk
         hDdGeMEq7jU8nu0sYjqAAYYoF6B6aLfW4mxs9IJ41Qwlx44jkgBQS7Hpz5WvawxPI7SD
         ZEVw==
X-Gm-Message-State: AIkVDXJLAdunVpxo2eLqYHh+umXBAcHaeCKMChqBYqIcseHwvodnEkFFYsrLkBVD5ponJA==
X-Received: by 10.28.15.2 with SMTP id 2mr20150708wmp.66.1485870339507;
        Tue, 31 Jan 2017 05:45:39 -0800 (PST)
Received: from ubuntu2pinto.pd5x2phgis1evm2itoce0l41ib.ax.internal.cloudapp.net ([13.94.233.52])
        by smtp.gmail.com with ESMTPSA id w126sm28199447wmw.0.2017.01.31.05.45.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 31 Jan 2017 05:45:38 -0800 (PST)
From:   Elia Pinto <gitter.spiros@gmail.com>
To:     git@vger.kernel.org
Cc:     Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCHv4] builtin/commit.c: switch to strbuf, instead of snprintf()
Date:   Tue, 31 Jan 2017 13:45:35 +0000
Message-Id: <20170131134535.35016-1-gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.11.0.297.g2a7e328.dirty
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Switch to dynamic allocation with strbuf, so we can avoid dealing
with magic numbers in the code and reduce the cognitive burden from
the programmers.  The original code is correct, but programmers no
longer have to count bytes needed for static allocation to know that.

As a side effect of this change, we also reduce the snprintf()
calls, that may silently truncate results if the programmer is not
careful.

Helped-by: René Scharfe <l.s.r@web.de>
Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
This is the fourth patch version.

Changes from the first version: I have split the original commit in two, as discussed here
http://public-inbox.org/git/20161213132717.42965-1-gitter.spiros@gmail.com/.

Changes from the second version:
- Changed the commit message to clarify the purpose of the patch (
as suggested by Junio)

Changes from the third version:
- Swith to use strbuf instead of xstrfmt (
as suggested by René Scharfe
here https://public-inbox.org/git/3165803b-6073-de97-bf33-71ad21108d6f@web.de/)


 builtin/commit.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 276c4f2e7..2de5f6cc6 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1525,12 +1525,10 @@ static int git_commit_config(const char *k, const char *v, void *cb)
 static int run_rewrite_hook(const unsigned char *oldsha1,
 			    const unsigned char *newsha1)
 {
-	/* oldsha1 SP newsha1 LF NUL */
-	static char buf[2*40 + 3];
 	struct child_process proc = CHILD_PROCESS_INIT;
 	const char *argv[3];
 	int code;
-	size_t n;
+	struct strbuf sb = STRBUF_INIT;
 
 	argv[0] = find_hook("post-rewrite");
 	if (!argv[0])
@@ -1546,11 +1544,11 @@ static int run_rewrite_hook(const unsigned char *oldsha1,
 	code = start_command(&proc);
 	if (code)
 		return code;
-	n = snprintf(buf, sizeof(buf), "%s %s\n",
-		     sha1_to_hex(oldsha1), sha1_to_hex(newsha1));
+	strbuf_addf(&sb, "%s %s\n", sha1_to_hex(oldsha1), sha1_to_hex(newsha1));
 	sigchain_push(SIGPIPE, SIG_IGN);
-	write_in_full(proc.in, buf, n);
+	write_in_full(proc.in, sb.buf, sb.len);
 	close(proc.in);
+	strbuf_release(&sb);
 	sigchain_pop(SIGPIPE);
 	return finish_command(&proc);
 }
-- 
2.11.0.297.g2a7e328.dirty

