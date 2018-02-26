Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5EF541F404
	for <e@80x24.org>; Mon, 26 Feb 2018 21:29:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751510AbeBZV3Z (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Feb 2018 16:29:25 -0500
Received: from mout.gmx.net ([212.227.15.18]:50891 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751245AbeBZV3X (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Feb 2018 16:29:23 -0500
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MUILK-1fHGsJ2LwI-00R2LP; Mon, 26
 Feb 2018 22:29:17 +0100
Date:   Mon, 26 Feb 2018 22:29:16 +0100 (STD)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v5 01/12] sequencer: avoid using errno clobbered by
 rollback_lock_file()
In-Reply-To: <cover.1519680483.git.johannes.schindelin@gmx.de>
Message-ID: <8ec3a73dfdc76c503d50e34e5fc8b8a3d5ea7dd8.1519680483.git.johannes.schindelin@gmx.de>
References: <cover.1518307771.git.johannes.schindelin@gmx.de> <cover.1519680483.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Dh6S+nP7Nc6aFMz3NXjahf2CtUA6vrQ/nqviQ1ZDN4ZXlC8naD5
 4zGg9GWaQgtZTBKsdcFM0kWACNifWLzcnpRft7d+EksHdZIBBgOm966vvzUclF1ryAXIu4o
 lRXk9BPjpaA1Es2ndg2B8T9gCWdg/YYAsygKt6jXS16/54TTA6bUCNRLqPB4+9kA8CWsGF3
 FREyHAkCy2i9lpupwlGGA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:vgIL42B/g70=:6zz4K8RnQ344Tf/6ZQV97s
 tLACPH38grriU06X9ylTjwZJtVBdGelrT177Bcg6QmES1j3AWb9s4DuKofW6+u1foVBK5hZbK
 1TK+XJkmAkyT6Avh+U6UywU2kUOxz1OoXnOzKR6eQ02BNlUIaZR2MzahcewQlJsNAMrd9vaod
 68B4SygQv+7lb+cJfVv5Ps28wgWIN7FKmqELHp9k/RxE784HMCcx4XY8qG1HpyP0Qwg1/s3IH
 1M/QwVlwe23KnKg4TfWntGtJ+eiaRINdGy14/DRUuD7St+tnZdIxunDOLG908iRkc3D3aSpcK
 sj6Cva/iv8MCLATvOTA3I45GZ/Lh1b5MKLn69+JtjLlnIf28B2x6TBO/CtbcFst4Tu+yw+jRH
 BzKIQYbKfeN73xDahufPUauT6DR/ihUTovb8Oiji+intEBceWFpsXNRc7p/srDU6v+MmxQBka
 9VruDoj9Eeifoh6P/b17Z0zzDlLg6xjwcPQexaK4RGX491xzpcBPPBbO1DIwib2rnNlH0cfGb
 Blcua6iKLEb7F7hZ+jUzZa4hlumeODeY169R+M04scxvfxCJ1emd2a71Ze++C2YXYFzilUbwy
 eXjI4uxzmvnI84+FbED/1ccoHfufNqwqu6l/OC6T2S/autKUobm8WDIMDoQTaJRfBqQKfHAug
 KIWyKdjalzWdlkXmftcCTXtM3pDaPvQN5TbrKu07Xqa/c9JvoPYsmbETNYyzkZkKc58qr6ss+
 NzBG34f0TNze1Ta4lYJRrVC9wss7L10inPb1xbN08US++O7EEjp45ddh4fbsPcqsCnDV/4wcO
 31DXbvQmywtzB/Wop3IwWv00h85ZiKoleuu4zWSR2xFaLEONARWgTref2DWk9KaoXMw1iVA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As pointed out in a review of the `--recreate-merges` patch series,
`rollback_lock_file()` clobbers errno. Therefore, we have to report the
error message that uses errno before calling said function.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index e9baaf59bd9..5aa3dc3c95c 100644
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
 	if (commit_lock_file(&msg_file) < 0) {
 		rollback_lock_file(&msg_file);
@@ -2106,16 +2108,17 @@ static int save_head(const char *head)
 
 	fd = hold_lock_file_for_update(&head_lock, git_path_head_file(), 0);
 	if (fd < 0) {
+		error_errno(_("could not lock HEAD"));
 		rollback_lock_file(&head_lock);
-		return error_errno(_("could not lock HEAD"));
+		return -1;
 	}
 	strbuf_addf(&buf, "%s\n", head);
 	written = write_in_full(fd, buf.buf, buf.len);
 	strbuf_release(&buf);
 	if (written < 0) {
+		error_errno(_("could not write to '%s'"), git_path_head_file());
 		rollback_lock_file(&head_lock);
-		return error_errno(_("could not write to '%s'"),
-				   git_path_head_file());
+		return -1;
 	}
 	if (commit_lock_file(&head_lock) < 0) {
 		rollback_lock_file(&head_lock);
-- 
2.16.1.windows.4


