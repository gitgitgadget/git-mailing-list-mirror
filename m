Return-Path: <SRS0=BxWL=AF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 522C0C433E0
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 13:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EE9420857
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 13:05:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="r7QB/gGa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390437AbgFXNF6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Jun 2020 09:05:58 -0400
Received: from mout.web.de ([212.227.17.11]:35445 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389393AbgFXNF5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jun 2020 09:05:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1593003939;
        bh=gCbnfYd727MVPhXgHRyIJiDCRalemQq/QEaTVC4Z9k0=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=r7QB/gGaOIxWQHjqHGFIONJESnFx+vxEt6eLTWuXyDQkkgV0Q8Ej6FR8Z+5xKcD2F
         Rz9SSkPtHvyQVA4XeA7luklXoujXgUsvBdMNsY/S4qGzHzGCVROLx3uLVlZ0WHFTIV
         NskmoNq42oFNZMnzpisyJ76rJWz7AXIC7oUNAXHE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.26.151]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LetYx-1j4Kc949Vv-00qewc; Wed, 24
 Jun 2020 15:05:39 +0200
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] revision: reallocate TOPO_WALK object flags
Message-ID: <29f8b1fc-fac7-12c6-4bfe-28aed7e709c3@web.de>
Date:   Wed, 24 Jun 2020 15:05:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mpfVFhVQ/mGrOccTt35seY2Y2I9zDzEbVn0ma84xu5oH1uIQerS
 Qy01yDWiGzvKl9XiGv4oimPAtWi+YH2If42y9sWcRaLxkWqZfH8fqA7KMXhtYS0p99vkgYe
 oK6QjuLCnIYsyWxWVRgKyIZDgC2wBnTQ11/K9ROP3uR1XEOcLbLfqOwaYLkg9BUCnvAqmHW
 XjYDlRNqwkN8JA4gcSIng==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XKMhZMIbDSk=:3r4W4zG2hsqz4IHjRp1VjW
 nTinZdW4wE3JSdm5m16pkfJKDLnlK8bbpO4/N93Ndum4KXV+H9lxI67ayKJQavxe0cdUXgqAa
 DHmTV3pyuYciXM3RtPitSHh1+Vz9bGsMLZuEFAbIm75wOUhLqd9JmZ+LYjZz8GilndcZoFB8L
 oNP2bZxPsook5/I3L11cw3YnnUzpmwsxD37M6PxclzaOo7XxDAZgPSUsvAcNqMEdkgj3niH/g
 kofuQZ08RBqRCTfvitnaXJ9FbxbRO4GOOsFqqR6UTpnnsTazWFwEVXXjs07lpzAKJub8F5KP/
 zYozwRmnf6za60nFM4W53MCOOhAneeoCsllJaYnbFvlgbDS3kwG0gp6GM/tBr3BMsDNryY3r7
 BimtxF4NUx6NYIrHiJsovJTkSA7ljKEbAuuVoecjjvAMF99PKjNnFG4UigK7lARLYYlAyhKDc
 P3SpDTjkkNYHP00Ck7BACNciFWfCWWU6oKdo0eregRKmQ6ukUNDHyxh38lmNzQ5CXbqN/bGjV
 LxToLf+ltr+kHohFdJL6ioLmSlZkThSsIUOsN7AVlV3oGIS4XhYMiNuxKL8Q+WggyaJReYT57
 TTfQwQonOkk9wVKXGbFCfQ5W/siw9S5/Eeq1RLpXlm8A+11I0+rYOY4XXS5Rb2rRnjj7Egs80
 Gqvan3McgL1XdPqNgd2/c8Lv5nYd0deX6jLc+MnEnKh6yrQGBCFRvihQjjoNelL/DfSxg7ew/
 xL3TYwjsDmlAKHDB/oOcaKolv9WOYGkjRqMOHGdTVKi4SR0JG+A7ZiPFrXiCsWY5nXkB7K9xI
 OAR8IMqski0PPaAWIfTLBECTJKPVLwiyc/sq5VMchJAk8zfZttiHyN4YyPwO8H3w2wHEYP9Py
 ySFjlds+hwN5+hqsHy03tdtwKqGS3w6N2hpS0Pcr4SQb8uxJEgBcYaJkWmR4W5oxg5XfV/Gj2
 iRIjX3Bt4M9e+CI1LrotlnMKlJdhTICNpy2PH//1s8MmcGXgOePWAI2rh9nn9HFHvtybo/8/S
 ub2Fq5OL4GCHA9+ZLPYAQTMpaQzU34E+LWVHUkJdH/+UaWTwa65nKy1WCwI2CHxjWq+5vcY4q
 ZvBLgL5Mf+p0XgqvzC1gcmwIUKTjiXKG+t9NGw9C1RGdQSIVDJuMDCRNw+T3sJbR5AEPaJC6K
 fLuYBC9TPyVp+6qDs0k+tuZ/rdjiTnqs5rcfwJdunhRTOo8DWVUW2SsKJwyf3u2+McUs2tOkI
 m8rm4BGNNpQSdCEHV
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The bit fields in struct object have an unfortunate layout.  Here's what
pahole reports on x86_64 GNU/Linux:

struct object {
	unsigned int               parsed:1;             /*     0: 0  4 */
	unsigned int               type:3;               /*     0: 1  4 */

	/* XXX 28 bits hole, try to pack */

	/* Force alignment to the next boundary: */
	unsigned int               :0;

	unsigned int               flags:29;             /*     4: 0  4 */

	/* XXX 3 bits hole, try to pack */

	struct object_id           oid;                  /*     8    32 */

	/* size: 40, cachelines: 1, members: 4 */
	/* sum members: 32 */
	/* sum bitfield members: 33 bits, bit holes: 2, sum bit holes: 31 bits */
	/* last cacheline: 40 bytes */
};

Notice the 1+3+29=3D33 bits in bit fields and 28+3=3D31 bits in holes.

There are holes inside the flags bit field as well -- while some object
flags are used for more than one purpose, 22, 23 and 24 are still free.
Use  23 and 24 instead of 27 and 28 for TOPO_WALK_EXPLORED and
TOPO_WALK_INDEGREE.  This allows us to reduce FLAG_BITS by one so that
all bitfields combined fit into a single 32-bit slot:

struct object {
	unsigned int               parsed:1;             /*     0: 0  4 */
	unsigned int               type:3;               /*     0: 1  4 */
	unsigned int               flags:28;             /*     0: 4  4 */
	struct object_id           oid;                  /*     4    32 */

	/* size: 36, cachelines: 1, members: 4 */
	/* last cacheline: 36 bytes */
};

With this tight packing the size of struct object is reduced by 10%.
Other architectures probably benefit as well.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 object.h   | 4 ++--
 revision.h | 7 ++++---
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/object.h b/object.h
index a496d2e4e1..b207f550b2 100644
=2D-- a/object.h
+++ b/object.h
@@ -59,7 +59,7 @@ struct object_array {

 /*
  * object flag allocation:
- * revision.h:               0---------10         15                   25=
----28
+ * revision.h:               0---------10         15             23------=
26
  * fetch-pack.c:             01
  * negotiator/default.c:       2--5
  * walker.c:                 0-2
@@ -79,7 +79,7 @@ struct object_array {
  * builtin/show-branch.c:    0-------------------------------------------=
26
  * builtin/unpack-objects.c:                                 2021
  */
-#define FLAG_BITS  29
+#define FLAG_BITS  28

 /*
  * The object type is stored in 3 bits.
diff --git a/revision.h b/revision.h
index 93491b79d4..f412ae85eb 100644
=2D-- a/revision.h
+++ b/revision.h
@@ -37,6 +37,10 @@

 /* WARNING: This is also used as REACHABLE in commit-graph.c. */
 #define PULL_MERGE	(1u<<15)
+
+#define TOPO_WALK_EXPLORED	(1u<<23)
+#define TOPO_WALK_INDEGREE	(1u<<24)
+
 /*
  * Indicates object was reached by traversal. i.e. not given by user on
  * command-line or stdin.
@@ -48,9 +52,6 @@
 #define TRACK_LINEAR	(1u<<26)
 #define ALL_REV_FLAGS	(((1u<<11)-1) | NOT_USER_GIVEN | TRACK_LINEAR | PUL=
L_MERGE)

-#define TOPO_WALK_EXPLORED	(1u<<27)
-#define TOPO_WALK_INDEGREE	(1u<<28)
-
 #define DECORATE_SHORT_REFS	1
 #define DECORATE_FULL_REFS	2

=2D-
2.27.0
