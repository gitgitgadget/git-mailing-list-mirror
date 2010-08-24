From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v3 2/3] sha1_name.c: use warning in preference to fprintf(stderr
Date: Tue, 24 Aug 2010 14:52:43 +1000
Message-ID: <1282625564-12752-3-git-send-email-jon.seymour@gmail.com>
References: <20100824001454.GB17406@burratino>
Cc: gitster@pobox.com, jrnieder@gmail.com,
	Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 24 06:53:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OnlVu-00051F-JC
	for gcvg-git-2@lo.gmane.org; Tue, 24 Aug 2010 06:53:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751948Ab0HXExT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Aug 2010 00:53:19 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:46555 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751357Ab0HXExS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Aug 2010 00:53:18 -0400
Received: by pzk26 with SMTP id 26so2541473pzk.19
        for <git@vger.kernel.org>; Mon, 23 Aug 2010 21:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=FPSgQabd7iQ2zsBQwUvppuIwAzviEQlyOxgISSYq6zI=;
        b=M9xJRExgngb0JXT8q8TEYade6ZePQd280TAcjLsl8kSjwtq+cRP3UAUH9dcSUEZlaz
         PMqBjlqoYqMuJCrvSBl56oFjcEA/T/ebemWJg1W2Bm46dBcPRZ+GLOQGGMVj18BGHeJ2
         rI13UAAVYf9hAX5Ys4YVEDpUN+7iP3vixuqVo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=IE+BJL79Y24zY+iAHOMY/QzRYmRPLHSuRK4DYr4RVdYu62YpReKs9+hkaEyFbVIA9T
         ekbakbk/t3FkrFgHQHdD0D7SKm/L0oNDO7qRk/3yeDQvGzNClezRuDHX73DvXGqCZ6pX
         Cndgx61f79yAobdPQXkW8loPaQ7Vg+w8ls8uc=
Received: by 10.142.141.10 with SMTP id o10mr5192988wfd.285.1282625597624;
        Mon, 23 Aug 2010 21:53:17 -0700 (PDT)
Received: from localhost.localdomain ([120.16.94.110])
        by mx.google.com with ESMTPS id n2sm9394805wfl.1.2010.08.23.21.53.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 23 Aug 2010 21:53:16 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.100.gceecd
In-Reply-To: <20100824001454.GB17406@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154289>

This commit changes sha1_name.c to use warning instead of
fprintf(stderr).

Trailing newlines from message formats have been removed
since warning adds one itself.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 sha1_name.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 10a4efe..3b8aea2 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -342,7 +342,7 @@ static int get_sha1_1(const char *name, int len, unsigned char *sha1);
 
 static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
 {
-	static const char *warning = "warning: refname '%.*s' is ambiguous.\n";
+	static const char *warn_msg = "refname '%.*s' is ambiguous.";
 	char *real_ref = NULL;
 	int refs_found = 0;
 	int at, reflog_len;
@@ -390,7 +390,7 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
 		return -1;
 
 	if (warn_ambiguous_refs && refs_found > 1)
-		fprintf(stderr, warning, len, str);
+		warning(warn_msg, len, str);
 
 	if (reflog_len) {
 		int nth, i;
@@ -426,9 +426,8 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
 		if (read_ref_at(real_ref, at_time, nth, sha1, NULL,
 				&co_time, &co_tz, &co_cnt)) {
 			if (at_time)
-				fprintf(stderr,
-					"warning: Log for '%.*s' only goes "
-					"back to %s.\n", len, str,
+				warning("Log for '%.*s' only goes "
+					"back to %s.", len, str,
 					show_date(co_time, co_tz, DATE_RFC2822));
 			else {
 				free(real_ref);
-- 
1.7.2.1.100.gceecd
