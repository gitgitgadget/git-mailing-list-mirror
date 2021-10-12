Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A6CC433F5
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 19:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD85B61050
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 19:15:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232486AbhJLTSA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Oct 2021 15:18:00 -0400
Received: from mout.web.de ([217.72.192.78]:49655 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231586AbhJLTSA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Oct 2021 15:18:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1634066151;
        bh=lgWkVgqQUd9DdrRnh/OqtnZ9/TaB145fiW3pdGEOqGI=;
        h=X-UI-Sender-Class:Subject:To:References:Cc:From:Date:In-Reply-To;
        b=WDCTr4ZFIBGbt/sGSMfhOar21M6frVOXjMCdVfNmeWa+RqvGQhQcQwVTZtPmiW8gH
         Zu6DoD/nScPcNuW0gPRw+ufq4QHx4uNFvymll/6idpAjP+HJ0XAT7IfZNapWejBPp7
         3b2vfp3LTNMd1/q5NmFZLKyV8GACfDsOqGXunzdQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.20.171]) by smtp.web.de
 (mrweb106 [213.165.67.124]) with ESMTPSA (Nemesis) id
 1MDvDi-1mQVLW3s1c-00AFpn; Tue, 12 Oct 2021 21:15:50 +0200
Subject: [PATCH] add: don't write objects with --dry-run
To:     git.mexon@spamgourmet.com, git@vger.kernel.org
References: <a2c0deed-fff3-6c1c-633f-af9dffea1e02@exon.name>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <0131d21f-dabd-3da5-34bd-a570e990f9e0@web.de>
Date:   Tue, 12 Oct 2021 21:15:50 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <a2c0deed-fff3-6c1c-633f-af9dffea1e02@exon.name>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:T6NNfVxO6Lqz47odRN9gtrVC+V+6KV9PTuvsmOxgBdnYRMJnz/d
 kdm3d+0aoTr3BRe87jWsHy5csKO0O+Bl7SslzpBFwydR9Qz/Gzfxx/CQa9asvAU/jJejzav
 kpehk/Ko9F0uTTGH410sCwbygJ2ziA4IAGxDyRxK0UkL9z5fR+3jdTRQle0q5BS8+5GOT8e
 Gem4NsSBByDnacVPROgjQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bNMeDl6bQI0=:x0kt5uCoLOWdUeKOFXMSj4
 ZCSeCjeOUiupd+/WbdIRmUy9KV/kfdj/yI3XS5Ktk8xnphAjlSB3f845eermAhKbBUEiyyYfX
 fT05Oc2r9c7FBa6V10hnkuUBKiE9nOaH1nrhDFCVHHZeRrI+0etF/O+7IqvRGY7hzaG1+JRNm
 Jr2rbjwk43u4ECliVPviK35axxspKav+GfxjoChNt+EGhhftosaGHsyVo7bn3xQLxdhF0DI16
 958FDerRLkreVLqKiVp61ajVnvOMNEohh9dGOS4iOywhi5JsU9OMV4y2iKg8KjckDmOYYYd9x
 PoqnJUVgqBYEcIYUjwTa82cD9lJq+MEqPoMCnkB5IbLOBT8R1B+Yq/pJJ4qOuYkM14CaFG3ux
 j9f6Jiv9e/5sFMpEjhfb8I6PEcJD6LkvKjDkiIFJpJP3LwDNnh72My0Tef0ymfJhxA24RwSTe
 B28dFl/Fj0YFfTZw6dzwd5GKci2hbixOlK1PMKuRRq4OqgVhpto1xliFVw1Wzg4stDgS/1G87
 WpLll/yCnL63afQ2OqgotvySsL5kzrLtTJDu7dmdC2eVmXeX7WgBcWSP0E3NNwQQhWAOIKhug
 vZob+gf3lk6yJPspIs46c1d7VeEcejY1yyfX+e2y/HHD/Z/SjBbhoOgZgHeaim2tfIMF7/qKX
 dCIqDH3blQyGkwZuehsRVsQVpqO+X9fm2LYnNV3hmrUbt0VB9i+UAOo0zC0ujXCBLSs1D4ctr
 pWUXC0hoAR27+b4IOK9QGF/xxQD6nmsDNnsCNTRSbOwgYJHCzKrKpyzG+lGepHNuh9DDBrtn8
 q/YhgVU344hnGMPCHHKj6EaGX/5ytUhEDwcPU51zKuJai+5rgP4hBP1wJbrnqEVWkr+Bg8C5Q
 cpd+UbWv6pLoo5kPYEjUh2JgMacXiPptYCmleWx+mu3cePiFQAwRvpakvq1v+32ALzaEVR0fx
 GOcCJcDc7f5EDPo4Xii9lLelLBNVqd8AB1fLqq+pGSGecRWJ5UvuX43n6fRENA/ckUDMsHSAm
 hFEc1jOPpmzxcBXNw6lZvsxpye0JuW1gR2o8LOTo7a+P68qKtnDSr+FZbQT2zSH6fn2CI9KZl
 xHVqDtn46YuR4U=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the option --dry-run/-n is given, "git add" doesn't change the
index, but still writes out new object files.  Only hash the latter
without writing instead to make the run as dry as possible.

Use this opportunity to also make the hash_flags variable unsigned,
to match the index_path() parameter it is used as.

Reported-by: git.mexon@spamgourmet.com
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
Am I missing something?  Do we sometimes rely on the written objects
within the "git add --dry-run" command?

 read-cache.c          | 2 +-
 t/t2200-add-update.sh | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/read-cache.c b/read-cache.c
index a78b88a41b..7fcc948077 100644
=2D-- a/read-cache.c
+++ b/read-cache.c
@@ -738,7 +738,7 @@ int add_to_index(struct index_state *istate, const cha=
r *path, struct stat *st,
 	int intent_only =3D flags & ADD_CACHE_INTENT;
 	int add_option =3D (ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_REPLACE|
 			  (intent_only ? ADD_CACHE_NEW_ONLY : 0));
-	int hash_flags =3D HASH_WRITE_OBJECT;
+	unsigned hash_flags =3D pretend ? 0 : HASH_WRITE_OBJECT;
 	struct object_id oid;

 	if (flags & ADD_CACHE_RENORMALIZE)
diff --git a/t/t2200-add-update.sh b/t/t2200-add-update.sh
index 45ca35d60a..94c4cb0672 100755
=2D-- a/t/t2200-add-update.sh
+++ b/t/t2200-add-update.sh
@@ -129,12 +129,15 @@ test_expect_success 'add -n -u should not add but ju=
st report' '
 		echo "remove '\''top'\''"
 	) >expect &&
 	before=3D$(git ls-files -s check top) &&
+	git count-objects -v >objects_before &&
 	echo changed >>check &&
 	rm -f top &&
 	git add -n -u >actual &&
 	after=3D$(git ls-files -s check top) &&
+	git count-objects -v >objects_after &&

 	test "$before" =3D "$after" &&
+	test_cmp objects_before objects_after &&
 	test_cmp expect actual

 '
=2D-
2.33.0

