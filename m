Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E52EC433EF
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 20:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4617261100
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 20:25:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233696AbhIJU1I (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 16:27:08 -0400
Received: from mout.web.de ([212.227.17.12]:39129 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233397AbhIJU1I (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 16:27:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1631305551;
        bh=/CE0jxpWMyGk9VpDbuqcYIPAYj6d22ItPz09Kfmi5Ds=;
        h=X-UI-Sender-Class:From:Subject:To:Cc:Date;
        b=IcdSfAg3XXnB6Xwp0oE9fFObY0scxBy2FT6pV4Qh04poMM8Cby87+U6WzGHYhqkBn
         gvuDyCmr13CQPnXdfYRuAQkyNFkB6wsN2RTlaQMF0mokFfYQiuhEMIr6Txsd3tsOK8
         j+OA2/Bu3IKYxLh24BfhSnUzoMzHwsLJwPWPsl0I=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.20.171]) by smtp.web.de
 (mrweb103 [213.165.67.124]) with ESMTPSA (Nemesis) id
 0M3BZj-1nFmoq22Bb-00swia; Fri, 10 Sep 2021 22:25:51 +0200
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] index-pack: use xopen in init_thread
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
Message-ID: <4e9d7ac5-d922-006a-9123-5b5622024c4d@web.de>
Date:   Fri, 10 Sep 2021 22:25:50 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VxeMiNGx2NNcZ7/iRPEGafuPlTu4keDLhuQG8XXaRFWL7VP3tk1
 mckpqJxk4jafH7+FjBqxelgWNEn9gLjQ+ilD4pI/E+nKmp2bXj0/l8tNre1FY9PK/m8q1FF
 9ZzjEIRFta0vm0fYE5z0hoHoENAgyL02IBZfSc7pwCiCjC7ilpXWU4ZjKpzeCV6gHbVHHKi
 uBkKbF2Es/nfyL8062vAA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6QoeyVkKOk0=:2cWhdy8V4IULTiISJPvhEO
 UewXnlM8mAy0KRT2T4Plge+XR+LPuSyaq5g+5rh18y0uBXTtMMwzhLs7KJdvFzEkchpSG1GI/
 3nTQMUwCc07nYpkTthneA83nivkUk9lfz/kK787VndDFZGxMW6W8P4v420GEplbn3aaORY06A
 u4nRt7M2WT7vCkt+6bLssmrECmk7BnAVSk79v5W7lrx31ts2dQYRKeIwvKoRqOL3aMhNrUkBh
 bXA5Tf8320Bke21AH3Wzwb6KR5vKqAskDGfjzt26AkZAyFEiPXvmFeZuynsqRb58Lwz+cVHD8
 GjU4TF/EEM3iHc6kBaCXh88ee1mgrlIWuZY6FNMOTFPe6LyCgBn8jQepZLFAJaFxjeWo1Qxfn
 FbzeA2+Ypa8H96vtrBpulDbY2gsb21Len3LfNaw6z93NCSwFckSpGAcskb6a6k0OBN22015/7
 insVgGmrb7+S9kyK84Za1ua9ghxO0IvEUjOISMihFLAKABYzUG0nSdCuc7wvPC6HMUAykKQFJ
 AbLqzkVUPHlxHFiAuQX9yjUaU00orep1IBacVXJmuKJKhLtkeYcg/hrMTDPdGUC5/eECmp3sR
 4a1dobooHafKPTXGDnCgXjrdbR+pO9WchGdq1wymZb9LX1YZ5dDer1nrVZ+jJ102I8L+CuP8C
 NGfNVoh/F+F8jciNh61cXlD3igB26LVwNPjEImLO9Xnq1pvQHnK3Sz80HBrGlUhBok+BTmsJf
 F3A6lYswyJ9yuW+qBSFqD8cauFkjnMbp9X18EHfPo6B0m5sV21rXRowj0GvmL/pyU4+lJysxZ
 Q/MQmsE+yzHaDDCrzxX/tqKsURAs51jk5g8/HWdXdd0XagCVSmBNTe2KwnHRhngVdPLjEqsuH
 sdoFFEaw22GA7iExWgZlskFxW2Fa5njhMozVFStx3Z3ZtsfDJwCHD9Kzg1chMQWHBN0fRa6YB
 /FxKzMpMTOiB6S+4hwyfpOWtl6dq/4GWgaLfqwAGZWlCzStLTqqot/m+KtCFvwqlSsbezrE1Z
 TuaJ5GkoH8gGF3pjDbqGcYOMPPRTIx7gJxh8Q40Dg6OUwlpA1l3+tsOMl6tc97RXzA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Support an arbitrary file descriptor expression in the semantic patch
for replacing open+die_errno with xopen, not just an identifier, and
apply it.  This makes the error message at the single affected place
more consistent and reduces code duplication.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
The semantic patch itself gains some duplicate lines in exchange,
unfortunately, but I don't how to avoid that.

 builtin/index-pack.c           |  4 +---
 contrib/coccinelle/xopen.cocci | 13 ++++++++-----
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 6cc4890217..738a35c53c 100644
=2D-- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -187,9 +187,7 @@ static void init_thread(void)
 	pthread_key_create(&key, NULL);
 	CALLOC_ARRAY(thread_data, nr_threads);
 	for (i =3D 0; i < nr_threads; i++) {
-		thread_data[i].pack_fd =3D open(curr_pack, O_RDONLY);
-		if (thread_data[i].pack_fd =3D=3D -1)
-			die_errno(_("unable to open %s"), curr_pack);
+		thread_data[i].pack_fd =3D xopen(curr_pack, O_RDONLY);
 	}

 	threads_active =3D 1;
diff --git a/contrib/coccinelle/xopen.cocci b/contrib/coccinelle/xopen.coc=
ci
index 814d7b8a1a..b71db67019 100644
=2D-- a/contrib/coccinelle/xopen.cocci
+++ b/contrib/coccinelle/xopen.cocci
@@ -2,15 +2,18 @@
 identifier fd;
 identifier die_fn =3D~ "^(die|die_errno)$";
 @@
-(
-  fd =3D
+  int fd =3D
 - open
 + xopen
   (...);
-|
-  int fd =3D
+- if ( \( fd < 0 \| fd =3D=3D -1 \) ) { die_fn(...); }
+
+@@
+expression fd;
+identifier die_fn =3D~ "^(die|die_errno)$";
+@@
+  fd =3D
 - open
 + xopen
   (...);
-)
 - if ( \( fd < 0 \| fd =3D=3D -1 \) ) { die_fn(...); }
=2D-
2.33.0
