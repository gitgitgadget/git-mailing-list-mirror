Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EAD74202F8
	for <e@80x24.org>; Thu,  9 Mar 2017 22:24:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753884AbdCIWYP (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Mar 2017 17:24:15 -0500
Received: from mout.gmx.net ([212.227.17.21]:65000 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753033AbdCIWYN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2017 17:24:13 -0500
Received: from virtualbox ([37.201.193.18]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LnlmV-1cKjKt3mjH-00hwlu; Thu, 09
 Mar 2017 23:23:57 +0100
Date:   Thu, 9 Mar 2017 23:23:55 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH v5 02/11] setup_git_directory(): use is_dir_sep() helper
In-Reply-To: <cover.1489098170.git.johannes.schindelin@gmx.de>
Message-ID: <e1e36dea6dc1ca14cf6d94ecc2e8bbef940d1d7c.1489098170.git.johannes.schindelin@gmx.de>
References: <cover.1488897111.git.johannes.schindelin@gmx.de> <cover.1489098170.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:cfiMLThGth7MHTwK4DrvtyJhe//aqXYJJZh7EW1ofFviWhUh3xJ
 2NBn7NksuWFWkRwcq6rPTnvhSf3Hflj9yiGBN/iLiV62+bbFeCzWpkeDaHf98eGWIxc7X8y
 uLGUkavL2HfgLV9RaQAYxdC9dHrKXyCdTCU5soCiTfTHlhz9s5CaCA972q9MqgeRAE54jYX
 Np0ACXyXHUNXTXJORriRA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:MiXaNprz3qc=:APJFE2uG4sfE3BkBSPHVmA
 5EFAY3qknqIq1Sc+Qn60edLgx5bgRBM/QqnEcqHULMank4WC+Wno8q4TO4EgQLq13IseJ/zY1
 lHZnX1OhUTu995m9edOjHbbsDwVwkBJLzf9A0N+ErR1V0ft867MNZd02La1zBsvgcOHs1Ws57
 tMZMzz3oKBhjjVc7eP5vJ99xjPcEP01kollpzHqekT+Q2/+bb+ySsCevN7NZ8XWtFTzXwu+jW
 ViKTcUaeD5pwshbzPFnQG825MalyWo2dt1LeySMYltw4BvGj8wsMfk1wsHZEvqxlWofgDWUtL
 pfOgL5B4xWlsJOy+n/UG7KlT43G+ip8XcRNCkzveAC+/7lRCENImwnpaMCbFnZ7h1F+aTG0EM
 X5th5KWJ6FOTWb0zFVlKfNlZf3GtsFA6XE/tWOl/Z71KZAuGUtDRyWaixDDQGiF+l5asgmxx5
 CF3OyDwh87DIOmyxFWnmMePwNFz5h5E9nOPdc6uIaQZQA7ta4vLokqsPC0bBYFnJr5/VjbydZ
 T1GbqYRdD34Utt6AtLe5BVAdavPX63Gyipk/XzC7crwhVRUHcAQ6/K2AQnxk8GY/f4YCmf1fT
 JIIxupxkVWfjxBf1Pu9aLUHA+7dlxkL4bEUBFViuu/KmEAXzoq4C7IraNK0gi4Yyy4QGG1VKe
 HMcNHzHS98PrI9kszemK33ENXFppHbjEnup2a/TD9xUsJ/0iLq8EIU2dPMMxA8tTYsyj77moh
 bCd3Ls9PJbxU8jUvZu5dhQVktSEBIzhDm5XJSYnYEht/rmZMHXpzgS4BNlknaDVs9B3plQ4OH
 j7wH7pc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is okay in practice to test for forward slashes in the output of
getcwd(), because we go out of our way to convert backslashes to forward
slashes in getcwd()'s output on Windows.

Still, the correct way to test for a dir separator is by using the
helper function we introduced for that very purpose. It also serves as a
good documentation what the code tries to do (not "how").

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 setup.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/setup.c b/setup.c
index 967f289f1ef..4a15b105676 100644
--- a/setup.c
+++ b/setup.c
@@ -910,7 +910,9 @@ static const char *setup_git_directory_gently_1(int *nongit_ok)
 			return setup_bare_git_dir(&cwd, offset, nongit_ok);
 
 		offset_parent = offset;
-		while (--offset_parent > ceil_offset && cwd.buf[offset_parent] != '/');
+		while (--offset_parent > ceil_offset &&
+		       !is_dir_sep(cwd.buf[offset_parent]))
+			; /* continue */
 		if (offset_parent <= ceil_offset)
 			return setup_nongit(cwd.buf, nongit_ok);
 		if (one_filesystem) {
-- 
2.12.0.windows.1.7.g94dafc3b124


