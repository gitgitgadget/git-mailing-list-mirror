Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E02A1F424
	for <e@80x24.org>; Sat, 21 Apr 2018 10:30:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752826AbeDUKag (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Apr 2018 06:30:36 -0400
Received: from mout.gmx.net ([212.227.17.22]:53423 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751868AbeDUKad (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Apr 2018 06:30:33 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0McluX-1es1uz3OOf-00Hu4y; Sat, 21
 Apr 2018 12:30:24 +0200
Date:   Sat, 21 Apr 2018 12:30:08 +0200 (DST)
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
Subject: [PATCH v8 01/16] sequencer: avoid using errno clobbered by
 rollback_lock_file()
In-Reply-To: <cover.1524306546.git.johannes.schindelin@gmx.de>
Message-ID: <ae9847669b70282a0e17e46030b5c4e609d73923.1524306546.git.johannes.schindelin@gmx.de>
References: <cover.1524139900.git.johannes.schindelin@gmx.de> <cover.1524306546.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:KXg9IttQap+su5PP8gh2PQBiEyu9uOSkjjZKDUTAMU8GDJpSsKJ
 prgmHuDanOMqJwC5rydnfMlkFLzaVz2yTYshqPBJw6nPIiYavk1mjm2+I83S8oPwbClagLS
 QpmQ4tuh5RdCl5mKu9fOLt5OzBE3ZrBxSL4qjOcesw0UHuNv3hBQQsTUGJuyxV859i2ttku
 6i33+cdFchPM4fCRsP0UQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:XYTJuZcOmac=:efxvN/X+hofYkeJEPj+XGS
 57fT79WfFZ4/L/vzv4maQ8etEsEkrZ7uMNzhSZ1HJxTzmtgyNo40Twxntxde3xRLISlTsT+lP
 NxyOStnseHNIrcOwBN5+dP0asy5QOxkKDxPWb69tqDBYyHy7QeG3Ay54jKvIb2b/4b26mAvIV
 1vy6PkCMT6jBBbUCRjXjaMvPdWz7vP+jteOg5gqxYyAYkiFugc6h587chGV7TtqT/x/vt3lAD
 LMip3/PIfR/zmdOPBQbb8fLmz4Bvu5L9vJIfuYrO/7BZDWj1z6Iro72rupuD94Xcj/k61/cQs
 Http2rN8cC/bwW0zs7oKsPRVuLDdAUOrjkYJHaGbhvbVeFPhSoFRfOizj/iXvMjS3Sxz5z/qC
 AYnhFJwREkX+EjNogeDXz68TgFvyNSDW2iiCUCx7SDStGmlS0TpReYkpITjTZ7d/F9mvVZGpD
 BMJn+rR3Jz1vU4Ie5MpsJ+aBGVylLB8HK8xADU5MaKvSa7lrI1rzvGaNr++oJqrhcC+6R1cK6
 XQGfjyDH6PUQb5nx7PSUuWjr6ADN6h/c4rtAPWfiBx/we6FsuMgM1DRB9FloqaGJ9xw/hAVA9
 /9CNtXiVHgYNOFYDarJRoWavYZ1s5mBIQNPHnxJXh74t5hgzA733GYa4O7AwpPKdocEU9majd
 8XKTY1kZ+fjlZANdaxJoOASSTmPyS+Ikb9pDg217P5RoEBcRYdi+gEPgl8H5jkeZsditgvzW+
 242lUe1xHdzlvDd1Y/iJG0TLyMc2Bf9wGJWd7tuUJYd8rQyQgsvYu3KFft/ktmeG+C8rxp/4n
 x7TExhnqjesSPycMh1WuTfkJVd2zX1CARWkNbk8iKT0LQsK0ps=
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
2.17.0.windows.1.15.gaa56ade3205


