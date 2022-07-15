Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D14FC433EF
	for <git@archiver.kernel.org>; Fri, 15 Jul 2022 03:59:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241091AbiGOD7O (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jul 2022 23:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232138AbiGOD7N (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jul 2022 23:59:13 -0400
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C03474D3
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 20:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1657857532;
        bh=9pepL+HHllr690b/7WSo/Ju89rHorEygW1tOQHG2Kac=;
        h=X-UI-Sender-Class:Date:From:Subject:To:Cc;
        b=gaxqoz0L+8/G09hd93QKxIX7O9Untbhn4vrOxTwj3ZI81zGQ9APzkIB0bIJx3jF6M
         Nod3zIOEVwl5yLAuhtbyLMW2bcCCxWddq57DFbnoibDF2oFiGhKTgYUp3lYrVwYHLC
         ggcf02+dFpXmCAp7/fHNh7/bYImdCim/913BMkvs=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.19.130]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mrww5-1nicH83q8D-00npqw; Fri, 15
 Jul 2022 05:58:51 +0200
Message-ID: <7265e37f-fd29-3579-b840-19a1df52a59f@web.de>
Date:   Fri, 15 Jul 2022 05:58:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.0.2
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [RFC][PATCH] mingw: avoid mktemp() in mkstemp() implementation
To:     Git List <git@vger.kernel.org>
Content-Language: en-US
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3EhERv/a8cg+2rO0PE5XMT1NOdZuf0HALxEWyyIU4IAL3erO4zj
 cF0BFtX0k8oPdHemVRItOEmJXAoUcSMyhPMdHdqgWwR0QylapX1XyErZMm+4dw9ZHFvEPt8
 jABOoJh3Qh/QYJ5vLZs4nsmVdIz+jaC3uexsHQg6t50WRhkWbClRFfYQ7IrfaqYpt8R8KEI
 QnlN6JTwvwH6f5pHzu2Xg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:L/U6sTanU+g=:JiHDLt/eV3zLstWnYNkZBQ
 jEACDxbouBJEKmSCIO1JLUoFedLQIUgX8cZfz6Un9Cv3IHJ4jjkhgyOMikj9GjsnfidFE6Lj4
 0z0/fzkgZOv5tAWSRyPFN4qLSYJUFd3mFHQqWjRaC3VVeIxtbI3PgAzCKnIXbJ4HlDfQdofHo
 kM6/ncXmi93F3y7R2MlNsSb/9rUVvJ8k/BWwBzyTSNVE1s/aQXAOOiyAHupt+3CushjlBKr/n
 B0leR98g2GlkDtoThqJtrOe66dFGNsJxMHby/8zZrfKgekZ2tBzdP57NVz9E5xexmzxpaXiML
 06z5caUqJ+KRSBbpR5wtI3UZr04xBdD0WAWZ5Sv8jDxyFIADPvjK+lIHtGjnQlI17ORgCaNGz
 OJVcaqUKcZ31KG1h3yQ+E5JtYj95Jb/2Vq7/X/BWaJyr8G+6a/1Q/j08tGjKdz+8NFzZCXvTd
 gNinkoqDlzq2mQglssM9SvBbT3ATcgO+JazWEa9XHFAP8+Sl/V1breyiHcArifQKD6U7sDnYD
 n19ewLXVcUFejr6Ctjc1n44xoauNb6MPpWjSGXT3qLjUHeeBYzKyqvpty5hDXE9ytF867ycnM
 5Z4kQt+XsPfxo/80HsvRJWL8HINWENYlo2SPrGFZjuGARnf5sdziQMKBaGxLS2UkkjH/AcPQh
 1SwYTsH4NmDi5XjpU8wb8h0RA1/zjwsx4uuUhyJU3wicNhbRi0a167prFA2a9na105LCmEVp0
 iYdQposcY618lhMK4g4IDRAskOvogqlZ05WKg1MtvMuappLMPlka6uzhu/3YW66De9seCbiiD
 sV2SpO/8q2CLzWHWtEYhH9gsuf7TfSBwfO22a4WlEM1z+nnKcDsA2uOqu9IWqaHdDRgBXAz8K
 WrbCmb9laHj3x4fa40pKfN2X+gGKhDT+NBGu8qaKGduIWhAzAiZKHwsxFqH+f/7wUM8KJaAyy
 3hsTQtEMkUdyARzu0wgpHhhwyuA+NwEspUKgwOpjFIOJfAw9V4FKsCvyNFzyIEsu/oRg/bfRe
 Sdb6C2L4Y9HEsFx+hAy1vhm+618zB4JhxagMUoSzjup1B+GCnRmbC3M9jeiK4hjmA0XBq1Qgu
 kkqu/2Y9OrN+E9J8coz7120kPqMdL4El4u+
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The implementation of mkstemp() for MinGW uses mktemp() and open()
without the flag O_EXCL, which is racy.  It's not a security problem
for now because all of its callers only create files within the
repository (incl. worktrees).  Replace it with a call to our more
secure internal function, git_mkstemp_mode(), to prevent possible
future issues.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 compat/mingw.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 2607de93af..b5502997e2 100644
=2D-- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1059,10 +1059,7 @@ char *mingw_mktemp(char *template)

 int mkstemp(char *template)
 {
-	char *filename =3D mktemp(template);
-	if (!filename)
-		return -1;
-	return open(filename, O_RDWR | O_CREAT, 0600);
+	return git_mkstemp_mode(template, 0600);
 }

 int gettimeofday(struct timeval *tv, void *tz)
=2D-
2.37.0
