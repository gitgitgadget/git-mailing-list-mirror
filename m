From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v4 2/2] builtin/apply: move 'newfd' global into 'struct apply_state'
Date: Fri,  3 Jun 2016 18:58:52 +0200
Message-ID: <20160603165852.12399-2-chriscool@tuxfamily.org>
References: <20160603165852.12399-1-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 03 19:11:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8sRW-0002zE-Py
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 18:59:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161087AbcFCQ7W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 12:59:22 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35818 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161047AbcFCQ7U (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2016 12:59:20 -0400
Received: by mail-wm0-f67.google.com with SMTP id e3so732692wme.2
        for <git@vger.kernel.org>; Fri, 03 Jun 2016 09:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kairwbPkeJZ7Yprvgt9cqaHGY3b/tP0uC20yLzFy20o=;
        b=DVD3GMjksr8XYIFYhIdvfm3zp5npZTgeuu8wiXF74Taawh6OOUXk+s+w8/Jc+SQKOX
         7OyeVWTl8jRkyZ5vrwADGaV0wF3TuxXZyOn2K5YsTi6wyJIvwYB5n6j9NcKWT7rZZO9+
         xGva+8gP/B1sCOwXEHAt3BiGWlaF6jMNVOqQvZLhPz4UDnEyDyFmo78A0oQRX5AwL70z
         7W6BabTexc6sKxzmy6VzRPWIh+5LFLTPEx2dGZk+1/4jvLRdlP2Dx9N2MhTGARlTb6B+
         jK8cWkj9v1IbMHtqH2R09zVkRT1EvQqEdYg2A9p9bf/zLjmDFYPHcqxAv2+NtUyjsUJW
         4umg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kairwbPkeJZ7Yprvgt9cqaHGY3b/tP0uC20yLzFy20o=;
        b=LVmI+yyUGiKJYZ2jv0sTAqp2LI9A438rR4gXFkFUATJOfeG0lHhSKCJjokRrfXQtfP
         8kZv1B90PEnDHasZpeQwlChMm1l9Ovha4/AgrpJSFKOKVXT3TdwNqu1bbwF3LqKKy1jt
         x5uQgnQvLWeYISOc3SvQdxUbMN1DG5m+0oNhx8qPo8iHnQdw4u7A/CEQeV5Y8YSHgucZ
         fEIYxRXao47fbJcJ3WlmfbAOxn1tZvvcM0AXBnd+wXmpm6asvlTYDC++bIEewPUAPWFJ
         35iF75rF4CsAlcM30JmAzuig3Ee7tBjEnLJsbXSjRI593c9Szh+0F87JPpiOWox1c8s0
         louA==
X-Gm-Message-State: ALyK8tIermB3QBXZ2W1ivBZpdo7SwbvIIqP7euR9IIMLQ+78S1GBNJMlV4uNRAyKqwRGFQ==
X-Received: by 10.194.105.34 with SMTP id gj2mr5024328wjb.154.1464973159331;
        Fri, 03 Jun 2016 09:59:19 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id ug8sm6596659wjc.42.2016.06.03.09.59.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 03 Jun 2016 09:59:18 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.rc1.5.gfce4374
In-Reply-To: <20160603165852.12399-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296351>

From: Christian Couder <christian.couder@gmail.com>

To libify the apply functionality the 'newfd' variable should
not be static and global to the file. Let's move it into
'struct apply_state'.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

This is to replace:

[PATCH v3 49/49] builtin/apply: move 'newfd' global into 'struct apply_state'

from the "libify apply and use lib in am, part 1" patch series.

There is no change compared to the previous version except that this
patch should apply cleanly on top of PATCH v4 1/2.

 builtin/apply.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index cc635eb..7338ee6 100644
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
@@ -4552,8 +4551,8 @@ static int apply_patch(struct apply_state *state,
 		state->apply = 0;
 
 	state->update_index = state->check_index && state->apply;
-	if (state->update_index && newfd < 0)
-		newfd = hold_locked_index(state->lock_file, 1);
+	if (state->update_index && state->newfd < 0)
+		state->newfd = hold_locked_index(state->lock_file, 1);
 
 	if (state->check_index) {
 		if (read_cache() < 0)
@@ -4662,6 +4661,7 @@ static void init_apply_state(struct apply_state *state,
 	state->prefix = prefix;
 	state->prefix_length = state->prefix ? strlen(state->prefix) : 0;
 	state->lock_file = lock_file;
+	state->newfd = -1;
 	state->apply = 1;
 	state->line_termination = '\n';
 	state->p_value = 1;
@@ -4782,6 +4782,7 @@ static int apply_all_patches(struct apply_state *state,
 	if (state->update_index) {
 		if (write_locked_index(&the_index, state->lock_file, COMMIT_LOCK))
 			die(_("Unable to write new index file"));
+		state->newfd = -1;
 	}
 
 	return !!errs;
-- 
2.8.2.444.g74f55c9.dirty
