Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24AA0207E4
	for <e@80x24.org>; Fri, 28 Apr 2017 14:03:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031531AbdD1ODW (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Apr 2017 10:03:22 -0400
Received: from mout.gmx.net ([212.227.15.18]:49208 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937554AbdD1ODU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2017 10:03:20 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LwZtX-1eAge139f5-018KzN; Fri, 28
 Apr 2017 16:03:02 +0200
Date:   Fri, 28 Apr 2017 16:03:01 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>
Subject: [PATCH v2 10/25] cat-file: fix memory leak
In-Reply-To: <cover.1493387231.git.johannes.schindelin@gmx.de>
Message-ID: <633670d87f7080d1e21f1f639bc560499572f3f7.1493387231.git.johannes.schindelin@gmx.de>
References: <cover.1493237937.git.johannes.schindelin@gmx.de> <cover.1493387231.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:B5ZBpQk1OdrwxKsOmXcwLf1rX9YFvq4IikrMzx8kBQtRM4ourGt
 hx3lOFuhO6GlqcRBK482GNou1UiTuWhGTbDSKTf5r9kjiZgxmzzA3406fXXU/al9a5XkEL3
 B9CuCQ6vExLUrY1ev0tHyrb698Z172dxJAUa6nORRNoTeMzOMz+99uoDjLPBFT2Ji64nPgG
 q6GhgGNIBGVtw3pwcMVjg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6JLj2qw6in0=:k/mixFbFFYAji3qGTy8bDK
 w5d+0iPFAC8Gq402DTcnk55Va1TchWhskdxyNgMz0EGWzQRXKkz9k+KaRdYR/5xc6fQ155nT3
 Bk/3taKnUc4m+H7B24whu472HQjKEN1av7ApcaDD6QMqubHdTi1dc+AkADdlsCawYgHEQeyl1
 HRhhjZvX4kmmv4M/uZX9PpLrk/D53PZaL1cGyC9A8x0DzD5oGIIquwlEbQbGyZGAFu62Rb+Os
 E0kBYzQqpfT7uzVujUnLaXiqGjpsQLm263T6CRI7m5SGA+D7YKIiiYaOB2rcDngvy6DSmrjWS
 NudfEU4Dx0TK8TQby+9e5k8guF4sNOUKtP/JiiUvJaVu8UXPnN7I+46mv3OYePptfjpGQlsCp
 n1UaKmhoR8utHwQW30At0t7ep3Xj+G/OBn4tERAE4HYaBhQzNAtBdhsq/dhlQEi20QwzGd0C8
 1teMOSTW7lI//Fm2HckkyaIQmdXri+zaoTRftw9DUsnVitZ1IiGPmuvmbXo//H8FvETAqV0ri
 AyGIPkFkwaMGVUtTAKQ4JgfWOiq9hY5bkOCekqcu/aGseyJ4HGiFpbk5z5GvckeHQtfG+6iUr
 DB5ltDXw17/K0MfePH416GFioQoJcM4rWC9udYdHkJaQHpY0sG/8L/U5RM0JEc1A+JG4Puc5f
 nm6MPZFv4cMQVTu4LXoOfVJCPYK4F6a4ssgG0mifZ537UhPCOhpRmP+Yigm7jdGMDXy8DB/LQ
 M2Ex4Dkpyz9X1me113eo9pNzWOvQLh+W24oN524sBIztoZVocZX4OWySm72AGPght9IB6Y5kZ
 09SM+vF
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Discovered by Coverity.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/cat-file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 1890d7a6390..9af863e7915 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -165,6 +165,7 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 		die("git cat-file %s: bad file", obj_name);
 
 	write_or_die(1, buf, size);
+	free(buf);
 	return 0;
 }
 
-- 
2.12.2.windows.2.800.gede8f145e06


