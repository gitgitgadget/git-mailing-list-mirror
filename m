Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D35911F462
	for <e@80x24.org>; Thu, 13 Jun 2019 17:52:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbfFMRwP (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jun 2019 13:52:15 -0400
Received: from mout.web.de ([212.227.17.11]:45263 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725886AbfFMRwP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jun 2019 13:52:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1560448326;
        bh=5Q/A/IQ/elj/WJrlOjCIcV4keuh36MMt1OlxCgGMO3M=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=scqVjuKXRy+5ltGQk25gTtJl1GtMPMLoGU21lQQmqkOZm43Qo4cVh9VRzP5f6/Aip
         i5cw+fbaZ1YqPHBymfUv7bL8BazdpJqZdM/WxK9SSVVdOZrfaQLmZvl9iO9WLdngyK
         4WiXnXLZKAuK4WxpsAfMvhqSXcAt+78qq5IdE/6c=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.23] ([79.203.26.169]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LetYx-1iQo1Z3VxH-00qmJB; Thu, 13
 Jun 2019 19:52:06 +0200
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] cleanup: fix possible overflow errors in binary search, part
 2
Message-ID: <f0059613-d3e4-a1e2-2c01-727579e069d2@web.de>
Date:   Thu, 13 Jun 2019 19:51:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:20OUfR45PpMcrriGviXZJkzoCOJg2bj2kZSMQyLp29n/W05mNw6
 npaoxxlea+90Mw+MPjYlgqA875XA7yZOsKuIj1GrJfxqQ6b5ICp1ZpjbUccIQDeZltMCEsB
 e1i+X2P6aOo+J5Kl+PPrRnXDNWWNG2XsNBOVDKF0Ueu25bzRwzEVWm2wWaG/e1JFxz1zBk9
 KGp5YSyJvnjSMyH1oPvgw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xUagCrWNDLM=:myeVUSMT0B/SwYOEWCswSl
 FQbZ17whyCzixy+KR9SXA+wRa6LxVJUlxQpyXQUR/c6V4aqBVu+ffToxpYvuBPFiAT8kQAbXt
 JzGgP7l/JDHdAEuezUWy85AYPFQhI1VpbXHW3qoroGI/a/Gh8Km2W64dY+Xw1jcVCrEJ1T6zr
 r7Uc1hDfBcv8v62cwm9ZS0WwCPJr1C1LqNCbzkNQVrndRdgEqMDW+ZbC+aKVKTYycSPPbbQ+j
 lKsymFg+a1iU3A9QSamVfxzfu4/2fDys8xTKm6vBTVkEfxIjs84/RMmQI51tfPS1LOJ9GPHzF
 MsTIfHZaM+rpHlNsdqVpqUwF7se8gYSqK5XMgEq2mB2juA39El7CfJLU4m4qCdzjfnwz17A8P
 pQ2EcWKDDZPA2OYuEQXylheK9XmM9H1HnsYDa4jNTyJd94VkTtbUJAPzZskNcxBhvqrUzdLt3
 EWU05QMpRc5j2t0nrLZukM9mel/ZKj3UZChmLC4RKEZBuTshHvcGiUi4ReKIFKSVXi+Y7T7zT
 qGUKT+rN21+sdbrlmqcjbQJoay9b2IHxc0Mj6/w4uYMwF+j9CZx3xu+CAo9aooK5c9e1Gtdhr
 h0PVNzBk2VqnKymVudl38zTjmzM/LpIRWzvAswWY7Y1DvizSNwlBcy86ZvW3OrwSuSXnVUA5h
 BYUU0nvlZlLHr8bZlVayxbpMIYnGhQtvc0aswtVFKsDkmNgSuf6MXex7Q9D4tUJEJWDPZ0/YO
 8KgUmXZM7YQ69yFu17LpILvbwnYyvk6TYfiHyC9s0L80lOc87PlzudDASSevIp9UP+GiIk3uC
 nlXE2SJ8odqCAokZX1lneLyHWoD6syGMoZrV9awBccJPTCLZvM3WBvB6YMBNf02EXNKRqZesg
 ZwGDGE5dp5Ik06oOZqTHTrfoY2FFClIl0di7Ot7BXChtR2wkQ8rwZaSRweHWricN2p5Q03Dou
 6u3ZnupzVKU0t+mJ8fX6iphMSW11jftI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calculating the sum of two array indexes to find the midpoint between
them can overflow, i.e. code like this is unsafe for big arrays:

	mid =3D (first + last) >> 1;

Make sure the intermediate value stays within the boundaries instead,
like this:

	mid =3D first + ((last - first) >> 1);

The loop condition of the binary search makes sure that 'last' is
always greater than 'first', so this is safe as long as 'first' is
not negative.  And that can be verified easily using the pre-context
of each change, except for name-hash.c, so add an assertion to that
effect there.

The unsafe calculations were found with:

	git grep '(.*+.*) *>> *1'

This is a continuation of 19716b21a4 (cleanup: fix possible overflow
errors in binary search, 2017-10-08).

Signed-off-by: Rene Scharfe <l.s.r@web.de>
=2D--
 builtin/ls-files.c  | 2 +-
 diffcore-rename.c   | 4 ++--
 dir.c               | 2 +-
 name-hash.c         | 3 ++-
 read-cache.c        | 2 +-
 sh-i18n--envsubst.c | 2 +-
 6 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 7f83c9a6f2..670e8fb93c 100644
=2D-- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -373,7 +373,7 @@ static void prune_index(struct index_state *istate,
 	first =3D pos;
 	last =3D istate->cache_nr;
 	while (last > first) {
-		int next =3D (last + first) >> 1;
+		int next =3D first + ((last - first) >> 1);
 		const struct cache_entry *ce =3D istate->cache[next];
 		if (!strncmp(ce->name, prefix, prefixlen)) {
 			first =3D next+1;
diff --git a/diffcore-rename.c b/diffcore-rename.c
index 07bd34b631..6af92d5eba 100644
=2D-- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -23,7 +23,7 @@ static int find_rename_dst(struct diff_filespec *two)
 	first =3D 0;
 	last =3D rename_dst_nr;
 	while (last > first) {
-		int next =3D (last + first) >> 1;
+		int next =3D first + ((last - first) >> 1);
 		struct diff_rename_dst *dst =3D &(rename_dst[next]);
 		int cmp =3D strcmp(two->path, dst->two->path);
 		if (!cmp)
@@ -83,7 +83,7 @@ static struct diff_rename_src *register_rename_src(struc=
t diff_filepair *p)
 	first =3D 0;
 	last =3D rename_src_nr;
 	while (last > first) {
-		int next =3D (last + first) >> 1;
+		int next =3D first + ((last - first) >> 1);
 		struct diff_rename_src *src =3D &(rename_src[next]);
 		int cmp =3D strcmp(one->path, src->p->one->path);
 		if (!cmp)
diff --git a/dir.c b/dir.c
index ba4a51c296..d021c908e5 100644
=2D-- a/dir.c
+++ b/dir.c
@@ -701,7 +701,7 @@ static struct untracked_cache_dir *lookup_untracked(st=
ruct untracked_cache *uc,
 	first =3D 0;
 	last =3D dir->dirs_nr;
 	while (last > first) {
-		int cmp, next =3D (last + first) >> 1;
+		int cmp, next =3D first + ((last - first) >> 1);
 		d =3D dir->dirs[next];
 		cmp =3D strncmp(name, d->name, len);
 		if (!cmp && strlen(d->name) > len)
diff --git a/name-hash.c b/name-hash.c
index b4861bc7b0..695908609f 100644
=2D-- a/name-hash.c
+++ b/name-hash.c
@@ -345,8 +345,9 @@ static int handle_range_dir(
 	else {
 		int begin =3D k_start;
 		int end =3D k_end;
+		assert(begin >=3D 0);
 		while (begin < end) {
-			int mid =3D (begin + end) >> 1;
+			int mid =3D begin + ((end - begin) >> 1);
 			int cmp =3D strncmp(istate->cache[mid]->name, prefix->buf, prefix->len=
);
 			if (cmp =3D=3D 0) /* mid has same prefix; look in second part */
 				begin =3D mid + 1;
diff --git a/read-cache.c b/read-cache.c
index 22e7b9944e..4f81fca320 100644
=2D-- a/read-cache.c
+++ b/read-cache.c
@@ -549,7 +549,7 @@ static int index_name_stage_pos(const struct index_sta=
te *istate, const char *na
 	first =3D 0;
 	last =3D istate->cache_nr;
 	while (last > first) {
-		int next =3D (last + first) >> 1;
+		int next =3D first + ((last - first) >> 1);
 		struct cache_entry *ce =3D istate->cache[next];
 		int cmp =3D cache_name_stage_compare(name, namelen, stage, ce->name, ce=
_namelen(ce), ce_stage(ce));
 		if (!cmp)
diff --git a/sh-i18n--envsubst.c b/sh-i18n--envsubst.c
index cecfdd36c7..e7430b9aa8 100644
=2D-- a/sh-i18n--envsubst.c
+++ b/sh-i18n--envsubst.c
@@ -249,7 +249,7 @@ sorted_string_list_member (const string_list_ty *slp, =
const char *s)
 	{
 	  /* Here we know that if s is in the list, it is at an index j
 	     with j1 <=3D j < j2.  */
-	  size_t j =3D (j1 + j2) >> 1;
+	  size_t j =3D j1 + ((j2 - j1) >> 1);
 	  int result =3D strcmp (slp->item[j], s);

 	  if (result > 0)
=2D-
2.22.0
