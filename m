Return-Path: <SRS0=DRt7=BH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7171C433E3
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 21:40:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A300B2074F
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 21:40:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="gAw9mu0j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729469AbgG1Vkw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jul 2020 17:40:52 -0400
Received: from mout.web.de ([212.227.17.12]:48379 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729169AbgG1Vkw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jul 2020 17:40:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1595972440;
        bh=3bBUzQoHUvXITsRuv3f2YAQkd6dgOIeITwvV24Foefc=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=gAw9mu0j7vwAQqF5Wo607vXR4hSi5Es+b7OdPA8y5TnVyhL3RYyagQ5xrcn4BO3QN
         l/w7BuDHzsAejQZaDaj7nvQNRyG2ANPP2Lpr2O/jfLO6tLM3QbLEizA6O7J72IHnh4
         NIixBptkF3LKZJuEcCJQNIuOMNJgttz0K6MjJC9w=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.26.151]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N7QQB-1kqS4Y3UJ3-017paJ; Tue, 28
 Jul 2020 23:40:39 +0200
X-Mozilla-News-Host: news://nntp.public-inbox.org:119
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares <matheus.bernardino@usp.br>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] grep: avoid using oid_to_hex() with parse_object_or_die()
Message-ID: <551da4ae-c75a-0f2b-7786-2fee32939b2b@web.de>
Date:   Tue, 28 Jul 2020 23:40:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cBgyvRRVmH4BZbLmTHqHoe47tPn+xLME1P2fHp32xv/iHm6qXqs
 LJD68LLut6JIkegP88qtz4hBp0L3alLQnSfpXhztkSchfDKu7192TniW/SCFPsNh5hclEqj
 VFkYhDJyHwWB/vPbDd8/ezfe1u7J8ftq4BA7jKeY9PuZ/L8GTsoWYR9x12ZfyV9o7CWlVPh
 Y3izx5AzSYz5mowiiu4ig==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sIEAy5FKbpU=:swUZHAYM/TROGG4cosFRCC
 IXKQUmkqWvGQEyoxQLPcKeviFUayUyexTwShMxX7EH1T6SxjbV+qn9IVLI1f/FDPygvIdQS5m
 BwOOLwFiQplBofMLFuZJtbTvfzSUIpBE6siy94nwpODGwHuoynKf3V+IKhdMK1ZSGAQGq74hT
 hDsAhqo+HxNepluGT4YGP5Xy7oZCmxv5jJYGzGfHM/NtzaRKrppRsTD1UWOmiFRgaxrEKrt3i
 xsAwD1gLb2Ou7oVKIEFc5AA+kN2FHnt112VLVPpT37lWBIE047zDnyDbFn6CpxmDPWC4dNyg4
 Pzd31vhbAMKQSWDuRK/P342HM4Acl/+lydGAWgSRQqW/pG+mBss02lTCWpq4Dmn6L0rr906EK
 pTw10prJKVy44jWF/8MzF3tv1vi2K35oCw6GiGdQyQcBRtii1BgIlGbF9dhksFHkG9a3FUYuc
 CLWN4AgAJv/64rA9ktzAWzVhRrI6nww0KaHRmReVWJvOd/AcjCaXV80+pjnWPqn4wkdSkbu2e
 7MkcUwJs1USKg29hnUvXI/f5lk8YdwcZK9kQUePLWqSIVMVZFWECdR2Xqn0ZH0/rfuUfVFg5Z
 5cDOk4wmWObOTkzORmiYcrsGyR970YUynX446woJBAuCM6m1E1dUC/Im293Veh7SjLKei8Bqt
 y8BD//MRNANIrjejgp9/GzN+qJuXh3GXn4Nyh8/PRGRXHMT9+GLzQMdgELgCgRwYVZ94UXfLB
 jPJRcwIQia2+ZJICsVIp4iP4Rhif4uTaVbQf9RBxcI0pqONdOXLbhUIRZ7960TYtqlIXT2q6j
 n3m5ghDi7Qrdqz3qufuQ3rZbIeHUKe1bjFOk+tVydbvX7aia7e14tEzfjq+jK9pjdzBIViVdG
 2+Wv2+NeivvwHfkXAWF8M1loVA7MnpjRBp8fPjdiljl1vN8ARGRvdHkhtzE0yasRBm7EzMg7y
 ZIwOfix2IWy/6vS+qgMOhf65vdSGGQiNZ/B+gscQS8aSmySI9Y323+enuszg82dsXS2WpiGYw
 wV4m9pTCxjf6pdE0XgYtSqHs9+UAZA6r47/1HY2VyMxEjnvldgbgSRSJi7Mt5gfX0TohDUKhg
 LexlRkEG4XoPkRpTbWL393yeSekZIUVeLlyyt37LO7J/yxF3C9A/dOJ/K0Xdrgn7Q0xZdKLCV
 Ee7VXTVPS/AG4TYGnncb4bHhfbOe2NdQ3WPsocmqZZ87doCiys+TJdxzbeHlk/Vf88IKPlyBr
 Y6yvxkJC56WBvf1gH
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

parse_object_or_die() is passed an object ID and a name to show if the
object cannot be parsed.  If the name is NULL then it shows the
hexadecimal object ID.  Use that feature instead of preparing and
passing the hexadecimal representation to the function proactively.
That's shorter and a bit more efficient.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/grep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index a5056f395a..5975cf5ef2 100644
=2D-- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -466,7 +466,7 @@ static int grep_submodule(struct grep_opt *opt,
 		struct strbuf base =3D STRBUF_INIT;

 		obj_read_lock();
-		object =3D parse_object_or_die(oid, oid_to_hex(oid));
+		object =3D parse_object_or_die(oid, NULL);
 		obj_read_unlock();
 		data =3D read_object_with_reference(&subrepo,
 						  &object->oid, tree_type,
=2D-
2.28.0
