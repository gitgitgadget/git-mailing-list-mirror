Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C249202DA
	for <e@80x24.org>; Tue,  7 Mar 2017 14:33:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755643AbdCGOdQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Mar 2017 09:33:16 -0500
Received: from mout.gmx.net ([212.227.15.18]:54766 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755615AbdCGOdF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2017 09:33:05 -0500
Received: from virtualbox ([37.201.194.72]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M2tXS-1cRnnz0Chi-00shiF; Tue, 07
 Mar 2017 15:32:33 +0100
Date:   Tue, 7 Mar 2017 15:32:32 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>
Subject: [PATCH v4 02/10] setup_git_directory(): use is_dir_sep() helper
In-Reply-To: <cover.1488897111.git.johannes.schindelin@gmx.de>
Message-ID: <08d8699a735024a4b7e2f859552ae9ae1d3cf0d5.1488897111.git.johannes.schindelin@gmx.de>
References: <cover.1488562287.git.johannes.schindelin@gmx.de> <cover.1488897111.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Ax5a+9n0nJdlhYVcAtHd5KKsbi0fdtqliWnJcJ2lnai+yeRGVXb
 Sf0yNDwr6Yqoj2H2YzRkEWqOkAjTA7uUldXl8bMps2xRt4irYZVSP77PobgcgSTpu9iM5sb
 V+iv0ChiJK+ImyzmOv3mE13lzFoUxSbhnW8p9OOzWhsAGCSXhyDO3ZnNGjF2fJ9WwCPaQ05
 TzKJGEwKqQrmQOP6oKAPA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:PF4Bx4kkdL4=:LDWmBdmzekrvOU7xUuoQmT
 DGn3FN7k2nGmGdxWT/gVLJynJ+BwvPeXzgT3rkXbyXR51GCHyLaTFjoYO3JSO8qjtiyvAqukF
 XVonPSaBBafJ99G7YlUtU6kOaSI/CEEXHnejGniNnzwtcvOF6v6r3bp1LVxcZRvFBi00aAcif
 ZKBoLTH3irof8NAz7HrQhbSS6svz72yZuKOFXDiRYCXgnBmSywX+lPBFiCc93F/mPmmcieAVR
 7AcSuGbPM07Zk45dKpmhOikNk5yLIW5gzWsaBII6jxVG1+ZvvNt7bGCdtgR3+uBKfGoK84pHU
 YCX/uuef5hUSuTqS30k6ieZfnNHXcPdtKR+WVYsLd1vc+oLUNDMKKuPKxj4OAn5rL2ZVi9Er9
 Bs1RufERHihtIxhDtkoDU6seNwWEjZsvIyfKIDqRaqsxR5NtzyH7rxjuN4A7Wyb4r3k+jOkiP
 RPXbtcltSLjaD8DHHtcsXoCB611Zxj/5912waGoBRJ0jV4tRJ9RFSa3B6fqzxIhOed/POkXbd
 a5fYMQ0/33OoCrw+oSn7n0+FanoscpxS3ft41FS//K3w0airNGoyzwjGv7vbEUVWmoW1+Czyx
 e2LQxA/WZdL3kh3I80j6hUPvXA/kBFtqKV0IaDWoDPO8SM/WgD0OIzJ+wP8uaMhhzY9md09tj
 bmlHb3S0H5xR+HxXb6q+Bx3NnYtpyfWRkU7uUFPeCGkC+3X2wGOBzzzDtF4ncqOLyPvp+UC01
 9wdMozZbQDyFJZGqylhbNxQ9mAGV4pidfKpM9SbqoKoKAVL/s/VLrKhk45GnpHlDsLDaw0UmU
 9OXauQF
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


