Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7316BC43334
	for <git@archiver.kernel.org>; Sat, 16 Jul 2022 16:58:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbiGPQ60 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Jul 2022 12:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbiGPQ6Z (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Jul 2022 12:58:25 -0400
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A980B1EEFF
        for <git@vger.kernel.org>; Sat, 16 Jul 2022 09:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1657990701;
        bh=YDfkxxYE6PZhiH5TAOTdSYIijUTWHjzAFeXWclhw4JQ=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=rkgwH0GZR6V8xI8pjrqRogQkdjrWSHTgqSimudzjBtvv0a9gW0WUKb1hbdp4pgmQx
         m/S31VVg+ZHg8OCUV4T1mFyQrgRQ68tGAknCfuizO4wXYj762Q8Y/JaFirMwQkFc01
         e6UqB8IqV5DARuUFFccRLJyrF53KmvkLpwBhHmFs=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.19.130]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MN6BN-1nwSmu1WWD-00J905; Sat, 16
 Jul 2022 18:58:21 +0200
Message-ID: <11f185bd-0117-7f1f-c97c-19cfb0de1384@web.de>
Date:   Sat, 16 Jul 2022 18:58:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.0.2
Subject: [PATCH 06/10] blame: use DEFINE_LIST_SORT
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
References: <4d7cd286-398e-215c-f2bd-aa7e8207be4f@web.de>
In-Reply-To: <4d7cd286-398e-215c-f2bd-aa7e8207be4f@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XY1IRe4wQi/JGm6AxE3Fm9ntGUGreRMTKtFBhL6l3Ka+BZ4CQpK
 YoaM57nE8tPy4hc9fKEWFRG8GQhaeChCA3fnfkopX24OcmicdG6hDvljEPtzBozPNeaTL/J
 CtjxRO5suBhrdUrrWTgCAU/EhsW9YLVR8VD8COFH6JYZQISp+KuCH9fRlf7+2Q7ETBmm9u2
 wQTDGNArx43nq/YA5OBCw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:La4eu1O1mcI=:jbr88lfGNusRa0O6eSx7j/
 vD6CkUAU9Pic7nIY3XrP23/uXg+/KwfujIghCvF34KMhcKKGjYbvJQD9cjjgNmHmMIi95EliL
 vGMknrnh8FG92YnTGTEG4ne0EeiunIUg2zem45zTagZRhiSxGmVjV5n+DUTrDFUsyZdXBR0bL
 u/TkTwfui163DExgZjVjDXiILkLklpwLQupPuArp0k3Z/2WARFvF29RCDKODY5XfESKABX7Af
 4Ecmc2gJI9X3ZmwCnAMLF/Cb1sZDVJRrTD9Dpy5Gkj/ct2JkPacfFfmRf59H1AUA1kTNQ7Oj/
 x910exIU5vzdt/CoHVigWj+BZ2YZo6PBtDTdRI+TGvvKS2lpZ+qHu2XSbEQzRSahmySZhtvPO
 2z6AdY1638QZHlJoT0JFNDzlPl4WAeIRflhflVAnxtmZwC44dTUp9mOceF8WSqs3Q0jFE2BMH
 nMIWWhT318lOHp55R6v27VCLIm+m/oxXxxeHXN+zAqFWizMW9yL8i1CezQPfT2KKcC0TG8UAF
 +KFomg9G2OG1s3HIWA/veY2iw9osWlGcEw3327schmFeoF/sE3tz1WXttcrgyKhYvSIzi8uoq
 2mT74jB2PL4qYcSF+Mt0BBZJMmcNjMrMrquqebhicLofQtcDw7bwo2ZOi506bmy5ONthBRDlF
 Kz7bTH6WWfllueZlYMzDY0K5JM69pllK8vt3rYKc4cRZXWPK9YU2xOAXGs27spDbhfZSApX9p
 EH+LF9pLqDGopmQHseDaATMKs4F92F4JDiy6cMIycYr9jRftKDnjI6ulC/OoVlbOZkKplpX1l
 QCvtYurkxixJuxALAl5/iSqGRav27gMMiz3zHfXuWA98kjsNT6V/DZcYTd7436R4AIGKyTogU
 lC6voWOwJRDwlJbuHuJDGUbusuT+68G0lRC7NUuXGRYo8ngCW7SXVCQ7wnWJcpl5hB/OVJsLh
 O/VlamUPJZIBTodQKX81l2nm0/wj8IAxyxEcomoSNkRMICz9iTdIIs6dbPY+M6VqH1lTUqDF0
 EkEp8/oeQN/6TGySbcE/xYNF1luJ+HXEeNOKhdpiMkokJzKRSx7h189VnFvohFM+j++oN5Fmv
 WLWivD+O1Tu3y2OZjLnduYQmeXFDTRYXtk60Qx9z4RRoPjr6WrDqEY0Cg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Build a typed sort function for blame entries using DEFINE_LIST_SORT
instead of calling llist_mergesort().  This gets rid of the next pointer
accessor functions and their calling overhead at the cost of a slightly
increased object text size.

Before:
__TEXT	__DATA	__OBJC	others	dec	hex
24621	56	0	147515	172192	2a0a0	blame.o

With this patch:
__TEXT	__DATA	__OBJC	others	dec	hex
25229	56	0	151702	176987	2b35b	blame.o

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 blame.c | 30 +++++++++---------------------
 1 file changed, 9 insertions(+), 21 deletions(-)

diff --git a/blame.c b/blame.c
index da1052ac94..8bfeaa1c63 100644
=2D-- a/blame.c
+++ b/blame.c
@@ -1098,30 +1098,22 @@ static struct blame_entry *blame_merge(struct blam=
e_entry *list1,
 	}
 }

-static void *get_next_blame(const void *p)
-{
-	return ((struct blame_entry *)p)->next;
-}
-
-static void set_next_blame(void *p1, void *p2)
-{
-	((struct blame_entry *)p1)->next =3D p2;
-}
+DEFINE_LIST_SORT(static, sort_blame_entries, struct blame_entry, next);

 /*
  * Final image line numbers are all different, so we don't need a
  * three-way comparison here.
  */

-static int compare_blame_final(const void *p1, const void *p2)
+static int compare_blame_final(const struct blame_entry *e1,
+			       const struct blame_entry *e2)
 {
-	return ((struct blame_entry *)p1)->lno > ((struct blame_entry *)p2)->lno
-		? 1 : -1;
+	return e1->lno > e2->lno ? 1 : -1;
 }

-static int compare_blame_suspect(const void *p1, const void *p2)
+static int compare_blame_suspect(const struct blame_entry *s1,
+				 const struct blame_entry *s2)
 {
-	const struct blame_entry *s1 =3D p1, *s2 =3D p2;
 	/*
 	 * to allow for collating suspects, we sort according to the
 	 * respective pointer value as the primary sorting criterion.
@@ -1138,8 +1130,7 @@ static int compare_blame_suspect(const void *p1, con=
st void *p2)

 void blame_sort_final(struct blame_scoreboard *sb)
 {
-	sb->ent =3D llist_mergesort(sb->ent, get_next_blame, set_next_blame,
-				  compare_blame_final);
+	sort_blame_entries(&sb->ent, compare_blame_final);
 }

 static int compare_commits_by_reverse_commit_date(const void *a,
@@ -1964,9 +1955,7 @@ static void pass_blame_to_parent(struct blame_scoreb=
oard *sb,
 		    parent, target, 0);
 	*d.dstq =3D NULL;
 	if (ignore_diffs)
-		newdest =3D llist_mergesort(newdest, get_next_blame,
-					  set_next_blame,
-					  compare_blame_suspect);
+		sort_blame_entries(&newdest, compare_blame_suspect);
 	queue_blames(sb, parent, newdest);

 	return;
@@ -2383,8 +2372,7 @@ static int num_scapegoats(struct rev_info *revs, str=
uct commit *commit, int reve
  */
 static void distribute_blame(struct blame_scoreboard *sb, struct blame_en=
try *blamed)
 {
-	blamed =3D llist_mergesort(blamed, get_next_blame, set_next_blame,
-				 compare_blame_suspect);
+	sort_blame_entries(&blamed, compare_blame_suspect);
 	while (blamed)
 	{
 		struct blame_origin *porigin =3D blamed->suspect;
=2D-
2.37.1
