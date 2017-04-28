Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18095207EB
	for <e@80x24.org>; Fri, 28 Apr 2017 14:04:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161575AbdD1OEW (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Apr 2017 10:04:22 -0400
Received: from mout.gmx.net ([212.227.17.22]:54466 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S968140AbdD1OEV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2017 10:04:21 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MOCSm-1d9coD2bR6-005VT4; Fri, 28
 Apr 2017 16:04:13 +0200
Date:   Fri, 28 Apr 2017 16:04:12 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>
Subject: [PATCH v2 19/25] line-log: avoid memory leak
In-Reply-To: <cover.1493387231.git.johannes.schindelin@gmx.de>
Message-ID: <6b0eda48e005b373cf573a9f58d9a084336f9b27.1493387231.git.johannes.schindelin@gmx.de>
References: <cover.1493237937.git.johannes.schindelin@gmx.de> <cover.1493387231.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:OxNIeyTLp4J3tuF8UGTAdHlfW13Gl9MwsnZ6o6ONAk/JXugAu+E
 UybHPMRP/NdHohHt7zly+WNzcCmPC5dedomiCl3Ws7dR3xuk063s7x6o+Zr9ds0h3cZf0qP
 J7BVXrykuIf6K2m59q/9Wt8YnmoKp16uhfklAPTymBotkuXPsmeVJsnTcLf70XnhUTsZL7e
 IHjANApkkXsUu3qp/D2zA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ZjKPjmT5U6k=:dKOBtO3HWK0BOWA+hb0Bfu
 FsTzlj8Bh3OioM8lOqmrjnw22WERpEF6QRwKtKRW6MwmgKJMTSZvS/OISeF1bH0913/jj1vcX
 iuA7CYjw9cAhOn7jUVh1USn1k1Sl46NB28Kw62aoHAgsotrH81oHMsqWF4RRAvKo65BCSMjDK
 pZi8OjFeBlLIMAK+2tclE5c0q+SOgwiA46gnV7fYrFc5ob2t+uTozQlEW7K1jWhxZrANO/fwF
 J19TXYE7GXJNNiaz6XrLchJEEDBB3gqTrfnr+ypR1z7GUSi4tgrEODAA8dU+xZms8hOUCC1o7
 Vw42Ezmva7PdMpGSfN0DAz3mqPyGVmZ0ipTfOfUV25GjnWCZ2SP7022oQJTiudglW4oWCZfC1
 RgtidsF7+vXFDKv5O+/E6vWzpE8PZMaOpNSsmlnQFpMvI/OtSpmfRdlwZ04Ik6ESDJYQvxpYE
 wSRkEJg+bsac92MBikJhQ+2RKk1hMxZYMdU0Jlw4cor0lnfD/JjHbewYLYO1e++Drjx2Ydw0Y
 mU5mokAb1AeQo9AZcll3nOSfEBVFEaQTfjdOwgu5Z+OBUYOST1pnJqcaQ4JpI3wd7HPGo6lQ1
 ToAwIGTHbFlvVMWwNXA4mWMJcTrfUSf7P51prMgLFLrAA48djxLQhalPr9AZn72c5j1RdRyfe
 VROowDQ5O6qqRmBPsRmj28oSlMSPTI7cjkN+62VawyzZl3C6DK9FU4k2kv19VSras40OXPxbz
 1FsgJcvCbL/J1TIasjv7iL294uITVVSuVBMUP+OA9tx5d5lSvgdgDlEezBHMgqgBkzVYdZlWX
 HOnBQPi
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Discovered by Coverity.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 line-log.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/line-log.c b/line-log.c
index a23b910471b..b9087814b8c 100644
--- a/line-log.c
+++ b/line-log.c
@@ -1125,6 +1125,7 @@ static int process_ranges_ordinary_commit(struct rev_info *rev, struct commit *c
 	changed = process_all_files(&parent_range, rev, &queue, range);
 	if (parent)
 		add_line_range(rev, parent, parent_range);
+	free_line_log_data(parent_range);
 	return changed;
 }
 
-- 
2.12.2.windows.2.800.gede8f145e06


