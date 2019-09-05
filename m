Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FF851F461
	for <e@80x24.org>; Thu,  5 Sep 2019 22:49:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388938AbfIEWtK (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Sep 2019 18:49:10 -0400
Received: from mout.gmx.net ([212.227.17.22]:32857 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388014AbfIEWtK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Sep 2019 18:49:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1567723736;
        bh=UYI0iOs94YWxw+je0eT4angiO4VJNZ9HC79OATPTagU=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=H2E346KXj41Yg12T8MdM5e2yg4NHO328Uv5UxJDz8qx7tRjBMfE/1EDLSv+b3EeTN
         ne061BdOxUxMbEVutowb352dgBPszQ2mYzfKU1FVABUaq0IxiSMVn2iBb1PQTOS08/
         VpRD+gCzc4FZPrC8PioSyl/yRSwbed0/SNIfIPdo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([88.70.128.63]) by mail.gmx.com
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MowKc-1iVkbG2674-00qVzF; Fri, 06 Sep 2019 00:48:56 +0200
From:   Stephan Beyer <s-beyer@gmx.net>
To:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Paul Tan <pyokagan@gmail.com>, Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Shawn O. Pearce" <spearce@spearce.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Stephan Beyer <s-beyer@gmx.net>, git@vger.kernel.org
Subject: [PATCH v2 2/4] test-read-cache: fix maybe-uninitialized warning for namelen
Date:   Fri,  6 Sep 2019 00:48:31 +0200
Message-Id: <20190905224833.24913-2-s-beyer@gmx.net>
X-Mailer: git-send-email 2.23.0.43.g31ebfd7ae6.dirty
In-Reply-To: <20190905224833.24913-1-s-beyer@gmx.net>
References: <20190905224833.24913-1-s-beyer@gmx.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:C3tvh2epfMGWr5aBeX0vSlSKNIXKxddiDBfHG+JLUXRa/C2p1Yf
 HcTrvkTEwkjLToQyTYzbuqKwLoTZlrmmZWsOwjeWGnyvMMkIiWGGiQkUpW7WMPpmYijE/nT
 ijQhxi/exjALYgR3MhCqL6XOfG7Ve+UrXTZsyiC4MNLB4ihxUdEco5ckm4Fd2Wle7CwjY7+
 AZdxgoLG5fENVaWDsg2tQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rxBlS7Ik2+U=:k2geS4Nxsohh+ln4i3zFuH
 bYEzgK9yYD3lA7yoARjD6yTe3EXUxjQCledGXojH8PfhkT6l/rqBWJk4ae9P7Xli5ArNsVLF9
 0FA3WNdCyoqcovHk3FhqhMlSmPrOMuydoIqjvsXxY0Ufz4x738jGBOxCctS7QdWwiWsDP6xg3
 ERHlaK/gK6ZSfjYA+wneTgqbQ+8SchDenw2DlVissrxT68ETBpKls/I2MM8hforU91AUiaFXp
 7QpcwyEBQudXg4wuWgB5QZGwiRFx97k6yLaX8ImAJuZ+YzJMk2BoOBtSIvtB2V07KuO+AbVBc
 5Sae9Vcn2ATLiIYMpAXc6feV1zhDsq3mxuYD3chim49QqCsDa0Xmxh+zAjmGI2hqRGrnyCtYD
 4Ls6mmtF4OWxN7ndC+2Wr7ME/RRmBwORS+zliyMQSAA1MGqkZtN5HRGrXa+ZVLxu8+VlvLxmm
 BGHg3v7SywVveb1wJ0jQqwSMzLUL6ALEKli66WfwmYYIuC4R99SSpZScqLGhdJoH6lcDm4dOq
 HfFwgVuX+4+XgP4gcKK+zOxVNwjUqUociQvOHc1e16TLd75126or2zvhlki3dy4cGGaJpfwAN
 gcyzYkEVu+0Ju7UyEl/jUJ7uBjzM37BqK4Oj8c51o3vys1Ww3YjS49+nyCuXgXZL8191x+SNb
 5nThgrtLLb6zGhDcf52isw9f61W71NHiCBy95k1lFi9QbfEmBoLHQGI8S+4RP5DE/+obtZSvA
 P3mwWJq4UpECI4arn46E2lk4uZrJYhkMmLn3W5b9vtD0Rydx/5OySqv2XG476ohh/DGcZaXA0
 uncA9ESBtqokopc7nSbHMhfvI3RtonBnHKX/8x4Gpn490bzpXkcvSHIcLwhIQHbq0Xz+rGpJH
 8RikK8L9Crx16A0kDVGpZNUGnVSYh/BAtik+wDmcNTU7eo676XjtqUu06sk0qkKMh9X/dU+yA
 DqsnvCT9MX/Si5yypbueXjP2JrIh1kMJT5o+erMm53x8JHicvFz5Wr7GG8Y9AG1GZzhvtHah3
 +icDs69AevEfD0spp8YlUDBhn0fOLZBCv+133RUz6Eb5KyF4kXogfztuVAH5OBHAZ4/IGQaLl
 //44VYMEwAGiMH+gnBh8L4esl0rsfofCw+1a8RrtxQBO3EhNCwRZGscgkz8YguODGDHxzbc2c
 uaOVK4ngYD16FoCeb43R3OxCSRnR6OMNnpXh8plxWy/poxJcPiNissPSyrEjPy4f4iyzk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is done by removing namelen at all. It is only used once
and simply strlen(name), hence we use strlen(name) directly.

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
=2D--
 t/helper/test-read-cache.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/t/helper/test-read-cache.c b/t/helper/test-read-cache.c
index 7e79b555de..244977a29b 100644
=2D-- a/t/helper/test-read-cache.c
+++ b/t/helper/test-read-cache.c
@@ -4,11 +4,10 @@

 int cmd__read_cache(int argc, const char **argv)
 {
-	int i, cnt =3D 1, namelen;
+	int i, cnt =3D 1;
 	const char *name =3D NULL;

 	if (argc > 1 && skip_prefix(argv[1], "--print-and-refresh=3D", &name)) {
-		namelen =3D strlen(name);
 		argc--;
 		argv++;
 	}
@@ -24,7 +23,7 @@ int cmd__read_cache(int argc, const char **argv)

 			refresh_index(&the_index, REFRESH_QUIET,
 				      NULL, NULL, NULL);
-			pos =3D index_name_pos(&the_index, name, namelen);
+			pos =3D index_name_pos(&the_index, name, strlen(name));
 			if (pos < 0)
 				die("%s not in index", name);
 			printf("%s is%s up to date\n", name,
=2D-
2.23.0.43.g31ebfd7ae6.dirty

