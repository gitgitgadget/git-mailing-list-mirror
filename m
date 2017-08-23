Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF8F820899
	for <e@80x24.org>; Wed, 23 Aug 2017 12:11:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754031AbdHWMLB (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Aug 2017 08:11:01 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:50864 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753932AbdHWMKy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2017 08:10:54 -0400
Received: from localhost ([130.75.46.4]) by mrelayeu.kundenserver.de (mreue003
 [212.227.15.167]) with ESMTPSA (Nemesis) id 0LpzzH-1d6CCa3LHz-00ffix; Wed, 23
 Aug 2017 14:10:51 +0200
From:   Michael J Gruber <git@grubix.eu>
To:     git@vger.kernel.org
Cc:     hIpPy <hippy2981@gmail.com>
Subject: [PATCH v3 2/4] merge: clarify call chain
Date:   Wed, 23 Aug 2017 14:10:43 +0200
Message-Id: <28682d03456d49b10b91c0c63de0f4119bcae7cf.1503489842.git.git@grubix.eu>
X-Mailer: git-send-email 2.14.1.426.g4352aa77a5
In-Reply-To: <xmqq1so34m6d.fsf@gitster.mtv.corp.google.com>
References: <xmqq1so34m6d.fsf@gitster.mtv.corp.google.com>
In-Reply-To: <cover.1503489842.git.git@grubix.eu>
References: <cover.1503489842.git.git@grubix.eu>
X-Provags-ID: V03:K0:CFpme7k8V8ki8WrGT0DjLMaZMZ9CvgNZc0cLQGh8iN9t+HdDmCw
 dzXGcAqWN75s4NbbVF/nanLy7pmJDfyeO/ZGgKews5z1JQnNS3LFQ5tqaLcBuNQR6XSGCz4
 no+IPHOHdgLkmcGhdhA14NqjkRYVVbxp5Y5gC0qrFmcC0MV31F9l2y10hPI3+IPlh59ZeBH
 ITKZv8FWjQMiJJTam2mgQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:0FbJItuvygE=:BZXdaJGXz3FLhu28BY2CHt
 g0J7njnpSttbbPiFpKIbsuwGNuXOyLcC0xE9+YcPnn6JO7zM+957imi5mwGQFG1mIJeLyx3Qb
 kga0OV7T5h7v/YgM7vqXHtWNsUTc0VDemFnOg8cfe6dPrjTOqmeK24TEFOWNyPu28Cqqyb8lK
 jgfGjeUypjJmwVqPjyHyg/dELwhn7l2pdDp3F1oMwWM5Pbluc8wfNlhmzyETRCpR5Vz5yDP3J
 hK5NWA9+Ie+gsMmQPFHBMLCWTNvUWcLUYBG8WIu21HbKD++AaHtqqk4XanvsM5JxYLBnhcUZe
 7hSoG6jD5bIweZdRRsbpLvbk/vzHFaGhf9m0nQKEK+oHDNNeVSJBBeAazlre5/2jA1LrkfZpF
 /Jq6Vpl01PXYzeza+lLybo9+4h5VDQl1FQS+HVWtX/dRYaLGUgsiphvEsBRowCn39zNOzV7Ew
 GXJb9/JwMyZeQE9WFZPmrflcHAhzf33bAFd8fPt9dBbL2t9uu64zMhm0gvqi7QV3hM7tvECL0
 9amAcsgnP6FGCHKU5BqzyDDlmAB0RGKMnxyh1g42nRcwfejlEFXFtzymN3Jt6KpNrNeNTbcTg
 PDjAnpr5gNvMpZciaJecAituu71sND2+prcFFg84l0FP3qJcVLICSrFv9z9NU7m3kOhJKnkP0
 ByfLMkI+OEkNF/2dCQOcrlLVlMWlPIFiC0OL1ewaOrwu3Kn0ps6hjrhAHfAGMG1OZ0ULLO+oQ
 VX49iPalpuCay4S9bDwO+BhMrVVy1ymJU+1L/A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

prepare_to_commit() cannot be reached in the non-squash case:
It is called by merge_trivial() and finish_automerge() only, but the
calls to the latter are somewhat hard to track:

If option_commit is not set, the code in cmd_merge() uses a fake
conflict return code (ret=1) to avoid writing the tree, which also
avoids setting automerge_was_ok (just as in the proper ret==1 case), so
that finish_automerge() is not called.

To ensure that no code change breaks that assumption, safe-guard
prepare_to_commit() by a BUG() statement.

Suggested-by: junio
Signed-off-by: Michael J Gruber <git@grubix.eu>
---
 builtin/merge.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/merge.c b/builtin/merge.c
index cc57052993..dafec80fa9 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -763,6 +763,8 @@ static void prepare_to_commit(struct commit_list *remoteheads)
 	struct strbuf msg = STRBUF_INIT;
 	strbuf_addbuf(&msg, &merge_msg);
 	strbuf_addch(&msg, '\n');
+	if (squash)
+		BUG("the control must not reach here under --squash");
 	if (0 < option_edit)
 		strbuf_commented_addf(&msg, _(merge_editor_comment), comment_line_char);
 	if (signoff)
-- 
2.14.1.426.g4352aa77a5

