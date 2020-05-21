Return-Path: <SRS0=Ny9l=7D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B906EC433E0
	for <git@archiver.kernel.org>; Thu, 21 May 2020 09:53:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92A14207FB
	for <git@archiver.kernel.org>; Thu, 21 May 2020 09:53:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="Y4sfIVCK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbgEUJxA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 May 2020 05:53:00 -0400
Received: from mout.web.de ([212.227.15.3]:38017 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726353AbgEUJxA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 May 2020 05:53:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1590054775;
        bh=xs/ddUgKfZJeZy8w0+Ngy5Hqapwzem0Nj9oMESMS8q0=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Y4sfIVCK+HLjDo2zM8kPxD3M5DGzP5OZohHD8JTDEqn9ba1Bv54BIGkub3Fs822wa
         Rc5N3mvE2KZm2XUIJ/UGV4Cxsg2aYha9wxuFVnXqSJ0zzmeBA6peAATklHpATomar4
         OFCy06ZPDZcWhPKcoAK7F6gzGDHmfuGPlWGpLxNA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.24.188]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MVrbl-1jS2gE0x65-00Rmjl; Thu, 21
 May 2020 11:52:55 +0200
Subject: [PATCH 4/4] fsck: detect more in-tree d/f conflicts
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Brandon Williams <bwilliamseng@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>
References: <CALN-EhTpiLERuB16-WPZaLub6GdaRHJW8xDeaOEqSFtKe0kCYw@mail.gmail.com>
 <d963242a-72f3-7f42-7c95-ea5148f74804@web.de>
 <xmqqpnbduiec.fsf@gitster.c.googlers.com>
 <938f0818-7e57-b883-009f-01db88ef8f65@web.de>
 <xmqqh7wovoop.fsf@gitster.c.googlers.com>
 <aab9512b-a70a-0f5b-5cdc-5d40acd343d0@web.de>
 <2937d635-52a9-5e69-b3d2-fbde415b7315@web.de>
 <xmqq4ksmsaks.fsf@gitster.c.googlers.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <36ba44ed-d076-12fb-3d28-7b5989c736b7@web.de>
Date:   Thu, 21 May 2020 11:52:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <xmqq4ksmsaks.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CkubMGKS0iqizBQScp9Ss5dEaWhY7hLfqF/zkj+kfpLvdm8yJxB
 Ls0Va+foehpTEST0nyGdV5WF6WstcvyFLxzpQ88UOdY8dnTvjR4lU/MNTrJ8jbxOU09veeK
 MTDuuNXXqe4jepY23bEb5UZBrhDLkpLJQ2juAnVhatr5k31g/Vm+DBRzyP+dLc8lVSJW/Dp
 IUvQEKH0fLmjt00PEuemg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1UDmio9RNKQ=:LRua6Kol2AA/YIwz/VGDTJ
 3Tk33dItYNT15WeP3XYFxG/KdwyDrRP5tz2urg1SxjWJudCtipe6sKO+VFZuUQc65f1Whnxgs
 msv770Bjq+DvitrFoG8mjke6K1jFy3CXYMdDWK5P1cVeLLhroPcJdqVwlEJWIv+p/bHMRuG7+
 TLz1oxbxbWhx++SFYIWmlcFZlM8oUS19PRlHs0RdRhb/2aa4a6qaGDBpXQVJsJx/66N0VAyLV
 KDsBZ7yeDusD/zfPIsP6kcDW1vuvQ43XtWZSjIXghNPdpI+X7MbAEF0KfZ57Zlg18iYK13htF
 UXmszV6DA/W2Qt5CBOYelaQ3hSYUvSI1ul7xjHIViRZm1bwVy4SCp/iXBpPHiW8x2tjvWXL6h
 tiL9byPe+f4ohIuK/JBd+VDAtBWYFBQLylt3g2ewqyzsu71nid4dNBBjb5pFLLW9Zd8Un6yTz
 +RXiywP6Lo4+rxjjQV18PEizltre8aBzXm+H4gUZY5mWOffcM8wSks7pN/noit87iRAnazU9q
 bYXPAHCm9x8zwonQWXb27GQ8DRHztOYMxfbw8TTJghIfqGhTjtVmR65fHCsAElUEblxkW2qhn
 H/hz9Ut5oaTwC0GMZ8MvGdCtZDJZ/R3uiYtw1mfXXHS29TZTmTloMcOs2Me2yNsf/3Hja0K3T
 ssZcVcbknyc6RqqBEbMNxN3+hW3NB0A4Da/kEOFuP1+u4q1jvMG2yvF3D+A3i4T0mtUt3Bz2i
 EcHNhB1X7f/FrCyqP5dc5e1Uey0bFVzBJaGKNahuotSP6+xW/vf9k5/5G9VIuh8NgWilSWNZ4
 QQIwrSmhLbZSvpNiA4QBKx/k8/JHULPpF2f07HUKkyemugZx5i9ByBghSXBmYYgZXUFuz5cfH
 kkqPLQsy5T6fOr7RPJVbyJ9zYK422RgNcNnTHDMRWNji4CV4jI9RgeRkdW13+MKgM16Kwm4ed
 iAXpGiH1+gGSestJ01gehlzv6umj8qvsTUUeqwdSqyWTV+QaVCb1idn5Aj5L+BeO4WjGHpiFd
 VxpNCU8I4RMDqrLq9jtoR57jowIZyHJLPe3VpveEXpTAz1q8L239pS7X0OLn/4lCanRhrQAbX
 M0/fMu39zepMpdmyQpZGrZxSr4zgtKUGg7FqbpdWBw4zkk5udvPqBTWSwdxhlxGRQ6l2raRKt
 VgCJBQk6gGh8+6IiQfdQgzI5VCIMW0bX4owyIfS84J87PFzJnVKDxE6TbodFFXMbMaQnivG6k
 G3WUGNV+yD+Ua81j2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If the conflict candidate file name from the top of the stack is not a
prefix of the current candiate directory then we can discard it as no
matching directory can come up later.  But we are not done checking the
candidate directory -- the stack might still hold a matching file name,
so stay in the loop and check the next candidate file name.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 fsck.c          | 2 +-
 t/t1450-fsck.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fsck.c b/fsck.c
index b48426262c..f82e2fe9e3 100644
=2D-- a/fsck.c
+++ b/fsck.c
@@ -620,7 +620,7 @@ static int verify_ordered(unsigned mode1, const char *=
name1,
 			if (!f_name)
 				break;
 			if (!skip_prefix(name2, f_name, &p))
-				break;
+				continue;
 			if (!*p)
 				return TREE_HAS_DUPS;
 			if (is_less_than_slash(*p)) {
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 5780e10cbc..344a2aad82 100755
=2D-- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -284,7 +284,7 @@ check_duplicate_names () {

 check_duplicate_names success x x.1 x/
 check_duplicate_names success x x.1.2 x.1/ x/
-check_duplicate_names failure x x.1 x.1.2 x/
+check_duplicate_names success x x.1 x.1.2 x/

 test_expect_success 'unparseable tree object' '
 	test_oid_cache <<-\EOF &&
=2D-
2.26.2
