Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB61C433F5
	for <git@archiver.kernel.org>; Sat, 18 Dec 2021 19:50:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234044AbhLRTu1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Dec 2021 14:50:27 -0500
Received: from mout.web.de ([212.227.17.11]:60999 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234041AbhLRTuY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Dec 2021 14:50:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1639857003;
        bh=LH6ISoowrJUzvMggPUf8R5RqzJBXxaVWhLaCicA57y4=;
        h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
        b=LrGao+4etb4KBZlbqA3mS7b5dJXuCo5SbdQZyh/Wh0/Q1kVujv/B1D9VE01mj8wCU
         u2tyBU97Eo98HVU45I47KRCXiH4Vn89aEOOZVV7s5yTb+GOe2yO5EtksG1rmWZfy5F
         TFFufVB9NeVhCv//fp21eHl9kiJ0OnwYnDTkJxQ0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.22.121]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mcpqq-1mP3mb3R90-00aDhu; Sat, 18
 Dec 2021 20:50:03 +0100
Message-ID: <5fa6962e-3c1c-6dbc-f6d7-589151a9baec@web.de>
Date:   Sat, 18 Dec 2021 20:50:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Content-Language: en-US
To:     Git List <git@vger.kernel.org>
Cc:     Hamza Mahfooz <someguy@effective-light.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>,
        Andreas Schwab <schwab@linux-m68k.org>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH 1/2] grep/pcre2: use PCRE2_UTF even with ASCII patterns
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vQIywTwTuta18nGdX4uZlcjn3f7kex7OCAGgJTOoFdp0h0KTS2+
 Cs1FszlgKAwonT7LJscnFVTxb4s2WEeGyXP0Qcl/ZBIlruA9FmOpscddSAFfXDENBZnhG5W
 7EzTIKeUitD63vdTOvkRQVBGRgWE0k4s57nemkssU0Q2GNGn3/YpOMt92eHj82wyowPmAyY
 IA6z1B5eAUO09El4+/J6A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qKj2HxsMsto=:34EcXeKF75N7PqLdSoqfrE
 QCrinkUsrLH1e4hRWfJ4e603u/e2RwnvJb3oEZBXHVq6tEvXr119GzWP4U1TXdVr5RaIzy79u
 YjXdm3DUN+9vnLMcgP+y4vC4KDjhZyaDv2V+3KQw18npRomrVoi1IkeT5uPgnqnvrA305OavQ
 NgFbbZhbJ0wODyTrGpINwGTS0WKK83xNDKQ7vfF/TSC21gJnja7sA8qI/2m+81+/ccy14Ph4S
 9cRzXWQ6rrbkVQAQIDiz8cWDqvbgtmAobqiV6nFGrmzJU6dgiRIzpf/KHNLFrH3fubehKIN6r
 Z280af1qTOMLk4GTRuS+tQOHbwUK1ALWOI9D9MZQGH3iwXKZVNyJKFR29/QFk6TZD+m+GWgiU
 SCrQL+u/cOBNrYJWvJ/pXo0QkvfUL5cTsoV7K1Y3934C+R08NbF1+Sy5eNpwEDcjjA64ZgGiU
 4Bl5564UwAINB8C12+to6YWFQv7jWzYdzX7KDTdVLnwYaO5jPWXzWEYyAlwPJ3+6cx5NuB4Ix
 SkXoxqEZC4aXZrm4nEijW7GL0iCHsGTt26yRvcSLJ6hrHVDh4s4/6sDIjYQF7sP/uLEveaB+u
 c1aGM8+MdF6n/5fh9rH6m8xKCi1GOYOV7ZNwK+Id+CXYFATFTQFv4Jje+IuDE1hSBEPkbGS2I
 v15Qm+kVWHO6jUh/58tnTqb0OqSMnDviipsA9pRMCXr8ajMdJooI2aJ/qzKd16UK1pTagSh8i
 TaOo+5Bg0V98lVrzEVvxXYtZf42JkA6bH1sgXyiWtVn00wA6tp5vQDQwvve7NUF9hOoHmfWXq
 N07p/2lCmoFs+ix+JcuHErZhle5AepREEaCVyH1hlAQKc0JafGnjd8t5hp7SwsRdL+Fdv5cJq
 I7y/pSrMTapkoPvXnc6PyZa0X0y3ex6KuGfr5JzhHX38xtwUUuqhsV7CU/WU1/HCouCGub6Aj
 nX5v8eqCTAXeWvmKkMOuQibudDdlwxj6onc7dyDy4rx7TaD4GB/RF8mJ97wkjDzmTnDUwZlFP
 RWyOiZg8Oo2IxvpSSZe8Uwaao5vALOEnMHa8ea4rpie+zfeuvldJmncCQ6M/NIm5lg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

compile_pcre2_pattern() currently uses the option PCRE2_UTF only for
patterns with non-ASCII characters.  Patterns with ASCII wildcards can
match non-ASCII strings, though.  Without that option PCRE2 mishandles
UTF-8 input, though -- it matches parts of multi-byte characters.  Fix
that by using PCRE2_UTF even for ASCII-only patterns.

This is a remake of the reverted ae39ba431a (grep/pcre2: fix an edge
case concerning ascii patterns and UTF-8 data, 2021-10-15).  The change
to the condition and the test are simplified and more targeted.

Original-patch-by: Hamza Mahfooz <someguy@effective-light.com>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 grep.c                          | 2 +-
 t/t7812-grep-icase-non-ascii.sh | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/grep.c b/grep.c
index fe847a0111..5badb6d851 100644
=2D-- a/grep.c
+++ b/grep.c
@@ -382,7 +382,7 @@ static void compile_pcre2_pattern(struct grep_pat *p, =
const struct grep_opt *opt
 		}
 		options |=3D PCRE2_CASELESS;
 	}
-	if (!opt->ignore_locale && is_utf8_locale() && has_non_ascii(p->pattern)=
 &&
+	if (!opt->ignore_locale && is_utf8_locale() &&
 	    !(!opt->ignore_case && (p->fixed || p->is_fixed)))
 		options |=3D (PCRE2_UTF | PCRE2_MATCH_INVALID_UTF);

diff --git a/t/t7812-grep-icase-non-ascii.sh b/t/t7812-grep-icase-non-asci=
i.sh
index e5d1e4ea68..ca3f24f807 100755
=2D-- a/t/t7812-grep-icase-non-ascii.sh
+++ b/t/t7812-grep-icase-non-ascii.sh
@@ -123,4 +123,10 @@ test_expect_success GETTEXT_LOCALE,LIBPCRE2,PCRE2_MAT=
CH_INVALID_UTF 'PCRE v2: gr
 	test_cmp invalid-0xe5 actual
 '

+test_expect_success GETTEXT_LOCALE,LIBPCRE2 'PCRE v2: grep non-literal AS=
CII from UTF-8' '
+	git grep --perl-regexp -h -o -e ll. file >actual &&
+	echo "ll=C3=B3" >expected &&
+	test_cmp expected actual
+'
+
 test_done
=2D-
2.34.0
