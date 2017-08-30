Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50454208DB
	for <e@80x24.org>; Wed, 30 Aug 2017 17:50:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752208AbdH3Rub (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 13:50:31 -0400
Received: from mout.web.de ([212.227.17.12]:50745 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752029AbdH3RuJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 13:50:09 -0400
Received: from debian.fritz.box ([91.20.59.6]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MUWBb-1dvXAq3dr9-00RJeU for
 <git@vger.kernel.org>; Wed, 30 Aug 2017 19:50:07 +0200
From:   Rene Scharfe <l.s.r@web.de>
To:     git@vger.kernel.org
Subject: [PATCH 18/34] merge: release strbuf after use in save_state()
Date:   Wed, 30 Aug 2017 19:49:49 +0200
Message-Id: <20170830175005.20756-19-l.s.r@web.de>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20170830175005.20756-1-l.s.r@web.de>
References: <20170830175005.20756-1-l.s.r@web.de>
X-Provags-ID: V03:K0:Isqa5LOEPsPEY9twlBTdk/AL8UgfCPj5pVR1iFvXzzUwG9L6qh6
 bbG3czzQ9dqI+NYxtbuEntzhYIKYlyM1wfSACZaSiVQyMhotSn5f4gShp8JK+lv+0yFV3gf
 QflswkiJaOaihVqNT/LALXhMLqqbjILRJKGTzgkgT9KmhWCtWG+YCWi3hkiQTPSu3blaMi0
 97jb/tuL565HUEWT1G/sg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Og693USd/Do=:3qDsGoRgSpt6C+wwtx32Sx
 Md+q2+N2ABW0r5Wr1x3HjBfPk1/339gWs4j7qRZrgyhAcAm2JLDT64/OvmVpATLDcvtCRDv2B
 0Lbd2EKOqJc+1EntNt2QVryU8IWhB8N5l145/5Y8EfY1svsKftqZHM4bUpgTfbLa5WhfO9ucg
 pTyVNt7KbcslaxxYWcHAL4/4VpVc8/9b+FXh3w8uLpayOHMv6rK+r79RJ6xV0P5aREXiUUUg6
 FJpsKm7qNEGAJWlgLLZ2RaPIA6ubxxQ2aMNJe4OrvAsIZWDbCBGZBNCSTQCZ7HQuYkDboNVki
 0zUV9q+lU4p9v2V3pvW1XVLQ/4uilaRIPejxiSwvURe+rZ2Xqr3zlyYtle0nVPuh4US7t7p5W
 1fr34dzNMO/4hthi22/mGBtmaVL5jxVIPaF4HaPcenLBnb4GNH3ZJ/I1VJWhzKt9NtQzopO4H
 3AiX4pCNS+kILdwpDpM2PEKtiOjjataYT5S6tegXgNdodxoZiNfcHxbLeHe4OCPK6f+K5Cuwk
 hDdV4NC4yElUepjfoeHnn+FmbT0yLt/K1rZR9OXX+/RWWLGFITQTUJfK/JlgUxvPAjkXKR6ZN
 SMe43RPQ6IO6PinI1g4p5IFdO/alLPW71CH/f7ynGqYk5yihySn8jsN+jgjGPGRz3YR71jmhp
 5QxtFj1jER0G4eVxbIbVbA7mkM1HKY23orvgo4aULi424e3KAt+we6+yrnWKfUYxROXJrvCgC
 zRzxiuo4bfE4XK9uVF8EonnNlcpBkwDhnwEp8vtykLqJBynzPc+P0U+mmNwvcW+l95fnZ2P/0
 Ued65BKNnsLtTSGfJca8qHV/+S+pA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 builtin/merge.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 7df3fe3927..4f8418246b 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -250,27 +250,31 @@ static void drop_save(void)
 static int save_state(struct object_id *stash)
 {
 	int len;
 	struct child_process cp = CHILD_PROCESS_INIT;
 	struct strbuf buffer = STRBUF_INIT;
 	const char *argv[] = {"stash", "create", NULL};
+	int rc = -1;
 
 	cp.argv = argv;
 	cp.out = -1;
 	cp.git_cmd = 1;
 
 	if (start_command(&cp))
 		die(_("could not run stash."));
 	len = strbuf_read(&buffer, cp.out, 1024);
 	close(cp.out);
 
 	if (finish_command(&cp) || len < 0)
 		die(_("stash failed"));
 	else if (!len)		/* no changes */
-		return -1;
+		goto out;
 	strbuf_setlen(&buffer, buffer.len-1);
 	if (get_oid(buffer.buf, stash))
 		die(_("not a valid object: %s"), buffer.buf);
-	return 0;
+	rc = 0;
+out:
+	strbuf_release(&buffer);
+	return rc;
 }
 
 static void read_empty(unsigned const char *sha1, int verbose)
-- 
2.14.1

