Return-Path: <SRS0=7IA6=Z3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA2BC43603
	for <git@archiver.kernel.org>; Thu,  5 Dec 2019 16:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54D6E20801
	for <git@archiver.kernel.org>; Thu,  5 Dec 2019 16:15:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="dORqsdB7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729815AbfLEQPv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Dec 2019 11:15:51 -0500
Received: from mout.web.de ([212.227.17.11]:32773 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729723AbfLEQPu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Dec 2019 11:15:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1575562541;
        bh=9PcVqxXSN/AcHOKeDEfigXipBzU7N6N2BiMxaZ0jYMA=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=dORqsdB7ARTmttxtZCcuVaJ5BUZz9BQNq5KhkkZ//lkn1EIAkIjZONUvK5wF0B95d
         A6AEw7ppqOxaCBR2+Hiyl/MC/6plTcJkNV/NnjX4mJEZaprEeAvroy6i7z8ib23g/C
         yGyLcyy+iiU/v8YbXWTL2zhfEIKx04XHbkTxmlFU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.158.92]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lk8t4-1i2BOR3Jow-00c83g; Thu, 05
 Dec 2019 17:15:41 +0100
X-Mozilla-News-Host: news://nntp.public-inbox.org:119
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?5YiY54Kc?= <lw17qhdz@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] xdiff: unignore changes in function context
Message-ID: <3053f7a8-0723-aaa7-fe43-9b8b13b2e259@web.de>
Date:   Thu, 5 Dec 2019 17:15:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ijXab8mxYb2XiJzq+xpKtwVc3NfuFb+1ZoSX/Gm6/vBjS2EdZ2M
 zuXmEPaIfLuaoR/kqt7egYUT6CtqQCqn41jEJlFTOyWZ6e/9AClb7xOEItKYeHkjMn6e312
 Jgxm/ZAWtC/vxzDC+wiV2lq7zyz5pyGRlG73919r85Os2Q57vNqCRkCFl1UTMyEI8wVV88u
 t5zMQgCpuz0LMciAGfjPA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zOKuTbbeyVI=:eU3smrsZSh2Fh51zoWPbdz
 4ml7dd+/n+XVHPra0v0Um3iUXSxJxg1xFsUqQaOJTIPcL444ifw/ya3I6ijZEzZU8wZeCK9BL
 eiMG0i7fQvXk7r8OLk59PzQWHfJ2aHQZxtWcI2HPVKXXdOTyZc1kKpuJFRqGTdHT6uMmccIBy
 tPGXnoh5XldPF8yVALySFXduKPiPCxsGwK8wHOMqqMdHltxAGKaRKTparQBHMVzsCeX6MCSBF
 jHRGlsElUEcxx6b0Q5W94kLH4mh8Cr9ewrvE/kRsSSnCAKAR37YAyt4Kqc+b9p+D+8j2tHQXh
 gTvRjdVpP2fioZMQnCnv7Qts0WvZsfMNPUyrz3WHd8XP/eT79Axeevi5NjurNG8MaIvVxjRtn
 IICmgklo8G0pnp6FsZLTp+rt3sdI51IlHSnncnbrpOi0bkovgZg2FofBkbWOJ08u0EUcLjxJW
 Xw8ilZAWz/VJPVOzyn/QOiAn4aIg1mrMoLo5Cdf4Hzl9WUVWIyLSDpvQ1ZasY2JWHHLAI11Wm
 Fb2qBP4RfNsO38uj8m6wZQEvp5btTU4Gt4QShMP/L8sJuoZ+K4zcABlA7A0iH61gJdqRgs+08
 6LCgln6r6aASaQC/zLimG09QvX9ctJxfj8w34HAA+NkCXrj50uLXs8QmoXOz4lezkxm0SEpkR
 lJii52j4i3WdeFHwmq+pWfPhWHQGvz6CkHfrPvR9jkZ1tVHX72WqanmYdD//S+KI7QsdbbMsl
 cLo4MzJWCkqTJHJ2M6N/xKy65TLCU9JeP8FoWJiR4hm326x+zT03Ht5uSrg386/jiVBKcT3YO
 Z8scBNn5F/kzP/uC7iuhx4I3wo3zdxvwfRXjRaj/aMhqlMcXADTaAwT6Ht+//PEaA2NE5b7mw
 IFk2iHLaDwNW8J3fSGCrhaH4M7pNPcd0sSZZvqU/TPeVdFz6/WUoatz+k9kr6taYlilnwnSUl
 S1F4jFjHVdjKRjlYnua8H6fdlijOYD1PmMxUQ3wspmhQ+qX2j83qJevm2iDlKhn9z11J+Neid
 wUitkRNzlu64Cn7/Ya7QkRB06UQQh3XH8/I/KGL6nIpmA/qu2jFx7Nubu5SHS3EvfKFalyBtp
 xxmbOVWUWHhp1c4wjro4IK4DbDuuUwZI1bTPuHwSpNBSubl0oGkRsrWi5rJ43OorTsWqbTEdS
 nph5VlGuWa1DNZck9wahCSAkzvqHIY1RxNmnGHrIB3D7SpduZtrjULOwfOuYKKFzak3Qs/I8h
 k5XCvv44TitI8Dw14vGSNK5WWDOqT7URotGWTig==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes involving only blank lines are hidden with --ignore-blank-lines,
unless they appear in the context lines of other changes.  This is
handled by xdl_get_hunk() for context added by --inter-hunk-context, -u
and -U.

Function context for -W and --function-context added by xdl_emit_diff()
doesn't pay attention to such ignored changes; it relies fully on
xdl_get_hunk() and shows just the post-image of ignored changes
appearing in function context.  That's inconsistent and confusing.

Improve the result of using --ignore-blank-lines and --function-context
together by fully showing ignored changes if they happen to fall within
function context.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 t/t4015-diff-whitespace.sh |  6 +-----
 xdiff/xemit.c              | 17 +++++++++++++++++
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index eadaf57262..5888ae5ed3 100755
=2D-- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -2025,11 +2025,6 @@ test_expect_success 'compare mixed whitespace delta=
 across moved blocks' '
 	test_cmp expected actual
 '

-# Note that the "6" in the expected hunk header below is funny, since we =
only
-# show 5 lines (the missing one was blank and thus ignored). This is how
-# --ignore-blank-lines behaves even without --function-context, and this =
test
-# is just checking the interaction of the two features. Don't take it as =
an
-# endorsement of that output.
 test_expect_success 'combine --ignore-blank-lines with --function-context=
' '
 	test_write_lines 1 "" 2 3 4 5 >a &&
 	test_write_lines 1    2 3 4   >b &&
@@ -2039,6 +2034,7 @@ test_expect_success 'combine --ignore-blank-lines wi=
th --function-context' '
 	cat <<-\EOF >expect &&
 	@@ -1,6 +1,4 @@
 	 1
+	-
 	 2
 	 3
 	 4
diff --git a/xdiff/xemit.c b/xdiff/xemit.c
index 30713ae9a9..9d7d6c5087 100644
=2D-- a/xdiff/xemit.c
+++ b/xdiff/xemit.c
@@ -172,10 +172,12 @@ int xdl_emit_diff(xdfenv_t *xe, xdchange_t *xscr, xd=
emitcb_t *ecb,
 	struct func_line func_line =3D { 0 };

 	for (xch =3D xscr; xch; xch =3D xche->next) {
+		xdchange_t *xchp =3D xch;
 		xche =3D xdl_get_hunk(&xch, xecfg);
 		if (!xch)
 			break;

+pre_context_calculation:
 		s1 =3D XDL_MAX(xch->i1 - xecfg->ctxlen, 0);
 		s2 =3D XDL_MAX(xch->i2 - xecfg->ctxlen, 0);

@@ -212,6 +214,21 @@ int xdl_emit_diff(xdfenv_t *xe, xdchange_t *xscr, xde=
mitcb_t *ecb,
 			if (fs1 < s1) {
 				s2 =3D XDL_MAX(s2 - (s1 - fs1), 0);
 				s1 =3D fs1;
+
+				/*
+				 * Did we extend context upwards into an
+				 * ignored change?
+				 */
+				while (xchp !=3D xch &&
+				       xchp->i1 + xchp->chg1 <=3D s1 &&
+				       xchp->i2 + xchp->chg2 <=3D s2)
+					xchp =3D xchp->next;
+
+				/* If so, show it after all. */
+				if (xchp !=3D xch) {
+					xch =3D xchp;
+					goto pre_context_calculation;
+				}
 			}
 		}

=2D-
2.24.0
