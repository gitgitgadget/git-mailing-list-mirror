From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: [PATCH v2 16/19] reset.c: inline update_index_refresh()
Date: Mon, 14 Jan 2013 21:47:48 -0800
Message-ID: <1358228871-7142-17-git-send-email-martinvonz@gmail.com>
References: <1357719376-16406-1-git-send-email-martinvonz@gmail.com>
 <1358228871-7142-1-git-send-email-martinvonz@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Matt Kraai <kraai@ftbfs.org>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>,
	Martin von Zweigbergk <martinvonz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 15 06:54:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuzUA-0003f5-Eo
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 06:54:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754879Ab3AOFyi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2013 00:54:38 -0500
Received: from mail-ea0-f202.google.com ([209.85.215.202]:53478 "EHLO
	mail-ea0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751762Ab3AOFyh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2013 00:54:37 -0500
Received: by mail-ea0-f202.google.com with SMTP id a1so171496eaa.3
        for <git@vger.kernel.org>; Mon, 14 Jan 2013 21:54:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:x-gm-message-state;
        bh=ASLotHUWyadSlyut6qU5BjnDjobhcKLqaTFlnfYbYZU=;
        b=JAbV8hpnKTHrMgAiBj0PWAjz3VEoJN7jyi41P+d0sr0MxOizkHqF2AQy/4def9Proo
         bRael4mbjW2lHXyxqjeaNJoDbQejUevAEgJOpfkyhoWROHarERNe0VNeaJ5LKZ8cWr+y
         cxyRofRg+VOnDt1teltiMjUlZGp4QvSdD6DqvbbxG0QsxQLItqfz74izddvqqEA7r1jD
         axed/Ohf/W0fGvs/Szd2gWtKrbYHQbSzQjV3IHzTmK8eQGGpPpKnGXsiApGSGl51+QoA
         RP42afgYBZ4sz64AhMcoqwF0lXQw9Z2i6uBRg5Pt7sdDunp1EVpG4mxvmgzjGwr8TpjW
         nmHA==
X-Received: by 10.14.205.194 with SMTP id j42mr109695910eeo.2.1358228907870;
        Mon, 14 Jan 2013 21:48:27 -0800 (PST)
Received: from hpza10.eem.corp.google.com ([74.125.121.33])
        by gmr-mx.google.com with ESMTPS id g9si5656365eeo.1.2013.01.14.21.48.27
        (version=TLSv1 cipher=AES128-SHA bits=128/128);
        Mon, 14 Jan 2013 21:48:27 -0800 (PST)
Received: from handduk2.mtv.corp.google.com (handduk2.mtv.corp.google.com [172.18.144.137])
	by hpza10.eem.corp.google.com (Postfix) with ESMTP id 5527920004E;
	Mon, 14 Jan 2013 21:48:27 -0800 (PST)
Received: by handduk2.mtv.corp.google.com (Postfix, from userid 151024)
	id B3EFC10135F; Mon, 14 Jan 2013 21:48:26 -0800 (PST)
X-Mailer: git-send-email 1.8.1.1.454.gce43f05
In-Reply-To: <1358228871-7142-1-git-send-email-martinvonz@gmail.com>
X-Gm-Message-State: ALoCoQkpMH7txBOFfXLqfJazDJbxlxdZuXxssscHmc5AQbVVuPtm1N9clRXkVPGP7ql2H4mzVQKp5YA5XffccGk6orCKaPhIt+KfohM1Z0vZFYm5B+Wo0OYkj/AEumchzWBa9chb87y5Z9h3vAgVBNFkKssJ4C3ETng7sj4CtNLfC8q8y8+kR2ZMLEvgohKalnEDWDGxykf3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213588>

Now that there is only one caller left to the single-line method
update_index_refresh(), inline it.

Signed-off-by: Martin von Zweigbergk <martinvonz@gmail.com>
---
 builtin/reset.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index c316d9b..520c1a5 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -109,12 +109,6 @@ static void print_new_head_line(struct commit *commit)
 		printf("\n");
 }
 
-static void update_index_refresh(int flags)
-{
-	refresh_index(&the_index, (flags), NULL, NULL,
-		      _("Unstaged changes after reset:"));
-}
-
 static void update_index_from_diff(struct diff_queue_struct *q,
 		struct diff_options *opt, void *data)
 {
@@ -329,9 +323,11 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 				die(_("Could not reset index file to revision '%s'."), rev);
 		}
 
-		if (reset_type == MIXED) /* Report what has not been updated. */
-			update_index_refresh(
-				quiet ? REFRESH_QUIET : REFRESH_IN_PORCELAIN);
+		if (reset_type == MIXED) { /* Report what has not been updated. */
+			int flags = quiet ? REFRESH_QUIET : REFRESH_IN_PORCELAIN;
+			refresh_index(&the_index, flags, NULL, NULL,
+				      _("Unstaged changes after reset:"));
+		}
 
 		if (write_cache(newfd, active_cache, active_nr) ||
 		    commit_locked_index(lock))
-- 
1.8.1.1.454.gce43f05
