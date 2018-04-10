Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 136A61F404
	for <e@80x24.org>; Tue, 10 Apr 2018 12:29:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752948AbeDJM3q (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 08:29:46 -0400
Received: from mout.gmx.net ([212.227.15.19]:38003 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752941AbeDJM3l (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 08:29:41 -0400
Received: from MININT-AIVCFQ2.fareast.corp.microsoft.com ([37.201.195.115]) by
 mail.gmx.com (mrgmx003 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0M3AWN-1eEjPu0EZL-00syDo; Tue, 10 Apr 2018 14:29:33 +0200
Date:   Tue, 10 Apr 2018 14:29:31 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v6 01/15] sequencer: avoid using errno clobbered by
 rollback_lock_file()
In-Reply-To: <cover.1523362469.git.johannes.schindelin@gmx.de>
Message-ID: <ed60b263766205c0de5460885c44a7398b569e78.1523362469.git.johannes.schindelin@gmx.de>
References: <cover.1519680483.git.johannes.schindelin@gmx.de> <cover.1523362469.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:MHISvBkuly8IPNAMWLL1OhQ7xBdAOKRo2X8lPQGv+KSfl1DNMYH
 mHE6J0WrKcg4jC5Vi+LFIIiBZIOZNNvEFHUG7Ohu1NORX88IA4c6GfNfHSbStJ3jCdMASrl
 fZp2XLYBAoK+kmHCdFYys6fdY8DHc14ilYfBaazrh7arOaVpZPF99gbSKo4JaClM7GlcLMR
 4aQFoSt7lyEpBY02iO6iA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ximM4B9jFhA=:0fh+71SDk+OfNikg35hvBg
 Tc4duhUUzta8yUj/qIWLSEgJmaKNtxBc+EOKXLSk2NZn5avHJTAtuqTJhuUFniPf9MAmi5qVR
 DcOMKC4NIcJHZCuCNerjkMYS8Qt8LJ5Y+V6Xv7q0yaZMb//ngk/0Ca36LW+BaHKD3L8ahQeTp
 d6Cz0QE8MukIHPPIqdU8LLhE2T8iUY4lqAogJECJ28nmUrG5tuelJm/eB0OkN4ESlvUF0iR7P
 0yWpFyCTxcaDLkrwTP3hoIoIuQQ0L9gs+KI5QyweU5aOy1pgeCRUPhfq6wDyJh4jLn8CE0P0o
 EbfIA1qGGYistu7q2F0zMVVk6ESLn3SBxodT61Q7LJvqcuM0qr4iw4Ki1+YJ7oJrnld9YMpgA
 SsrmwplUmzn2ecJUwe/0MtEx5wgGSnnxO5i4b+2uAkMqm5WokTW9Rax0AiBmlx7wiP/4mjU4y
 F14LajeOqKZGhdN84p9VKcuUSNwlqGKZrCpifYQl+PbZ6WvtHU6nd5P8y714XmS8VlyJXXq2H
 b1+ALylB944LgrdlK1+0ZD5FP4aonYE1UTCxTZjrd19BarX9zGEnfO7BKJWLIhER5wc3rh4jl
 QSrWmkBedNIiJ2DRNewixzkPUWQGsgRVLjJqo3sMkOvD5a2XM5iQkQeSeguLv5HVFibnqzdlY
 gf55nbmrDhJCi6h1KaOE4MepMXJDz17k844dUnrK2kY0vAcD9zofXWpP5GarBuR82lLQ74T2u
 Dk60nu+wa4llPzb4tAAxJlSkqCr+ZvwulbsU2iHwpyROy+64uNgO3Xvbv2fJGEBOiqAByK1Kl
 qHG057BwJOhT2aQBt389h/bHy6HQSCKe9PYhVoBm3dQb2M1ZsE=
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
index 667f35ebdff..096e6d241e0 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -345,12 +345,14 @@ static int write_message(const void *buf, size_t len, const char *filename,
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
@@ -2119,9 +2121,9 @@ static int save_head(const char *head)
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
2.17.0.windows.1.4.g7e4058d72e3


