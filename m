Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6E431F424
	for <e@80x24.org>; Fri, 20 Apr 2018 08:04:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754218AbeDTIEU (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Apr 2018 04:04:20 -0400
Received: from mout.gmx.net ([212.227.17.20]:39531 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754102AbeDTIEN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Apr 2018 04:04:13 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MYfJW-1ewrwQ3MPa-00VOZn; Fri, 20
 Apr 2018 10:04:08 +0200
Date:   Fri, 20 Apr 2018 10:03:53 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Dan Jacques <dnj@google.com>
Subject: [PATCH 2/3] git_setup_gettext: plug memory leak
In-Reply-To: <cover.1524211375.git.johannes.schindelin@gmx.de>
Message-ID: <c9502718c0ea1801a1123f976f4f8ca5332372fb.1524211375.git.johannes.schindelin@gmx.de>
References: <cover.1524211375.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:VrcNBdETrI8f4OQyyJbNQY9Urqycs8TBeA/lGky5d4dxDIG6dOs
 Re+vXP+RY1k3Eq3XKeZOcKieOKxGmBebXTph3hxO6ze33FfZD6PolgQjeHt3qPsBPZuPy+D
 wDGmhCN4at8VOI0+K+QSymjeG3KCVIDmg6heU8vJ9sblxa7BLY3Ohnxs922YqDF2A4sxYAI
 qb+NQbxQuDPuhSfntBZMg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:n3+56CZNumU=:afIW0ArdrV8bjKVipdl3A3
 inSFs8KBlQcpacqiI5nR2h9owp40ZY5H7FlGdBqVnYDR3pMwGHPGYR/g6AFA+enixcOqK8eZw
 bBpUBr1sz6cMEy6MFDf/NB+G03/9at7DaT/8pzrCToJKJ3KjFR88nuFHjn7qKzjBtl98o/5D/
 p9thHdKVDMGtNsHkfWM8raGn8VXJvsWi9OTwd0MJaYT/IVi6XChPiUWcRNXrnM+fFTXhAqspY
 iYexvk6rlR4Asu4tuWV8aq8gDYnoxPpZnreXg5v48Jabw1b3c/EUZp5mJjtg00HX4EeicR4lD
 NC2A2yXSkeR9PLS1+LgtEhGFiakizoTC7RwhwW8GfZJKZW9tR1PjAsAR+6Va+6RlFcoCMotgC
 ihxPhXUoRE4Vw0r5dhfEsqeMe9R4EspSD0Jmq3KXavkt8p894ktFOCcWbdZmJKsPBi3ZXK+Ey
 gDrYXor4+GxmUxcxd+ZRxRQhArNi4uaBv14N61hJIJ8euWbxpYjEqi/yZ0LFLZUixXsAetZQ0
 DXwYN21SlGsPM48Oc0KHIqpNxCMwcrEKVtsUk+HL8OqT80rKMi5tOjFOXS/cfLiovtiKh7P4d
 HpHh8UEKW9tMOeVUeEpptXTuLeI+qa2vQlzZw+bHHVqqLETILAkHXWGrnA0OuKTMdcL4055HG
 rRis8aaGqc2Z8Yq8Pv89Zm1mc9jntL7/zOdtwBN4Y4eVa/ZdrMuomplLrjfqGf87i4vjuzxTS
 lXtCQu6RJBTs/wmmDvWtfYLwqPm1bg1ZuMeJ+Svv2XrC+gqzfCDOZZoR1+wK5Rgir5N2CYTBw
 OOeva0MUEmWP64EscGjkdOyarERGmeAenXvhgbmH9bgdS0cmN8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The system_path() function returns a freshly-allocated string. We need
to release it.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 gettext.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/gettext.c b/gettext.c
index 701355d66e7..7272771c8e4 100644
--- a/gettext.c
+++ b/gettext.c
@@ -159,18 +159,23 @@ static void init_gettext_charset(const char *domain)
 void git_setup_gettext(void)
 {
 	const char *podir = getenv(GIT_TEXT_DOMAIN_DIR_ENVIRONMENT);
+	char *p = NULL;
 
 	if (!podir)
-		podir = system_path(GIT_LOCALE_PATH);
+		podir = p = system_path(GIT_LOCALE_PATH);
 
-	if (!is_directory(podir))
+	if (!is_directory(podir)) {
+		free(p);
 		return;
+	}
 
 	bindtextdomain("git", podir);
 	setlocale(LC_MESSAGES, "");
 	setlocale(LC_TIME, "");
 	init_gettext_charset("git");
 	textdomain("git");
+
+	free(p);
 }
 
 /* return the number of columns of string 's' in current locale */
-- 
2.17.0.windows.1.15.gaa56ade3205


