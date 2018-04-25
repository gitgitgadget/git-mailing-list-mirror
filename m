Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26BE31F424
	for <e@80x24.org>; Wed, 25 Apr 2018 12:28:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753706AbeDYM2g (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Apr 2018 08:28:36 -0400
Received: from mout.gmx.net ([212.227.17.21]:54345 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752924AbeDYM2f (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Apr 2018 08:28:35 -0400
Received: from localhost.localdomain ([37.201.195.116]) by mail.gmx.com
 (mrgmx102 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0Lkzph-1edcsO1GgX-00apNf; Wed, 25 Apr 2018 14:28:25 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Sergey Organov <sorganov@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v9 01/17] sequencer: avoid using errno clobbered by rollback_lock_file()
Date:   Wed, 25 Apr 2018 14:28:17 +0200
Message-Id: <a328071912bc0ef35f1f57748ae8cc03f41dd67f.1524659287.git.johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.17.0.windows.1.33.gfcbb1fa0445
MIME-Version: 1.0
In-Reply-To: <cover.1524659287.git.johannes.schindelin@gmx.de>
References: <cover.1524306546.git.johannes.schindelin@gmx.de> <cover.1524659287.git.johannes.schindelin@gmx.de>
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
X-Provags-ID: V03:K1:T17fNRscVujq6HCJUnyYXf7IKlcNg52aJa1jfblkPMj2+8Je1di
 lzATRudPSaSb4CBOCE1m9d+v7GGCAC246AxV6IMlczj1bu2XWB54U9NR6VY8kMTOZW6Gd9C
 dEezjhWROW1xrhgsri7qXiBlf4KmRWv3hzBAWDHMjA/1CBUJy/NJlK01KQRj1HwztyP+dZr
 i2/JgHmrHKwvyB8mt66wA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1PoBJshBiS4=:TWZcbNp4NNucvW+16KrImM
 0nAsCuCQoeWgV5ViE+5XNBxBHLzUE5s0JhIEYKIPW508OUtWYjoPKlO+D3OjCzx+UKxCcfMPZ
 2+ZVrjdRIonFSFGh75lKhRptWwM8haAOsQ+JBb+zLqkPKLdpZ7ZYgWyc1M3tnpQ6Zi2HOOiYf
 HzBIe6SqNrlRMWGd6OG3NpHsl9tkBr+rPxFmQ9vO4H3yoNah2CxARtxDm44Cgco+Ug3FFNR6m
 /pp3UkdqNw0q7l53KKsDQ9t79LIk3PiozSckh3gvhMaf5mOAe1e9iwFEcUGBJ7/U1IqSmB9Fc
 Dh42zefik3IbCZgqs2WK7F1ip4eGoqknylr+zql3ZoiHdLLHRV7aAkYvaO8kvaB+n7Le9mlYu
 gcqA+t38rUhJijLPSeFLErFVE7RfnRI+7Bq9rR3RCMOTz5e4l51rnutlZ11IH7rz11xcdBTz1
 beXuxmSuX5fhUNNPe8FD2Oyz8m6oal+Q3J8zK3jfoeG3kXyI0/+LLDU3GpjXP/42kWmrQpxoU
 sozbm8vEwj3NmXLpyORiKrLH5BOqEIcOGYv/r+2L+0sZOGf9WoeI8soOwG0eTpwj5V2r3jc6f
 IBwbbsLlOD6hVoUl3vLjqv9nVT68sNkz71CQW6IUjEOGcs2FPDPi1LKpOkc2rCYg1j/VYD87B
 u19c0qZtrD3N9AiDiZ7EadPS6KY0G2xMIt2HQac/2bPa5liLIzEslGxhrvGPnMg0FoGxyeIz/
 QNN9g/RzzNN3iuFE0khxd1Jj1SDCjePnQ4ibOBbwvAM1AyoPl58SxaAgVvAojNGdzJ8U2fKOY
 jdeEeOtF22aJ9METFhvf15JlykQ/D/wYTsfFrDlPlKumGCiIUwnvXU4o9dfVqy7fW19Mx/y
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As pointed out in a review of the `--rebase-merges` patch series,
`rollback_lock_file()` clobbers errno. Therefore, we have to report the
error message that uses errno before calling said function.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 5e3a50fafc9..674e26bf826 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -346,12 +346,14 @@ static int write_message(const void *buf, size_t len, const char *filename,
 	if (msg_fd < 0)
 		return error_errno(_("could not lock '%s'"), filename);
 	if (write_in_full(msg_fd, buf, len) < 0) {
+		error_errno(_("could not write to '%s'"), filename);
 		rollback_lock_file(&msg_file);
-		return error_errno(_("could not write to '%s'"), filename);
+		return -1;
 	}
 	if (append_eol && write(msg_fd, "\n", 1) < 0) {
+		error_errno(_("could not write eol to '%s'"), filename);
 		rollback_lock_file(&msg_file);
-		return error_errno(_("could not write eol to '%s'"), filename);
+		return -1;
 	}
 	if (commit_lock_file(&msg_file) < 0)
 		return error(_("failed to finalize '%s'"), filename);
@@ -2125,9 +2127,9 @@ static int save_head(const char *head)
 	written = write_in_full(fd, buf.buf, buf.len);
 	strbuf_release(&buf);
 	if (written < 0) {
+		error_errno(_("could not write to '%s'"), git_path_head_file());
 		rollback_lock_file(&head_lock);
-		return error_errno(_("could not write to '%s'"),
-				   git_path_head_file());
+		return -1;
 	}
 	if (commit_lock_file(&head_lock) < 0)
 		return error(_("failed to finalize '%s'"), git_path_head_file());
-- 
2.17.0.windows.1.33.gfcbb1fa0445


