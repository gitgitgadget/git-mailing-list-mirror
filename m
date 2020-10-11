Return-Path: <SRS0=tPyM=DS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D45ECC43457
	for <git@archiver.kernel.org>; Sun, 11 Oct 2020 16:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A79720776
	for <git@archiver.kernel.org>; Sun, 11 Oct 2020 16:04:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="MCkvEXpE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387760AbgJKQD5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Oct 2020 12:03:57 -0400
Received: from mout.web.de ([212.227.17.11]:59001 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387695AbgJKQDk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Oct 2020 12:03:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1602432217;
        bh=mwIP/P2ij5+T54TDxOEP/6U4dMcBxrXEgP8X/fIJj7I=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=MCkvEXpEb3lYuYtvQugLY8WmB7794vfJBeH/ffViaZd9kWOuKZaxs+dS6zDINRlzX
         aCnq+0Zv7/Pz43uHHnDtzoLqswBzecl+A7lbU9QqdAjZSYg882RyhmGpvtGbiMVyTc
         uIbrryuDqULGs4MeSGqGYT3arEdrnob7QOwu5AjA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.158.172]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LopiJ-1jyMny2FEB-00glc3; Sun, 11
 Oct 2020 18:03:37 +0200
X-Mozilla-News-Host: news://nntp.public-inbox.org:119
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] blame: handle deref_tag() returning NULL
Message-ID: <3cf2bcfb-521d-0f4f-a8cb-8d6507c69f35@web.de>
Date:   Sun, 11 Oct 2020 18:03:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bqinGFyc/06L2OHgfTGkzeSDO4Kk7tobr932UwHG6AiW+Didmxr
 6f0LV0SCFuD8ttcT/AUxWXXVfoB7dVvQQgVhlHXSL6V1JPyUkIivEmgS22gdywtYPuzmu7M
 DEiDj2XB3YUy3Rnxhnu+MbeItFndRUyXYMMw0PNeyJUCkIRsjpv4rKxIXsuiay25MP8aEen
 rOn6Co5XCASWPNzqVeqIQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oR/Xm2Sqrw8=:9e3Jv83mmM4DdB2QxxS1iv
 MF7hJKnqnW2ZMqArGwIciZcuE7nO4VPZKCG1bGWY3TQTn4Rf1lbEigYTikgBfC6MBwBUlfGV8
 yxaVJbsT7q5NMtJvyTrsFnSO9XEDnRwDHN7HFbKKNiQ8Ecs5xdP+H4dj0J35pYuzR9jePL3Y9
 njuOTbWcX03tVJOQ12HhlDVy51EvECEwlbInMXIHYm242KMHtUrTzJQgndo8sFXQtoQT2OQYP
 VVIhF7/xx7AMmnmuHX3nwnoFz+4AUJ8Q2YHWAMjq03SIAp2J8IdX35sgKMeqibgQU/bR968s7
 /8JvxR4y3gkSxmknutIMElPReSbc0YGPIPzb1ccdh0hDwBzxxl0KQrMPglPkPzQNJjSYZi8u/
 OB6CT7fhGe1UFK79ONVM2yMcty/XHLgXaQahq87EcSG76fuiVelimSJOfhYX8B9iDHrLL6GbR
 PGizkpt1JCjJxO4wF1OJboojbR4eiIwjKZQUd0ilgCayZYC2r/FCL6y4IGSFSV1pGB7UNJQ5/
 S9NQKxy2bIu0Ah960jfFHmUtencQSkk+TVhGIdSy/Qox9TetloH/Zon1keBLsXuB07nH0VgvH
 dQkUm8Ftq56J/oOG/eWBz9LWKyT0f2LnhnzlKIoqSQt8CVbaEUTOWB8VK3DVvh57jxIyfxpl3
 GMUTmsLOiUD3gXI7n5l23oG30A700ruuoXfFCvyqfxmrcOs+uSy/ii6VYRLdPrYRuvdNEeN2Q
 n0XMQLMk9XK42pTnUmr7SvOnPSMpeE3MgcemzSGn3AOhQLu65R/tyQdvGECADU7gdDG5i6I+W
 BxZQ8XDNRRdK/IWp9AAGUrUYT9+twgl52l0VNE8GwzlmL3njbngISL5QLaK0E/eOHOHJUFcRx
 HQIs4TDs2/M/gFnVlU21yHKSt+Ayx1qHhbPu9aMWdsbTviMAPJaq11B1sGdfH4+75OVExOUO+
 BJXxvmKvNIm5MiEjrIbteYmjOMKmG63FCFYDG2OXOLYq7qw2vkMIdNuAVSMyiSZjBpfNORdj3
 IRxjX3ldaleDZCuIlz1s9PdyOth3EPfO4IK2VHBlDUS+sUVKzCupjrdx8x5w+bS8LtrVdoudb
 3nST3v8v4lcuer3bk3OYxPhmpga7ykHRIfwMWe8A5dyfV+V9rNmV8rlYXWMc1m1eXQwgxiiAk
 iSrGt55CeOFpS6CiNAxM2tiH9XvrGmdI36hVj59T8FaLuE5O2bCRr1l2hiBFplsw7Dh1Galbs
 655Won9YQqthhO/MT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 blame.c         | 6 +++---
 builtin/blame.c | 2 ++
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/blame.c b/blame.c
index 686845b2b4..de7b5d411f 100644
=2D-- a/blame.c
+++ b/blame.c
@@ -2670,7 +2670,7 @@ static struct commit *find_single_final(struct rev_i=
nfo *revs,
 		if (obj->flags & UNINTERESTING)
 			continue;
 		obj =3D deref_tag(revs->repo, obj, NULL, 0);
-		if (obj->type !=3D OBJ_COMMIT)
+		if (!obj || obj->type !=3D OBJ_COMMIT)
 			die("Non commit %s?", revs->pending.objects[i].name);
 		if (found)
 			die("More than one commit to dig from %s and %s?",
@@ -2701,7 +2701,7 @@ static struct commit *dwim_reverse_initial(struct re=
v_info *revs,
 	/* Is that sole rev a committish? */
 	obj =3D revs->pending.objects[0].item;
 	obj =3D deref_tag(revs->repo, obj, NULL, 0);
-	if (obj->type !=3D OBJ_COMMIT)
+	if (!obj || obj->type !=3D OBJ_COMMIT)
 		return NULL;

 	/* Do we have HEAD? */
@@ -2737,7 +2737,7 @@ static struct commit *find_single_initial(struct rev=
_info *revs,
 		if (!(obj->flags & UNINTERESTING))
 			continue;
 		obj =3D deref_tag(revs->repo, obj, NULL, 0);
-		if (obj->type !=3D OBJ_COMMIT)
+		if (!obj || obj->type !=3D OBJ_COMMIT)
 			die("Non commit %s?", revs->pending.objects[i].name);
 		if (found)
 			die("More than one commit to dig up from, %s and %s?",
diff --git a/builtin/blame.c b/builtin/blame.c
index bb0f29300e..b5036ab327 100644
=2D-- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -820,6 +820,8 @@ static int peel_to_commit_oid(struct object_id *oid_re=
t, void *cbdata)
 		if (kind !=3D OBJ_TAG)
 			return -1;
 		obj =3D deref_tag(r, parse_object(r, &oid), NULL, 0);
+		if (!obj)
+			return -1;
 		oidcpy(&oid, &obj->oid);
 	}
 }
=2D-
2.28.0
