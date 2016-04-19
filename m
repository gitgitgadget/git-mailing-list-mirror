From: santiago@nyu.edu
Subject: [PATCH v7 6/6] tag -v: verfy directly rather than exec-ing verify-tag
Date: Tue, 19 Apr 2016 13:47:21 -0400
Message-ID: <1461088041-19264-7-git-send-email-santiago@nyu.edu>
References: <1461088041-19264-1-git-send-email-santiago@nyu.edu>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Santiago Torres <santiago@nyu.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 19 19:47:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asZkW-0002Ju-9U
	for gcvg-git-2@plane.gmane.org; Tue, 19 Apr 2016 19:47:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933127AbcDSRre (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2016 13:47:34 -0400
Received: from mail-qg0-f54.google.com ([209.85.192.54]:36303 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932998AbcDSRrc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 13:47:32 -0400
Received: by mail-qg0-f54.google.com with SMTP id f52so13561513qga.3
        for <git@vger.kernel.org>; Tue, 19 Apr 2016 10:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vhohPyhN/SALINgv3+ZmaXEZuCaRtvKN5O9czn34M/k=;
        b=ro62LG5+Iw8iXzlSJv/8/9zfLUsgZyv+VmAXVKVUhptPQmNHkgpSw4VC/dT8AagK76
         jRTssrKIMYemWkBPKftGVJZgoAAGBKn5vMEGsDtMM/QlRKrgQBUznIqpxlwM9NhC89WL
         OxVXJLemgTNJKNQDibvjx+PQaV1UPmjgiW1uAuJU6ECw4rilfc/B3bmLRQ550z+vtpj0
         5lIDwHSdx5P1TMSKU5UfdT0tfw8rjI9VV0Km3ULcldOCUhYZK+DWlRV7zRjnrVLeVfnh
         5OKp59D5KvitRekt1s50GAxocK0uEKioR+T4Q3hgw6h9jpLe1oc1zagNI0Klkw2kkfjr
         RSKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vhohPyhN/SALINgv3+ZmaXEZuCaRtvKN5O9czn34M/k=;
        b=AlpzA6yifUIq/XH+T6y8amw6pI91M4frASols4X1UU1Qb2kJ+NaXAFYFELcUND2MtH
         3o5vyKyTb35EQJvU2IoaHSZNtPQq2ZV0QbN0T4yO0YMlNOK1SwFV+KvQhGfYVY9hlfZz
         5kKiitlMEvDnHVl0jj+gUeozZoL0wqNSMSfZ03RbXjGc/8/zjv8RXmOsezM1LT0aBncj
         I/f9hmAJNQNt6I7w9txgrFyYtV/SkAnXsU/vrd6EBcoW6wBhQtoh2kIQyXwvMl6Sk2MO
         i746E/9Kjiq6S00rFpnuw/9jlxAc6L4UuauX0U7NT7WlzacHoPkvdS4qBb/sroG4LtEt
         MjNA==
X-Gm-Message-State: AOPr4FUL3v8E33xHgMSdgbkCUykxfS8DKQvXJSrc74xMNccFwmT83+xyk9zLIyJ2KNBltbwG
X-Received: by 10.140.25.141 with SMTP id 13mr5219153qgt.5.1461088051314;
        Tue, 19 Apr 2016 10:47:31 -0700 (PDT)
Received: from LykOS.localdomain (NYUFWA-WLESSAUTHCLIENTS-19.NATPOOL.NYU.EDU. [216.165.95.8])
        by smtp.gmail.com with ESMTPSA id w184sm11073374qkw.4.2016.04.19.10.47.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 Apr 2016 10:47:30 -0700 (PDT)
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1461088041-19264-1-git-send-email-santiago@nyu.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291886>

From: Santiago Torres <santiago@nyu.edu>

Instead of having tag -v fork to run verify-tag, use the
gpg_verify_tag() function directly.

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
