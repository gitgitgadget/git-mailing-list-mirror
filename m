Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B426D20285
	for <e@80x24.org>; Wed, 30 Aug 2017 18:20:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752683AbdH3SUS (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 14:20:18 -0400
Received: from mout.web.de ([212.227.15.14]:58095 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752098AbdH3SUQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 14:20:16 -0400
Received: from debian.fritz.box ([91.20.59.6]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MV4hR-1e1HGd3Hx7-00YPfr for
 <git@vger.kernel.org>; Wed, 30 Aug 2017 20:20:14 +0200
From:   Rene Scharfe <l.s.r@web.de>
To:     git@vger.kernel.org
Subject: [PATCH 28/34] sequencer: release strbuf after use in save_head()
Date:   Wed, 30 Aug 2017 20:20:14 +0200
Message-Id: <20170830182014.21147-1-l.s.r@web.de>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20170830175005.20756-1-l.s.r@web.de>
References: <20170830175005.20756-1-l.s.r@web.de>
X-Provags-ID: V03:K0:zKOkyOcMQ87KwNRgci0/Q/uyscKd4PV2ekOxjnuI4fGJotWPr73
 4/lM6yGvRsMbNkvimIg93MfO3e92Ng3jpO30k2wVaqdOLGkMYEnL47h1M5t6AqSfPeSxhPZ
 uLaHTKYIbARcNmdPQP+kiP4ghlr/CYDNtw8nfMWgahF2C9CDRCMvaouGJFWQ2+r/AY+0tJW
 jzGfKzwz0+5+GYJ/pYV0g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:PhxZ9ntM4Hg=:IydrhIlGOGw5mUbmznT7S5
 irRZI7kJ47wfYUCMcPf56sgCgN76m/iecLvJFOBWTKVlyC7zFB/wLjM28qPDglSSHnxapDw94
 MABCGUvhbmH4Q2lPMup9lN7pOlDqbLU+hVC+DoJNbw9cUpGxjxj5z2c0f7FhxWkoUyKexMwKC
 odEpdgcvtDTx5V0NwKc91kkHmSMwgWHG3sFzeRu0n1+cQOLatKCKLT/iWMiBRx0fjldnJvGWI
 77JoqRDaGeRoaN2xH/R+/EvPXpCEdGV4PPb1ZpXU0sU+MOLncXygEzR8S20ZrsFBDi+FyISjg
 v0Iwr+kurmMu4hA+afGlcOPNSnF/eifTNECIAkj7Xoj52Vo6LlMDmbBCILkSn/amxyovlqaVf
 HK1tv3n6DiKzIdujsNCg5EVNYwIxtrR1NstvtmMJBSvdWsvGHkCAAVhxnCpFU+ihsN0Jbef5d
 tmLpfX7XfvHI6aR+HIKRr1+ICZqzMm0swKaZ5E3VP6NUXKhTJVrr4D03UwXW+E6MSqqBEy4fA
 X6XSrYsQCRn1rhmVpZARaWwvFZ211Nh8E9otzfPdDJk5xAgLUrusDYNCPgxfzthZgrSuX/uBj
 iciAYw78lHETRpDPi2TGMQdY0J+/ahPZPUFSSHnUJJB7FSVr/NL5RuM1YO7JO5xwphvpU2TVA
 1WFzE7reigLPtYW7RssnXY1Yr+kZex2wMdK5rA/q4Rysp9zz6Pul5+owW0Cj54Wg5FeuuKtzN
 7KU+BgQ3HuGKfqbslSRM7/7DWyA8AO/3a0q4cW2/EWNXpDVuuVB3JaeAZP7dVyk8b0mGpC/Lj
 8MVYfwUdtwHk1LxrTP0PmYK4XXKMQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 sequencer.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index fcceabb80f..60636ce54b 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1563,23 +1563,26 @@ static int create_seq_dir(void)
 static int save_head(const char *head)
 {
 	static struct lock_file head_lock;
 	struct strbuf buf = STRBUF_INIT;
 	int fd;
+	ssize_t written;
 
 	fd = hold_lock_file_for_update(&head_lock, git_path_head_file(), 0);
 	if (fd < 0) {
 		rollback_lock_file(&head_lock);
 		return error_errno(_("could not lock HEAD"));
 	}
 	strbuf_addf(&buf, "%s\n", head);
-	if (write_in_full(fd, buf.buf, buf.len) < 0) {
+	written = write_in_full(fd, buf.buf, buf.len);
+	strbuf_release(&buf);
+	if (written < 0) {
 		rollback_lock_file(&head_lock);
 		return error_errno(_("could not write to '%s'"),
 				   git_path_head_file());
 	}
 	if (commit_lock_file(&head_lock) < 0) {
 		rollback_lock_file(&head_lock);
 		return error(_("failed to finalize '%s'."), git_path_head_file());
 	}
 	return 0;
 }
-- 
2.14.1

