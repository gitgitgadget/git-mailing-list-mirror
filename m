Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3F6D1FBB0
	for <e@80x24.org>; Mon,  5 Sep 2016 15:45:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755384AbcIEPpV (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Sep 2016 11:45:21 -0400
Received: from mout.gmx.net ([212.227.17.20]:61883 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754807AbcIEPpT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Sep 2016 11:45:19 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MSMr9-1bWJvP0UKR-00TScX; Mon, 05 Sep 2016 17:45:12
 +0200
Date:   Mon, 5 Sep 2016 17:45:09 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/3] diff_grep: add assertions verifying that the buffers
 are NUL-terminated
In-Reply-To: <cover.1473090278.git.johannes.schindelin@gmx.de>
Message-ID: <a264f55769cd6cfedb842710791d71b11d830091.1473090278.git.johannes.schindelin@gmx.de>
References: <cover.1473090278.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:EwNIW3vaqJyxTFaHOHWBWnIDhLK0XeEnMQYug0iIPz70sIZiSzB
 a5OFl/geUaQGi6SexsaJeNUfSLBbVIIwb6zzTdA0Da63lot8UjKyTtgwV21fmyPO8Ad6ljW
 Tqp+09j4PtmIrdPOLNE9rVMFPDO+Qn/pbAvtQaislSl++T6UHXMLuUeQl7OKV1OI6GSMsKV
 UD4NDZpD/SVT60NWDMIaA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:DFEzMlXPqWg=:Z5gnjGdIQVWvBbcAMRGu5e
 TBxxROdPL2SUuzNrDcDU0ZO3+MdItqGv1/Ulu+KL7wdd1eSbq9whBA8ndEP/c9R55zSfFL71P
 QytxdKu+kBatNOoqbGyqkJFUKM+l7j8hOR0fOmvxciQ0Xp2n3H6yViHZlUckiQkc/73ReWeWD
 uAfmZBq0HuK1YWNYPxs2WZc1pep2+UEsb2KJ9hZxEVXW+MKNHFTqkFsIma0s54pu83/9r+duC
 yK7BK3y9VsscXwa4kdECkrn4kfqiIFiygNKJtvigqQp7/1UXu3bhe2UVd5mIsMN6H4bSgQNP1
 bcpANph2lUKKRqQmn3WN4tueQg7kkFXV3JbN8yZJ/kyEIesbwchEHfieJf7I01ZrppKivHeGF
 8hd8EYXFvsnyHiz4qTna/o9jP/Gtex476/84c20POR/jMNgELro374u3mqn3uRHny3EZrbo02
 8I3dcbnRlJW2wqWqIcxgEEvVNwywWU3SBwIxDKGhzM7LxBPN1iwXciwo3K3YoAGul7EWwmMxn
 cfexc/Zve/TvOogoKYi+OtsWTLTm4WEDMboFLg1a+FfuFFsaUEh8ouuItosHr0bnBeBZqhLO0
 p9kTMTJHHfthdNXVHWbA2wAp4f4SJxHWZJ/sLyAvSz3yZqfh3xLb7HFpO1stLEaNJWm45eCS0
 YlekE+BFyH5ouR5ZhI7AL5Mw7du4Xhq9zcmpwJz+8gs5Av4xYZYLdEIh4Iu5xt49Spx5Rf6YK
 asMCnPE7Xry9tkd3kivVIh8l8nvuGb9w2onDI8eeiyTUPXqnq9/qPBzrP1axMNGjjsh8sJ73a
 8NY+JZY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before calling regexec() on the file contents, we better be certain that
the strings fulfill the contract of C strings assumed by said function.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 diffcore-pickaxe.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index 55067ca..88820b6 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -49,6 +49,8 @@ static int diff_grep(mmfile_t *one, mmfile_t *two,
 	xpparam_t xpp;
 	xdemitconf_t xecfg;
 
+	assert(!one || one->ptr[one->size] == '\0');
+	assert(!two || two->ptr[two->size] == '\0');
 	if (!one)
 		return !regexec(regexp, two->ptr, 1, &regmatch, 0);
 	if (!two)
-- 
2.10.0.windows.1.2.g732a511
