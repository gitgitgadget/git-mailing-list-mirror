From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 50/83] builtin/apply: get rid of the 'newfd' global
Date: Sun, 24 Apr 2016 15:33:50 +0200
Message-ID: <1461504863-15946-51-git-send-email-chriscool@tuxfamily.org>
References: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 24 15:36:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auKCo-0008GD-9u
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 15:36:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752928AbcDXNgF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2016 09:36:05 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:35091 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752910AbcDXNgC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2016 09:36:02 -0400
Received: by mail-wm0-f51.google.com with SMTP id e201so60540019wme.0
        for <git@vger.kernel.org>; Sun, 24 Apr 2016 06:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BvLMBps5Ix/ZG2B7fLYBUBA21HwvWs6q5ZyFMUA1aRA=;
        b=X24t4PuoI3pnq7AKLp4PUFVaOja/5m9+bh3Rm7bgQ7hi1a6Xrkwag+7vxxgDFXLlRk
         W3MsNNWYhQBbRWOlP0OG5XErM491L8BFcdCd9kuerCh3iC1VdmOTiyHSHrYAYxtiNNTC
         4rGwVopHWTbJEimmkJ6TgZUtdBSQH/0kpxkI191bS1CMKBGgZZSBXX4z1g3lVFipQO5e
         bybhridmXTU7lVYknn61NzGE1Lht7WgWN5yD4PqMetsTk7xdPJqdmX4WLxQEvvCP+N9s
         EMNNF0anbpNG4Vrh5px0mVauJVt/JJLcaU/zmJwLjl0cXWN0ZYraZ0l6T7gSUocDQlVx
         SobA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BvLMBps5Ix/ZG2B7fLYBUBA21HwvWs6q5ZyFMUA1aRA=;
        b=RWdlKJ9oDqwodF5lXjE48IeuPJlTTrczt/MPLJclUTvHu/D2OpHDifzu11f4PD+2Kn
         R12FXS6eQEPuWY6ZUajEcrhosRoKCUUZO/312nALLbqmeIFU1VE+cv8fRbRH8t32EZsa
         G/ek//Jk4Gr8ZG0K4bhEJfXOzpC3oMqFNKiXepdVEQyvFoyTeUdvyw3bV52JYeM3ECPE
         5GvDR2BtRR8z1M9RnWPUhPWdusNK/zfl4OZ2/hOM47WUnJ8GT8QgjnlMOEaNufwwD7s1
         vxGY/EXZFrKHwN6XOIz72G0voCfzFK5E2Rfh0D/royqy99yTRxxQGFglLz2kTQ53x2Av
         NR+g==
X-Gm-Message-State: AOPr4FVmTa5e/coRn1FaTSvhpfjwrGGdFPm3dqMnQU2z8NKtCesocGBHF21kwkXR/Wf1TQ==
X-Received: by 10.28.127.81 with SMTP id a78mr7149478wmd.34.1461504956274;
        Sun, 24 Apr 2016 06:35:56 -0700 (PDT)
Received: from localhost.localdomain (121.73.115.78.rev.sfr.net. [78.115.73.121])
        by smtp.gmail.com with ESMTPSA id j6sm6717101wjb.29.2016.04.24.06.35.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Apr 2016 06:35:55 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.1.300.g5fed0c0
In-Reply-To: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292348>

The 'newfd' global is useless now as we can just test
for "lock_file == NULL" instead of "newfd < 0".

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index d26419a..84ff2da 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -141,8 +141,6 @@ struct apply_state {
 	enum ws_ignore ws_ignore_action;
 };
 
-static int newfd = -1;
-
 static const char * const apply_usage[] = {
 	N_("git apply [<options>] [<patch>...]"),
 	NULL
@@ -4572,9 +4570,9 @@ static int apply_patch(struct apply_state *state,
 		state->apply = 0;
 
 	state->update_index = state->check_index && state->apply;
-	if (state->update_index && newfd < 0) {
+	if (state->update_index && state->lock_file == NULL) {
 		state->lock_file = xcalloc(1, sizeof(struct lock_file));
-		newfd = hold_locked_index(state->lock_file, 1);
+		hold_locked_index(state->lock_file, 1);
 	}
 
 	if (state->check_index) {
-- 
2.8.1.300.g5fed0c0
