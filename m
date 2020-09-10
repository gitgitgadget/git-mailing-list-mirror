Return-Path: <SRS0=4khD=CT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A9DBC433E2
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 17:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAC1420719
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 17:03:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pjXuMrbj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbgIJRDT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Sep 2020 13:03:19 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53882 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727094AbgIJRCc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Sep 2020 13:02:32 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0AE0CFEECE;
        Thu, 10 Sep 2020 13:02:18 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=dykOb3ZypdPJEX40sk7we6g5d
        pE=; b=pjXuMrbjt9g7sNlB9wCXYaN6zhde5+aye1rwuEYlxUuF2LSpznJNsRKye
        jfy8ixCP31WnpY/KrGSCPHmlvE15B1VNaC9dR/qOIGtYmFZ3ItpxxyCPiHxCCJdS
        o5ECC6xcZNm9PAppBA5AjjPeUJmFNHqvclA/lu3nYGcpz4tD88=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; q=dns; s=sasl; b=XAcfesw+Pbmhk01ugir
        o7vBCClqFtO9CBZR/RoXyMUNx8fwIEWTQo84N7QbaAbvsR77nqmUiJVbm9w/X6oP
        fj1RA40i9bBANA0l/7tJi97HdCVvW7+zxWRBklhqBtBy10IH3tqWFMCqfERUkVin
        f1fQZkNv917VSHDC2vT/NaJg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E596FFEECD;
        Thu, 10 Sep 2020 13:02:17 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [35.190.152.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2F00EFEEC9;
        Thu, 10 Sep 2020 13:02:15 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH v2 6/7] quote: rename misnamed sq_lookup[] to cq_lookup[]
Date:   Thu, 10 Sep 2020 10:01:58 -0700
Message-Id: <20200910170159.1278781-7-gitster@pobox.com>
X-Mailer: git-send-email 2.28.0-603-ga98dad7d4d
In-Reply-To: <20200910170159.1278781-1-gitster@pobox.com>
References: <20200908205224.4126551-1-gitster@pobox.com>
 <20200910170159.1278781-1-gitster@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: 606C47A2-F387-11EA-8FB2-843F439F7C89-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This table is used to see if each byte needs quoting when responding
to a request to C-quote the string, not quoting with single-quote in
the shell style.  Similarly, sq_must_quote() is fed each byte from
the string being C-quoted.

No behaviour change intended.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 quote.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/quote.c b/quote.c
index b8107cd403..9a6e0e7dea 100644
--- a/quote.c
+++ b/quote.c
@@ -210,7 +210,7 @@ int sq_dequote_to_strvec(char *arg, struct strvec *ar=
ray)
  */
 #define X8(x)   x, x, x, x, x, x, x, x
 #define X16(x)  X8(x), X8(x)
-static signed char const sq_lookup[256] =3D {
+static signed char const cq_lookup[256] =3D {
 	/*           0    1    2    3    4    5    6    7 */
 	/* 0x00 */   1,   1,   1,   1,   1,   1,   1, 'a',
 	/* 0x08 */ 'b', 't', 'n', 'v', 'f', 'r',   1,   1,
@@ -223,9 +223,9 @@ static signed char const sq_lookup[256] =3D {
 	/* 0x80 */ /* set to 0 */
 };
=20
-static inline int sq_must_quote(char c)
+static inline int cq_must_quote(char c)
 {
-	return sq_lookup[(unsigned char)c] + quote_path_fully > 0;
+	return cq_lookup[(unsigned char)c] + quote_path_fully > 0;
 }
=20
 /* returns the longest prefix not needing a quote up to maxlen if positi=
ve.
@@ -235,9 +235,9 @@ static size_t next_quote_pos(const char *s, ssize_t m=
axlen)
 {
 	size_t len;
 	if (maxlen < 0) {
-		for (len =3D 0; !sq_must_quote(s[len]); len++);
+		for (len =3D 0; !cq_must_quote(s[len]); len++);
 	} else {
-		for (len =3D 0; len < maxlen && !sq_must_quote(s[len]); len++);
+		for (len =3D 0; len < maxlen && !cq_must_quote(s[len]); len++);
 	}
 	return len;
 }
@@ -291,8 +291,8 @@ static size_t quote_c_style_counted(const char *name,=
 ssize_t maxlen,
 		ch =3D (unsigned char)*p++;
 		if (maxlen >=3D 0)
 			maxlen -=3D len + 1;
-		if (sq_lookup[ch] >=3D ' ') {
-			EMIT(sq_lookup[ch]);
+		if (cq_lookup[ch] >=3D ' ') {
+			EMIT(cq_lookup[ch]);
 		} else {
 			EMIT(((ch >> 6) & 03) + '0');
 			EMIT(((ch >> 3) & 07) + '0');
--=20
2.28.0-603-ga98dad7d4d

