Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C38C81F790
	for <e@80x24.org>; Tue,  2 May 2017 16:02:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751152AbdEBQCN (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 12:02:13 -0400
Received: from mout.gmx.net ([212.227.17.22]:59815 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751144AbdEBQCL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 12:02:11 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LxxNo-1eAaah3BWW-015F5h; Tue, 02
 May 2017 18:01:59 +0200
Date:   Tue, 2 May 2017 18:01:58 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>
Subject: [PATCH v3 10/25] cat-file: fix memory leak
In-Reply-To: <cover.1493740497.git.johannes.schindelin@gmx.de>
Message-ID: <c914a7f84b781e81c361f206fe3bc9a4369cc48b.1493740497.git.johannes.schindelin@gmx.de>
References: <cover.1493387231.git.johannes.schindelin@gmx.de> <cover.1493740497.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:hydu+V32wrpI9eLn1G7HpTWO6uYngT2U+OrQeBdi+1Mvtktc359
 btNEnHLqDgIfZxmXaEKDluIZ2tolNXU51z/jRJVv5P93HP1sY76taQO/Wcs9w5E39S7pkdc
 mVx8ccxbcB7NV7dxl7BBb634x7WVKdoQhBSWOtrsFlgBXxK/4nYukh97kaXRVdK8du7gBcY
 oqlT1TYujRfinPMmYi7+A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:0FRzZVE2WiM=:2xQF7gssOBcn3xuuvaomoK
 mt+5WQsCD2ki1kVP+YWFD1/BycYPed5XcDZOHfB2v7hRy7zuKQgZc7UX6oQmz4XcRP9jBzZKf
 EAFHOEETgTeim8AUohxsU8uQKdzd2ozG1TwDQyOapCRbwSVrpS08QjkDOR85tdDmwFofAVq28
 8E76AL76h0sH3MXq83eSJYxm2Xo5GnVbGJawDgVGmnztj505Nac9nxQMZ7Sv5euyB7kxYo2TB
 5EpqnRgEyLlQ2aGFY5xEFVdcmSqhsAa2jlZ83H5GCHEYX7872QVOB32EDgev9ovx5qyL5mlWz
 WzEaLU0DwY2BXVlc+IMDP3qM592dnKMsUtHWW04kzWBb3w4ejJF/6oj+Fg+elIL6+H8L+WlHL
 vVRnwr8AFwolI+OzEVo2EVn3+yllFGDlHhUH9mcWALwr5p4y91W43I+aLJIS/l86UjrW9q81t
 dXZlh4OOW/yGXnDQYYmlsQnyf8kiYZqlJ8DB/4aipRb5aCFonlkIgHPdaOhrJ8pT9YrvxvfVa
 71ziWPW72UL0B4BFzEvgIgZYlWmEUbN912xCa8ag7R2M+lkP79oxJgLCx8EJ+rOI+WjMTun3P
 trZE5NryZCX7SqXmWO4dpUrwcxCBcNlzGyH2d+FpuVb3ttbcPDuq5JOn8jga/lcBbdrg4q2oB
 b44SxQhbCZ51aneF9u49bsw+w+NIhIT6a2OrISgQidNnO1rXikzyThlmirQHMfqqyI/jRg4DC
 G61IkKh0juN7Ow0xLSVBg/eqq8UKnEEt+nCSto8tKFJboktMwv51z4DIM/a13hAMOomB71lWf
 eaf2lzt
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


