Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B9F4C433EF
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 09:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DADC961A51
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 09:10:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbhJAJME (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 05:12:04 -0400
Received: from mout.web.de ([212.227.17.12]:49643 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229702AbhJAJL7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 05:11:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1633079410;
        bh=0JPtoY5xDq3tgkgxexgL/nQg9/XjMjc+CvhgAi0iljI=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=ZknzkCPbizIZbCwQUVrwq084dcANEc+ae6i29FWYYuzFm/Jf+auIp+RXbRD/h9e1z
         15keBp3iDgeqek1V0zcDOnPASUgwC5MXE9LAQT4yyMCZ4T+joxM/38sLtXqK11A+HD
         nNeZAuBqUE3YyeQhAu/Tsm2q46pMYYL0xCwqrPVc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.20.171]) by smtp.web.de
 (mrweb103 [213.165.67.124]) with ESMTPSA (Nemesis) id
 0LyDlZ-1mrDwF1sft-015c5d; Fri, 01 Oct 2021 11:10:10 +0200
Subject: [PATCH 1/9] test-mergesort: use strbuf_getline()
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
References: <943b1e01-465e-5def-a766-0adf667690de@web.de>
Message-ID: <928cb42c-c45b-c90a-c71b-2f6669e03251@web.de>
Date:   Fri, 1 Oct 2021 11:10:09 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <943b1e01-465e-5def-a766-0adf667690de@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:obHIWkUGR86Ec+d7uVtTCydtwTQwoRF7rQjmLL0jcJfGSvIUftY
 rws3NUrj7WRMAKop+YBZikeOmozpFnehEFiquWIYYJTcs/9mEpDJ0NAy7ea8OjOZOyPGK0l
 TkSfBFZzbuSP+SykKwZEu+hu6/dVcOU4KwMJ5Ef2H+F1yaFZYGgDJPIRWonZb5cR15gKgOC
 yoJZmY1GjmFC7Y4unYUjQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uN/nnY+5Vyw=:Lltu63VQi6mcMm4xIXN7Yv
 RfbWiKG5iV2JTLg5bMUtH/0BjgAm/SenYdouxNJ3G3YzZJyP34N9BjuCjCFgy+zJkA7SJRlf5
 nKCW0HVjR7+46rrRWon50KsmWy6J3j6ddtGLyjpg90mgy9yYHSJ9qelTKOERT3Wvn0QJ3wg8T
 EfbqX9K2BVVldEeAKfKGJBq+tSz5Z9ad//s0Mw0AgQOCotH2ZbSKgnn+D32PvBI2szBqyZR7a
 ByNaZrfTgRJxjkjaP7WZnuMAvRGtM1/SApIXxsdQtbhGu6yl0zpYdzKaFpmEtuPkxfwAHEPCS
 9INIHgYCuwbPhCXRCdKFNazfDVoaXZk2MiV6F1G6qBAhHybbOUQWPbdE/lXhuJOeJ2wgkNEor
 w+EnEWW4G98RGqHFI6dcT2V+eMlOrbovI1CaJEd5OQ072HcDQxW/dLObDu/VvSokJDtwZ/4HX
 cIIDM0qjpMWLaktXK2Q2lfoCj6uabw2cNR6jEZ6sLzIIePKpbsveoTFgvBzMiOlZGOgSQaqac
 ItEvzpkLd9KgPd4xki7hWssN1tl6GDUCERkA5/70rUIgTegW4RuOvi0z+3cHxS0FwiqnL+KKl
 howVlq8C4ZqT4zaM4YLHtLXZf2jWQjzu4+xBQkQ+ovS1XV39l7lrNrpsu91lCQFDKPJf53+Jb
 i53gfEVW0SlmpCJKqn2jq3FrzUHzsrOB8CyODxDyR5Zg4URV9vbFtBmGnsTr29sLEdGQ7XyhU
 vkHayZhIBxjz4OxUu+E2b7ebcRc8QPHlvgZ6RDCZBntRpC9WFpCtT5JWpzwcpB3YlLJI7jmuH
 S7aUA7aCGYMenimWUND1jT9r7L4BIoNKZIWjeaQ4qfb3hKldANHX5eNXsqiy5oxV6RPTBv7ou
 GllEIwL1vl2FlC76QlYPwkHHgIJ5lrk58pPVtytZdMY4dDUORBIKy750DbiuqtqZ2JwE2/w6O
 E9MUjeYCkMe0+FmYHeYAaPofqmGcUZXDNBDsTbpr1gOHXlK3sZjoJY7mMbLk4S5nGDXFUpPLW
 z+Xvmn9qCJTCsXCVh1OyJ6r2TkO7hVcF9X8YBpy3WpEcpklrtEwxdMSrjWGmME8POw==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Strip line ending characters to make sure empty lines are sorted like
sort(1) does.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 t/helper/test-mergesort.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/t/helper/test-mergesort.c b/t/helper/test-mergesort.c
index c5cffaa4b7..621e2a5197 100644
=2D-- a/t/helper/test-mergesort.c
+++ b/t/helper/test-mergesort.c
@@ -28,9 +28,7 @@ int cmd__mergesort(int argc, const char **argv)
 	struct line *line, *p =3D NULL, *lines =3D NULL;
 	struct strbuf sb =3D STRBUF_INIT;

-	for (;;) {
-		if (strbuf_getwholeline(&sb, stdin, '\n'))
-			break;
+	while (!strbuf_getline(&sb, stdin)) {
 		line =3D xmalloc(sizeof(struct line));
 		line->text =3D strbuf_detach(&sb, NULL);
 		if (p) {
@@ -46,7 +44,7 @@ int cmd__mergesort(int argc, const char **argv)
 	lines =3D llist_mergesort(lines, get_next, set_next, compare_strings);

 	while (lines) {
-		printf("%s", lines->text);
+		puts(lines->text);
 		lines =3D lines->next;
 	}
 	return 0;
=2D-
2.33.0

