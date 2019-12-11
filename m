Return-Path: <SRS0=ratM=2B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA0FC43603
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 18:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B368320663
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 18:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="QjVxK5ss"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbfLKSqn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Dec 2019 13:46:43 -0500
Received: from mout.web.de ([212.227.17.11]:41777 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726411AbfLKSqm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Dec 2019 13:46:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1576089998;
        bh=ytmxtUS4CKF/DltdDnJ+v2+4ifjo9otG8lXSHAehKgw=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=QjVxK5ss25DvcTSoNW43ITKG2gyb+xgCcJRSdwBU7cHeMTG+rWGTs5am+IG5ZndSC
         6zZZb6o/r2tRn6c0Q79WVCcmwHfVB/MA4jSJ2ZzA1YKGBgz8UZ7C4asyb4tiHSMWGA
         KaQPNEnosnqInGSQl7IQ/nGl826mM0tbSQU3AHYU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.158.92]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M9XM3-1iZqkb1Izf-00CvqU; Wed, 11
 Dec 2019 19:46:38 +0100
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] remote: pass NULL to read_ref_full() because object ID is not
 needed
Message-ID: <24fc1649-d80c-cc4b-8268-a7833812d39c@web.de>
Date:   Wed, 11 Dec 2019 19:46:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wx9CToBd23tE3Raet9rM4tn46DwrS2h9guRLPDueSyhgloTGZMu
 xwcs67ocxhfzOz5k2PObc0mr1bLifmrGCsI8DjXPIsT7U4oJiGuREw8E44yVL3XCH4q/Q/M
 NMkCsaCtq8r243u6EXSxug3ss+y8DeeoXX1xpF6soaKDBfIXG4SobOUCITCQo3lQDnzNL5Q
 e+rxbVQe7b/1Dt71pbjxg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3+GO7rAnruo=:u1yZvyhavAPFEUOFGuEdOv
 uGhUKvW14Q+O5wifC9KQ+vcRlfWpdsuj7eVK29lFs5OgE/QBgAlJ5QCCT6SJitnS+qbEUq2nh
 krilCHpLc1cAh5hukz6NrTi6dOX3966txS8dAIUfdtS4ZaOlrOfghjoSCSys1MRJbEnJsp0lU
 wliOU1AokGEvMpmzeEO+mZ6xrVwWAsm8cgjxBR1Pzqk4QGnYkuHuiCvW0eYpiwXIV8U5OIEaO
 hyTQQq6Pj+UURq3umR2gxTaE5KhLwQNfaYLdkyGyYa+QKF1YGD4JRqGBvQzqnvwIKLbMNEI6Y
 GkRsUuCwSbHuCFbpQO4AjSE3TT/8kmtIJX6KBVbfgmGcyqrSOae7PPNA0pI4BeBjidhomRJ0X
 ipFqfqU9pbdU/Ywycq4tTpCQWieHlvTEDr+3IZzQvSYeUoB7wM7HSBOu2LHKYhzruzlEXqrkb
 Qc+LhQ+OIo8GI2P8mVcT1ukF+Lgquw2z3AO3nK1rptkuwfbVCzgF+/Muq+cY+9x6+kp/tJY2l
 sqlE9WDOXXroM1f6tfrgML62G07OaLgbUfMyyZYVv9+LBaJNlL3mUZcohaXjZYROBJcHTwlZx
 zmC9vKz5EQHV41XjRgzbf3sfu9uqfwdehxg5Dnx8pzh1Q+BMZet8CQNfu/xSqTr5WwmQFMH2g
 T7ix6fnq7f5wvqyOZuufji4jpSaLagyFVFVRBdCRqSoAaEhHGk7RJo4mgt5DywgxnEB/sEURC
 5e4xOqWc95BJ88AqTGMPDh6sZpjwMDOKiVgivr/D8aKQgrGbr7fkySoIHbg2XxyBjTqSOUgRq
 c1KMGnbKYJkNRKI2xB+1Hks71UWGvJx5PmC2v/3irWaZAgPznXfWetcTi9h+cZXuXRgHoQkLy
 up5SisyAOPsRkQqggCwH+c1dTSCiHc8fhKRLvUn8sX05hG5ICi+M9gL+rnaIjIYOz642u76lJ
 EDBPtSdmb9OtjQSmnyzqM4U15bSPQFgxHwToREreuWGyzpjWJ29q8UvInWDDUOC8shEp618Sf
 7SuhpPZiKMLdFK9u5hL3we9R4k3Lhm/blT7k5NX99LlvcdFCIXxZz4k+WxVG9/SX5mvJY6Oq6
 dt/9vZCZI1nh0sfXjrIMkLmGO92suPIXy2eV/mX2uJ4+G6vzXK1c3sAzA4bZwW1J5cT4PPm2G
 /ZBafP5KclEGyPuI3M7gRXRd3esVmENjzIkiAvzx2uTSIsFE31g5IVy5fPy60zdlhZAos5Orf
 +8GuSi07nZe7PomD2ltvsnSMhyDaEg4XgUphqAQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

read_ref_full() wraps refs_read_ref_full(), which in turn wraps
refs_resolve_ref_unsafe(), which handles a NULL oid pointer of callers
not interested in the resolved object ID.  Make use of that feature to
document that mv() is such a caller.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/remote.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index 5591cef775..96bbe828fe 100644
=2D-- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -693,9 +693,8 @@ static int mv(int argc, const char **argv)
 	for (i =3D 0; i < remote_branches.nr; i++) {
 		struct string_list_item *item =3D remote_branches.items + i;
 		int flag =3D 0;
-		struct object_id oid;

-		read_ref_full(item->string, RESOLVE_REF_READING, &oid, &flag);
+		read_ref_full(item->string, RESOLVE_REF_READING, NULL, &flag);
 		if (!(flag & REF_ISSYMREF))
 			continue;
 		if (delete_ref(NULL, item->string, NULL, REF_NO_DEREF))
=2D-
2.24.1
