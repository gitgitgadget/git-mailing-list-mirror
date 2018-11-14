Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC2F81F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 18:21:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbeKOEZm (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 23:25:42 -0500
Received: from mout.web.de ([217.72.192.78]:50003 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727822AbeKOEZm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 23:25:42 -0500
Received: from [192.168.178.36] ([79.237.248.89]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LzKIP-1fS7mS3LRh-014RKv; Wed, 14
 Nov 2018 19:21:13 +0100
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: Re: [PATCH 8/9] sha1-file: use loose object cache for quick existence
 check
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>
Cc:     Geert Jansen <gerardu@amazon.com>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Takuto Ikuta <tikuta@chromium.org>
References: <20181112144627.GA2478@sigill.intra.peff.net>
 <20181112145442.GH7400@sigill.intra.peff.net>
 <87ftw62sld.fsf@evledraar.gmail.com>
 <20181112162150.GB7612@sigill.intra.peff.net>
 <87d0ra2b3z.fsf@evledraar.gmail.com> <87bm6u2akf.fsf@evledraar.gmail.com>
 <878t1x2t3e.fsf@evledraar.gmail.com>
Message-ID: <e5148b8c-9a3a-5d2e-ac8c-3e536c0f2358@web.de>
Date:   Wed, 14 Nov 2018 19:21:11 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <878t1x2t3e.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:NjW+jR/zzIfT+ooYis2kMegtP11M+rxb3/Z633ok6EPEcGqjCdH
 rI/yDciOKOD/pbuyEH1/heUfBGLSZCFplG5AKhwJ0SgA2NdRFizf8VAd1W+Xv4g5Z1KCUji
 S1I8/m8dSzDQnUIAUTgp1/iMn8tZYL4pEYN6IEI4cxxeXDibmk1/FerHhhouoM+OdsmRdQk
 CD0wX7pGEtGO9+iLKhQNg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:MRiLSzm6mjk=:2MP39feTcXiPcF/ZHytMiK
 tFU/6LUJBVoPNf7pUKRp92VUujbevN/lN/dxFI4Us4zw9VX6qDkjEwdjhLq1W6tkPAFPTGWye
 nviUcEkwbBkxACtZpTzGHpmiUXNJnVbM8SKsKjIxUVmnG9QfXv2qxOBJeXTD+dGYbtjoI6d7A
 1llPoPEx6lgnRktcH/1hxq7rJEXY18XC59Smq9/ouH2W3rhTWIo/6BI9joNRJdubQl/x50g4F
 pMgJbQseaqud7FCfGGwnfsCnemaDgYvDGAW1e5mBjN4oTw/9TAE57LikuYEKXF7goFmSwsikH
 E7DnZ8ZEIcplPc6suJuGXz8/+MmIk/QOTwOHaFPEdwzucxM1wbPLyjKDFoWIeQObQt5oWZnDJ
 osIcLtGwkWwuTf3dQWPsQO/4wuQWufCLXEXA5I8ixQPwfYJI8IPwygUT8/nns2GEx1peRdJrs
 E5Al/lbUrAIWDtx9iYXT0LkKvSt/Zqr2R1ehUZ1KAt4H4t6z6wwlI7nhwyZWYxNk+PYroM29n
 +QFMTEImB4YY3qPncbJOXlw0IHPXU87HUPNnSwN0N9Hlf0XOkWnsjJJEpNylpjQ0HTM5SC6K/
 Q18UzLRlt8I0F4szSVvIj5hquaJlQNuntSaPOofnXIy840y9mU1wNbY2Ys01P8ZlbDdgdQNXQ
 +hLOgM841UennPQb331FtCgb6VqiUJJ1jWAMwrClxaIuA6RN0TeLopemLXr6FEEw+ax8K77NT
 hb6KaBHrNyhTE0yqve1w2mWL/BVD4L/b9pEvB/Jf5Llw86yZkv71VB7mMxAL5b0Zk5EwItghg
 kWbR6JXgHriwDWwctLMWQ4JoEFL2NoIaFqwU5uDYJ0kBEQBPpl8Hf/qqbm226b160yPHeN9LN
 zRskxkKypNfEj21hMMigFV+VrulXJTxRTbZpU+EskZ7guMC8wE6lTmhAwkxUyp
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 13.11.2018 um 11:02 schrieb Ævar Arnfjörð Bjarmason:
> So here's the same test not against NFS, but the local ext4 fs (CO7;
> Linux 3.10) for sha1collisiondetection.git:
> 
>     Test                                             origin/master     peff/jk/loose-cache        avar/check-collisions-config
>     --------------------------------------------------------------------------------------------------------------------------
>     0008.2: index-pack with 256*1 loose objects      0.02(0.02+0.00)   0.02(0.02+0.01) +0.0%      0.02(0.02+0.00) +0.0%
>     0008.3: index-pack with 256*10 loose objects     0.02(0.02+0.00)   0.03(0.03+0.00) +50.0%     0.02(0.02+0.00) +0.0%
>     0008.4: index-pack with 256*100 loose objects    0.02(0.02+0.00)   0.17(0.16+0.01) +750.0%    0.02(0.02+0.00) +0.0%
>     0008.5: index-pack with 256*250 loose objects    0.02(0.02+0.00)   0.43(0.40+0.03) +2050.0%   0.02(0.02+0.00) +0.0%
>     0008.6: index-pack with 256*500 loose objects    0.02(0.02+0.00)   0.88(0.80+0.09) +4300.0%   0.02(0.02+0.00) +0.0%
>     0008.7: index-pack with 256*750 loose objects    0.02(0.02+0.00)   1.35(1.27+0.09) +6650.0%   0.02(0.02+0.00) +0.0%
>     0008.8: index-pack with 256*1000 loose objects   0.02(0.02+0.00)   1.83(1.70+0.14) +9050.0%   0.02(0.02+0.00) +0.0%

Ouch.

> And for mu.git, a ~20k object repo:
> 
>     Test                                             origin/master     peff/jk/loose-cache       avar/check-collisions-config
>     -------------------------------------------------------------------------------------------------------------------------
>     0008.2: index-pack with 256*1 loose objects      0.59(0.91+0.06)   0.58(0.93+0.03) -1.7%     0.57(0.89+0.04) -3.4%
>     0008.3: index-pack with 256*10 loose objects     0.59(0.91+0.07)   0.59(0.92+0.03) +0.0%     0.57(0.89+0.03) -3.4%
>     0008.4: index-pack with 256*100 loose objects    0.59(0.91+0.05)   0.81(1.13+0.04) +37.3%    0.58(0.91+0.04) -1.7%
>     0008.5: index-pack with 256*250 loose objects    0.59(0.91+0.05)   1.23(1.51+0.08) +108.5%   0.58(0.91+0.04) -1.7%
>     0008.6: index-pack with 256*500 loose objects    0.59(0.90+0.06)   1.96(2.20+0.12) +232.2%   0.58(0.91+0.04) -1.7%
>     0008.7: index-pack with 256*750 loose objects    0.59(0.92+0.05)   2.72(2.92+0.17) +361.0%   0.58(0.90+0.04) -1.7%
>     0008.8: index-pack with 256*1000 loose objects   0.59(0.90+0.06)   3.50(3.67+0.21) +493.2%   0.57(0.90+0.04) -3.4%
> 
> All of which is to say that I think it definitely makes sense to re-roll
> this with a perf test, and a switch to toggle it + docs explaining the
> caveats & pointing to the perf test. It's a clear win in some scenarios,
> but a big loss in others.

Right, but can we perhaps find a way to toggle it automatically, like
the special fetch-pack cache tried to do?

So the code needs to decide between using lstat() on individual loose
objects files or opendir()+readdir() to load the names in a whole
fan-out directory.  Intuitively I'd try to solve it using red tape, by
measuring the duration of both kinds of calls, and then try to find a
heuristic based on those numbers.  Is the overhead worth it?

But first, may I interest you in some further complication?  We can
also use access(2) to check for the existence of files.  It doesn't
need to fill in struct stat, so may have a slight advantage if we
don't need any of that information.  The following patch is a
replacement for patch 8 and improves performance by ca. 3% with
git.git on an SSD for me; I'm curious to see how it does on NFS:

---
 sha1-file.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/sha1-file.c b/sha1-file.c
index b77dacedc7..5315c37cbc 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -888,8 +888,13 @@ static int stat_sha1_file(struct repository *r, const unsigned char *sha1,
 	prepare_alt_odb(r);
 	for (odb = r->objects->odb; odb; odb = odb->next) {
 		*path = odb_loose_path(odb, &buf, sha1);
-		if (!lstat(*path, st))
-			return 0;
+		if (st) {
+			if (!lstat(*path, st))
+				return 0;
+		} else {
+			if (!access(*path, F_OK))
+				return 0;
+		}
 	}
 
 	return -1;
@@ -1171,7 +1176,8 @@ static int sha1_loose_object_info(struct repository *r,
 	if (!oi->typep && !oi->type_name && !oi->sizep && !oi->contentp) {
 		const char *path;
 		struct stat st;
-		if (stat_sha1_file(r, sha1, &st, &path) < 0)
+		struct stat *stp = oi->disk_sizep ? &st : NULL;
+		if (stat_sha1_file(r, sha1, stp, &path) < 0)
 			return -1;
 		if (oi->disk_sizep)
 			*oi->disk_sizep = st.st_size;
@@ -1382,7 +1388,6 @@ void *read_object_file_extended(const struct object_id *oid,
 	void *data;
 	const struct packed_git *p;
 	const char *path;
-	struct stat st;
 	const struct object_id *repl = lookup_replace ?
 		lookup_replace_object(the_repository, oid) : oid;
 
@@ -1399,7 +1404,7 @@ void *read_object_file_extended(const struct object_id *oid,
 		die(_("replacement %s not found for %s"),
 		    oid_to_hex(repl), oid_to_hex(oid));
 
-	if (!stat_sha1_file(the_repository, repl->hash, &st, &path))
+	if (!stat_sha1_file(the_repository, repl->hash, NULL, &path))
 		die(_("loose object %s (stored in %s) is corrupt"),
 		    oid_to_hex(repl), path);
 
-- 
2.19.1
