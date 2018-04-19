Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62AB81F404
	for <e@80x24.org>; Thu, 19 Apr 2018 12:15:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751865AbeDSMPn (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Apr 2018 08:15:43 -0400
Received: from mout.gmx.net ([212.227.15.15]:33377 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751381AbeDSMPm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Apr 2018 08:15:42 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MO77c-1f5rDk19vg-005bbf; Thu, 19
 Apr 2018 14:15:32 +0200
Date:   Thu, 19 Apr 2018 14:15:15 +0200 (DST)
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
        Sergey Organov <sorganov@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v7 01/17] sequencer: avoid using errno clobbered by
 rollback_lock_file()
In-Reply-To: <cover.1524139900.git.johannes.schindelin@gmx.de>
Message-ID: <ae9847669b70282a0e17e46030b5c4e609d73923.1524139900.git.johannes.schindelin@gmx.de>
References: <cover.1523362469.git.johannes.schindelin@gmx.de> <cover.1524139900.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Be3Mlhx1BYSm3NjOiMWJvA+mhnmWAecNqUchdwVbaG4pqdsBqxM
 pcq1y/vmRrVpVuA58o8zubqUJE3NZqNRITazdmd5Rk5w6tmpXAxajTt8Tsy8hutM4TzX3t1
 HH3SNaSibAB/nD2xswQgLROGBOzNp48zeatchNiUW9xfFTkqJRELBkipn3hMvPz6ZWnUVB/
 wiTq92IJFmBIX9TkevRuw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:aSKbO4pPnME=:nuGjssFzm3tnFnWzn02Ehh
 GGJvnU1ihTqVq96bhtbAumo9yZZFz47IgjPaLWLxIyVRvkHvbADZ31JABziC1MGy6WVoE4FAW
 CCSvhlOuo51aQDAt/HCGSRWXv9+oq7JF7V/RTgsolgu/l/IRFa/zY8U/Nbzjd4hMv5gavIVeA
 yTl3M+YaNLMEOKdXugwNfl+kOb3sLVWcOVmdSf3T594/wW1mcJwvHo3BE3hR9yaNAmcn7t7jd
 uqoAGYQZkY54ZuR436ZBqsdkMIUpqkdUsCS2bqSSfJiUu6vdrmbMGo2Uq94vFGCPJwf1SazZ1
 QYA6vAjQ12UT/WnG3JKb26iBsqJliWBHzhYA0k6XsslinvegaV1oCWSrIUxqrXrurRXsqaJOh
 nxMMw8uNV3RKSUhtrSqBj+tB2FDQ5B2OffWxpF7PssbvyeZoKMV7/HBTW6RfAY8236KkGaVOV
 TXHJEPYtQj27znzVIv6gvdeGBNabrf1NIkK3WD/qD/vXQe5FqLm/+sEMdmoqfXhpZHY1LDraT
 EyCO0FQfFVc9pL+a0zDQzXeyCKuPlPqI0YtRVmRZUe04BqkoRxjMuwDqhZSG5OhLvWyxYQrkL
 iVi5r15Z175zpcqaVCWx9q1Yji5WUefBFfG6qcMrxbv14h5jzZlW/w4CGq70Gz6jQJ/gPPGAy
 DbhSjsYnx4Q9hQerNtUVUxslMEt6pTXTd8kHV9ri2HahlewRGRuWHbHB0ksKXa1XLf/OxJKnT
 Fr8uClP56YKinNGDeCw6SkLkHr8ZouW/NHruOioTR6CrQv98GCXtsxtuBNERnyfvAdy5F4R5L
 U5NiMFZwRWtYK71wTCB5EYDAahah5ujW3rFSoFUFm3wKsYErtw=
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


