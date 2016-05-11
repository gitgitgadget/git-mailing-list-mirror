From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 49/94] builtin/apply: move 'lock_file' global into 'struct apply_state'
Date: Wed, 11 May 2016 15:17:00 +0200
Message-ID: <20160511131745.2914-50-chriscool@tuxfamily.org>
References: <20160511131745.2914-1-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 11 15:20:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0U3p-0003Ol-SF
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 15:20:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932284AbcEKNUQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 09:20:16 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36262 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932190AbcEKNUJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 09:20:09 -0400
Received: by mail-wm0-f66.google.com with SMTP id w143so9350569wmw.3
        for <git@vger.kernel.org>; Wed, 11 May 2016 06:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sB7bz2cRR7vWrNMJKk6J5ytJAtSwEd8uc+xqnWHrZJE=;
        b=DN0UfODpIRE/+Y4a1j6B7JAFmsjNhQEd2XtyXgN+26jyFZME0pHAGisy9NhBksLmX6
         tOljuZQHLpvZ03DG6Gh73YfMiOclstncj87EWjPh5C3KaeqtlRBR/fiBC9sEmH7JHq8z
         KIswJ/4JzREIIUnI4fdBhwr9HCGJYCytBBEHXH6Gslm7BigJHgU28LJ9lQl4VhQRxLzW
         o+PcK0r1GQJmwLmKw2DlEjlhzBYEdqfzloNY7DZvR4UgWHZTzxbn2N/18F6olaR1e3dc
         02fJ1+yTo3xWApIigjuvoV4gdDpzXnCE8Gwxs9q+eEkbQdcBnbFUrqvd4g62iWylPtKV
         eUtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sB7bz2cRR7vWrNMJKk6J5ytJAtSwEd8uc+xqnWHrZJE=;
        b=A79EDgL8KKa7Wz4eWBRg1eTGvcQmrLECMXmjmEx5MyotSBzAY42BVoN7SUq3SESNoL
         aSqIN2Sr7cNXKSjZA3ZY8wuAiRksluA3Y9Kr8vgKmoeH6sNgnAR+qTX/frNN4xO8OH9s
         s3IdD1+3Zvby1UY7Couu1JSFnM3o4wawWFToxCMWQKxz7fMorFPZH/58B3ejgEhTNt47
         aHgYM59DNqVHguXdyd8YhHhDaCy8jTTDs80QfgPhc15swRt2Y6eRfh/HfG95u8BcNJpt
         KLW9eFyZ2lpw+9Y7GcbbfGaa07bNloWomDa5MIULN+McuUmTusc2CSfR3Sh29rCIE8MD
         lfHw==
X-Gm-Message-State: AOPr4FWCgmGH9Fk3NP6G+Meqcuwk6sW5qxbBthUwfhcYv1ak9FFmDIhPihqxSGlovQzQVA==
X-Received: by 10.28.168.76 with SMTP id r73mr73552wme.44.1462972807480;
        Wed, 11 May 2016 06:20:07 -0700 (PDT)
Received: from localhost.localdomain ([80.215.130.96])
        by smtp.gmail.com with ESMTPSA id pm4sm8060791wjb.35.2016.05.11.06.20.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 May 2016 06:20:06 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.2.490.g3dabe57
In-Reply-To: <20160511131745.2914-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294280>

We cannot have a 'struct lock_file' allocated on the stack, as lockfile.c
keeps a linked list of all created lock_file structures. So let's make the
'lock_file' variable a pointer to a 'struct lock_file'

As the same instance of this struct can be reused, let's add an argument
to init_apply_state(), so that the caller can supply the same instance to
different calls. And let's alloc an instance in init_apply_state(), if the
caller doesn't want to supply one.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 2aea8ba..cad2c56 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -52,6 +52,12 @@ struct apply_state {
 	const char *prefix;
 	int prefix_length;
 
+	/*
+	 * Since lockfile.c keeps a linked list of all created
+	 * lock_file structures, it isn't safe to free(lock_file).
+	 */
+	struct lock_file *lock_file;
+
 	int apply;
 	int allow_overlap;
 	int apply_in_reverse;
@@ -4504,8 +4510,6 @@ static int write_out_results(struct apply_state *state, struct patch *list)
 	return errs;
 }
 
-static struct lock_file lock_file;
-
 #define INACCURATE_EOF	(1<<0)
 #define RECOUNT		(1<<1)
 
@@ -4558,7 +4562,7 @@ static int apply_patch(struct apply_state *state,
 
 	state->update_index = state->check_index && state->apply;
 	if (state->update_index && newfd < 0)
-		newfd = hold_locked_index(&lock_file, 1);
+		newfd = hold_locked_index(state->lock_file, 1);
 
 	if (state->check_index) {
 		if (read_cache() < 0)
@@ -4659,11 +4663,14 @@ static int option_parse_directory(const struct option *opt,
 	return 0;
 }
 
-static void init_apply_state(struct apply_state *state, const char *prefix)
+static void init_apply_state(struct apply_state *state,
+			     const char *prefix,
+			     struct lock_file *lock_file)
 {
 	memset(state, 0, sizeof(*state));
 	state->prefix = prefix;
 	state->prefix_length = state->prefix ? strlen(state->prefix) : 0;
+	state->lock_file = lock_file ? lock_file : xcalloc(1, sizeof(*lock_file));
 	state->apply = 1;
 	state->line_termination = '\n';
 	state->p_value = 1;
@@ -4771,7 +4778,7 @@ static int apply_all_patches(struct apply_state *state,
 	}
 
 	if (state->update_index) {
-		if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
+		if (write_locked_index(&the_index, state->lock_file, COMMIT_LOCK))
 			die(_("Unable to write new index file"));
 	}
 
@@ -4853,7 +4860,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
-	init_apply_state(&state, prefix);
+	init_apply_state(&state, prefix, NULL);
 
 	argc = parse_options(argc, argv, state.prefix, builtin_apply_options,
 			apply_usage, 0);
-- 
2.8.2.490.g3dabe57
