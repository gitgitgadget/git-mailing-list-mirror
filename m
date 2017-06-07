Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E6D51FACB
	for <e@80x24.org>; Wed,  7 Jun 2017 16:06:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751469AbdFGQGS (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Jun 2017 12:06:18 -0400
Received: from mout.gmx.net ([212.227.15.15]:50695 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751190AbdFGQGQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jun 2017 12:06:16 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MOf5S-1dFtur0j1a-0068fe; Wed, 07
 Jun 2017 18:06:07 +0200
Date:   Wed, 7 Jun 2017 18:06:06 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/9] discover_git_directory(): avoid setting invalid
 git_dir
In-Reply-To: <cover.1496851544.git.johannes.schindelin@gmx.de>
Message-ID: <300d32d72b67f8c12b6cc91c36a5735a77f5ed89.1496851544.git.johannes.schindelin@gmx.de>
References: <cover.1496851544.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:j17aVaamtyKfGwGN0kO0cJ5ZIlSLC0zJMFE1TtMp6GOHgVxrctM
 bXD6iWynYNzmHR2dTXvw9D1f3CZAilREkIqTioXTWYHzHKo0saAjcIqbbmM52YoukluEyje
 17PaOo8npkZuQfdIQhl22HbiRuNI/CMqk2ig1NFxwtd+Wiv7IK/nwSf3FpU6G4sQ35XwHgB
 WCDVttbJ8WtLVklML5M+w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ejEdjTCQN/g=:6O9qoM35YsMdhV5OAb6fo4
 iCo7LxNM5n+pWx+tuY88UzE5E5igInXm6SVXMJx3WlZJYUZ/LzmC8geeo+3dPfSZ/jpZ3FNZt
 pD5aa0Xryy0UItjcGWmylWHr/bTmc7rsZwpFekz5w2nR3Gqj9Ong7PYryNXg4gCIOEYr1XrDs
 jN994nr6aq0yD1UidXmAjj8heEEp45PxNmqSOXYERkpf74tnlhOO0g+LOhPL7SmFzFDq17QXc
 uzt5jbNLwU2JG2xvWZXgjjKvzVn7IkghbezIQ0KMhgbzx9w+1AXhsm3VtiIVUpVECXrQPmpX8
 rX3WKQ5O7oKMh0txifQwbY4J5G0wsvV0iQAzqfeMUEVJS/WcjsaDGYGPORkJTyNx6Lq2c7Xfe
 BjfapWZY87m+KA7/5iK2R3tzeyhKCHX0aZwMDKIo8CbowsLc1NtjKS7b5/qdXiy/+wBEYKzgt
 dAtXAL/7CrUKoqcNgni6F5XpdunMkP55qExZRP7rsgiJ1KB47Q23eDwl0PaROhcvddMpMZA1d
 bOSL/8lpV4uIFFQwCz+4tNvGddnqcq3IDQMgGk+kFGri6/FufDsbYrtnxvFEMBbxpEXASxOhz
 5Vl2rJKAZgeruWsBY5f75Temce8oMAmYlix0s9eGaItK89KnrV6AuRthvxw+0mdpddefFcLaU
 w3+w3vKIWW9NTV+SBO0nYJDEYj8TBkAvO7dZlcPqbZnK6YvahzVSVTRVjSpLIm7FBfMGrHvYj
 cljZtLxlcXymdX2npBhxyrtefICtFEb4e5Y73R8w9/MmhMcrHvJ0q/3qns+2Wblrdu4FvmRYq
 YyLdBvx
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When discovering a .git/ directory, we take pains to ensure that its
repository format version matches Git's expectations, and we return NULL
otherwise.

However, we still appended the invalid path to the strbuf passed as
argument.

Let's just reset the strbuf to the state before we appended the .git/
directory that was eventually rejected.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 setup.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/setup.c b/setup.c
index e3f7699a902..2435186e448 100644
--- a/setup.c
+++ b/setup.c
@@ -982,6 +982,7 @@ const char *discover_git_directory(struct strbuf *gitdir)
 		warning("ignoring git dir '%s': %s",
 			gitdir->buf + gitdir_offset, err.buf);
 		strbuf_release(&err);
+		strbuf_setlen(gitdir, gitdir_offset);
 		return NULL;
 	}
 
-- 
2.13.0.windows.1.460.g13f583bedb5


