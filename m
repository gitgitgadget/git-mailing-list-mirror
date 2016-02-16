From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v5 07/12] ref-filter: introduce parse_align_position()
Date: Wed, 17 Feb 2016 00:30:10 +0530
Message-ID: <1455649215-23260-8-git-send-email-Karthik.188@gmail.com>
References: <1455649215-23260-1-git-send-email-Karthik.188@gmail.com>
Cc: gitster@pobox.com, sunshine@sunshineco.com,
	Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 16 20:00:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVkr4-0008O5-3X
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 20:00:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933219AbcBPTAD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2016 14:00:03 -0500
Received: from mail-pa0-f42.google.com ([209.85.220.42]:35651 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933189AbcBPTAB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2016 14:00:01 -0500
Received: by mail-pa0-f42.google.com with SMTP id ho8so109312661pac.2
        for <git@vger.kernel.org>; Tue, 16 Feb 2016 11:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=smvEwrfkjwA3eb5XpolrUciRQv8M/ewgPCTWoUv7Se4=;
        b=ewoTSOTgyRD0AZ3R5qO3BNqAqbL7gwmjIIq51tfuBNcSfk/6rlWz5nUIWM2n0GOo3o
         yBhR9WAXCW1F66R3n7rtmCOFimT4iknBnOf9uV/KgsODoULtcMsVuWM69Dhyu69atNB7
         /KzR5KCXJ+eBrrn5azdxLNCJAaylu/8vve3kW60dycb7UKnc/BdVyyGGir55u6WBLZUr
         FHr9ESKHsi+D0lZYL1uRJLM7LUPhL2ZPRMWvEI9UoyFjI9qpqBJafMBgGXzmLJE9hw/z
         7mvB7WV2ebyoUI1F2UU/HEiUXrFpeLF9fiIPoEb7qMSPtd/TIKAZQOf81cBQnOxkE93y
         9Z6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=smvEwrfkjwA3eb5XpolrUciRQv8M/ewgPCTWoUv7Se4=;
        b=P2N/TTW26HHM4wwpU6S+ueEa0/Fz5hUdlILrlQLAKSoMXaDJqN8aMJ5fqOR2/4Lr/Q
         Yz3Rq021hcB0+V9VKQjMcUhchadG3LFkScJio1FERRg3HMujq2ZyF47N+F0teZFImZGe
         VAR83mm+syGwlSpBnK4ijeb7iypWvBD/gOe/S35BYDcLehgEqGkU6ai+Gf6REfJJrmhW
         42pGMkPjizuOOdl6vh8K7P4uectMhzP7g23BAPPI8C30xdiYRTwXeJLm0HCODAG0fgy9
         uFXWCxmqV0CS0SbVo4A9IanS3M8/vEQiRblh6mXiFavTNgC/VLJFbYff2KnBZDa+71DF
         +sTA==
X-Gm-Message-State: AG10YOS1laDo9zJbTXThV/HNHpRFpoFWTr88hC60Mo8ONR89riEwkoeDCaOlGJN+9dgNlQ==
X-Received: by 10.66.225.177 with SMTP id rl17mr33217556pac.46.1455649200076;
        Tue, 16 Feb 2016 11:00:00 -0800 (PST)
Received: from ashley.localdomain ([106.51.133.38])
        by smtp.gmail.com with ESMTPSA id 27sm47469677pfh.48.2016.02.16.10.59.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 16 Feb 2016 10:59:59 -0800 (PST)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.7.1
In-Reply-To: <1455649215-23260-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286418>

>From populate_value() extract parse_align_position() which given a
string would give us the alignment position. This is a preparatory
patch as to introduce prefixes for the %(align) atom and avoid
redundancy in the code.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
---
 ref-filter.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index f401da6..a08ea83 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -44,6 +44,17 @@ static void color_atom_parser(struct used_atom *atom, const char *color_value)
 		die(_("unrecognized color: %%(color:%s)"), color_value);
 }
 
+static align_type parse_align_position(const char *s)
+{
+	if (!strcmp(s, "right"))
+		return ALIGN_RIGHT;
+	else if (!strcmp(s, "middle"))
+		return ALIGN_MIDDLE;
+	else if (!strcmp(s, "left"))
+		return ALIGN_LEFT;
+	return -1;
+}
+
 static struct {
 	const char *name;
 	cmp_type cmp_type;
@@ -911,14 +922,12 @@ static void populate_value(struct ref_array_item *ref)
 			align->position = ALIGN_LEFT;
 
 			while (*s) {
+				int position;
+
 				if (!strtoul_ui(s[0]->buf, 10, (unsigned int *)&width))
 					;
-				else if (!strcmp(s[0]->buf, "left"))
-					align->position = ALIGN_LEFT;
-				else if (!strcmp(s[0]->buf, "right"))
-					align->position = ALIGN_RIGHT;
-				else if (!strcmp(s[0]->buf, "middle"))
-					align->position = ALIGN_MIDDLE;
+				else if ((position = parse_align_position(s[0]->buf)) >= 0)
+					align->position = position;
 				else
 					die(_("improper format entered align:%s"), s[0]->buf);
 				s++;
-- 
2.7.1
