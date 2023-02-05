Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F413C636CC
	for <git@archiver.kernel.org>; Sun,  5 Feb 2023 10:42:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbjBEKmh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Feb 2023 05:42:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjBEKme (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Feb 2023 05:42:34 -0500
Received: from mout.web.de (mout.web.de [212.227.15.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE85921291
        for <git@vger.kernel.org>; Sun,  5 Feb 2023 02:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1675593747; bh=ScogY+TgdK0VJAgHh0vkRuyNWjatAMeZ1/YcNjPAlUg=;
        h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
        b=MsL77kjE9GYCjTqtum9819Fwiyr6lEHG505pF2tjsJTRbRhdjHZqyvqECp5FMv5ZS
         C6DLmrW8W7rEC7nNfkMfoNCJ3FmAxM4cb6E6rkVRx+Ji5RzVbq9brh7OjM9vUIFlkV
         VXdGpInwmxQMeS0mEm3h6VbqWKE3VHKiCxQEudHUgReFqMjsxVjie5RU5Oi2ig1f/1
         alfV6NgGdYxhIhmd2PGyYWVBT6JdUEEh4xFrdtx4eK1KruyXxNHyu4/xJzzle2S6+O
         GEnit+shSi25amrbCZEfPkJVCcotP4Uex4xgjJNZ7PEoLGkkqOjd+6dvIRlh1u6Tqq
         VtLq5SzmVupFQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.21.51]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mxpmc-1oPWKz3Ry2-00zGsA; Sun, 05
 Feb 2023 11:42:27 +0100
Message-ID: <7315487c-c97c-b8a2-d3b2-4fbf642495dd@web.de>
Date:   Sun, 5 Feb 2023 11:42:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Content-Language: en-US
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] pack-objects: use strcspn(3) in name_cmp_len()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uU6xt4pW4XlyJx+fqJcKEVYoMe0teu5A2hnr4c8TylkdwyO7Wd2
 S8FZpomvW00vGlnmBo6uYg2cfuJwzY2L+FLM6cGXbxnZpbniWKYH+i0eLvzIgso5FZhGInz
 C606ZQUsH/HmyGjhqGGmGLJS/M14oPy63C+x+Axqwf357+i3vxY6Ll+0JWzYnp6dxi3S47w
 X0Hkpy3fkj7eWUh4tHuIg==
UI-OutboundReport: notjunk:1;M01:P0:rGkLJFzuoe8=;Y6++HIhzu1uyxxXXam+1ekCq8sJ
 0u4wNbNAfumrzmCblLCzIwtlNYczVJolG8Zpv6c8DtP5yCDtGpvc7aDBit8vQ4NqUkAHodHFC
 wRRlQUrwfT1kH/VT43pYquyPi+nYFCwcCopvxBOXaA27AfDlQSQsWZQGVIqCgmwnAtS6D1xwb
 xryf8yO5NiWFTXWM7LsKDQRkJ8KD5wLuIkaHdk6liLf52ocZAD/ff8mghOq5MNgbVzE6AuazF
 SoxkqhbG3ZJPaVVwIIYaZvSEWAzT2Lx81/uQiwPlh4glbpg8kfHpOTQDfThtgxjFxx+qTK5l4
 YojxkCJ29n4L0XBZU7A3BJps+nVYjLGdxRbKLMsE10F6dmQ6Mns8cSNA1aU9c/ZnstiW1Fov8
 w7SUimFKWOq3cDqhWJ0JHDjL7zmb0K2cWjF2VkOCBucULQU21RGh9nSLBcvfVgFIX7x0BMFMS
 O0gEVC8z/WvHLocON+w7GKt46JQmX9LULArlWpCACSHt7bIUQXmNUquKoObyEKWW31JbQhTeH
 e84nAJ0i5WD0mK3xykku5MGoChDFfmaNE9qOBTmj8F/NolAc7/GQeQun5DUrhXDyv2ouRUke3
 /yz+k1vgrNKHqdNYZ/qXUSrMAghNpt4FgLxUaUbSpMCb1/x9w1D4Fx1omwbl2mYo59oYYSOZM
 jIibUT9ApVHZ+/zga920MozP4Of+WtV3cFBoZF2thHORkwvLgtej0+4UD0xYMe7nVOWALoN8t
 zc91z3okq213Qt/3+v5s32b3EZxX8ie+d/8p7hTccXV3DG4F0FIizhSfWTSMjWlKlZeAkqffz
 LqlDKpO5YoGylvNO89B5aVI4s//GYh1eS4mwZMmfyAfilLntSSMlYfWVXY/ngoa8kI8KUcpDp
 8reJ4qFTY2A1AQR3P7CBta3JJTr/6jTBZtxKpq1Xp167rWHARqigLgTlJibK4S0NtwNG4bdNx
 RQJHOQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Call strcspn(3) to find the length of a string terminated by NUL, NL or
slash instead of open-coding it.  Adopt its return type, size_t, to
support strings of arbitrary length.  Use that type in callers as well
for variables and function parameters that receive the return value.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
Formatted with --function-context for easier review.

 builtin/pack-objects.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index cabace4abb..536edc3a48 100644
=2D-- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1708,50 +1708,47 @@ static void pbase_tree_put(struct pbase_tree_cache=
 *cache)
 	free(cache);
 }

-static int name_cmp_len(const char *name)
+static size_t name_cmp_len(const char *name)
 {
-	int i;
-	for (i =3D 0; name[i] && name[i] !=3D '\n' && name[i] !=3D '/'; i++)
-		;
-	return i;
+	return strcspn(name, "\n/");
 }

 static void add_pbase_object(struct tree_desc *tree,
 			     const char *name,
-			     int cmplen,
+			     size_t cmplen,
 			     const char *fullname)
 {
 	struct name_entry entry;
 	int cmp;

 	while (tree_entry(tree,&entry)) {
 		if (S_ISGITLINK(entry.mode))
 			continue;
 		cmp =3D tree_entry_len(&entry) !=3D cmplen ? 1 :
 		      memcmp(name, entry.path, cmplen);
 		if (cmp > 0)
 			continue;
 		if (cmp < 0)
 			return;
 		if (name[cmplen] !=3D '/') {
 			add_object_entry(&entry.oid,
 					 object_type(entry.mode),
 					 fullname, 1);
 			return;
 		}
 		if (S_ISDIR(entry.mode)) {
 			struct tree_desc sub;
 			struct pbase_tree_cache *tree;
 			const char *down =3D name+cmplen+1;
-			int downlen =3D name_cmp_len(down);
+			size_t downlen =3D name_cmp_len(down);

 			tree =3D pbase_tree_get(&entry.oid);
 			if (!tree)
 				return;
 			init_tree_desc(&sub, tree->tree_data, tree->tree_size);

 			add_pbase_object(&sub, down, downlen, fullname);
 			pbase_tree_put(tree);
 		}
 	}
 }
@@ -1795,21 +1792,21 @@ static int check_pbase_path(unsigned hash)
 static void add_preferred_base_object(const char *name)
 {
 	struct pbase_tree *it;
-	int cmplen;
+	size_t cmplen;
 	unsigned hash =3D pack_name_hash(name);

 	if (!num_preferred_base || check_pbase_path(hash))
 		return;

 	cmplen =3D name_cmp_len(name);
 	for (it =3D pbase_tree; it; it =3D it->next) {
 		if (cmplen =3D=3D 0) {
 			add_object_entry(&it->pcache.oid, OBJ_TREE, NULL, 1);
 		}
 		else {
 			struct tree_desc tree;
 			init_tree_desc(&tree, it->pcache.tree_data, it->pcache.tree_size);
 			add_pbase_object(&tree, name, cmplen, name);
 		}
 	}
 }
=2D-
2.39.1
