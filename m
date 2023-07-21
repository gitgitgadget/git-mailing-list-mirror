Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2BF2EB64DC
	for <git@archiver.kernel.org>; Fri, 21 Jul 2023 12:41:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbjGUMlw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jul 2023 08:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbjGUMlt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jul 2023 08:41:49 -0400
Received: from mout.web.de (mout.web.de [212.227.15.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8430630E3
        for <git@vger.kernel.org>; Fri, 21 Jul 2023 05:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1689943304; x=1690548104; i=l.s.r@web.de;
 bh=engiN70y6mJgUG19Cmx3Z6psQ5jONP58BvONiPEZvVk=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=evRS4AeUD5f+HhWcftyR3aq+smtFELse5Xatnw2CC+TCPc1RefcEX1YOlbo/x3nNy9laEuK
 rsw3iHYbhNm3Xn5GfQNgNaknM1lLH9sG/HBc4VAL423ZdpukLNd3ynnjgzMJd3LswysWdRRpJ
 1EqrqBPD1jsn/8B1JJIQ0+v1vzZFudiQXkkmthEhe2YXce89fkPtRC6nmVt37G7Vjxu7PwyZ2
 dXScDgOQrVFWALcrNaxvvU2PbVQF38xAyTG7MDxd/zIHgVD0ojn25p4uHGYX0EE+RhovZ+CNv
 VxkA5AOrqSBFaRbuy1xkcLnBkb3Q6HNGXBqDz4ynu+M0kQQ6/fdw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.150.179]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MzTPQ-1q0sn20FRA-00vcwA; Fri, 21
 Jul 2023 14:41:44 +0200
Message-ID: <3f590f19-11a2-36d7-2520-1d1625ca1a25@web.de>
Date:   Fri, 21 Jul 2023 14:41:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: [PATCH] show-branch: fix --no-sparse
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
References: <d392a005-4eba-7cc7-9554-cdb8dc53975e@web.de>
 <xmqqo7k9fa5x.fsf@gitster.g>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqo7k9fa5x.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:r4mOvAE8w7cuspFkmzYM528vZXGJ4k5hffJXWLlDIIRc52M+rZQ
 tHYlRKLmL1Xz8ZWNMwsOCg/jILey9EPS0NkwkV+lFeCxOjW8lIqYlPG2s9MANUOGktj4LuF
 JQDmcpjTn7RWW5nWqSCz/VRJs+vZt94AvTX6bp4xjBWZ/gge5T7g3Cf/XbUbeqhdxTFHkTU
 ZiNUGr9dk4K3kJl5FJMbA==
UI-OutboundReport: notjunk:1;M01:P0:csrhGuA3tKY=;czm6wNMTdfAVdkvR/kGhFls+z3p
 DjekTigMJ1HzrgBWI+FIAiSy5DKh1NXnb1PuFQKWXjyGlXpaN3zab6Ey3Fy1PY7C05stAs9xm
 ZgfT7oiOpYnsmVRe8x7AYw3adQuiRi5t5MsXaDskse9XqQFW+rP5UfNZQcxqlPi8Lpo08eXmn
 TivIaloM+aW9t05yCFfPsVYqt+PfKh1O1efEUvzTsAsM95FiCntVfdkZqci7e7be+gg8MzSea
 nvSWPMLLcMkJbCm43hwbQ6RsytBze85ZqeCwn0PNy/lL7N9II2rYNaP71FZTchtN4M9uxjRG6
 M+9nPq7rO2EiyADiI+nWYHBivsd1b12TBOG0dyYGPHQ6tdm8FjdDh5db+F9ohTdBdpwjB8xzs
 CXAzvnAXKkupPJKL90Cnq4kTzaJC7xh+Pl87BeqrZKQbC+u5wmuLyPwpjTfEU7tUfoBtloTI2
 B+9qQO72YVbLDWKgc2Lp0GPXx9FxkTCMK51uGb2T4zg9JkazCk3leGeZHD50Fy/AFCDXQyhcK
 fewcHfB4v2UfQQRpMn2vNDNlNjDfdLxop4yWk+MoTwJdlIy8W+a0mgF4IGMJ/7rsgTNGMuNKz
 O5/xbKxvHWUPfiZ3Lxw66UMJVD8Y4WsjT7V/Sluy4EYbOnQPSBXBTE/sQlm90k6v4Ob3E6YbW
 TzJsWMsaj6Kte7u91cUjvTTm/Grwz1ErLFJv02iRxJYVCkPEwapn/ktCiR0Hy65g3xQcui5y4
 /0uUis7c6Ko2vb6h2Ti96DzE+3vi9I1SP2A27MgdAh7v12T4AD1suMon1i6Ckuht06LtbVOHz
 VjDJRrswbJQNfdYhMrVbphxAGlXDI42i1u+GbZG/kFjJ8JxUanug0IWtjHK1/TqX0KskYZaCE
 uDpnEeY8hZsREcNCuUNqC8rfArABpHxp9E8+1sRldo1lTUNoh8xLfl6ci2V6RFHGEBpH+AFKu
 4AlOeQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since 57343652a5 (show-branch: migrate to parse-options API, 2009-05-21)
git show-branch has accepted the option --no-sparse, but it does the
same as --sparse.  That's because it's defined using OPT_SET_INT with a
value of 0, which sets 0 when negated, too.

Turn --no-sparse into the opposite of --sparse by using OPT_BOOL and
storing the option's status directly in a variable named "sparse"
instead of in negative form in "dense".

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/show-branch.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index a86b3c7677..99b3f4a09a 100644
=2D-- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -649,7 +649,7 @@ int cmd_show_branch(int ac, const char **av, const cha=
r *prefix)
 	int with_current_branch =3D 0;
 	int head_at =3D -1;
 	int topics =3D 0;
-	int dense =3D 1;
+	int sparse =3D 0;
 	const char *reflog_base =3D NULL;
 	struct option builtin_show_branch_options[] =3D {
 		OPT_BOOL('a', "all", &all_heads,
@@ -676,8 +676,8 @@ int cmd_show_branch(int ac, const char **av, const cha=
r *prefix)
 			    REV_SORT_IN_GRAPH_ORDER),
 		OPT_BOOL(0, "topics", &topics,
 			 N_("show only commits not on the first branch")),
-		OPT_SET_INT(0, "sparse", &dense,
-			    N_("show merges reachable from only one tip"), 0),
+		OPT_BOOL(0, "sparse", &sparse,
+			 N_("show merges reachable from only one tip")),
 		OPT_SET_INT(0, "date-order", &sort_order,
 			    N_("topologically sort, maintaining date order "
 			       "where possible"),
@@ -940,7 +940,7 @@ int cmd_show_branch(int ac, const char **av, const cha=
r *prefix)
 			    !is_merge_point &&
 			    (this_flag & (1u << REV_SHIFT)))
 				continue;
-			if (dense && is_merge &&
+			if (!sparse && is_merge &&
 			    omit_in_dense(commit, rev, num_rev))
 				continue;
 			for (i =3D 0; i < num_rev; i++) {
=2D-
2.41.0
