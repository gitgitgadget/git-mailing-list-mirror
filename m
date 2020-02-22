Return-Path: <SRS0=hy0J=4K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6178EC35671
	for <git@archiver.kernel.org>; Sat, 22 Feb 2020 18:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 409F9206ED
	for <git@archiver.kernel.org>; Sat, 22 Feb 2020 18:51:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="knRBb80/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbgBVSvY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Feb 2020 13:51:24 -0500
Received: from mout.web.de ([212.227.15.14]:34531 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726550AbgBVSvY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Feb 2020 13:51:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1582397479;
        bh=EAFKJ539zq0g/L/8WSR6UYDLdgFnriWzSMyj4CaDeTw=;
        h=X-UI-Sender-Class:To:From:Subject:Cc:Date;
        b=knRBb80/dS64IJt7I4yiUCQWwXmYak2XBXW/fPRBmxcHCQt2X6BUKUjBWnjtM+J03
         sXEV3E7TgIbY/WzjqAOGZ3Tl+EJHggEkK+tszIJKsx84oMwV8Lx3GusakzPmju6L0q
         L+Myz6dK2lvKsJi9evvDXuzvQ2IvlScOtVwVHwuw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.21.89]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MTyEL-1iwOwA2IsL-00QnJv; Sat, 22
 Feb 2020 19:51:19 +0100
To:     Git Mailing List <git@vger.kernel.org>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] use strpbrk(3) to search for characters from a given set
Cc:     Junio C Hamano <gitster@pobox.com>
Message-ID: <4140dade-d999-a74a-1f8e-06eedb84ed20@web.de>
Date:   Sat, 22 Feb 2020 19:51:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MbiiU0eY46kOkf2swYFYHFZ6BNSuNCLr5xQt/64aavO0BRX0twX
 fyuhOyRbQhiZBOniolXh/wEvawg0a5mCjuqY5ftNjfHEnMLPWALFilBhbylj+KCVECZt0uj
 V10Rz8Eqg97Rvi7BaOWXxyL4Pp5CbRn0RI0bDYIk5VaqmJlYcEM1+yusfB+LkBkgim8iy9c
 vh91cpFA/cg+T9JkaMs8g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jJIHXNXc948=:52Ri1wQ0JcwLHIMegBEPHf
 PQPr4nV63XFRwJlUti/p3KJNAq8c0IiPJtSX+soEETB2/YLYkub2YvWjk9A5KbONj0Ee7S+FJ
 hgeNiM1kZnY9TY2kiIjv348GPYxnI7osA/cHxAvrFojfbUsZ521eKcTNCwWC5/7X8LVT3rdHz
 AbzeUvfNj9u8htMFPeBQdSv7/Drbe/Ga9w2ZZWkVcMDtzRJUNTXi6vj8MzulEIPjbbqyXpRux
 33VRHLifRlYz32ug+0QU+zWX/zlInQAlkktk852NXhVOs5KElPE+XB2gTyzRL0PwrBf4alw+Q
 8o3x0uTPXwDyhDw6dsTCZu5fL2m9o5+MpRJPn0wnUPFn4E4pTwEUOOpHmGz9IZNRo8GjQVE9B
 8oCKdMxlRTyhGevabJYcdhI9Gaf8UAGdBPfRtI91lZr+0zckBjHLE0t5N38hY3eVpt/XcJHXM
 idqMLvUBTSlCr0kMtIKXKCcxwhLRIAk+vLbMV6W/6zzCFgnIUBfTMlO6VBdENzR1MYtm6oCx0
 j8IrpyoGiKARmLJNUaHiFFf2Zl+gHDX3KwQdysYhWXwfYWei2wLro4G63YxOUHph5BV+USQ9b
 +iB1IAyI7MsKA1ku/sBZOtVEUgScFu1z7FqhzQ6bcBnGamWeUcqr8oc9B8wkKDnvazS4hWx/7
 60V8YVu9k3Bu8GlBvlp/M4GC+CqxpDxT4JNLkVKpF5VLyEAi4kYnUAeg9Ox5is8Ssn+elgeb/
 v46w7rEMq/N6GCG+i/GtAMFuY4O/H72t6qWTrmNha2rvW4w+EQSASd6arkJVbU2HWN79wVF38
 /kdWXgWfQfLljY8AImxHCM30KLS8ecTK6qszcYiW1AX7r11n5guMizTVPd+7pyKWJiznfo6f8
 bdKgLORj/1uWg+blBu1XxzMFhPDO5Vh42iZDJkHAXPcLrVaZ3W7WD+MjSV1pLa1Qsm6QGJqvu
 yetSVT59Wsz8U7HXStfG0VBE5c7RLyKXOfJ+gcACXeBGdGvJ3uzX0IliQkRwkCy4N8WBNleX3
 kTJbGHM7vcReLnrDpxexuRvtEgs+IUFHX7GHRj7yEk80FC1yIK7RwotM9HoEtIixLjLykV2y+
 wSY/fx2LSoOXQp83yXAtWbzKBf8A+pJPDMhwH/CiI9tZdPnBJArFVYIxkrZL3U5fGrJNTwxrx
 OnSVLw1o+NdG1XSJxdWec6cmqB5ytleNChb+GSOjmqydKCW2RhgsFSxPuM4PCWbVVRdtAmCMY
 1ZtMSxkkvsfHKxYpC
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We can check if certain characters are present in a string by calling
strchr(3) on each of them, or we can pass them all to a single
strpbrk(3) call.  The latter is shorter, less repetitive and slightly
more efficient, so let's do that instead.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/show-branch.c              | 2 +-
 compat/mingw.c                     | 2 +-
 mailinfo.c                         | 3 +--
 t/helper/test-windows-named-pipe.c | 2 +-
 4 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index 35d7f51c23..8c90cbb18f 100644
=2D-- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -536,7 +536,7 @@ static void append_one_rev(const char *av)
 		append_ref(av, &revkey, 0);
 		return;
 	}
-	if (strchr(av, '*') || strchr(av, '?') || strchr(av, '[')) {
+	if (strpbrk(av, "*?[")) {
 		/* glob style match */
 		int saved_matches =3D ref_name_cnt;

diff --git a/compat/mingw.c b/compat/mingw.c
index b5230149db..d14065d60e 100644
=2D-- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1245,7 +1245,7 @@ static char *path_lookup(const char *cmd, int exe_on=
ly)
 	int len =3D strlen(cmd);
 	int isexe =3D len >=3D 4 && !strcasecmp(cmd+len-4, ".exe");

-	if (strchr(cmd, '/') || strchr(cmd, '\\'))
+	if (strpbrk(cmd, "/\\"))
 		return xstrdup(cmd);

 	path =3D mingw_getenv("PATH");
diff --git a/mailinfo.c b/mailinfo.c
index cf92255515..742fa376ab 100644
=2D-- a/mailinfo.c
+++ b/mailinfo.c
@@ -19,8 +19,7 @@ static void cleanup_space(struct strbuf *sb)
 static void get_sane_name(struct strbuf *out, struct strbuf *name, struct=
 strbuf *email)
 {
 	struct strbuf *src =3D name;
-	if (name->len < 3 || 60 < name->len || strchr(name->buf, '@') ||
-		strchr(name->buf, '<') || strchr(name->buf, '>'))
+	if (name->len < 3 || 60 < name->len || strpbrk(name->buf, "@<>"))
 		src =3D email;
 	else if (name =3D=3D out)
 		return;
diff --git a/t/helper/test-windows-named-pipe.c b/t/helper/test-windows-na=
med-pipe.c
index b4b752b01a..ae52183e63 100644
=2D-- a/t/helper/test-windows-named-pipe.c
+++ b/t/helper/test-windows-named-pipe.c
@@ -19,7 +19,7 @@ int cmd__windows_named_pipe(int argc, const char **argv)
 	if (argc < 2)
 		goto print_usage;
 	filename =3D argv[1];
-	if (strchr(filename, '/') || strchr(filename, '\\'))
+	if (strpbrk(filename, "/\\"))
 		goto print_usage;
 	strbuf_addf(&pathname, "//./pipe/%s", filename);

=2D-
2.25.1
