Return-Path: <SRS0=d2Ax=EG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD896C388F9
	for <git@archiver.kernel.org>; Sat, 31 Oct 2020 12:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BA7F2072C
	for <git@archiver.kernel.org>; Sat, 31 Oct 2020 12:31:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="stRUPlrs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbgJaMba (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 31 Oct 2020 08:31:30 -0400
Received: from mout.web.de ([212.227.17.11]:42705 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727037AbgJaMb3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Oct 2020 08:31:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1604147486;
        bh=xSVs2XLdEqXcHBpWw2kC6CR8z1KL3WzJZvGm9+d+sto=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=stRUPlrsFQEGAnqb5q8EMSqD/8Kd1z+pwrCOugWdRATGYoYyuKdXNhLH4RwB2hXw+
         U8zs05gxekDTSGuOiShJOeoayJxkGTjgyUPjhJZxrgG2UXLRjigsAj7Ak0912vna03
         y/3QNKyH43BOSR3xX3JXNEp3i+aasSgnHMai8aQ8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.17.45]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MLPNm-1kZOGt3PiE-000eJC; Sat, 31
 Oct 2020 13:31:25 +0100
Subject: [PATCH 2/2] bisect: clear flags in passed repository
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
References: <f8cce944-a094-6097-39c3-904f52e4b9f6@web.de>
Message-ID: <e9f1dbc1-065b-dcf7-efc1-7709681de5f1@web.de>
Date:   Sat, 31 Oct 2020 13:31:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <f8cce944-a094-6097-39c3-904f52e4b9f6@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+dyDRLz/KiPWG7MsMlVRLk2i3/GsGh0Wl0jMzBv6seFxD2c2cuf
 q/sscH2O9xWmVn5ccmfPkcpD7N+wCS+uEooZFXIhOaIaV9bz1iqdA1LVO+VOYDrHEjHG8eh
 I60Q30uCz/Ood9LNlBE6idH0pbC5io6kPCkRDywNnSWot1Ewj1/q/l6qgXDPN5dfrUwTbD7
 aIwGoXtwmyGopClKCmo1g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7fKLcU9qGac=:2DeFYQj92zNViDMGZouxHq
 7esV95gXpWu4exlVPL+qi3+LaysWC3sg72owH9LrvfaDnQnEENdBjCx8NTCWwX4VXSw9xjbCA
 ZCmVOqe5XvWHe4fw6dZqW0ahJQAiIC5f0R19YNX04l2t19dHtEjJu5exn2bm1EGoSfEHDMO2o
 8keGYiVuMoH75ZHJK7fB2D7WZ07QbQV3+wzqdl2OlfzWi7+AnAZ7eYXtMG+b4/PXayByYlT+/
 MzuEvgPFuzuhaYVNpDAHC4BGa3uSxgUe3gkg/ENxXrZLdAmZP3rH19a7I4J9qaMkEkb1nxk+r
 xmG6bGSx0Qi/eowOpnfAUfmYJCkMtPqCcN/V4e+ZlFajaQOPMGZJJkQlF7VQdMxm2Mxc9N8j8
 8rgv8ax0AXzVcS4iDJ35K0IRgVK6XMFVexhKgsmzW5sa9y6U8UbSGkobSOfbm8IP5Q2JpbHuC
 crWDy9Mtz6VfLIl7loqZu/YrqD0In5XhzRjmG37S1ImzDmAKmmeI+9djaZ4isgx86QEwnBquT
 qM/W4Avo+JXe/1qwjrxmKHhc00QjpVZ/IdzHX1SGQfraw1mm3ZnpZY85T7zT+tPOFzqZ8sjE2
 DX4khbv7Nqp249nrzDF4ogMkzl6FaiI8qGtTun02dyMZK3L45jmlNpP+8RTXiKnHcNM3K8fCy
 M0NM7q7PgXjwJbDD3/BrGeERPYJeSI/Aq2DTzWLB0LFTUtRim1l018joMiwNfdkbBaXFxfV1Z
 ecm9MuxCCuLRgC0QEK+/sKKoa3QYQeAt2QK1T0PrjBh1rD7EE8eH9L0MzGF8f3Qc5F/ZAYdfx
 ivk9Ap/eDto40j1OkkVhbUigjvzDKqhHR6Pw2zR5oiYuXN+fl/kxiutnXCij2jVhsEdFZ8ko7
 C3VXs0+tEsDZk8XcoMLQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

69d2cfe6e8 (bisect.c: remove the_repository reference,
2018-11-10) kept the implicit the_repository reference lurking
in clear_commit_marks_all().  Replace it as well.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 bisect.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bisect.c b/bisect.c
index ee7f7bd017..453bf10a0c 100644
=2D-- a/bisect.c
+++ b/bisect.c
@@ -1090,7 +1090,7 @@ enum bisect_error bisect_next_all(struct repository =
*r, const char *prefix)
 		  nr), nr, steps_msg);
 	free(steps_msg);
 	/* Clean up objects used, as they will be reused. */
-	clear_commit_marks_all(the_repository, ALL_REV_FLAGS);
+	clear_commit_marks_all(r, ALL_REV_FLAGS);

 	return bisect_checkout(bisect_rev, no_checkout);
 }
=2D-
2.29.2

