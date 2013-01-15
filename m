From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: [PATCH v2 11/19] reset.c: replace switch by if-else
Date: Mon, 14 Jan 2013 21:47:43 -0800
Message-ID: <1358228871-7142-12-git-send-email-martinvonz@gmail.com>
References: <1357719376-16406-1-git-send-email-martinvonz@gmail.com>
 <1358228871-7142-1-git-send-email-martinvonz@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Matt Kraai <kraai@ftbfs.org>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>,
	Martin von Zweigbergk <martinvonz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 15 06:54:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuzTx-0003Rt-P0
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 06:54:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751377Ab3AOFyY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2013 00:54:24 -0500
Received: from mail-vc0-f202.google.com ([209.85.220.202]:33180 "EHLO
	mail-vc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750902Ab3AOFyX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2013 00:54:23 -0500
Received: by mail-vc0-f202.google.com with SMTP id m8so588046vcd.5
        for <git@vger.kernel.org>; Mon, 14 Jan 2013 21:54:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:x-gm-message-state;
        bh=M+9FKbT3w3/+8pT6kcGN665/vVJNoEk9zdERKSDLjdI=;
        b=f7a8Qt7rnMk0bM8+WJSk6TXiobv+SBnXFowBRvKfmLqB8iV65eBRkVbNpDES4/TbxV
         nm77vCIMYRAJHIVRsd81vyw75do4MURAOFEawxjdxBpGTAg/8KuS4A1P/PmxwO9cKVcF
         8T1qe7CMjOKWjDnlf7oIcdDQl+Sea/H6PwG7YL3dE9l1q2uHBJ+DEoYg6GzWEqxm50ah
         2mGV+TPcvZExTQtqnMTi8q24qkQNWM3pUH3ByGTLrWbe4S8Tv2ryu8QeK2qUGCf2EISI
         dfrdWIn9RSLJQaxH5qaDxL6ORHI8g2jc+4rrXv+e0whCnRXzl9SH0/FN+G3nDeAjKTC2
         T6gQ==
X-Received: by 10.236.179.103 with SMTP id g67mr19420976yhm.47.1358228907071;
        Mon, 14 Jan 2013 21:48:27 -0800 (PST)
Received: from wpzn3.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id i63si818053yhk.5.2013.01.14.21.48.27
        (version=TLSv1 cipher=AES128-SHA bits=128/128);
        Mon, 14 Jan 2013 21:48:27 -0800 (PST)
Received: from handduk2.mtv.corp.google.com (handduk2.mtv.corp.google.com [172.18.144.137])
	by wpzn3.hot.corp.google.com (Postfix) with ESMTP id A471A100049;
	Mon, 14 Jan 2013 21:48:26 -0800 (PST)
Received: by handduk2.mtv.corp.google.com (Postfix, from userid 151024)
	id 51D731018BD; Mon, 14 Jan 2013 21:48:26 -0800 (PST)
X-Mailer: git-send-email 1.8.1.1.454.gce43f05
In-Reply-To: <1358228871-7142-1-git-send-email-martinvonz@gmail.com>
X-Gm-Message-State: ALoCoQl48pCtVRuFknkjG0SQSlMh6no0Gr9yWX65t0hsrLqc3soNGsE/ws6udl3+JYlLw/BywKTM6O+GdKENymQYDMIvNqRAqk2JBBYMQSiMt1LlN8OFox/WECI3zWTMyi4+g7wyHcOr7KZmB3dkSJdFt5lh2MuwTMXDD0LfIBOMT4ZsJ1uUhWIXUOI38c0paPZymc6T5fFy
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213587>

The switch statement towards the end of reset.c is missing case arms
for KEEP and MERGE for no obvious reason, and soon the only non-empty
case arm will be the one for HARD. So let's proactively replace it by
if-else, which will let us move one if statement out without leaving
funny-looking left-overs.

Signed-off-by: Martin von Zweigbergk <martinvonz@gmail.com>
---
 builtin/reset.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index 97fa9f7..c3eb2eb 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -349,18 +349,11 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 	 * saving the previous head in ORIG_HEAD before. */
 	update_ref_status = update_refs(rev, sha1);
 
-	switch (reset_type) {
-	case HARD:
-		if (!update_ref_status && !quiet)
-			print_new_head_line(commit);
-		break;
-	case SOFT: /* Nothing else to do. */
-		break;
-	case MIXED: /* Report what has not been updated. */
+	if (reset_type == HARD && !update_ref_status && !quiet)
+		print_new_head_line(commit);
+	else if (reset_type == MIXED) /* Report what has not been updated. */
 		update_index_refresh(0, NULL,
 				quiet ? REFRESH_QUIET : REFRESH_IN_PORCELAIN);
-		break;
-	}
 
 	remove_branch_state();
 
-- 
1.8.1.1.454.gce43f05
