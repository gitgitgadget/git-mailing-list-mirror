Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90178C433EF
	for <git@archiver.kernel.org>; Thu,  6 Jan 2022 09:51:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237581AbiAFJvH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Jan 2022 04:51:07 -0500
Received: from mout.web.de ([212.227.15.4]:48429 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237370AbiAFJvG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jan 2022 04:51:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1641462661;
        bh=5cNi6g6qo5b18tZz9kmUhmT63aZV9sPCYQBFu6ae2HE=;
        h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
        b=gNw1N5Uq0oiz5/rSFu7Qz3/RRTzFB8b8UejdzObd7AukG+yxYawlwBlfEJiptOEdQ
         A9iIh2r4U/DStjZC78GjnUmwzP3Y31yjWuqeTUqZbNojqdiCZ4L4nKJxofwYAzOymQ
         OW33gAE02D5kLZlF2GyxT2aIp/BIHnINNvil6s/4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.22.121]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MdfCH-1mWLaO1FHl-00ZOav; Thu, 06
 Jan 2022 10:51:01 +0100
Message-ID: <ea01f9b6-2ce3-57e8-533f-4cc29937f700@web.de>
Date:   Thu, 6 Jan 2022 10:51:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Content-Language: en-US
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH 1/2] grep: use grep_or_expr() in compile_pattern_or()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OgwvFwGCgP/A89yi0vOF/yscESgVWdne15kqSjZ+kek23tNjeBs
 yamswcOxLNi6XsQjt9/Y4Quqz4SgJQlt3wzeXewKsxtaPhlJu7/JhucmdeZfvoGGRz+V6MJ
 GL9Q0NGXn6fTbiO7OI+BovZLqodFlEwFz+Sb2RbwD05RYMn1avLN6OPdhvFKKcy5B/bDCfj
 tKL2RNB4dtGOSnD34+z3A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cPUNTp3VNbQ=:j/MayfGxNXquFyLWErh/zc
 GuNowKYRTip0scqmWfsZz7JJ54eMzzY2FAIDEVyrfV3cWhKsEu928r65I5W3DbIjBPE1JSPHN
 7/FNCd4AEFLTm7xnb2c4ivP/+5rk4quaN89KfJBaTU1q5SEa07b4HRWY+OpcsxiJoEZUEdJsx
 RiTJ4gmlAXNDqmk2saptEzOKdU9z1n8bxHszo/eyTDHCxgZ2osL5ZozpdOq49v31ercZ8HYyy
 ZPR5DHwf2NwA/HjWKuuPqTn50Ak/umBDtFMiDipCru+HhAGRR/fRDcBKA+vtYnAfiRRD1jR8R
 TEOBroLFJQaDTOMh2ObRoJpZ6zkETqozgYI/lj1Tv8lfqKnB6Pr3S7tqPEuGpYTbh7XFdGyES
 WoLzg5EBaNnis7ezKZsm/ay1FLTRlRd+pMaxQJJ3x4V1iA9ZF/nruW04WR8JoOkUEz4yke2Or
 HlP1gyLQoTIvHl4SqS8sqZQAgqhUD3MFrgvNpWQ2iMpig1pKTqe3ntiKAWwiVKDh84VkEPKbm
 53NZEhIg29w9CUTcX4hKuoBrYXULOdtxZJOwOSd+joP+ewmEcWObDXUNejMNwmlk8DgYh4rVi
 smSTwMfeOitiWpfW3+e0JFXa2c9uf82ObGcB2+649jDrLq+6M6vEkGVhumE+0hG9aAXRInilT
 S8+lCnQeqr9bgieky2/vrkWOu5HHbgeQUz6jOk1I19aiH9Juzby40amRGKZXEFK2BZswAwk2q
 Q+LmK5veJcoVXDWPtLJ1ro43yn3KkVTgxc0Zmy3Y9t+iVt/ePPwX7w0yTW3QPyOkw7J+V8RzG
 /g1DI+J9xyfMTwyJFBWCOulO0+JVcsF2QmnbW3SGct2vfJcaQ7d6y51T40Fq/K/j/OG0a+L5J
 PXgah5fUKI72MxM6elJ8B+stkIK0SlYnYut7zWU0Q9VHj5G+Bx/YOVe10UPAPBgrHoxvgWDgk
 FlF5/Lqrk5+xoEOcTsXb/5HcDyrY75OUjvTgCvIvxGIXJQ0BX0/781BWHkAM+z3mz0WL4H+OY
 6OaeJDFjcrrgJiAfAX5Jzu7QBXUDy/V1PPCzbXITHMNvCEKy9icmTugJhE3+9odJ/A==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the definition of grep_or_expr() up and use this function in
compile_pattern_or() to reduce code duplication.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 grep.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/grep.c b/grep.c
index 47c75ab7fb..f1bbe80ccb 100644
=2D-- a/grep.c
+++ b/grep.c
@@ -595,6 +595,15 @@ static void compile_regexp(struct grep_pat *p, struct=
 grep_opt *opt)
 	}
 }

+static struct grep_expr *grep_or_expr(struct grep_expr *left, struct grep=
_expr *right)
+{
+	struct grep_expr *z =3D xcalloc(1, sizeof(*z));
+	z->node =3D GREP_NODE_OR;
+	z->u.binary.left =3D left;
+	z->u.binary.right =3D right;
+	return z;
+}
+
 static struct grep_expr *compile_pattern_or(struct grep_pat **);
 static struct grep_expr *compile_pattern_atom(struct grep_pat **list)
 {
@@ -677,7 +686,7 @@ static struct grep_expr *compile_pattern_and(struct gr=
ep_pat **list)
 static struct grep_expr *compile_pattern_or(struct grep_pat **list)
 {
 	struct grep_pat *p;
-	struct grep_expr *x, *y, *z;
+	struct grep_expr *x, *y;

 	x =3D compile_pattern_and(list);
 	p =3D *list;
@@ -685,11 +694,7 @@ static struct grep_expr *compile_pattern_or(struct gr=
ep_pat **list)
 		y =3D compile_pattern_or(list);
 		if (!y)
 			die("not a pattern expression %s", p->pattern);
-		CALLOC_ARRAY(z, 1);
-		z->node =3D GREP_NODE_OR;
-		z->u.binary.left =3D x;
-		z->u.binary.right =3D y;
-		return z;
+		return grep_or_expr(x, y);
 	}
 	return x;
 }
@@ -714,15 +719,6 @@ static struct grep_expr *grep_true_expr(void)
 	return z;
 }

-static struct grep_expr *grep_or_expr(struct grep_expr *left, struct grep=
_expr *right)
-{
-	struct grep_expr *z =3D xcalloc(1, sizeof(*z));
-	z->node =3D GREP_NODE_OR;
-	z->u.binary.left =3D left;
-	z->u.binary.right =3D right;
-	return z;
-}
-
 static struct grep_expr *prep_header_patterns(struct grep_opt *opt)
 {
 	struct grep_pat *p;
=2D-
2.34.1
