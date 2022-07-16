Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82716C433EF
	for <git@archiver.kernel.org>; Sat, 16 Jul 2022 17:01:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232235AbiGPRBc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Jul 2022 13:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232217AbiGPRBY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Jul 2022 13:01:24 -0400
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B76B220192
        for <git@vger.kernel.org>; Sat, 16 Jul 2022 10:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1657990878;
        bh=2PBc5Mm97PDs6p4eVbaOqO0otjiRK9R0XgecFLIufvI=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=hJtA1IYBG+a0BKjk2ggwpdvKR9JyM+7cx9pY5unrFmU1jJwWzSFCC5l/KSphJm+IX
         zcUU5APuzNMTIHaVDYPYYjhUDXkZqwo7SEs8SDP1HE2L7/pGl1NbGhZUmkQJGMuirq
         JMnCR+BXGtfhCU6b/xR/OmiVp1LXAc3W7yhOYbCU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.19.130]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MJFhX-1nx0Uv2Fbf-00KpWv; Sat, 16
 Jul 2022 19:01:18 +0200
Message-ID: <a041739a-cf0c-ac8d-c8ec-5c046575f59a@web.de>
Date:   Sat, 16 Jul 2022 19:01:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.0.2
Subject: [PATCH 09/10] packfile: use DEFINE_LIST_SORT
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
References: <4d7cd286-398e-215c-f2bd-aa7e8207be4f@web.de>
In-Reply-To: <4d7cd286-398e-215c-f2bd-aa7e8207be4f@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:c3b2zSJwD/w/2vIdfS3w53gkzn2VK8cVhNJ6gk7G04TE5UX0zzL
 kO0VroPiZdd+kwdVn8ak7UTOSWkOMMPDE+3KUH++7SYARvc53RhFEX5obDlG8iM9bae46L6
 pIq/np0IL9pnR0uPAO6+wvINR8pAMCZwn58TWpLHYvthLwgdtTFQ9XsXbgKeEVPbcgTUoZy
 tqwLVVQf/3PAS5htSU0qQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tIIJFPm8NBg=:84BKTMxaiErJRcCNowDuoE
 bOQ2xg0M4/K9b4d/H86gID3iMnUvmSC5fhfwZNnZ42lnfWSjM32VEa3qSMaCoK2rm02ktyagt
 tyAYDfMbgXBDoEuWAjRp2PU+iaxiXH6G3Gq7IDCqd0hHOotmNO5CUFKSQOiAgufzrukknbF3w
 HHbGpgLPXaUejwOk56/E+eG6cRZV0PSUvhCRQGQB5DOF3g8It89nu4iPbRKBHOOcoYIyCdtnz
 E3X58LroEpuvhxLMuooOlqRMMZSxddjR6bDzUT6fsBOqR6kjabkw8oJ8ud/U2eRROmdAcA+z0
 5T+sb/FsuMRx0goAuF+y7v3T5pqY76nD8t2avFvV4pSGMc+2g+fv213Ey4lnxq1X8Er1VxoqD
 U4+lEi1cq7FPkrG8FE3WSCycL6UA/Oxgrcw1iq2MBZnyhM1ym5UV0osTGvqWUulR2XBgLyOrp
 jzR1Q8s8UNJj545fQXjolbVjUvVV2wi4YrqI1FUPwT5+/Xjjk3YIIT41vsYJQsV2nGZ55JrSf
 sFC9bfkbY5EcaI7YubaVnkl9gm5M8/gtKvpEJcOZeap7PMDCw20LN70lhIsVki1/NsFc7wQv0
 o1r433vMFzotLK9VFsh1kGX9QQx5X1CEBIfaCHUk4nufEqRp8eUWg2Dov3By4lAbEK/U+H7iA
 bZrS/RVHObFUm6UoQ2IVKjuOXBmgfcPK52p+mMUiIliCL34GbTohM+jzW5i4f1fNSJe26k3nH
 M1p6hHWYHHif85zrwCiX9HVQhQOfwUl55Iq/5r9EhoW6wQ7bhgGNlGrd5tOzRLM6agNQUoyRt
 TKl2/yA0+YEDcNxl+E8Z5awNZwOV34LcDv7+Tw70v315O8l4gy9kxp2lp6jlpTsOBF3HTn1yK
 +ipDWaB1zq24ljKwNT7erWYh8nC2brXh5/F+tEXS4WKWpcj7W096kNyBsWnTvxs5MYoOCaQyv
 nj4GXbS/hQjiMpC0N0NGATbn0Mtst113go75JO595E01I01Gk6GFUoEg7HDfVT9HDIYntIxUN
 ElRUsZxD1ya+p67QPcCY0QopgZfW5yVbakgP0BXwjUaLiCQD9IjgmItWl8lbjHysNPBnRD/pQ
 s5LZ3WtXnBIE6jz2xlKW8/9TmR363YLVMHESmAZv3dzG//3H/+L3O/wHg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Build a typed sort function for packed_git lists using DEFINE_LIST_SORT
instead of calling llist_mergesort().  This gets rid of the next pointer
accessor functions and their calling overhead at the cost of slightly
increased object text size.

Before:
__TEXT	__DATA	__OBJC	others	dec	hex
20218	320	0	110936	131474	20192	packfile.o

With this patch:
__TEXT	__DATA	__OBJC	others	dec	hex
20430	320	0	112619	133369	208f9	packfile.o

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 packfile.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/packfile.c b/packfile.c
index ed69fe457b..6b0eb9048e 100644
=2D-- a/packfile.c
+++ b/packfile.c
@@ -941,20 +941,10 @@ unsigned long repo_approximate_object_count(struct r=
epository *r)
 	return r->objects->approximate_object_count;
 }

-static void *get_next_packed_git(const void *p)
-{
-	return ((const struct packed_git *)p)->next;
-}
-
-static void set_next_packed_git(void *p, void *next)
-{
-	((struct packed_git *)p)->next =3D next;
-}
+DEFINE_LIST_SORT(static, sort_packs, struct packed_git, next);

-static int sort_pack(const void *a_, const void *b_)
+static int sort_pack(const struct packed_git *a, const struct packed_git =
*b)
 {
-	const struct packed_git *a =3D a_;
-	const struct packed_git *b =3D b_;
 	int st;

 	/*
@@ -981,9 +971,7 @@ static int sort_pack(const void *a_, const void *b_)

 static void rearrange_packed_git(struct repository *r)
 {
-	r->objects->packed_git =3D llist_mergesort(
-		r->objects->packed_git, get_next_packed_git,
-		set_next_packed_git, sort_pack);
+	sort_packs(&r->objects->packed_git, sort_pack);
 }

 static void prepare_packed_git_mru(struct repository *r)
=2D-
2.37.1
