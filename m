From: Christian Couder <christian.couder@gmail.com>
Subject: [RFC/PATCH 28/48] builtin/apply: move 'lock_file' global into 'struct apply_state'
Date: Wed,  9 Mar 2016 18:48:56 +0100
Message-ID: <1457545756-20616-29-git-send-email-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Wed Mar 09 18:53:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adiIw-00006C-Ci
	for gcvg-git-2@plane.gmane.org; Wed, 09 Mar 2016 18:53:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933749AbcCIRx1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2016 12:53:27 -0500
Received: from mail-wm0-f46.google.com ([74.125.82.46]:36412 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933725AbcCIRxR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2016 12:53:17 -0500
Received: by mail-wm0-f46.google.com with SMTP id n186so190611186wmn.1
        for <git@vger.kernel.org>; Wed, 09 Mar 2016 09:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xj26WN8EsLO3IRIpwjdRGcqcieJbRXIXLF81V8xEjzo=;
        b=oDBYTK+PltST1sS8sWUzJwQIxmsKJ6X5Ad1DjTbLGCNg0lLgBp4jlljQn8dXIezzrO
         VJBTDeBapmAUrsT7UBa6ESMDq3GJJvu2rvlXNiQN0h0coML7+Fx7KmJKb0CiAvfv0AQZ
         cg2UijLcrlMC69BUesqklnIWwdhSQEAK16XFK+1xb+E/pgg8OBI+Rbo5XDOp+UoHm/jw
         aICwqQLYR88B9LCul6Dm5GH5kC72cbESisu99XMpq04igSRytZCcDo+cOsQTR8f1UHbl
         LM5OdTSy3JCy0VHhinCosB12El7Fbxe/U7sH3xCsINMiEbqFVj2ZvqYKB/h1pVbB9woq
         iOIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xj26WN8EsLO3IRIpwjdRGcqcieJbRXIXLF81V8xEjzo=;
        b=fWSRILkv69pKyyKhctcrjPVvDHTomE1wtUsRtrOapIzm88yDQqydV9rZGmf1t0sY06
         a2bqhU7Tx6hCzjzegkVS8jylmuTR0V7qLD1zIzHCxMjj0SVpT35tMvD7lR27lCtxiIrf
         912txcHnFOuTrj2OWYvRfDpgvIMtr6RMNxMVMSnazGH+Cz1hjVRUDSemIIDQnO7IAQpc
         Hurk0RKo+S+b5hLvLSuQf8cf1QCl7D4h8M0vXmHA/emPnMOgcZlIWBapgEnMWkKAFW4y
         xu78foPtAT+w09pbG5a0JEERJxMjozZDrtw9QfEjiRmqUlKVXSzSRExHuTnzuLRo3wnV
         7YqA==
X-Gm-Message-State: AD7BkJJ/7W1ROaeja9v1jqH1wrcq49C0OkPBUsqHXsDs8E+OPQ6LQUWcINBStzCDYi21hQ==
X-Received: by 10.28.136.19 with SMTP id k19mr361808wmd.11.1457545995372;
        Wed, 09 Mar 2016 09:53:15 -0800 (PST)
Received: from localhost.localdomain ([80.215.161.239])
        by smtp.gmail.com with ESMTPSA id e127sm24975419wma.20.2016.03.09.09.53.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 09 Mar 2016 09:53:14 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.0.rc1.49.gca61272
In-Reply-To: <1457545756-20616-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288524>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 44fdb9d..70bb51a 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -67,6 +67,8 @@ struct apply_state {
 	int line_termination;
 
 	unsigned int p_context;
+
+	struct lock_file lock_file;
 };
 
 static int p_value = 1;
@@ -4429,8 +4431,6 @@ static int write_out_results(struct apply_state *state, struct patch *list)
 	return errs;
 }
 
-static struct lock_file lock_file;
-
 #define INACCURATE_EOF	(1<<0)
 #define RECOUNT		(1<<1)
 
@@ -4479,7 +4479,7 @@ static int apply_patch(struct apply_state *state,
 
 	state->update_index = state->check_index && state->apply;
 	if (state->update_index && state->newfd < 0)
-		state->newfd = hold_locked_index(&lock_file, 1);
+		state->newfd = hold_locked_index(&state->lock_file, 1);
 
 	if (state->check_index) {
 		if (read_cache() < 0)
@@ -4748,7 +4748,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 	}
 
 	if (state.update_index) {
-		if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
+		if (write_locked_index(&the_index, &state.lock_file, COMMIT_LOCK))
 			die(_("Unable to write new index file"));
 	}
 
-- 
2.8.0.rc1.49.gca61272
