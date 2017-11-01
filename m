Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89B67202A0
	for <e@80x24.org>; Wed,  1 Nov 2017 14:44:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754706AbdKAOor (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Nov 2017 10:44:47 -0400
Received: from zucker2.schokokeks.org ([178.63.68.90]:44337 "EHLO
        zucker2.schokokeks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751853AbdKAOoq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Nov 2017 10:44:46 -0400
Received: from localhost ([::1])
  (AUTH: PLAIN simon@ruderich.org, TLS: TLSv1/SSLv3,256bits,ECDHE-RSA-AES256-GCM-SHA384)
  by zucker.schokokeks.org with ESMTPSA; Wed, 01 Nov 2017 15:44:45 +0100
  id 000000000000000D.0000000059F9DDDD.000079F2
Date:   Wed, 1 Nov 2017 15:44:44 +0100
From:   Simon Ruderich <simon@ruderich.org>
To:     =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 1/2] wrapper.c: consistently quote filenames in error messages
Message-ID: <32c515d01d4257c1532004d0bf21b2c330f6b81b.1509547231.git.simon@ruderich.org>
References: <22afeefa-cdd5-cd32-0a7c-6bad4de79f05@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <22afeefa-cdd5-cd32-0a7c-6bad4de79f05@web.de>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

All other error messages in the file use quotes around the file name.

This change removes two translations as "could not write to '%s'" and
"could not close '%s'" are already translated and these two are the only
occurrences without quotes.

Signed-off-by: Simon Ruderich <simon@ruderich.org>
---
 wrapper.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/wrapper.c b/wrapper.c
index 61aba0b5c..d20356a77 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -569,7 +569,7 @@ static int warn_if_unremovable(const char *op, const char *file, int rc)
 	if (!rc || errno == ENOENT)
 		return 0;
 	err = errno;
-	warning_errno("unable to %s %s", op, file);
+	warning_errno("unable to %s '%s'", op, file);
 	errno = err;
 	return rc;
 }
@@ -583,7 +583,7 @@ int unlink_or_msg(const char *file, struct strbuf *err)
 	if (!rc || errno == ENOENT)
 		return 0;
 
-	strbuf_addf(err, "unable to unlink %s: %s",
+	strbuf_addf(err, "unable to unlink '%s': %s",
 		    file, strerror(errno));
 	return -1;
 }
@@ -653,9 +653,9 @@ void write_file_buf(const char *path, const char *buf, size_t len)
 {
 	int fd = xopen(path, O_WRONLY | O_CREAT | O_TRUNC, 0666);
 	if (write_in_full(fd, buf, len) < 0)
-		die_errno(_("could not write to %s"), path);
+		die_errno(_("could not write to '%s'"), path);
 	if (close(fd))
-		die_errno(_("could not close %s"), path);
+		die_errno(_("could not close '%s'"), path);
 }
 
 void write_file(const char *path, const char *fmt, ...)
-- 
2.15.0

-- 
+ privacy is necessary
+ using gnupg http://gnupg.org
+ public key id: 0x92FEFDB7E44C32F9
