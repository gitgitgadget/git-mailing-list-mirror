Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5927020989
	for <e@80x24.org>; Mon, 10 Oct 2016 17:25:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753224AbcJJRZS (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 13:25:18 -0400
Received: from mout.gmx.net ([212.227.15.18]:51465 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753055AbcJJRZQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 13:25:16 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0Md3ZK-1bbQgU0jVC-00IFAU; Mon, 10 Oct 2016 19:25:12
 +0200
Date:   Mon, 10 Oct 2016 19:25:11 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v3 08/25] sequencer: strip CR from the todo script
In-Reply-To: <cover.1476120229.git.johannes.schindelin@gmx.de>
Message-ID: <5a639610c09bf1dacc8143603f321a8ea23cd270.1476120229.git.johannes.schindelin@gmx.de>
References: <cover.1473590966.git.johannes.schindelin@gmx.de> <cover.1476120229.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:yb1FUCGQuYqxEtSD4eXIjsmoP5uDZKKkCN7+jSRmz0dkePYxZaC
 cciGo2IgyNd1dFDWqDWdf4f2BCZtEYfzXj2ZeT48nSwbrtgLdQFllETmBog00qVM49IRUaZ
 pKQgCjyej6r9ofhyguzBYDXjTbcp3IBpXEb6WZw4BBU6XcbW8hVP5k+827D7rgHpa4BstwZ
 j7mAOdi1PLWxCbAh2TpUg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:SMLY3GilfOc=:07pv5HzXPfgR/VsErC1foK
 jUAaJjNhqzsu5QohzeO9DRjufJO9fndOQWV8CCfmjfxj+ISIj5o7r9YTF54i0nBSosqpL4Q61
 yPLxv3Bp1WFOg70Fabrdwn2xFTL8RCt5hj6Kp4ytuzfPimK3QrwDs6rwvehmmDeT3tJQr5rEw
 UABVOzFjB2HVXF+9K3n9BRhdk0Xrl5+2iMrT/LqSWTGcqodHHzgEC77yI95htUSH7iZETe6Nb
 Tc0Eo83dhd1gMuJlFA/hV6X+/ojgmDFg9r/QPTvR37fLNaS18gxjI5VFtSeQ3SRjXjj3nIB8T
 QJtNqapGJrG+Pvk5Oc+JpGAopmUjOlDFoo1a4WFzH7TA+Yp/BxwQO+fSG0uOIseqr3HYj5CaU
 W6F10h5k7lWcYhCTOhDtxAVGiFrdMUd/7kTDpDvo3zGGHxSZEycndp0zImD33v2JvshmfRXqT
 AZGI4h+u+Tsm5BXWZAripLtnTxZIWdChYZ8zwqoe3ORb6rdOh9PArkKwIu66muixe+01uSMv2
 0qY3EQhxop/UHRkAGpzhW9gfo4Q0+SaAoaIlqGQprxQhzlJ0ri7N5PvklLQVS6R9cUApo2To5
 dn02Q2ZS21J4RDe4fInMVM6p05CV6V9OnK7IWCaQGX+LOZxeCdiPRKIM8eI4BSYm0nHZjc2Io
 KOMUnNILFwhwj/x/4egj3EOJP28TEowMm8i359Xk/TjOpUFVvxT5p8ZW8lbMBC65aS1D68JBi
 qEdSehnPB0D6IKxHhL+0HACkf1KHib3J5rLKT2sIMzVolveDbRuG3JbR+fwJU7g8vl8NO4+6r
 Qfe6/q6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is not unheard of that editors on Windows write CR/LF even if the
file originally had only LF. This is particularly awkward for exec lines
of a rebase -i todo sheet. Take for example the insn "exec echo": The
shell script parser splits at the LF and leaves the CR attached to
"echo", which leads to the unknown command "echo\r".

Work around that by stripping CR when reading the todo commands, as we
already do for LF.

This happens to fix t9903.14 and .15 in MSYS1 environments (with the
rebase--helper patches based on this patch series): the todo script
constructed in such a setup contains CR/LF thanks to MSYS1 runtime's
cleverness.

Based on a report and a patch by Johannes Sixt.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index 678fdf3..cee7e50 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -774,6 +774,9 @@ static int parse_insn_buffer(char *buf, struct todo_list *todo_list)
 
 		next_p = *eol ? eol + 1 /* skip LF */ : eol;
 
+		if (p != eol && eol[-1] == '\r')
+			eol--; /* skip Carriage Return */
+
 		item = append_new_todo(todo_list);
 		item->offset_in_buf = p - todo_list->buf.buf;
 		if (parse_insn_line(item, p, eol)) {
-- 
2.10.0.windows.1.325.ge6089c1


