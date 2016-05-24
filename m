From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 49/49] builtin/apply: move 'newfd' global into 'struct apply_state'
Date: Tue, 24 May 2016 10:11:26 +0200
Message-ID: <20160524081126.16973-50-chriscool@tuxfamily.org>
References: <20160524081126.16973-1-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 24 10:13:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b57TL-0001LX-UP
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 10:13:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754735AbcEXINq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 04:13:46 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36809 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932320AbcEXIMz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 04:12:55 -0400
Received: by mail-wm0-f66.google.com with SMTP id q62so3642458wmg.3
        for <git@vger.kernel.org>; Tue, 24 May 2016 01:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VAOhkAblavxrff9LFBjBj2HO1LstzIjiJUeiWUjOXbE=;
        b=tMmdN8DVPqtOfZszm2zgvGgVUT9Ln1pzwW6KTOlh3ZpicRR0Uu1Yzxr1i+uwXMAFKb
         QYKuvJLO/KQbLIBJXGJy/ihn218zYArbOkd52awdga0rcfNIrHTBnmYccOtWdYhDcOsZ
         Hly+lPBTFdMjr+Bl0yCgdYYjeWUcbjb8UEgI9AElIjcecpW/9E7i/tDkaqLoy6iB3RW3
         b0q/BxdhukGwC/WHRgTIqTqJfcYg8LPXoLXSXzo/R/DgbD91CQ3DzcSvXcMPqJol2TAr
         BYLXX1Fxhk2BCVo40RsPkDf42bYafY6mppAqoF1lzRA5q4lEE5JX8EkY5dV2xhAQm3we
         8dkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VAOhkAblavxrff9LFBjBj2HO1LstzIjiJUeiWUjOXbE=;
        b=DjltjymioJRSGB6VilSPgVj2AiVsNzEnlm01+cUM54tLBKu0ZSfkGRoCN2F790VKOQ
         GxzVA37q681bXTv1ItMem8urNckwDRtGf9zFq5CFZAYzSYao6wMjkl8r+uHAcr2BL8KL
         b2uCe33MouWGCLvlTQX5kqdCmjNSC6P6FTORke9hhJ5FURM5XX1ejFObx9F75raNcM0A
         E1RFGiF66lTi983v0gcUDAId9Aj9Ax3rVRZ7o/M9v6WFIgSdTR9NKQAUyf0PTUVt2f+R
         3Wr0X8CRGemkojZYDzOkltd+1ZdJ2w3MGzFYoEWc8JtMo1KG4GZHzI9DGu3fyH6ZJIU2
         43hw==
X-Gm-Message-State: ALyK8tIs2kbcV9CMQ5ksuSMaJU/XZVy2TfUxrsBcA0z3nnQT72tlDHupaUS4EdGY85vM9Q==
X-Received: by 10.28.154.130 with SMTP id c124mr4100557wme.9.1464077573809;
        Tue, 24 May 2016 01:12:53 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id 131sm2258044wmu.17.2016.05.24.01.12.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 24 May 2016 01:12:53 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.3.443.gaeee61e
In-Reply-To: <20160524081126.16973-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295448>

To libify the apply functionality the 'newfd' variable should
not be static and global to the file. Let's move it into
'struct apply_state'.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 5d46b7c..c1c5592 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -57,6 +57,7 @@ struct apply_state {
 	 * lock_file structures, it isn't safe to free(lock_file).
 	 */
 	struct lock_file *lock_file;
+	int newfd;
 
 	/* These control what gets looked at and modified */
 	int apply; /* this is not a dry-run */
@@ -120,8 +121,6 @@ struct apply_state {
 	int applied_after_fixing_ws;
 };
 
-static int newfd = -1;
-
 static const char * const apply_usage[] = {
 	N_("git apply [<options>] [<patch>...]"),
 	NULL
@@ -4550,8 +4549,8 @@ static int apply_patch(struct apply_state *state,
 		state->apply = 0;
 
 	state->update_index = state->check_index && state->apply;
-	if (state->update_index && newfd < 0)
-		newfd = hold_locked_index(state->lock_file, 1);
+	if (state->update_index && state->newfd < 0)
+		state->newfd = hold_locked_index(state->lock_file, 1);
 
 	if (state->check_index) {
 		if (read_cache() < 0)
@@ -4660,6 +4659,7 @@ static void init_apply_state(struct apply_state *state,
 	state->prefix = prefix;
 	state->prefix_length = state->prefix ? strlen(state->prefix) : 0;
 	state->lock_file = lock_file ? lock_file : xcalloc(1, sizeof(*lock_file));
+	state->newfd = -1;
 	state->apply = 1;
 	state->line_termination = '\n';
 	state->p_value = 1;
@@ -4778,6 +4778,7 @@ static int apply_all_patches(struct apply_state *state,
 	if (state->update_index) {
 		if (write_locked_index(&the_index, state->lock_file, COMMIT_LOCK))
 			die(_("Unable to write new index file"));
+		state->newfd = -1;
 	}
 
 	return !!errs;
-- 
2.8.3.443.gaeee61e
