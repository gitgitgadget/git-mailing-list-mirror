From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: [PATCH v2 10/19] reset: avoid redundant error message
Date: Mon, 14 Jan 2013 21:47:42 -0800
Message-ID: <1358228871-7142-11-git-send-email-martinvonz@gmail.com>
References: <1357719376-16406-1-git-send-email-martinvonz@gmail.com>
 <1358228871-7142-1-git-send-email-martinvonz@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Matt Kraai <kraai@ftbfs.org>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>,
	Martin von Zweigbergk <martinvonz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 15 06:49:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuzOf-0007Y3-3W
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 06:49:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755930Ab3AOFsv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2013 00:48:51 -0500
Received: from mail-ye0-f201.google.com ([209.85.213.201]:55212 "EHLO
	mail-ye0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755662Ab3AOFs1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2013 00:48:27 -0500
Received: by mail-ye0-f201.google.com with SMTP id r11so588083yen.4
        for <git@vger.kernel.org>; Mon, 14 Jan 2013 21:48:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:x-gm-message-state;
        bh=SEMEZjGR2QL1rN3blEgm5pKyunacoDzGp7XoUL+x8ZA=;
        b=S1YhThxotGE3KQ9rTc/bI/iaTVvJoXeRktMjGKpdjU85KqTzrdEK/PlF7XYdHAxP8O
         FoAZxdKm9lLExPpd98Bkqqt+I6nlUtWSJVrbT4Uh9b+zym8bHhHiHBrRH5pxDXh0SYV6
         QdjYuJg9xoOt6CwGEGfGJUHbC3AAs/wPJmuoNDnARUppuOhS0HDNAfvS85lvf4jGJT41
         A9GoWDNsW6CPDeS7WNl3RynUJuVtpYDe+R4mfiBJI0Co2HRThtkJeK+J5/ros5YGlizb
         58w/K1Y7Z/PBAIAjZyIg9w+o2P8fR+om25TvkJRs56kjz1Wn4cFJylRaDOOCVavnkr5a
         EcXA==
X-Received: by 10.236.129.244 with SMTP id h80mr47965865yhi.0.1358228906859;
        Mon, 14 Jan 2013 21:48:26 -0800 (PST)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id i27si818377yhe.4.2013.01.14.21.48.26
        (version=TLSv1.1 cipher=AES128-SHA bits=128/128);
        Mon, 14 Jan 2013 21:48:26 -0800 (PST)
Received: from handduk2.mtv.corp.google.com (handduk2.mtv.corp.google.com [172.18.144.137])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id B11885A4173;
	Mon, 14 Jan 2013 21:48:26 -0800 (PST)
Received: by handduk2.mtv.corp.google.com (Postfix, from userid 151024)
	id 5E3471019AE; Mon, 14 Jan 2013 21:48:26 -0800 (PST)
X-Mailer: git-send-email 1.8.1.1.454.gce43f05
In-Reply-To: <1358228871-7142-1-git-send-email-martinvonz@gmail.com>
X-Gm-Message-State: ALoCoQmAMeb0SSSCVOtZBZAZvWWE7v0yQF1XdpBR6x8AH0Mv93Qn0lWZ0+WSvizcijkrDIzs+fX4wI0vEV/gy4SYon8QbVRCLG23rAGj7BdYPaaja7KeCG34wN0GyWbEPqOVS2Teaow6O24IYimsgYP79HeC0DAWpWGVRwcMOmU1FKLxa/YiL6KAIUpk5PGLuBn2hoTmEByc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213583>

If writing or committing the new index file fails, we print "Could not
write new index file." followed by "Could not reset index file to
revision $rev.". The first message seems to imply the second, so print
only the first message.

Signed-off-by: Martin von Zweigbergk <martinvonz@gmail.com>
---
 builtin/reset.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index 7c440ad..97fa9f7 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -338,13 +338,11 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 		int err = reset_index(sha1, reset_type, quiet);
 		if (reset_type == KEEP && !err)
 			err = reset_index(sha1, MIXED, quiet);
-		if (!err &&
-		    (write_cache(newfd, active_cache, active_nr) ||
-		     commit_locked_index(lock))) {
-			err = error(_("Could not write new index file."));
-		}
 		if (err)
 			die(_("Could not reset index file to revision '%s'."), rev);
+		if (write_cache(newfd, active_cache, active_nr) ||
+		    commit_locked_index(lock))
+			die(_("Could not write new index file."));
 	}
 
 	/* Any resets update HEAD to the head being switched to,
-- 
1.8.1.1.454.gce43f05
