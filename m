Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E767BEB64DC
	for <git@archiver.kernel.org>; Fri, 21 Jul 2023 12:42:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbjGUMmB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jul 2023 08:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbjGUMmA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jul 2023 08:42:00 -0400
Received: from mout.web.de (mout.web.de [212.227.15.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F2B830E8
        for <git@vger.kernel.org>; Fri, 21 Jul 2023 05:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1689943307; x=1690548107; i=l.s.r@web.de;
 bh=MwrzdNdquzI8aaKFClTZZRQL8bWzPGLVFcCDA0xi3aw=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=QzQPX92KZEHqziIUxwQZXKGp+xLcpusxDfv+MiDLTDZpo1vCsJm2Oo0d2lcXvQXG/Ufs4SV
 lF3ONEVSbzZhY51FO3UrURKbmAC1yN+Vw9ty1MHdeQ17esJc7SHrPCTllZUiVryOMlVARAcs4
 A92EwIVlW3Fld+XBc/Bio3Q5R/H2XxVSI/gqs5W3z5KrkyntAk2OHjoQT/3CQuKqc13p5ZL2a
 HmTIYqiJdm+brdgo1m7zLy580nGoDvUxnCrV8njj0fKAfcd6/XMXVYZ/T/uMoCxFX5yFlXs5j
 qOBpb2tvzrkFLh6IcTpNTJmrXNNWcqJipNZEqmMYmi2vWREQYAcA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.150.179]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MJWsm-1qc9PX0LOa-00K5CK; Fri, 21
 Jul 2023 14:41:47 +0200
Message-ID: <417cab57-2952-9687-d8cb-72f5661a673f@web.de>
Date:   Fri, 21 Jul 2023 14:41:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: [PATCH] show-branch: disallow --no-{date,topo}-order
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
References: <d392a005-4eba-7cc7-9554-cdb8dc53975e@web.de>
 <xmqqo7k9fa5x.fsf@gitster.g>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqo7k9fa5x.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YZSKt3WJakwTbHuau18Uc7PN72XleqdaJxbmOh6H/yqBnMFXwTX
 blZvl4FDEVmWqwwNMQW6A02F2+mr0C/tRHIe7f76Bv+ikI6GM7LxIoGaO+tvqa4vdvx50DB
 buWkiRsnjpeWDuLaDABxD0duXTlBeurSVpzTk2HysZenCt2/e+vhKFsADGTl1rNdnOIe9kD
 XmJiOpayOnItbaZhHMnyA==
UI-OutboundReport: notjunk:1;M01:P0:i3sRWVCZ/Fo=;fFH5tYMnl3zjJlb25IYsAq5RuZW
 wLxYD7Ikx1+7CIfmrPC9lekwcC5yNLav1mswcAeEQzOtckmBppGOJ8KXY4XnqYkj19Y8HwzVh
 f/ipDj95xDz679WS2jBPk2sy6SNsfjPEaQUhB5L7RskWiY/yv4Fi8xMCmLsYystysCeT1gp8g
 pobh8pdmyOMU0wiCDZdEYQdtxz+52x/m17I+hUADuQcypc6d8GQDIT/qWWJ6mHFIeEzGCYNF6
 89cieHUuYgDSefitzpZ/4s7Xsz32AN1NVDMBcd3gnh84YisHMGSVPvnpAyXeJ+48p5yvAo29H
 W0DIuTp6QcK7fQUuU1o2/9kUcq69+qme9jRVMuZFeBtrWzX1IaQmqAKRLQaaF2MEo4XdLDbwY
 gUbXUWVQ0ms/5cQQj81hUtAj1q0b28XZx8lF4CvetmBylR0H0SXM5N1qAz6C4hQoS2RfFpmNI
 FY+0k3JNa6arjS127IZktaUQnRiA9L2cQNvhNy47O61PqB1b5NCr+QZUuB83AczUfL4w6OdVl
 qnca7GNzWKYb40ScXkGNg8UVXAsbMZ0ooKMm8NTtrn7rQ0GOv99nxzQ0bHADN+pmvtu739wd5
 MwnYqu6RcyvuHF5o6v7BqOSxMcAvGaoiBfJQOz0HGR6TfdkfGfqQy9eXBygdr1nch9KjbKPGe
 8+SZ16glkIE1bFOxY43Oddt36IFet2fQWEruSOJksYy/4Cj1uF4S5ED+pqBcvH/IaYY8TCByw
 uuY1+iZrzVX3uc4M2/qlFRqKEDQ8JZk6rLApK+abPWupikYI5TQnmQ70mgCb8n8oqZUuiMD6f
 yX6s3+KhQBMcl7Hz7LtoCGdM4SyTH7h79J+CDsy6rGda2M4mjktq72frE1CXzR+m0CJe94BYA
 EG7/XWk2tcBvnFLIkGBEINySJBitO8Q625yhKnnO47S/0mejrFQsFdxcJXlezokvAPdUFdYUK
 Hdf77bJU+swWcFU5c8E8k+7cQvo=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since 57343652a5 (show-branch: migrate to parse-options API, 2009-05-21)
git show-branch has accepted --no-date-order and --no-topo-order, but
both mean the same as --topo-order.  That's because they are defined
using OPT_SET_INT, which sets the value to 0 for negated options, and
the value of REV_SORT_IN_GRAPH_ORDER happens to be 0 as well.

Ordering chronologically or topologically is not a binary choice in
principle; we could add e.g. an option to sort alphabetically.  So
negating a sort order option makes no sense conceptually.  Forbid it.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/show-branch.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index 99b3f4a09a..587d231dae 100644
=2D-- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -671,17 +671,17 @@ int cmd_show_branch(int ac, const char **av, const c=
har *prefix)
 			 N_("show possible merge bases")),
 		OPT_BOOL(0, "independent", &independent,
 			    N_("show refs unreachable from any other ref")),
-		OPT_SET_INT(0, "topo-order", &sort_order,
-			    N_("show commits in topological order"),
-			    REV_SORT_IN_GRAPH_ORDER),
+		OPT_SET_INT_F(0, "topo-order", &sort_order,
+			      N_("show commits in topological order"),
+			      REV_SORT_IN_GRAPH_ORDER, PARSE_OPT_NONEG),
 		OPT_BOOL(0, "topics", &topics,
 			 N_("show only commits not on the first branch")),
 		OPT_BOOL(0, "sparse", &sparse,
 			 N_("show merges reachable from only one tip")),
-		OPT_SET_INT(0, "date-order", &sort_order,
-			    N_("topologically sort, maintaining date order "
-			       "where possible"),
-			    REV_SORT_BY_COMMIT_DATE),
+		OPT_SET_INT_F(0, "date-order", &sort_order,
+			      N_("topologically sort, maintaining date order "
+				 "where possible"),
+			      REV_SORT_BY_COMMIT_DATE, PARSE_OPT_NONEG),
 		OPT_CALLBACK_F('g', "reflog", &reflog_base, N_("<n>[,<base>]"),
 			    N_("show <n> most recent ref-log entries starting at "
 			       "base"),
=2D-
2.41.0
