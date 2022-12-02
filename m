Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD66EC4321E
	for <git@archiver.kernel.org>; Fri,  2 Dec 2022 16:51:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234084AbiLBQva (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Dec 2022 11:51:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233546AbiLBQvZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2022 11:51:25 -0500
Received: from mout.web.de (mout.web.de [212.227.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656C0B7DDD
        for <git@vger.kernel.org>; Fri,  2 Dec 2022 08:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1669999878; bh=ww/RvJA9ufj3hJ8KxBA/E4889hMCTXWViv6Hel5ve8A=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=TVuGH7iWtt0y3EHjc89r76zH/VxN0vRR1fzs3XlrbvrLFvEZeCeLl1jAGesLV64P4
         nZzZgfX4+yLjBeSPGmnJ8kAFQEjWPEf7wW3PLGND6fElaDOsUckdf7Luzo78pumXMD
         fXSqQRceGvAD9Sc06spUjlj+v3jSd4yQ8vw1SCN207NSPpa9oHsZGyIK/sDcfAkBuV
         WG0ddcMiMS0fYkVcyrw+/70LhRwkN797U40vn87uXS1kcFk2I4lC/kY243CskZ5BsN
         S1I5/IF4uEqua3QP3qipmU7IA4YPkyUjnr4jH3JmSjo+CK3sTyo7mAXv8KkN/PbNWt
         1w2mUpmNTkAtQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.35] ([91.47.154.159]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MZSFY-1pWXvE2gzO-00WhAZ; Fri, 02
 Dec 2022 17:51:18 +0100
Message-ID: <9dd8764d-bda9-6602-9ce5-af14de32e315@web.de>
Date:   Fri, 2 Dec 2022 17:51:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: [PATCH 3/1] t3920: simplify redirection of loop output
To:     Johannes Sixt <j6t@kdbg.org>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        junio C Hamano <gitster@pobox.com>
References: <febcfb0a-c410-fb71-cff9-92acfcb269e2@kdbg.org>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <febcfb0a-c410-fb71-cff9-92acfcb269e2@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DPILryLXAfzwPnwTjcJWUZ2hWo3AZ4QqcICxWVBP61qi7ODVuGu
 P2aF3T5AcMLuMVXufIA/lHQN09EPxMEZ/6iLMcou6aciHdQ5QrUtQIlRJ77AKXincV/7NKO
 6RUt30bOdlagliq+DLpRm69q2h0YtCN07PmLo7oHmjc4gQ+tg+xTX5ZvRd+kQ10CsogACt9
 2zcif1fgQ6xxzmhqytrPg==
UI-OutboundReport: notjunk:1;M01:P0:XiXDix/ULoo=;ZkvRkyZxcieLh9A1nv8u1B/cLrb
 cz7LKy8upaxrJpqfEAmKRQ5Aq9r9kuhNt/b6ND3q8pzOypSEfXpOrvdcry5YWtjXBzvljQMYW
 BCWUgYzAwk2JYxMuHRBLnB+wEJ3Li6zE4JxD3ZkOSpv10HRX4tUM16pEwVScM9iB6Rr5ko8Im
 /IowJHuMf1eC4v0YrH/tBTDG1XuwETSLS7474bCmVUzjrRMwyIHT0zzMiMhWK12mwf8Dp1ZED
 yH2os+wDlrM6M8/qLiActyF1PNlOudOjBFVkzysV1yWiWF/ZmO7JwTWHoZodU+nFuGrLtUy1O
 pfGxtkuzeleY+K2HTTQqG1odUOWr+9w6Raiyz1ENz7RmHYnULVRVBxv9lkY+wrzIgCdyc/qMY
 NL+J9CBE4iy/NE8ASgwx6U/IbSbqcjdYOCvlC6Oxf00/N7mvUQR7JCcyHHXEGuN5z9ZEhNzD5
 MYTTr0HZLXY9jNzZ+UUATsntuAQpuUqUb4O+WqSs0M3ePcb8+lrc+6IBbo44JR7D8iYkL2iQg
 cxMETGGsPNr+xfRaM0tjH4Q3VtlvnsTFpAx0WWYfWSCfFkt75IK9DnqovwTh5a4unTfawqfBL
 aldcDS/gC2IYG9pRrsrbzxGRSRuwYTzWa+p1ZzRJs6Kilmypqd5iNfo3gFRiatNKHX3PaY7ta
 I8vf+MCp7+Ze1Z+08BT/DtQsXtOSEVdFRwFn5M1ET73CKvpAq+VyHawXu0uPGp7ZNI7/TSVn8
 CTlm+BelSdV9IyJmk2Ku95KSyzok1bOO5PnT0lPQ8SdpkWgAKg32XjqBnvbJDAZd2TRwz57T4
 c4C6ngVyVuw9wnRAigHbD+JzojBxRzDrJea4eGM9yBZa6KcJYEZogsQC4k6QF6UvglUcFkaiT
 864eT0nyRxVyd/umkXgG8Byzg8NE6EC4q0cLHlwPqt4KHEVgM+f4vDP1P91Preeduam4+mUPB
 QN4Zlg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Redirect the output of for loops once instead of deleting the receiving
file and appending the output of individual commands.  This reduces
repetition and speeds up the test.  Here are the numbers on my Windows
machine before:

   $ (cd t && hyperfine.exe -w3 "sh.exe t3920-crlf-messages.sh")
   Benchmark 1: sh.exe t3920-crlf-messages.sh
     Time (mean =C2=B1 =CF=83):      5.923 s =C2=B1  0.037 s    [User: 0.0=
00 s, System: 0.004 s]
     Range (min =E2=80=A6 max):    5.889 s =E2=80=A6  5.997 s    10 runs

... and with this patch:

   Benchmark 1: sh.exe t3920-crlf-messages.sh
     Time (mean =C2=B1 =CF=83):      5.705 s =C2=B1  0.047 s    [User: 0.0=
00 s, System: 0.001 s]
     Range (min =E2=80=A6 max):    5.632 s =E2=80=A6  5.772 s    10 runs

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 t/t3920-crlf-messages.sh | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/t/t3920-crlf-messages.sh b/t/t3920-crlf-messages.sh
index 67fd2345af..4fc9fa9cad 100755
=2D-- a/t/t3920-crlf-messages.sh
+++ b/t/t3920-crlf-messages.sh
@@ -68,12 +68,11 @@ test_crlf_subject_body_and_contents() {
 		set ${atoms} && atom=3D$1 && shift && atoms=3D"$*" &&
 		set ${files} && file=3D$1 && shift && files=3D"$*" &&
 		test_expect_success "${command}: --format=3D'%${atom}' works with messa=
ges using CRLF" "
-			rm -f expect &&
 			for ref in ${LIB_CRLF_BRANCHES}
 			do
-				cat .crlf-${file}-\"\${ref}\".txt >>expect &&
-				printf \"\n\" >>expect || return 1
-			done &&
+				cat .crlf-${file}-\"\${ref}\".txt &&
+				printf \"\n\" || return 1
+			done >expect &&
 			git $command_and_args --format=3D\"%${atom}\" >actual &&
 			test_cmp expect actual
 		"
@@ -87,13 +86,12 @@ test_expect_success 'Setup refs with commit and tag me=
ssages using CRLF' '
 '

 test_expect_success 'branch: --verbose works with messages using CRLF' '
-	rm -f expect &&
 	for branch in $LIB_CRLF_BRANCHES
 	do
-		printf "  " >>expect &&
-		cat .crlf-subject-${branch}.txt >>expect &&
-		printf "\n" >>expect || return 1
-	done &&
+		printf "  " &&
+		cat .crlf-subject-${branch}.txt &&
+		printf "\n" t || return 1
+	done >expect &&
 	git branch -v >tmp &&
 	# Remove first two columns, and the line for the currently checked out b=
ranch
 	current=3D$(git branch --show-current) &&
=2D-
2.38.1.windows.1
