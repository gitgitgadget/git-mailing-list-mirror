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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2928C47082
	for <git@archiver.kernel.org>; Sat,  5 Jun 2021 12:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 880C8610A2
	for <git@archiver.kernel.org>; Sat,  5 Jun 2021 12:27:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbhFEM3l (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Jun 2021 08:29:41 -0400
Received: from mout.web.de ([217.72.192.78]:44765 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229916AbhFEM3l (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Jun 2021 08:29:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1622896069;
        bh=/8cGvvsT9XoQxhlO3MXZLJpDtQciYiAYoybF6B7cofk=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=rq3fynFLssZyI+ET/d4x24Z9j4NHzGN4UPmFk+B0/M2K00NzL5kd0drlWXIG+HS+w
         2j1V2XyH6oy2+agaF2DB23GCtYc5CrGqSg/ZJFhU9Zx9jV5QyNMD2BWE1kMiDIqmFN
         8Q/DZi5Y3HFdUNA8xT4LklCwU0VSbR/nReWSwc4Y=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.31.60]) by smtp.web.de
 (mrweb106 [213.165.67.124]) with ESMTPSA (Nemesis) id
 1MsaRt-1lUwU20R9n-00u4Kl; Sat, 05 Jun 2021 14:27:49 +0200
To:     Git List <git@vger.kernel.org>
Cc:     Matheus Tavares <matheus.bernardino@usp.br>,
        Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] parallel-checkout: use grep -c to count workers in tests
Message-ID: <eb4bcd4c-e6d2-cbeb-8951-cf22b9d3d5fe@web.de>
Date:   Sat, 5 Jun 2021 14:27:47 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4LYdFEX3sd04XqI6m3bLl2binN+hS5FR9nc9GAhp6AMlLLewWH9
 KdFK+FDx7O3j7iRcUoM2XXvF7zcZ89COIjmJi3YP6vzoPH6weRFj/wF4DW9K+WZovMfbSL6
 I7O8B1L3YbCexNkCEY1zO90kfi0fBJth1e6H4fSVfuBvXzwNvoYBul16sA7tQOy1cM4z83P
 pAywmwK4cHv8XcCNTP82g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:V3bVkLH1Fyg=:NoeB4/y1uA4qSK8neADFEh
 R/sYtAeF3STWIDbTh7DmWb7vbJaCJnIi3B6A43V6VLuO16Dbplz04MYdu4xP6XOUxrVBQfw5z
 Qe6c9nSyKZIzjQcHdCwE9OPl4nAvg5Goo9WjZIesVbtwnpoPj/AxdA3QSS+r8Ncz9GNbzGM+U
 5t5+HaLlnCWH2TFj/c6AEiDDniGjNyRwkKfAVrrFpE30IiFZpk3EGv6m4j8xksirk4T1ALNGu
 5GvNJ8mMv8wMcvq+d+cDGgLoRB64cJ6yA26R6+JimXEDmS4Tc1lhZiRhm+08LGCBwtV3SVUN0
 MDXg3Jai/DFYs5VrQ4beRgJDBngqNaDnnbDR5YhMbpaTEp6OY2hIfNdrsrfqHvCZvkOxEvEB/
 cpamkBpSh3I+9CjdYlB5iu4d3iyjwjWdF5O116m53SWcrp4WKeuMQ47iHf/WvWMYvyRVLDVpi
 TjF3MGgGeFM2kpH/jHkfwq3x1pFdztKiWezFUuN4iw0nUQOM9tNPotQ/S+OfPWBU9blYUD4m5
 kTWaD968ipHe+QuF/iO5LWKkld/88iqVrprE5tjThEahfRFmOpfBlVtA4YtubmaJhfmkOYHp5
 OhngVpVlWz1xv1EyqgLLkvum0i7h3Gkbd8RG72uyD0BK7DT4nhH4tlv2u9o1Cpd8xgzAayBkP
 0LI8dbSgZ6rbV9ipDaKRT91SF9fOY4BGZ0AvDMOSN6C/KJ8nfn7za8J6MNgFZPu//mng+HLdb
 viiSpjI48RQwbDJgcxBeGBSAjb8wlpiNGIu0tQPaFrh07QF9j4LXBsz1OxUgR11lzKCTiNXjN
 6tER7xqLiQUPwY6XLFaAUmO/fEU6z5NzwnIJlB2nZcwtAImC0E3/U83z1C6h9yolMud992HVv
 UMb3I6D9hzT4ntc8z1l/KPxMcZgJ7c326RAKVepERgY3ZOnjUXvdT7FN4NVzo1rLJuQ1cq06u
 PhsO56DJoND0aEBMCZr+q8QgdCxUsqr1K1xpQXuYfYRvgcJ1Ok3k3eWun84maS8hlh3moBzby
 AKCOqeIBiayZXsg11aQX996sKcQrevIYHCjr5SUxxCVwWqvV1cCuFv/Fz4vPNGSflo7IgNleS
 uQAThnwgDjqh2dB0+gCDjTE/pF+S08iPeiK
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The parallel checkout tests fail when run with /bin/dash on MacOS 11.4,
reporting the following error:

   ./t2080-parallel-checkout-basics.sh: 33: local: 0: bad variable name

This seems to be caused by a bug in dash, which doesn't like the pipe
into wc for some reason.  We can work around it and make the test
slightly shorter and faster by having grep do the counting, though, so
let's do that.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
Reduced test case for underlying dash issue:

   $ dash -c 'foo () { local bar=3D$(echo baz | wc); }; foo'
   dash: 1: local: 1: bad variable name


The pipe is not even required to trigger the issue:

   $ dash -c 'foo () { local bar=3D$(wc /dev/null); }; foo'
   dash: 1: local: 0: bad variable name

Turning wc into a function calms the shell:

   $ dash -c 'foo () { local bar=3D$(echo baz | wc); }; wc () { :; }; foo'

Setting a global variable also works fine:

   $ dash -c 'foo () { bar=3D$(echo baz | wc); }; foo'

 t/lib-parallel-checkout.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/lib-parallel-checkout.sh b/t/lib-parallel-checkout.sh
index 21f5759732..145276eb4c 100644
=2D-- a/t/lib-parallel-checkout.sh
+++ b/t/lib-parallel-checkout.sh
@@ -27,7 +27,7 @@ test_checkout_workers () {
 	rm -f "$trace_file" &&
 	GIT_TRACE2=3D"$(pwd)/$trace_file" "$@" 2>&8 &&

-	local workers=3D$(grep "child_start\[..*\] git checkout--worker" "$trace=
_file" | wc -l) &&
+	local workers=3D$(grep -c "child_start\[..*\] git checkout--worker" <"$t=
race_file") &&
 	test $workers -eq $expected_workers &&
 	rm "$trace_file"
 } 8>&2 2>&4
=2D-
2.31.1
