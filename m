Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93FE1C636CD
	for <git@archiver.kernel.org>; Sun,  5 Feb 2023 10:36:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbjBEKgg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Feb 2023 05:36:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjBEKgf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Feb 2023 05:36:35 -0500
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E051E1FB
        for <git@vger.kernel.org>; Sun,  5 Feb 2023 02:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1675593389; bh=mlsENJCHFprolVpNQ87a4pSMyaoMkcXnYVOYGOZgcgw=;
        h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
        b=TKDqnBI2TGfDYjO2MH8V8rt3/rjG9AMFhh5VFE53spVUr8YGzoHvEEFKLZw0023Wp
         TyYNkqahy5ss75Ch1kOkJCbrGFN16u1TzTyUwm/TBOyALM3jqaRs354gvUGQd72H2+
         sI7GDBgWPV4rV+EUo+XyK1on38q0DCemJOsxstHrgHBm0euWB5uarDgJNM4fWFmHPl
         2rxZNATt2nsCnaWTrHjpDp5rQO/vFGdsOq02EAl77lnkRtX6I0kTcYlY1FE69baEax
         ya0IIWuySdSydPRqAfJ/KNVKMrIHty3bBdbhaLbS1TfGc/N1cbX5ieeZ/Cgkph4nrk
         pR8biLjvSXjfw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.21.51]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Md6xz-1ooSLv3I5T-00aDlM; Sun, 05
 Feb 2023 11:36:28 +0100
Message-ID: <d272fd03-a005-f6ad-3f00-6b1a970a519f@web.de>
Date:   Sun, 5 Feb 2023 11:36:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Content-Language: en-US
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] read-cache: use size_t for {base,df}_name_compare()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Vs+yX1dT8EIkVeob8n0UMUTeEze5qCCmT3EE69Ywi/kgPaFqoGK
 8dEs0FbkPY83t4Sio2YmEsXwQt0nOCibPQO5Nm7XReT0lDWY0QWHF7SJ6BcBL//XvU8ec51
 lOY/MXE9fc/rN8B1NV/GFM0u4Wp1xarPtQAYkMqV/xbRY5gdHMIfvMAFyU6rvzydXb9Hsq5
 3DK5d6RMpLfKKrece0+QA==
UI-OutboundReport: notjunk:1;M01:P0:dbq/gZtwhMA=;Qov65GRIJ/wq15EFopk8tro0/xn
 HsgXDIg+fX5qjNeO7WHIV5w/WPaKcLgnQRTneVKy4CdWbqGeAQbfGR+iNJYkNoMogJOsLJPtt
 ZXISV9QNp+ny/TOVUvIEEq4jCECzXDlZ9r/1I4V8glq8UtMK3yLwDX/AgNGjC2kwAVrrP4+vG
 8wAJPmKx361i3R4TIo4hoplVSLcKDP/tGqcX8NltuRrn9LQqA6mAhKu/RMM+6f//3lbomY3RP
 NPC/IuAfyVvMKBhUriNK7rat+mlKJY/mT89bttcalzexIzA9Y+pDD1m7GLJ+vsG05b+CmIv5W
 Mt4ZrvVUvJhZL3ROCY/l/GH1mVluye3r8gCR1i4JDA77/BE49skJaM4M3+6ba9Yz8mbfCfR1q
 L9bdhHihb0ErjEXBjyRicPMyvhBRU74wvyQtECBsdviSnJjxkcZBEZDFmP5VXgO2N8wu9aPEH
 o311OOvCRNNgde2GEGnP0wA65EaVfhAa7PH1gkeU2c8qRpqJr7EtXVELb5b/7Tpo/4DveyQFp
 UbsQr3iHbakqtzvG7IR0wq125JTWi7+NY5qEZizizDqvk62gvLRcNqoDZhpviOJE0zj/Ik4dq
 igXj/nAbjpNUrc85nV+oMPc04aFXiowOQYitFjuiS/yW5Uy6u4mk5i0B4ZhXodgjqGFzmSCXE
 2JpXGFkkAC2iRztXcQYMMK+grdvQgZOlbVltNWTKqJH3WQZOlaRg4mAkZs7l9mxYzUY+lGvnL
 2dLGSI75nObjANehjZPqXT+g6R8HFj8RN0PvURuxXqzhFrXW35mk2Zo73FD5DjcvnwpnSvkzb
 ytEk1OPBRxIQ73fF4uoATipm+wOcDAtZNvm+DL9LBFYk300GWWbpIiMRdGpQNQ09cEsAUNIVR
 c42w9J5CqnjHdMmw9ojGlDr7DJNWdw2yVpDAJJ4PZLVBAzx67lRVetgHTUHGxp0O+mOhKdyS+
 ZeZ07A==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Support names of any length in base_name_compare() and df_name_compare()
by using size_t for their length parameters.  They pass the length on to
memcmp(3), which also takes it as a size_t.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
Formatted with --function-context for easier review.

 cache.h      |  6 ++++--
 read-cache.c | 13 +++++++------
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/cache.h b/cache.h
index 4bf14e0bd9..52d017335e 100644
=2D-- a/cache.h
+++ b/cache.h
@@ -1623,8 +1623,10 @@ int repo_interpret_branch_name(struct repository *r=
,

 int validate_headref(const char *ref);

-int base_name_compare(const char *name1, int len1, int mode1, const char =
*name2, int len2, int mode2);
-int df_name_compare(const char *name1, int len1, int mode1, const char *n=
ame2, int len2, int mode2);
+int base_name_compare(const char *name1, size_t len1, int mode1,
+		      const char *name2, size_t len2, int mode2);
+int df_name_compare(const char *name1, size_t len1, int mode1,
+		    const char *name2, size_t len2, int mode2);
 int name_compare(const char *name1, size_t len1, const char *name2, size_=
t len2);
 int cache_name_stage_compare(const char *name1, int len1, int stage1, con=
st char *name2, int len2, int stage2);

diff --git a/read-cache.c b/read-cache.c
index 7bd12afb38..35e5657877 100644
=2D-- a/read-cache.c
+++ b/read-cache.c
@@ -488,56 +488,57 @@ int ie_modified(struct index_state *istate,
 	return 0;
 }

-int base_name_compare(const char *name1, int len1, int mode1,
-		      const char *name2, int len2, int mode2)
+int base_name_compare(const char *name1, size_t len1, int mode1,
+		      const char *name2, size_t len2, int mode2)
 {
 	unsigned char c1, c2;
-	int len =3D len1 < len2 ? len1 : len2;
+	size_t len =3D len1 < len2 ? len1 : len2;
 	int cmp;

 	cmp =3D memcmp(name1, name2, len);
 	if (cmp)
 		return cmp;
 	c1 =3D name1[len];
 	c2 =3D name2[len];
 	if (!c1 && S_ISDIR(mode1))
 		c1 =3D '/';
 	if (!c2 && S_ISDIR(mode2))
 		c2 =3D '/';
 	return (c1 < c2) ? -1 : (c1 > c2) ? 1 : 0;
 }

 /*
  * df_name_compare() is identical to base_name_compare(), except it
  * compares conflicting directory/file entries as equal. Note that
  * while a directory name compares as equal to a regular file, they
  * then individually compare _differently_ to a filename that has
  * a dot after the basename (because '\0' < '.' < '/').
  *
  * This is used by routines that want to traverse the git namespace
  * but then handle conflicting entries together when possible.
  */
-int df_name_compare(const char *name1, int len1, int mode1,
-		    const char *name2, int len2, int mode2)
+int df_name_compare(const char *name1, size_t len1, int mode1,
+		    const char *name2, size_t len2, int mode2)
 {
-	int len =3D len1 < len2 ? len1 : len2, cmp;
 	unsigned char c1, c2;
+	size_t len =3D len1 < len2 ? len1 : len2;
+	int cmp;

 	cmp =3D memcmp(name1, name2, len);
 	if (cmp)
 		return cmp;
 	/* Directories and files compare equal (same length, same name) */
 	if (len1 =3D=3D len2)
 		return 0;
 	c1 =3D name1[len];
 	if (!c1 && S_ISDIR(mode1))
 		c1 =3D '/';
 	c2 =3D name2[len];
 	if (!c2 && S_ISDIR(mode2))
 		c2 =3D '/';
 	if (c1 =3D=3D '/' && !c2)
 		return 0;
 	if (c2 =3D=3D '/' && !c1)
 		return 0;
 	return c1 - c2;
 }
=2D-
2.39.1
