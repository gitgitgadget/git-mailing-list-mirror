Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB86ECAAD2
	for <git@archiver.kernel.org>; Sun, 28 Aug 2022 10:34:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbiH1KeN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Aug 2022 06:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiH1KeM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Aug 2022 06:34:12 -0400
Received: from mout.web.de (mout.web.de [217.72.192.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B80081B792
        for <git@vger.kernel.org>; Sun, 28 Aug 2022 03:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1661682846;
        bh=E+LtwnkhWXhMdxd5XXdpJnPNzGVBFf3B7HDBILfLOaU=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=WxSzKMdU9CgPVELXdr6ZM6HLRY3wg8ZWwu0RRe5zDl0CSFTQ3QQp134+i0d18fuZx
         Qk1tU0kGEP0I0vkgp2J3ZwRJJopm31Co3I38yS4gVD4pu6p9Gs9AsrkNPkYFzYGorF
         tG8vZi7AVYOcJVAI3VRB5yHSyqsvnUzwKN2lfo2M=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.35] ([79.203.21.84]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MElZB-1ocUM92u5r-00GU2g; Sun, 28
 Aug 2022 12:34:06 +0200
Message-ID: <63cae51b-877e-0ca5-c61a-bf4f72d7dc8c@web.de>
Date:   Sun, 28 Aug 2022 12:34:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: [PATCH 1/2] test-mergesort: read sort input all at once
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <128f0fb8-d29b-8622-0cfe-2ecadc999db5@web.de>
In-Reply-To: <128f0fb8-d29b-8622-0cfe-2ecadc999db5@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Zcz91f7RdViMoJuIP20sjfuaedx0KyxVGjhk1YPKTtTaLUfIARu
 a3bwHapgXbqo53QJCAjuVQjhj0OCCDFH1m1l/ckYLp8MC1Fo/NzzzfCgKpG3ax5rzQzC9z9
 HlETk3u4WFcAT9+Qn8YGlu8IBfDImhY1nvP0/sIOOkuXBMBjXv78uRFVUww7xfaMCvDnl9d
 TMO2dFZwPBpJ7JRMRypzQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:siClq0baGIg=:f+jCv8MwUP7VvSMpdeJYi4
 OCYAjpajeBgOUpE2IS452l952QJKrZWubV1hv7GdDwaLda0NHxtEcPSLU1rjKwhLMQNKhoCrv
 OZhhLN4MyrMLpD5YFsgqNzwRL8iHcn2CjKhPYhrTmBwweaiyAeDbznGAr/M21RwlIn48gzWOX
 RXbUejP+1ca3Mbg1YfDnRhTvHZGVknQSlBUbrcYgiZhlZu+EdSgXiebUc5ve3/9eb1gbFXzl6
 xRwj4bCrU6Pw4AuzCU8XwZjwlxTqT/zBFqvRcJaH7HHxNo92AqSge9HcjFb7Stb43xHlFE2L/
 bPHgrM941Xv026VmI4JP6KI3HaBhKbgvnVdF6tzSMYuZPYBTxRKtKlxDsLicVXJ6Z2GvrKV1/
 ShdvkUGRxVf+n6EwNagUIIjxOOY6H6Fg7OyFTZtyaQysBFs7lsWyUG+Tnl5NgkiKZTy56NZGJ
 tCf1rb2WAx9kv0hhBGVgg2/3vZUlmS+PNUi69YagIPRJfIFqYds/Vxtuv4zKizKh4kadHx9q3
 ZntdiZT9cSgj4Lp7Oey/Hrv0yWApJSESsYm5DOZNeRjnKpgElOPcuVZ4IG2Quz1r9zs2uOTtH
 oF7A6/8sgVxlYMWb+hyoNNvvxRhgji+HnE4WyxqNM3ATILDwmBZjnueR5qFIDW6pfFUSuvizl
 Awrz1xd/syyE2ELPBH7iZdJXTy21VepJdwtZ752wvfQ8AGTw37+DDemrsBd/3HbmuQYqlMlIy
 95oz6YOA82vajYxXEpWT31dZJvGvuNWermFaBarJO+0wvX9qee+rXx3uYgy2gHKuXwXQ0UgxK
 jkHpNi1lwCIcSqfQUbi4wmtHd3mPLNMoPf+/+JybovZ12deCxnMOtvjfEme/tYgCSMBEwPV6q
 KpwBvEWhR/s7hRajeunz1Wwg/Jn+6WItifyhiBziTOUbq8H8e6VgibunU6se0NsWhPWX5KW1t
 XAgPgzxAtloFATjdUgX7u3k2SNS0R1ndZLUB3naDsV81+tj3z4PCIe3aY7G9DMkXhx5bWbTsH
 mjPtPFt+gRqUbqHeMn7IyfTY0+QDkthZS/3c3m5dIf2JiWE9aAdAYnVegGGEO6ptEr+m60n01
 etcw5HYsi9q2wC61I5RFYrg5m/90SOlGiFv
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The sort subcommand of test-mergesort is used to test the performance of
sorting linked lists.  It reads lines from stdin, sorts them and prints
the result to stdout.  Two heap allocations are done per line: One for
the linked list item and one for the actual line string.  That imposes a
significant amount of allocation overhead.

Reduce it by doing the same as the sort subcommand of test-string-list,
namely to read the whole input file into a single buffer and then split
it in-place.

Note that t/perf/run can't be used directly to compare two versions of
test-mergesort because it always runs the helpers from the checked-out
version.  So I hand-merged the results of separate runs before and with
this patch:

macOS 12.5.1 on M1:
0071.12: DEFINE_LIST_SORT unsorted     0.23(0.20+0.01)     0.22(0.20+0.01)
0071.14: DEFINE_LIST_SORT sorted       0.12(0.10+0.01)     0.10(0.08+0.01)
0071.16: DEFINE_LIST_SORT reversed     0.12(0.10+0.01)     0.10(0.08+0.01)

Git SDK 64-bit on Windows 11 21H2 on Ryzen 7 5800H:
0071.12: DEFINE_LIST_SORT unsorted     0.71(0.00+0.03)     0.54(0.00+0.06)
0071.14: DEFINE_LIST_SORT sorted       0.42(0.00+0.04)     0.21(0.03+0.03)
0071.16: DEFINE_LIST_SORT reversed     0.42(0.06+0.01)     0.21(0.01+0.04)

Debian bullseye on WSL2 on the same system:
0071.12: DEFINE_LIST_SORT unsorted     0.41(0.39+0.02)     0.29(0.27+0.01)
0071.14: DEFINE_LIST_SORT sorted       0.11(0.08+0.02)     0.07(0.06+0.01)
0071.16: DEFINE_LIST_SORT reversed     0.11(0.08+0.02)     0.07(0.04+0.03)

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 t/helper/test-mergesort.c | 38 +++++++++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 13 deletions(-)

diff --git a/t/helper/test-mergesort.c b/t/helper/test-mergesort.c
index 202e54a7ff..540537224f 100644
=2D-- a/t/helper/test-mergesort.c
+++ b/t/helper/test-mergesort.c
@@ -22,21 +22,33 @@ static int compare_strings(const struct line *x, const=
 struct line *y)

 static int sort_stdin(void)
 {
-	struct line *line, *p =3D NULL, *lines =3D NULL;
+	struct line *lines;
+	struct line **tail =3D &lines;
 	struct strbuf sb =3D STRBUF_INIT;
-
-	while (!strbuf_getline(&sb, stdin)) {
-		line =3D xmalloc(sizeof(struct line));
-		line->text =3D strbuf_detach(&sb, NULL);
-		if (p) {
-			line->next =3D p->next;
-			p->next =3D line;
-		} else {
-			line->next =3D NULL;
-			lines =3D line;
-		}
-		p =3D line;
+	char *p;
+
+	strbuf_read(&sb, 0, 0);
+
+	/*
+	 * Split by newline, but don't create an item
+	 * for the empty string after the last separator.
+	 */
+	if (sb.len && sb.buf[sb.len - 1] =3D=3D '\n')
+		strbuf_setlen(&sb, sb.len - 1);
+
+	p =3D sb.buf;
+	for (;;) {
+		char *eol =3D strchr(p, '\n');
+		struct line *line =3D xmalloc(sizeof(*line));
+		line->text =3D p;
+		*tail =3D line;
+		tail =3D &line->next;
+		if (!eol)
+			break;
+		*eol =3D '\0';
+		p =3D eol + 1;
 	}
+	*tail =3D NULL;

 	sort_lines(&lines, compare_strings);

=2D-
2.30.2
