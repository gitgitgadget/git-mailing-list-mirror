Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A18420899
	for <e@80x24.org>; Wed,  2 Aug 2017 20:42:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753244AbdHBUmP (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Aug 2017 16:42:15 -0400
Received: from mout.web.de ([212.227.15.4]:59352 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752116AbdHBUmN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Aug 2017 16:42:13 -0400
Received: from tor.lan ([195.198.252.176]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MKaDH-1ddpwg314Z-0022ND; Wed, 02
 Aug 2017 22:42:05 +0200
From:   tboegi@web.de
To:     git@vger.kernel.org, asottile@umich.edu
Cc:     =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v1 1/1] correct apply for files commited with CRLF
Date:   Wed,  2 Aug 2017 22:42:03 +0200
Message-Id: <20170802204203.29484-1-tboegi@web.de>
X-Mailer: git-send-email 2.13.2.533.ge0aaa1b
In-Reply-To: <cceaf377-73e0-e733-20ba-c4e547226382@web.de>
References: <cceaf377-73e0-e733-20ba-c4e547226382@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:2OU5K151Rjt/0sgiBFUn5pJaVgMJKoaEJ7hxuMgzwAhn28SCtyz
 ioW2GGCeDCJj9U87GmmpHmFfcwNbXzMhE6Q4xDS2R3UZFzphjtRM4ceev5huk7xYXY1R+RW
 dhyz3RJfnryOqrT8UQ/gN/KfQCy+9BWe7otSlcOKuQkFLqXpJFkB7qvC+42uX6SZO3QTjIh
 mcBy9D10jrI5zjuh4XWgw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:vF4kuO5/0C0=:24wafMymx5f13kodSsZVE/
 nQ667hN50trraFyWwv/Dq/fWA+IL+Z+0jG3otlrqZWps7oxYhvnnrxDjlhwCI/rchdQqxiKLI
 B3YBAhugXInHSWoITTgQw48aI5YUpt7gfUhW4MmYTmlMQzYjZvegbBCLrVwUilaCcxJ0YCmUr
 ZPeOh7lqGZRhhm6zIQWZ1vzbGV9pD7ODvqFXRO38SfmVUR3Dws0LcGQSoBbsLca/h7V3yHBxV
 fUhJsX8BgUv5Mny23Ah1yrgajtZPkE9RCqsQPH2U5mVqxk9h+0IPXnyZ4j4KYoUD0eoYVAHza
 LOCwgVKuRvxIVnSLIF07/+W50be2NthBj98r2NKKqHrcFSyyOoJcqICxlRar95YeZalJN5073
 unmmqoh5KWmyKvKU2iTHKC/KkIRmWFFyk7dfADZuBjPkX+7nLzZb0woCqWjOPLJs05+CuvzEP
 2/wm+zBIi8ojPzK5OgUiaLzVHO2IVemGchTcZirdo5X+Qohwjv5VCRCNR0B1lyhjClB+ZBdzy
 GJjP9fnb8g/ymNJ8/oDwm5NrIkExqGI1AIUI6tT5DU2lCyH33BOD37FIcKylCgnmjYd9Gj2ZZ
 ewIHohqVEvNvRo2A4x2vZW+PDb+TPj5GbpVsq9pbOZujozlRKAi8wauqThGZxj/SDXrbP2oZB
 d5wX+Mn/BsLADvM7GHCoxhNK0D3BQMsryeLSoTRvQRGrn6XZpFDeS3BiFt2yoorPolw750iz9
 FZRI0NCRJ47Gx4VDPXQ/sqlFiTslRKPaHO2nhv4tBOypBCEKZt4IdeptsmAsMiKrHmUwPK2To
 750Y/oP1F0q1SZO3uQfQpI0LqaQdwKzOLJLw18JMqQVCrHT3fQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Torsten Bögershausen <tboegi@web.de>

git apply does not find the source lines when files have CRLF in the index
and core.autocrlf is true:
These files should not get the CRLF converted to LF. Because cmd_apply()
does not load the index, this does not work, CRLF are converted into LF
and apply fails.

Fix this in the spirit of commit a08feb8ef0b6,
"correct blame for files commited with CRLF" by loading the index.

As an optimization, skip read_cache() when no conversion is specified
for this path.

Reported-by: Anthony Sottile <asottile@umich.edu>
Signed-off-by: Torsten Bögershausen <tboegi@web.de>
---
 apply.c         |  2 ++
 t/t0020-crlf.sh | 12 ++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/apply.c b/apply.c
index f2d599141d..66b8387360 100644
--- a/apply.c
+++ b/apply.c
@@ -2278,6 +2278,8 @@ static int read_old_data(struct stat *st, const char *path, struct strbuf *buf)
 	case S_IFREG:
 		if (strbuf_read_file(buf, path, st->st_size) != st->st_size)
 			return error(_("unable to open or read %s"), path);
+		if (would_convert_to_git(&the_index, path))
+			read_cache();
 		convert_to_git(&the_index, path, buf->buf, buf->len, buf, 0);
 		return 0;
 	default:
diff --git a/t/t0020-crlf.sh b/t/t0020-crlf.sh
index 71350e0657..6611f8a6f6 100755
--- a/t/t0020-crlf.sh
+++ b/t/t0020-crlf.sh
@@ -386,4 +386,16 @@ test_expect_success 'New CRLF file gets LF in repo' '
 	test_cmp alllf alllf2
 '
 
+test_expect_success 'CRLF in repo, apply with autocrlf=true' '
+	git config core.autocrlf false &&
+	printf "1\r\n2\r\n" >crlf &&
+	git add crlf &&
+	git commit -m "commit crlf with crlf" &&
+	git config core.autocrlf true &&
+	printf "1\r\n2\r\n\r\n\r\n\r\n" >crlf &&
+	git diff >patch &&
+	git checkout -- . &&
+	git apply patch
+'
+
 test_done
-- 
2.13.2.533.ge0aaa1b

