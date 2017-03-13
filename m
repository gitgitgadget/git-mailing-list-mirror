Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DECE420373
	for <e@80x24.org>; Mon, 13 Mar 2017 20:09:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753560AbdCMUJy (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 16:09:54 -0400
Received: from mout.gmx.net ([212.227.15.15]:59509 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753784AbdCMUJu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 16:09:50 -0400
Received: from virtualbox ([95.208.58.29]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Mcmmn-1cW81Y2oAT-00I00H; Mon, 13
 Mar 2017 21:09:37 +0100
Date:   Mon, 13 Mar 2017 21:09:35 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH v6 02/12] setup_git_directory(): use is_dir_sep() helper
In-Reply-To: <cover.1489435755.git.johannes.schindelin@gmx.de>
Message-ID: <dd755b3cb3a8ad409ee126c4b00651ad5b9707c7.1489435755.git.johannes.schindelin@gmx.de>
References: <cover.1489098170.git.johannes.schindelin@gmx.de> <cover.1489435755.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:b6oHa19RnvKhxdxlane1Y5MN43JFr+1hU2SX/I0R+ooIzHrFBU0
 J1xymDx1JEH6aSHnm4sSymcLJw24PPkHPzwVdaPb1m1LlgXwRKZnJaubugeeGkn1tW8HIGn
 6ANMOZNJznXpYAHN78GzT4LXN+1rcjg0n31FpxV3uSeYrdM5NbiPnIqGTUxCcNRrfXVg26k
 npquI87bMZWm7XnuzKgqw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:F6993xekAbU=:fjH+FyITW/B/MNn/CZ6Jyo
 KE+OkO4dvl79lchlJPTyoiuq3ktjUGBE6ee2v2GfU2tK/V0SSpvLfqgyNHYsKBs3YcpjwrK68
 9ikTtCRQhQO51T8PFJ/INTI3TbI3rin99Snw/AA87fSk+PrzHgxMT4v7Hh3p0h7LVtAo73uJE
 kIVESz2aEIhuArBycKZcelKUtzLRYU+NKUOngv/sYa4CDGWsY5+2clatph4DnNaluI1ItH+jR
 OCeMumJMvZL2Zl8aSOpYbIrYCBFS6i/fk8HHzdtoKNOBpDWJgNipjewEYsPNa4wJWJxcdxqG1
 zNF4R2d+ahIkeV3WXVV4qMU88MBWQqfmZ3yM8mHqsIMcIfZFNA41wa3cb2W1mnB2BOoQgXDdw
 kc8Q+xyqMSbg+xIkGvQEioovSmyQRWFEy6Z9cp1WfKoQD1NvsWNKOtbJEMzGI9mghBV9v1aMJ
 jfToCn9+3QvIbJsBpcAwbEHQzJY2IG0OriPUs25XVr4m7lUl5Y1M00Zxe1e2X/ziI7e0EQRFc
 BiNA/mfEQvUywTBiIvfj5FDBvpExHs/JNf693DoSTnqA4s0x3PPTN3ZecI2ZCX1j/n8Jgr79d
 pwVROzRZGmaUakZfSGvOiNpwRFUmqG0AxwIu4DvjTyA3kvJgnfNgFi1nLCmoUjRz7n0IqGJHu
 hsTJF3RHWvrgyvcX1BDFORK5HhzFK0Y3y/uIwN2VC+lM8oERmWP4Ay9XU6kQbB9im0VKf7pQ6
 BPLjkXSVJJQlVVu+xrOWFGWj0v/cc5zsXdoioZVJH6Wptlj9I4O9VfbEzPKkFs9LCa9hFlENd
 opzVwQy
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
index 8f64fbdfb28..2ac891d4b9a 100644
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


