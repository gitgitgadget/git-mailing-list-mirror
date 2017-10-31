Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 689FE202A0
	for <e@80x24.org>; Tue, 31 Oct 2017 09:54:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752372AbdJaJyd (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Oct 2017 05:54:33 -0400
Received: from mout.web.de ([217.72.192.78]:62438 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751605AbdJaJyb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Oct 2017 05:54:31 -0400
Received: from [192.168.178.36] ([91.20.50.251]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lx7Ir-1d3fBm4649-016jJa; Tue, 31
 Oct 2017 10:54:24 +0100
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH 1/2] sequencer: factor out rewrite_file()
Message-ID: <6150c80b-cb0e-06d4-63a7-a4f4a9107ab2@web.de>
Date:   Tue, 31 Oct 2017 10:54:21 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:Uxa6mmgvsafuq0Za+cYgttaCEzT4f0v94fEUE2I3MYf+O8PKPy/
 X0Yk0M4zMmeMa1OLu4zeLiFYHIZG+pLO2BxsjvqWEZ8MWxquVKhGMDTL6c6usWLhcVHh9Wt
 JfmVgxCva1n2A/bHOEmR82ElnIR0Ix2eUTqCWJikugG67NLyArOFms56ESuZsa5Tdxls0b3
 Aj6V25mOqaZDZ48cN1p1A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3Z1U79koMqc=:dE5qRtPqecoUlcAIZCexvm
 ifv63mimErcS1Er53EapZUbLYs8gOe2oTchJQVeNHhLMCy+fLSlwbiZVj40lCpm3mnRSK1DHA
 OH/MirTSw+4RKcH8LXZQLTuTxKzYeRMw9vqxEikS08UItXKen15jsCNXwvEIbEpapvsTy2Ile
 xHRWGqFxiNw41OI+CBaI3O4WmlWkzqoAaAGW0tgweeKK3puK3rDx3J7EabMV2Wvf3F4Q227wM
 3EMXqFoT+MSkWz2XcXmWFFTIvkNmN3fDrfjchgDKw+Eeulzt5dCspi4KaA4aMoLQsI2wUOEyA
 cnGDO3FCn04ebag7gnvpMpP498jQSrjo6He4+pDgDroxygRuCt9Q52Z2zPRbZoXE5d8zod8EO
 eOLYfiOOiIG7sRzE2faHTE2WkSl4CcHT5dSr3bC97xCNuKLbIAdEVtiNPN76lx/r+ANGbM9J/
 Sj9iIJr5xk6CAgPynm0mWn6D2+TEpu0MNADfZ3rNEtKd8GaZ1oX/MkoeFA/Zu5PPWHjSdZvM/
 cd9yGHUua2xZRo2d/c+AODEldC2sQR9JHaBafArhwDfhL1lINwKEZV2Fv0jy+rJgik0q8KC6m
 7bIAsvfqWcTDL7bfNaezTQuHtTi8a5eoJVEZ0sTbrEooM2CS8J9x4snYl4FkUuuPNy2//d7H7
 m4hfLdpf6DFW76LalvZplu/FiNA00xgJ2xIR1DeDfwyzLGbkWtdvT8/qSWkIrhJo5BZQJY4s0
 kAmpRoABnoIz6mzVCYBvQ6HVIvUFLjF9hjj2Qkvk/yuXMSjd98uIez9Y8Yz+u88jPnSuHn2go
 /BUz4huZNmnqn+Gy73rVIm/C0+spwoO5FEudF2gvcmzihet6+Q=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Reduce code duplication by extracting a function for rewriting an
existing file.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 sequencer.c | 46 +++++++++++++++++-----------------------------
 1 file changed, 17 insertions(+), 29 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index f2a10cc4f2..17360eb38a 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2665,6 +2665,20 @@ int check_todo_list(void)
 	return res;
 }
 
+static int rewrite_file(const char *path, const char *buf, size_t len)
+{
+	int rc = 0;
+	int fd = open(path, O_WRONLY);
+	if (fd < 0)
+		return error_errno(_("could not open '%s' for writing"), path);
+	if (write_in_full(fd, buf, len) < 0)
+		rc = error_errno(_("could not write to '%s'"), path);
+	if (!rc && ftruncate(fd, len) < 0)
+		rc = error_errno(_("could not truncate '%s'"), path);
+	close(fd);
+	return rc;
+}
+
 /* skip picking commits whose parents are unchanged */
 int skip_unnecessary_picks(void)
 {
@@ -2737,29 +2751,11 @@ int skip_unnecessary_picks(void)
 		}
 		close(fd);
 
-		fd = open(rebase_path_todo(), O_WRONLY, 0666);
-		if (fd < 0) {
-			error_errno(_("could not open '%s' for writing"),
-				    rebase_path_todo());
+		if (rewrite_file(rebase_path_todo(), todo_list.buf.buf + offset,
+				 todo_list.buf.len - offset) < 0) {
 			todo_list_release(&todo_list);
 			return -1;
 		}
-		if (write_in_full(fd, todo_list.buf.buf + offset,
-				todo_list.buf.len - offset) < 0) {
-			error_errno(_("could not write to '%s'"),
-				    rebase_path_todo());
-			close(fd);
-			todo_list_release(&todo_list);
-			return -1;
-		}
-		if (ftruncate(fd, todo_list.buf.len - offset) < 0) {
-			error_errno(_("could not truncate '%s'"),
-				    rebase_path_todo());
-			todo_list_release(&todo_list);
-			close(fd);
-			return -1;
-		}
-		close(fd);
 
 		todo_list.current = i;
 		if (is_fixup(peek_command(&todo_list, 0)))
@@ -2944,15 +2940,7 @@ int rearrange_squash(void)
 			}
 		}
 
-		fd = open(todo_file, O_WRONLY);
-		if (fd < 0)
-			res = error_errno(_("could not open '%s'"), todo_file);
-		else if (write(fd, buf.buf, buf.len) < 0)
-			res = error_errno(_("could not write to '%s'"), todo_file);
-		else if (ftruncate(fd, buf.len) < 0)
-			res = error_errno(_("could not truncate '%s'"),
-					   todo_file);
-		close(fd);
+		res = rewrite_file(todo_file, buf.buf, buf.len);
 		strbuf_release(&buf);
 	}
 
-- 
2.15.0
