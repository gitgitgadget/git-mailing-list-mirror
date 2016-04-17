From: santiago@nyu.edu
Subject: [PATCH v6 6/6] tag -v: verfy directly rather than exec-ing verify-tag
Date: Sun, 17 Apr 2016 18:27:01 -0400
Message-ID: <1460932021-27633-7-git-send-email-santiago@nyu.edu>
References: <1460932021-27633-1-git-send-email-santiago@nyu.edu>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Santiago Torres <santiago@nyu.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 18 00:27:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1arvAA-00055l-Cv
	for gcvg-git-2@plane.gmane.org; Mon, 18 Apr 2016 00:27:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751413AbcDQW10 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Apr 2016 18:27:26 -0400
Received: from mail-qg0-f50.google.com ([209.85.192.50]:36685 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751226AbcDQW1Q (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Apr 2016 18:27:16 -0400
Received: by mail-qg0-f50.google.com with SMTP id f52so107442958qga.3
        for <git@vger.kernel.org>; Sun, 17 Apr 2016 15:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kR4Qhf3Ob7dWeysvU9bEi6eFykF5UCGm44FzKACW6AA=;
        b=ktkxKEqFpVHFvg3Lt/tkaMeLKeqcG0QW5YxtU52Zybws4p82QJWKoJa8zVLA0g4iCe
         orJ974Hvo7N90nNhI1ecY/1Qd/Ir1GB7JciylSMdjiS40NxK9cdiaTO13S9T0B5D+8ft
         IiTdrNdFuQ/l9xsC7MGFCx2majzWoO3qwrReiGroJItfOMuPZNC5rk4T37NjfazV25BH
         TxzVLBOoAzsHFUzqMU2krlsPvRwYFUyO4wbLOB63ElP/cjSuXfKmcKtsYHdGspxss0fi
         chE6r3ed7NqTUWNL4drsPOZ2QTdwFZDnWmAl91ZQ5B7jJxi2dr/Arn4OBV3VMOBaGsba
         WDbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kR4Qhf3Ob7dWeysvU9bEi6eFykF5UCGm44FzKACW6AA=;
        b=eOuyugFn8SY0Kw7pd0qec5pXK3p7scBG0nYxLG17y4NIArNhrMqNr8DJQjsnBY23d2
         PNaWFViIRpocJfuUZF/M5H4erLEa1kJIXCpexW78g0/O1fJrv5O8tmnrn52ERwuc5+EH
         9NjqU7rX9lBWaX9frCpfuSfLv+1/08OnIfZD91JXHxrVwGZCnEa7J5tXX+EFwf/rhZGL
         wZk6VJsPIU4J9kyPIzuim408CehefOekjsiGn5/N9n7iM9ja3ogAbTU4RFdapShi66SO
         NKOG/2tuoDpltWNpxCQwVHOeaL0p0ToixUDgHvxB5CldHCFaxk61sQMbYF+ai81eubpU
         mjew==
X-Gm-Message-State: AOPr4FW1F0hcL/fCa5Li1UNwNfctVwD4zcZSC7pEM4qZCCTwVJi4vYwuvHils9ovS+QXFMCy
X-Received: by 10.140.104.13 with SMTP id z13mr38710252qge.68.1460932036006;
        Sun, 17 Apr 2016 15:27:16 -0700 (PDT)
Received: from LykOS.localdomain (NYUFWA-WLESSAUTHCLIENTS-19.NATPOOL.NYU.EDU. [216.165.95.8])
        by smtp.gmail.com with ESMTPSA id j75sm5120767qgd.19.2016.04.17.15.27.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 17 Apr 2016 15:27:15 -0700 (PDT)
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1460932021-27633-1-git-send-email-santiago@nyu.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291779>

From: Santiago Torres <santiago@nyu.edu>

tag -v forks into verify-tag, which only calls gpg_verify_tag().

Instead of forking to verify-tag, call gpg_verify_tag directly().

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Santiago Torres <santiago@nyu.edu>
---
 builtin/tag.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index 1705c94..7b2918e 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -104,13 +104,7 @@ static int delete_tag(const char *name, const char *ref,
 static int verify_tag(const char *name, const char *ref,
 				const unsigned char *sha1)
 {
-	const char *argv_verify_tag[] = {"verify-tag",
-					"-v", "SHA1_HEX", NULL};
-	argv_verify_tag[2] = sha1_to_hex(sha1);
-
-	if (run_command_v_opt(argv_verify_tag, RUN_GIT_CMD))
-		return error(_("could not verify the tag '%s'"), name);
-	return 0;
+	return gpg_verify_tag(sha1, name, GPG_VERIFY_VERBOSE);
 }
 
 static int do_sign(struct strbuf *buffer)
-- 
2.8.0
