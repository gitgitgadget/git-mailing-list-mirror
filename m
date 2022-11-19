Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85846C4332F
	for <git@archiver.kernel.org>; Sat, 19 Nov 2022 17:50:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232969AbiKSRuk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Nov 2022 12:50:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbiKSRuj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Nov 2022 12:50:39 -0500
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF7792D0
        for <git@vger.kernel.org>; Sat, 19 Nov 2022 09:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1668880229; bh=QasVMZUvMRXXdd8PvhI+/SPeWEsxZOgjT56nE0KhAEQ=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=FX/eNim1cBmXGrR6TQPsVNKBcFfH+2W5/gYnkFPyr0rS+xPaGttxkhKPC3axphFyf
         s5kNbYx4Sljv6/uitgt2WEcmhnU+Gg4ZVwnIyzrBijPWkMowmzZH9VSmt73yyDxDyD
         FRLEyWy8plaOAhUNj6gaRIitq+kjnOJW72RXgyedDHE0PTu59HuCKUXVCs1oCQiqw+
         zehPlJw6uh0TzxWZz1OzwSrCD+Rnj5XIBTLgxYxbF9vXuu0xQYKAyr/uhaa9+gkHS6
         B6xQylFxEjBVfjtoWT3Y7pyXTxAG8iGx7EX5tI790exUyVDWTPmAJ2fHXwQTw2bl7g
         7B8y2BI1VzNjg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.34] ([91.47.154.159]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M4sXt-1oxolG3OFT-0025QL; Sat, 19
 Nov 2022 18:50:29 +0100
Message-ID: <f5d6c063-2fc4-4355-57e1-056eac1fb4a2@web.de>
Date:   Sat, 19 Nov 2022 18:50:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v3 2/2] tests(mingw): avoid very slow `mingw_test_cmp`
To:     Johannes Sixt <j6t@kdbg.org>, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.1309.v2.git.1662469859.gitgitgadget@gmail.com>
 <pull.1309.v3.git.1668290855.gitgitgadget@gmail.com>
 <a7f4265ceb26c6dd9d347ef4cbef2aac7d60bf13.1668290855.git.gitgitgadget@gmail.com>
 <Y3B36HjDJhIY5jNz@nand.local> <xmqqv8nbkg77.fsf@gitster.g>
 <65ff24be-4392-f236-5500-ce0c0d4d42ca@kdbg.org>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <65ff24be-4392-f236-5500-ce0c0d4d42ca@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GneYwTnQkmUZKFmbCKGJgAeJROVj8jqzLhK9oONDOtlwH1ZOVla
 ZQ6ccB/9dhHBpag9OwypAA6rQp/0gZxa/jrHpexZPuA6jXul2Y5GVg4wMpsGsJTS05iaq5G
 W+ImNtrNKWkwvKalOdl4VrQJd5A0oXnxdPlmc0bxc4oHKymjYigjSQY4b2g0OiHk+bUnKrX
 heHKogIXcLDxQtRIb1xtA==
UI-OutboundReport: notjunk:1;M01:P0:IcGqc3azSh8=;fITUlmqBLWEGBreaNyuQeG3j7LL
 aGT2Em41F1RpHErmRri2l/yg4nwmWRnQKZhAt8c4aSwmf5xgWMW1SWnWQUVpAz576ntpoZhAJ
 C+LXlvHBrS7Y/37uS2ECTJ+vnxz4BmupngqhrwlHSEIq2wJakKar7Gp6t+K8upfmguQQx48af
 UxQj/+Vkfwk0Wf55iE5W1mksyVLxtUqHbK1Q5Pcd6WlqT3Oo6HU5NO4aYJexN/0ydYqtfGBbD
 RyQm4km8wsUdpG/YNbt+L/6WloAJyTX9Egpwdp4Kc6QJv92DjU4OJlkdPpRclMdCjdst7ZYe+
 OXz/RqTRcGv9EhjuKgmxAO1RQyqIsSZsUgkTZKJ/VkQPLxqg0pqVcxXhBnDO5XTRLcSxnUDTZ
 jPazilqASo/YNCUaUNLhgU6z7tV41xVXYFyI3YRicPuiMMUUBejT5sbQVTRE4Wrf6YToHwfHS
 T99aX1q+JZ9wM2tU7L50j+NzC9Q7y6TWdZkOPCHCRMGW+dGRA6YRwu/wA0KpEY+ZfYvvj6EBn
 56Gng0ypEKbzAFnamA8OC1n2XAgARN81r0wtXc7GXTohUdnoww5H4OWU4gdczQYN4F3vxSpwx
 E9Gm8KUSD5iqLLrbxlRSXHx3kBofUxEHA0P/rSWnHTANDl5b+PvS6noSa0iG/d1AkSq0/FiTp
 nb1K3A8EJ4vAOKnKQjo4K+GvnAsz+WSc+74TO4iN3hw3Y42Lcqqn9w7zalOoWc45Oa1Ydt3YV
 Yy3zgXvoex7LK9V26iysbNkBDfgzw8Jpx9NIkEaipnvuJoljrHAWCkFUavHVGyQRMd5lFu6o/
 GZ2TU57hKwGBOs3fOD9BTRoFmagS2pqoQS1z6s8Gmm5KL3X5lVHX1eYOB+2oPpjvhNG6jaRbE
 yFvEJDgeFVjUu34Pdy2rQClMlHqooeoANkjkQhVM3pz6KQQTVE2rX6UySpr6vi6bWA97SW65o
 +lEm2g==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 19.11.2022 um 09:18 schrieb Johannes Sixt:
>
> The reason that mingw_test_cmp exists is not that Git isn't ported
> correctly, or that tests aren't ported correctly. The reason is that
> tests assume Unix LF line endings everywhere, but there are some tools
> that are outside our control that randomly -- to the layman's eye --
> produce CRLF line endings even when their input has LF style.
>
> For example, when we post-process Git output with `sed`, the result
> suddenly has CRLF line endings instead of LF that the input had.

Actually I see the opposite behavior -- sed eats CRs on an up-to-date
Git for Windows SDK:

   $ uname -s
   MINGW64_NT-10.0-22621

   $ printf 'a\r\n' | hexdump.exe -C
   00000000  61 0d 0a                                          |a..|
   00000003

   $ printf 'a\r\n' | sed '' | hexdump.exe -C
   00000000  61 0a                                             |a.|
   00000002

And with the following patch on top of eea7033409 (The twelfth batch,
2022-11-14) the test suite passes for me -- just one case of grep
stealing CRs seems to need adjustment to make mingw_test_cmp
unnecessary:

 t/t3920-crlf-messages.sh | 2 +-
 t/test-lib.sh            | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/t/t3920-crlf-messages.sh b/t/t3920-crlf-messages.sh
index 4c661d4d54..353b1a550e 100755
=2D-- a/t/t3920-crlf-messages.sh
+++ b/t/t3920-crlf-messages.sh
@@ -12,7 +12,7 @@ create_crlf_ref () {
 	cat >.crlf-orig-$branch.txt &&
 	cat .crlf-orig-$branch.txt | append_cr >.crlf-message-$branch.txt &&
 	grep 'Subject' .crlf-orig-$branch.txt | tr '\n' ' ' | sed 's/[ ]*$//' | =
tr -d '\n' >.crlf-subject-$branch.txt &&
-	grep 'Body' .crlf-message-$branch.txt >.crlf-body-$branch.txt || true &&
+	grep 'Body' .crlf-orig-$branch.txt | append_cr >.crlf-body-$branch.txt |=
| true &&
 	LIB_CRLF_BRANCHES=3D"${LIB_CRLF_BRANCHES} ${branch}" &&
 	test_tick &&
 	hash=3D$(git commit-tree HEAD^{tree} -p HEAD -F .crlf-message-${branch}.=
txt) &&
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 6db377f68b..af5ec357e5 100644
=2D-- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1721,7 +1721,6 @@ case $uname_s in
 	test_set_prereq SED_STRIPS_CR
 	test_set_prereq GREP_STRIPS_CR
 	test_set_prereq WINDOWS
-	GIT_TEST_CMP=3Dmingw_test_cmp
 	;;
 *CYGWIN*)
 	test_set_prereq POSIXPERM
