From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 01/10] transport-helper: add 'force' to 'export' helpers
Date: Sat, 12 Oct 2013 02:05:29 -0500
Message-ID: <1381561533-20381-7-git-send-email-felipe.contreras@gmail.com>
References: <1381561533-20381-1-git-send-email-felipe.contreras@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Richard Hansen <rhansen@bbn.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 12 09:12:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUtMw-0004bU-9R
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 09:12:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753885Ab3JLHLv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Oct 2013 03:11:51 -0400
Received: from mail-oa0-f54.google.com ([209.85.219.54]:34784 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752214Ab3JLHLt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Oct 2013 03:11:49 -0400
Received: by mail-oa0-f54.google.com with SMTP id n5so3112218oag.41
        for <git@vger.kernel.org>; Sat, 12 Oct 2013 00:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WPM9+BbpqdrgJhnhGvZFhOEbVWD5lybn298sZXjb3vI=;
        b=hBe6JU48IIshG3zsqY09/qsyV6cFkAI9SCEdvdbl6ycaBe7GmiIHQpOVHpiYO/X/o+
         LTOIRedgAStTaXFWuJIcxddtrXv5BZvsoQUaGT0+0r8hIbbjwA1q2zsK9L6lVa/Vunwb
         2HqTySaFqnTLe18wx40/viMBv2AanNerOWU8uVwGrboRXCSG04cQhjDQ6kg2pm/DGXBJ
         sOOiLDQ/y6aiaMfLrv5Jzr7X3m77PUolQGEGAJcUlOP15XuOzwu70MGnVUb/CzOY8OuB
         opvxhjMqxUKUg90yHwtozfAioZ3fUNobKLt7pFBnrVd98dMPo0eZNRc137nQg/dqBXk6
         Yvpg==
X-Received: by 10.60.70.134 with SMTP id m6mr17756086oeu.14.1381561909484;
        Sat, 12 Oct 2013 00:11:49 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id d8sm101365902oeu.6.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 12 Oct 2013 00:11:48 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1381561533-20381-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235980>

Otherwise they cannot know when to force the push or not (other than
hacks).

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 transport-helper.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/transport-helper.c b/transport-helper.c
index 63cabc3..cd913af 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -814,6 +814,11 @@ static int push_refs_with_export(struct transport *transport,
 			die("helper %s does not support dry-run", data->name);
 	}
 
+	if (flags & TRANSPORT_PUSH_FORCE) {
+		if (set_helper_option(transport, "force", "true") != 0)
+			die("helper %s does not support 'force'", data->name);
+	}
+
 	helper = get_helper(transport);
 
 	write_constant(helper->in, "export\n");
-- 
1.8.4-fc
