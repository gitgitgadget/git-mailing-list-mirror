Return-Path: <SRS0=Nv7C=AP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62BFEC433DF
	for <git@archiver.kernel.org>; Sat,  4 Jul 2020 12:56:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F96520885
	for <git@archiver.kernel.org>; Sat,  4 Jul 2020 12:56:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="KW3uPeDd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbgGDM4p (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Jul 2020 08:56:45 -0400
Received: from mout.web.de ([217.72.192.78]:43739 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726738AbgGDM4o (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Jul 2020 08:56:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1593867393;
        bh=GD9UaREf5OJuYwrhkONl3UMxsEV+kT7WqfS4I+0h8cA=;
        h=X-UI-Sender-Class:Subject:To:References:Cc:From:Date:In-Reply-To;
        b=KW3uPeDdZtGVYB9eZ7UpjT5diuRC7ryFHHoV9W8Xc4PPg0J4UvsQBAopt56ONOWPI
         /JaQH287PcgcjItV7blu6OEAoFdk9AA7kNd091z+0qx6Z9ztD+TSOJQCanmP+SjsZM
         NoUBXNr7xUl8JsaSFzFur2Y0xd8rDIEkvc3IIw2I=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.26.151]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N5lj7-1kyjj028KJ-017ER1; Sat, 04
 Jul 2020 14:56:33 +0200
Subject: [PATCH] revision: disable min_age optimization with line-log
To:     =?UTF-8?B?0JzQsNGA0LjRjyDQlNC+0LvQs9C+0L/QvtC70L7QstCw?= 
        <dolgopolovamariia@gmail.com>, git@vger.kernel.org
References: <CAD6JL5SRvB_yXcqJ5HGADQaGtZAiKrtd447vtHLSagJqNGPChA@mail.gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <0c55e178-8f7c-ef84-e6eb-e50de9924ef6@web.de>
Date:   Sat, 4 Jul 2020 14:56:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAD6JL5SRvB_yXcqJ5HGADQaGtZAiKrtd447vtHLSagJqNGPChA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uRie3PBIdkZCQBBupDOMNXyIqQpk9cgnwmGfeccE0dd3HM2zV06
 mcC9nepnXkf/wzmQW01+zgkMLec6L/hmCYk+bsdte0j/2EFVTWF6phZWP62MgrbV6t2l8bI
 IB+OwoDUgULoz+20yOMBRTCMGEGAqbyvQeD1Kq/16R4aPv+z0/4g82VWpLtyetP2R8H5h5c
 7aL3m+c1+yPuipWfwmf4g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ed9+MHn8x6E=:ANlchnyP17iqCQJQ8wzh6y
 F+9KME0Fb57GIlNwdlkytjKk21wUt+BN+SPW2VVSXviJzT+rxkH3CLHSe6C7zYzRH8Uhwe1hs
 iAyYu31Zzjg1eLEl71PXj3Pvb2Z002grpu34haiM3Xi/PViiDX7PNRLPaD2eVCCRUW826Xzfl
 wwo26/pMcs8dd0x/8jyg8cTekiw74nT9c0L5zUsx+5r4msOTpTcEXntgAOCE5VyL3a17ZUeVu
 Zefmt2C+eFMhUDn7turtOca3X8Ed6GU2Q7QDTO586jFMljGcSc4uNlDzjuqTr6KmdRTwRYp0Z
 2YCvC6Rmlzh66tFMgXWYVjKHYDhXNSZ7G1oCUfDEQyKceHY3hPln2sjwdZ4tNTY7A+MwU+unP
 JPWQbPtU24J4J5N53CMQgnv29yp5jaUgD+QdC5wjV7mExduBkoe2M7OKgJijv5WVFIMU+oYQ+
 PeeUWA4txa3RhDPwrHLSOq1H8tLDY6J13cRHJygIiyEvYyUdrcl0UyCSbLUI6SezDfivGrktM
 W4zzXizGD2BKS6PPECuUlPokFgkQfV7kC9LwW8a/emJl8zubqVBH0/Og+3WIT01wkOfTMpIuO
 NsBL93oJBpfvVtDQbhhKGhBqmuCVZUPLVce0R1n4xhoxzmt4kgMIi+ytqtt8v2zRSTPKX/eoR
 f7AHHkG9SpPXsEe1H5eB08sbQSPm+jBt6uMH7BXAbFzA7jdfs1Q2MvwBPqjtLqu5K8RkXtEfo
 2maNe0JHs8FUPCTESO+5vboZbFnrhsaDUhS6/wZUq6wLzmjp9TM8gL4NbVJ7UEFOE5yaoXA7R
 6FqpSPC2NYujq1OqHMIqicz2rOcbKJfDnixG5xVhWnrlZGIhh6PGtUKFJQVnwscgEGfNvlbAn
 6Vo/S4Bppdi1jV96FbGcIHAD9WWtRt8ULKlma2afq8ibBJHtyhlid8o8WRV+aQGULWwd7SIgB
 GDBxw7p2/9jo7CQ8CdyY+KRlea/Lcsr5eo5YictVG/zy3B1t8uG41zJjyP4dpyQ+PJjRak04N
 phjadiwAd0qsbpW2fqLF7bc/h0dibmZFIgY+u/S3yuLxyt9Fg+aT5xP3Ohy2xovhCLWMe20pu
 rFSEnRj7a4MXlaVY0HiuzMckJQeMraxGAQGGsz3MxjAKZkR/uaZek6i7idP9+QEmu423rk8mi
 n3C+nDwaPKn07cICebMhyUxAFzn0IVvgYOsuGfHYVamcOSa8wPQRquppSQ9IZqJq4JFZs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If one of the options --before, --min-age or --until is given,
limit_list() filters out younger commits early on.  Line-log needs all
those commits to trace the movement of line ranges, though.  Skip this
optimization if both are used together.

Reported-by: =D0=9C=D0=B0=D1=80=D0=B8=D1=8F =D0=94=D0=BE=D0=BB=D0=B3=D0=BE=
=D0=BF=D0=BE=D0=BB=D0=BE=D0=B2=D0=B0 <dolgopolovamariia@gmail.com>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
Needs careful review -- I'm not familiar with that the line-log code and
the revision traversal machinery is a bit scary.  AFAIU the min_age
check is done again in get_commit_action(), so this patch shouldn't
cause underage commits to be shown, but I'm not sure.  Test coverage for
the three options is spotty. :-/

 revision.c          | 3 ++-
 t/t4211-line-log.sh | 8 ++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/revision.c b/revision.c
index ebb4d2a0f2..3bdc1bbf2a 100644
=2D-- a/revision.c
+++ b/revision.c
@@ -1410,7 +1410,8 @@ static int limit_list(struct rev_info *revs)
 				continue;
 			break;
 		}
-		if (revs->min_age !=3D -1 && (commit->date > revs->min_age))
+		if (revs->min_age !=3D -1 && (commit->date > revs->min_age) &&
+		    !revs->line_level_traverse)
 			continue;
 		date =3D commit->date;
 		p =3D &commit_list_insert(commit, p)->next;
diff --git a/t/t4211-line-log.sh b/t/t4211-line-log.sh
index 1428eae262..e186c83250 100755
=2D-- a/t/t4211-line-log.sh
+++ b/t/t4211-line-log.sh
@@ -240,10 +240,12 @@ test_expect_success 'setup for checking line-log and=
 parent oids' '
 	EOF
 	git add file.c &&
 	test_tick &&
+	first_tick=3D$test_tick &&
 	git commit -m "Add func1() and func2() in file.c" &&

 	echo 1 >other-file &&
 	git add other-file &&
+	test_tick &&
 	git commit -m "Add other-file" &&

 	sed -e "s/F1/F1 + 1/" file.c >tmp &&
@@ -283,4 +285,10 @@ test_expect_success 'parent oids with parent rewritin=
g' '
 	test_cmp expect actual
 '

+test_expect_success 'line-log with --before' '
+	echo $root_oid >expect &&
+	git log --format=3D%h --no-patch -L:func2:file.c --before=3D$first_tick =
>actual &&
+	test_cmp expect actual
+'
+
 test_done
=2D-
2.27.0
