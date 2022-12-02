Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65C9CC4321E
	for <git@archiver.kernel.org>; Fri,  2 Dec 2022 16:51:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234014AbiLBQvc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Dec 2022 11:51:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233682AbiLBQva (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2022 11:51:30 -0500
Received: from mout.web.de (mout.web.de [217.72.192.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 360EBB7DDD
        for <git@vger.kernel.org>; Fri,  2 Dec 2022 08:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1669999882; bh=Bl3rFSRc9kDl3IBcQriX7bkS+PIUqhZXyaKNd0j4BTk=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=vCZnpUkHeNrI1Rb9m9TfPhg1jOb6eav916b/WHJCIpiflOy+JjR3MWI1mLBSDlqYh
         Dx7yOpoO/kbafog58UA+AVnpCGIwQbXqsSF2AyO4YZg0fLbm40x22SEiHMk9UN9t2o
         XVFaMVtfV+Qmkc8HEQu3z8qQd6Pl8sjdApJzocArqX/6lK+p/KM/FRbrhl4NEgym+O
         669TyhBtCirOVU9dFjPNOMNd7NvTRIPj9srcnA0N2PpH29sTq4l6n2beg47mS/4dUq
         HxL0Xb1Y4IJdsAD8qJEEakondjjT65IRkFMhijIzQPgXV37w9vgmQfqoWcmGg0migE
         UDYg7HVfd5hLQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.35] ([91.47.154.159]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MiMAO-1oX3N630qM-00fXaH; Fri, 02
 Dec 2022 17:51:22 +0100
Message-ID: <203cb627-2423-8a35-d280-9f9ffc66e072@web.de>
Date:   Fri, 2 Dec 2022 17:51:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: [PATCH 4/1] t3920: replace two cats with a tee
To:     Johannes Sixt <j6t@kdbg.org>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        junio C Hamano <gitster@pobox.com>
References: <febcfb0a-c410-fb71-cff9-92acfcb269e2@kdbg.org>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <febcfb0a-c410-fb71-cff9-92acfcb269e2@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wbXYqIyPjB4v3Y6iS84CRy2mDnbeDy1PJS3oGTX6MPer4b1ecYE
 6IGVmV1XoVVcMb9JPNK06bU4v/Y/QbrL29Qatb+YWiRRTP6S0BtuI40obo+4hvRERUrHuKe
 UXvR+3E32YgNJ9dZyp0klsHf8oPnvvHqmfk70wiM7+fC+qji/pJQNpgPrKX2wyvA36PjVpL
 6CLEq0pdIlPotJwRmwDQQ==
UI-OutboundReport: notjunk:1;M01:P0:SYKExHB6FWM=;xNDkyZCqfUGqdvlhsMrgd8BY92z
 GjNOfHXxcrvn7w9f/I/pkpZJ8aFlPAjdOkslfqheqC8KqxQOUizEWgn79vXTApHwH5iIzX7pe
 tVU6RhbMgWmPN+1GduNna7cbObwmCKPTNLKjL8SSfkIICADOk8Tn7OWQM18M+UpDoAKn26i1M
 kKOwoHbj/ON+UV0WrCIRkXFilz7ct7KDi+yXVB6OFwSIKFdi/GQPL9KIgfUo+H/pZharWiTEm
 xRgqQQlbaKids58FN/b5slUhLDpkxjMnjDAcoX0uWorMZEa8bR5W3cKItPpCRCzHNFIyL4izt
 qxn6mqONlw1yEd6nkHNRKCY2QkVJ8tueoO0YcdkjFk7dhaCoqWQe6MlH2C3uHEsJ/sUbgZbcw
 TcA3Nfdsb7eA1L3MtGbRPgEwMauQEBa/FMXhxTJaxeeupHOZTZ9kmJkdhflG9JppwhiGluYB0
 OSc5WlURRhvHFtjBOfsUKFMglTnjC07FEldkvq1x0h/6Cm91mPCaa2fAnekuZ0a8D7tAXPv3Y
 Iu5UIS7muDOyWqUULUHGaiKFFBMPK6FvzwjdvuYqbZQBYr87PnB7MOSDczoloZoN//KbuhE2W
 wWxelcAmHo6PNQLOad5QBlWBbTmk9YXrJtMyRjkbflo8BEp6QNB21vNLNdCPTkbqH9wHhxHHB
 XtTh9wDLGDQwXW5iHQ/6MnzJ+F6SnnNq/ky1duZ0pz49RemyKebijkYEoxCq7Yvrry8Zh8cnS
 2LC/BCBA+6b72FxoFLYTa6CMFpng9k7gWvF4vudsbXlJ/LYoXmcBfzZhzDSbxJJ7zkxcu0KMc
 n9nr0nrEOu92bTX4/pkKmFx2YHqhD7CHHBfWVvqDO3jwxc+vw1LeNQSVrdOrzfqJL3VCrnWVy
 njn7TV+HBumuKNHi48x5BN3ldrRY4C6jIPStOVMqhfFZMgJ6HA88hq/ggcUXnTgB/v69JwaT3
 fXm0Pw==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use tee(1) to replace two calls of cat(1) for writing files with
different line endings.  That's shorter and spawns less processes.

It has a small, but measurable performance impact on my Windows machine.
Here are the numbers before:

   $ (cd t && hyperfine.exe -w3 "sh.exe t3920-crlf-messages.sh")
   Benchmark 1: sh.exe t3920-crlf-messages.sh
     Time (mean =C2=B1 =CF=83):      5.705 s =C2=B1  0.047 s    [User: 0.0=
00 s, System: 0.001 s]
     Range (min =E2=80=A6 max):    5.632 s =E2=80=A6  5.772 s    10 runs

... and with this patch:

   $ (cd t && hyperfine.exe -w3 "sh.exe t3920-crlf-messages.sh")
   Benchmark 1: sh.exe t3920-crlf-messages.sh
     Time (mean =C2=B1 =CF=83):      5.616 s =C2=B1  0.021 s    [User: 0.0=
01 s, System: 0.002 s]
     Range (min =E2=80=A6 max):    5.577 s =E2=80=A6  5.644 s    10 runs

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 t/t3920-crlf-messages.sh | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/t/t3920-crlf-messages.sh b/t/t3920-crlf-messages.sh
index 4fc9fa9cad..1f64ce565f 100755
=2D-- a/t/t3920-crlf-messages.sh
+++ b/t/t3920-crlf-messages.sh
@@ -9,8 +9,7 @@ LIB_CRLF_BRANCHES=3D""

 create_crlf_ref () {
 	branch=3D"$1" &&
-	cat >.crlf-orig-$branch.txt &&
-	cat .crlf-orig-$branch.txt | append_cr >.crlf-message-$branch.txt &&
+	tee .crlf-orig-$branch.txt | append_cr >.crlf-message-$branch.txt &&
 	grep 'Subject' .crlf-orig-$branch.txt | tr '\n' ' ' | sed 's/[ ]*$//' | =
tr -d '\n' >.crlf-subject-$branch.txt &&
 	grep 'Body' .crlf-orig-$branch.txt | append_cr >.crlf-body-$branch.txt &=
&
 	LIB_CRLF_BRANCHES=3D"${LIB_CRLF_BRANCHES} ${branch}" &&
=2D-
2.38.1.windows.1
