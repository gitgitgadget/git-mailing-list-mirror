Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC8D4C433F5
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 23:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BECC561AA7
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 23:22:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244935AbhKOXZC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 18:25:02 -0500
Received: from mout.web.de ([212.227.17.11]:56095 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232556AbhKOXWl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 18:22:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1637018379;
        bh=UIV2P/K/2qSd4BxEpctghOQVYhXensZ9qFV1BkN7hoo=;
        h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
        b=nG6mhqH6ErDYnzHRW6Zrhq5whaG2WYsB2wQEVQHmRMU9/2jJcZbLVdY7JAt9KGr/V
         leJ6O4v0GHz3HTXVt3Fih6q/xYe3W9WIV8xQxAz2Wh2MPav1fUVSsrmCltkiQELs2o
         luVdySvZIugHlnBUHlcRqxXCkij2kGBH1VK4ThYk=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.20.171]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mmyr7-1mN1AK0IQJ-00jiZ3; Tue, 16
 Nov 2021 00:19:39 +0100
Message-ID: <5eabbe1c-4c0f-559a-da21-423afec89e7e@web.de>
Date:   Tue, 16 Nov 2021 00:19:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.0
Content-Language: en-US
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] mergesort: avoid left shift overflow
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LdxVE5KgXypqeOjCv4Mo91+BDe7pVKE5kePnhs1o8TKJqVGao2s
 Sf2b3voQbgbnC7uFSDrQWhGqPVnDgGAedn6O7dW6SN4OCMwaWwf9azkxgLdwleYetCW8m6g
 5tas78SBJafSCIY79Q57wQcADyz+gWJHh0nsh+w5MOg5u4yDU2LFJJe8DWiVU0xizmKRui/
 BIDKEN5KkyBjIBAdln5sQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UoRiqJ89yKs=:TKTFM99N8Wd2hAJv8b1/gJ
 Su7hV+m00XR6ar9CCWqqoDwGYpeJQYds/SYeyfwWOL2RpbBbazutIWWJPPhppOnhhrK/0P18A
 ERgSTqZFeqNJWdHq/7aOMOEJKdlKSVPc3DAMcEegvLs+RUUP5nyr0HB+utdN5ix0pcPcgvaU6
 Pn+u1sfNu+xoQOYB8uPJhIKGiFlQorB9XkNLSNRWe2bvQqdX5QVMwDR37ZWusHwLGhWsNtkTa
 etA0GMo8f1KM73DGMTldwNfqqBzZlgWyfe4D+XwrPu828ns0OoGZXfzRjWZy87IPqVKnFzqkz
 o1I0WnyNBJ99tVNtMuIuQkghVTnAbEFYzlNPwpdwkpfuBsb9ATPA7A6uK2QvjijmArwv88iy0
 por9QZWzWKHFEcSUUx64K5+30JuM4lQEpKSoHFrPyZHTGV/PScdk7tFIB/25SWVq5PU5eLH7F
 17Jy6smIik40jDm0rcjXc25Us60uJZ2rWp8zulad4Ig8XWl9eWHD1XL+kcSOm2RDd/58QANnd
 3eoZTV7M2ul4w8ZrshDVkSYayZ7ekEkCFq3+Mlk89ZL/42o+sNUkshkdqjJPI8oCsNs4YwQMB
 35dUKq5+jXJQYhhLJAtsJVmdCgKafHc+bOw6uSAmWMmvmcHEZ7Ic4TI96Odc4Vaxy/SES5O0P
 Aoz/mkBNEha2NFdqoRbrPxBdH41OYpv+JWxLlNXry0DfRc5pyxH9UGeCVjK6BaXij13tbj2i3
 rwyZNuNebj97mAUcBDd2TkRgvJ4gowdg41gDPf5EpjUUXOwKvQxr2beOPGPMepF9sdC6nqPB2
 hJqgl3KG3dL4/aEYjTnKR+f/az4yJuWZy/x4ZibkJy9BZjjBxUzmHenl1Zwd3uu2nTLT6yPa2
 2b49QIiq7qYZyhX8lhSvI55ll+zR7fOCi7WXnTAKGhn/MnPxoPrjcMUWRqDFmbBvIPVMfPqg+
 icu8+nzWwwhAhlfBvXSYsLoL/htP+Ps3Zw1BuB56+cPvtfyYk5Auq17xJf7m0p3xx4UTjPcIP
 dGG8tywv5ejAlAMyTbEConEErAdDLJnAVgWpyuvlAU9yWAAiwQ48Sw0WIe2LCocXog==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use size_t to match n when building the bitmask for checking whether a
rank is occupied, instead of the default signed int.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
Ugh, sorry. :(

 mergesort.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mergesort.c b/mergesort.c
index 6216835566..bd9c6ef8ee 100644
=2D-- a/mergesort.c
+++ b/mergesort.c
@@ -63,7 +63,7 @@ void *llist_mergesort(void *list,
 		void *next =3D get_next_fn(list);
 		if (next)
 			set_next_fn(list, NULL);
-		for (i =3D 0; n & (1 << i); i++)
+		for (i =3D 0; n & ((size_t)1 << i); i++)
 			list =3D llist_merge(ranks[i], list, get_next_fn,
 					   set_next_fn, compare_fn);
 		n++;
=2D-
2.33.1
