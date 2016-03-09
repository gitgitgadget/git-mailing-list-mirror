From: Christian Couder <christian.couder@gmail.com>
Subject: [RFC/PATCH 15/48] builtin/apply: move 'allow_overlap' global into 'struct apply_state'
Date: Wed,  9 Mar 2016 18:48:43 +0100
Message-ID: <1457545756-20616-16-git-send-email-chriscool@tuxfamily.org>
References: <1457545756-20616-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 09 18:52:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adiHy-0007oT-Py
	for gcvg-git-2@plane.gmane.org; Wed, 09 Mar 2016 18:52:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933709AbcCIRwq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2016 12:52:46 -0500
Received: from mail-wm0-f53.google.com ([74.125.82.53]:37482 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933702AbcCIRwl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2016 12:52:41 -0500
Received: by mail-wm0-f53.google.com with SMTP id p65so81799559wmp.0
        for <git@vger.kernel.org>; Wed, 09 Mar 2016 09:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PAjcKEsXrB5LkjCyc8/aW43HKOV/EqAQK66qy/Vnp9c=;
        b=rQcKd/22MYBTiLq+xw9yHvJZU9VJHwPoen3jnWdqxuS07AS6B+4SD2+9j5/hFHlXni
         m6C/JlmxWLzAYF1Bd6QEOBRtog5CUlVIsg5tO3VgnlRkIzdSI52u1nkWGpvEcrx/kpCo
         L7nDpH+VhbMP6O/liIYRLEHZyZDJybQquybcER8y3QOyyKrMtKV4581OnVYAV9ZEqOQb
         L1XZzoUoDGeShIbmYtnOgdQsgv7LH5UwWeFyNt4r/v0G2H6YP6sYvgK0Ntwx26waGfVm
         1x5j56JGPsY9SjJ0s5jW9KFJq2MnIPqUsGNUcB/L9lXDW5tBIs8JXgCsOgZhYpIFEIb7
         0ipQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PAjcKEsXrB5LkjCyc8/aW43HKOV/EqAQK66qy/Vnp9c=;
        b=Fcx88DCpuOOllb/zoDqQkPDKca8koDNh7WbYGt4ctaTixO5n4rvQFu1GnMZ6kwyXkJ
         IOEeJ34LleJpLee1zk/YX/ybFUAZamhqYjZBbUNxOIi4cfjeC/V9YXMUxizsCJ+MfzZC
         e9TMBvf27+FokNpAIWHaLV/wI2r1WDfnZNEwh7a7FDQLm5bzA0SQYjX9CqMrcnva596I
         /SMPpIzxVzK6B6Pu+x3o2vFtWrqegnC7dlDg1J1B8j/Hqgh9dTMS2f1px7aS67iEpfVP
         XUFjFFw8HL8d19krKxZy11P75LsNFhWbDmXWXIQWPjJ38TmLbpTy3KoDXttdhJbO8xFK
         bBuQ==
X-Gm-Message-State: AD7BkJKiTelFlmq5ywjwsIBit5dcJ5maRlQ6xTEPl8UFvCs5Sh0w6kz3hmJjHZ1XJb3pTg==
X-Received: by 10.194.91.205 with SMTP id cg13mr35752443wjb.166.1457545959828;
        Wed, 09 Mar 2016 09:52:39 -0800 (PST)
Received: from localhost.localdomain ([80.215.161.239])
        by smtp.gmail.com with ESMTPSA id e127sm24975419wma.20.2016.03.09.09.52.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 09 Mar 2016 09:52:38 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.0.rc1.49.gca61272
In-Reply-To: <1457545756-20616-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288505>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index a6026cc..e3ca5c9 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -26,6 +26,7 @@ struct apply_state {
 	int prefix_length;
 	int newfd;
 
+	int allow_overlap;
 	int apply_in_reverse;
 	int apply_with_reject;
 	int apply_verbosely;
@@ -58,7 +59,6 @@ static int diffstat;
 static int numstat;
 static int summary;
 static int apply = 1;
-static int allow_overlap;
 static int no_add;
 static int threeway;
 static int unsafe_paths;
@@ -2637,7 +2637,8 @@ static void remove_last_line(struct image *img)
  * apply at applied_pos (counts in line numbers) in "img".
  * Update "img" to remove "preimage" and replace it with "postimage".
  */
-static void update_image(struct image *img,
+static void update_image(struct apply_state *state,
+			 struct image *img,
 			 int applied_pos,
 			 struct image *preimage,
 			 struct image *postimage)
@@ -2702,7 +2703,7 @@ static void update_image(struct image *img,
 	memcpy(img->line + applied_pos,
 	       postimage->line,
 	       postimage->nr * sizeof(*img->line));
-	if (!allow_overlap)
+	if (!state->allow_overlap)
 		for (i = 0; i < postimage->nr; i++)
 			img->line[applied_pos + i].flag |= LINE_PATCHED;
 	img->nr = nr;
@@ -2950,7 +2951,7 @@ static int apply_one_fragment(struct apply_state *state,
 			fprintf_ln(stderr, _("Context reduced to (%ld/%ld)"
 					     " to apply fragment at %d"),
 				   leading, trailing, applied_pos+1);
-		update_image(img, applied_pos, &preimage, &postimage);
+		update_image(state, img, applied_pos, &preimage, &postimage);
 	} else {
 		if (state->apply_verbosely)
 			error(_("while searching for:\n%.*s"),
@@ -4627,7 +4628,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 			N_("don't expect at least one line of context")),
 		OPT_BOOL(0, "reject", &state.apply_with_reject,
 			N_("leave the rejected hunks in corresponding *.rej files")),
-		OPT_BOOL(0, "allow-overlap", &allow_overlap,
+		OPT_BOOL(0, "allow-overlap", &state.allow_overlap,
 			N_("allow overlapping hunks")),
 		OPT__VERBOSE(&state.apply_verbosely, N_("be verbose")),
 		OPT_BIT(0, "inaccurate-eof", &options,
-- 
2.8.0.rc1.49.gca61272
