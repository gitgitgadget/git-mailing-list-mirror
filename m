Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC30D2047F
	for <e@80x24.org>; Sat, 23 Sep 2017 09:42:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750913AbdIWJmB (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Sep 2017 05:42:01 -0400
Received: from mout.web.de ([217.72.192.78]:63655 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750847AbdIWJmA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Sep 2017 05:42:00 -0400
Received: from [192.168.178.36] ([91.20.61.209]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LcgVn-1dU1N61Dd9-00k8Kg; Sat, 23
 Sep 2017 11:41:47 +0200
X-Mozilla-News-Host: news://news.public-inbox.org:119
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH 1/3] refs: make sha1 output parameter of
 refs_resolve_ref_unsafe() optional
Message-ID: <b89d36b5-0996-829b-a267-7ee4da9673dc@web.de>
Date:   Sat, 23 Sep 2017 11:41:45 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:SDBqUkmZRh+YohxZlhPalWBvjGjYW5DprtR98yjpx2VVyyhItTK
 6ZGQYKKqOxswA34y3OvkR+yis9SULPfzGGOr0zYa9q/0giO+Ap60+VAFt+nkwKQ4u2YJ2Yp
 ETMfZxmV9yk2EA9siXfgrNsdduROLUfueGWWU38QV2f7aWaAGYbhJ+d/Pq9lkCgfPLoXf3F
 kKZtkRenUXsNBk/N6kqEg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:M6y9O21X12I=:DQTShbh3s/9JbWxxBApH5j
 BR6a6NAnJ5ErbtTYLZpw3nlvWkkUS0U1S08HgVLPzLiz2qMR1nRkYKiZ01TtYphmGDNK0ImY0
 6xoDU7/G920h2mFPEE0aihVh+i3HCycXOi6Wvd0bbhYdXoXJ1Q5++PsYmRRUqv+YrkLr+kDJe
 OaOmKhTyNGGi6MIJGv2GTjNDbfYDRm+a6Up/DjnlhLZR21l37n+A+LnDSUNyVZuw3boZ4m0Pi
 bQ+D3ahjtiUdFLE2xArQo/5DdCmol820ntrR7tyQc+QR9+4d3HX3e7LMx40PwzVxOzll6jOMX
 lIY/lO2wSRVyRWFicuQ1nbGlbEk5Djy6KaWndUpn/yxyO8VnY9EeU+m7Q80Ka50Y68qUTfste
 y23wkswJVYGYu8ozA8Bbjv4+okJO7VcwiK8xQ6bk39gGsem8f/N7nVAEp5WIjzZ/EI1YwLAmm
 VW3q2ky0K1npCcRs/fGLFcE8sMTysmHivJn3DjPyHI89AasaMs3d9wiovNS7HMhCwFJbe8dKM
 LBrbr9oG5pQlI4a4jg2zmgWg6ScB9ClM1tdrTz4eM+PSz0pHN8S6HkzYsjXBAx7LBsAyh3DYh
 oqwlCr1JaZ3m+All60HkgQTBq3lNxorqJkKXx5A2II2gmzenlC73rv2lRpKCZPlARg5Mq5YnW
 iXsHai2Ylfo7aBoLoazE0Q44zHJKBK/GfHyqIOTQ/RyhI/fTQB+td10wrhDka6s+p6lHgqnWQ
 +2buqzyoVGbHEpaiOcHjt9gJwUxATDt2GRV+txIrMQN6J2bF+dZ8uT2I9kM54HQ6BzojLKDt0
 ubWci7+AKWVNV2Zk4yr3HHERMfh7DlSFK2KvHpC2gXA8qSDjyo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Allow callers of refs_resolve_ref_unsafe() to pass NULL if they don't
need the resolved hash value.  We already allow the same for the flags
parameter.  This new leniency is inherited by the various wrappers like
resolve_ref_unsafe().

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 refs.c | 3 +++
 refs.h | 9 +++++----
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index c30f4c36be..36439fdb54 100644
--- a/refs.c
+++ b/refs.c
@@ -1396,9 +1396,12 @@ const char *refs_resolve_ref_unsafe(struct ref_store *refs,
 				    unsigned char *sha1, int *flags)
 {
 	static struct strbuf sb_refname = STRBUF_INIT;
+	struct object_id unused_oid;
 	int unused_flags;
 	int symref_count;
 
+	if (!sha1)
+		sha1 = unused_oid.hash;
 	if (!flags)
 		flags = &unused_flags;
 
diff --git a/refs.h b/refs.h
index 78a26400b6..996d4ea54d 100644
--- a/refs.h
+++ b/refs.h
@@ -10,10 +10,11 @@ struct worktree;
 /*
  * Resolve a reference, recursively following symbolic refererences.
  *
- * Store the referred-to object's name in sha1 and return the name of
- * the non-symbolic reference that ultimately pointed at it.  The
- * return value, if not NULL, is a pointer into either a static buffer
- * or the input ref.
+ * Return the name of the non-symbolic reference that ultimately pointed
+ * at the resolved object name.  The return value, if not NULL, is a
+ * pointer into either a static buffer or the input ref.
+ *
+ * If sha1 is non-NULL, store the referred-to object's name in it.
  *
  * If the reference cannot be resolved to an object, the behavior
  * depends on the RESOLVE_REF_READING flag:
-- 
2.14.1

