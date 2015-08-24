From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/5] builtin/am: make sure state files are text
Date: Mon, 24 Aug 2015 10:09:43 -0700
Message-ID: <1440436186-7894-3-git-send-email-gitster@pobox.com>
References: <20150824065033.GA4124@sigill.intra.peff.net>
 <1440436186-7894-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 24 19:10:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZTvFw-000596-44
	for gcvg-git-2@plane.gmane.org; Mon, 24 Aug 2015 19:10:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755046AbbHXRJv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2015 13:09:51 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:36325 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751734AbbHXRJu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2015 13:09:50 -0400
Received: by pacgr6 with SMTP id gr6so492968pac.3
        for <git@vger.kernel.org>; Mon, 24 Aug 2015 10:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=rLMzJW3WA8pHxR+Xcx4LVXRTECzhU6cDI+xWuFfANnI=;
        b=Xw4MEXdSuSDv9UImQJK7OEWJNn9d3w6y4J4FJfksVxhwRZaEIRUn4DURrJRz+PyXK0
         Ox2jLnYolIItpG9e+lHAdLTzWJTA6zVUo5qaT5tyaRr02DUmdOjbYDJcMF+r6yyfOC3U
         Xa6sqkd+wXWhbdCz/019pNUMPD1pdHilkbRxkrnBDgAIBUtIMiqJRJH5WpVtW72c7rfg
         d2BAM/WbCCd9ukbFVpaQQHSJfuNTGc+1M8V84rCu0Sz8vQjZ5LdmPlsyIzQYxm3GJJxi
         QbP1HFsf/7QY5APXkXF2xDHhnWyN8K6i3tV+w42FNn+ynTzfYhw5wtXIiXMdpIpzDGnh
         T2Hg==
X-Received: by 10.68.250.5 with SMTP id yy5mr47146380pbc.34.1440436189681;
        Mon, 24 Aug 2015 10:09:49 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:813d:881a:159:a8e7])
        by smtp.gmail.com with ESMTPSA id gx1sm18035584pbc.29.2015.08.24.10.09.49
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Mon, 24 Aug 2015 10:09:49 -0700 (PDT)
X-Mailer: git-send-email 2.5.0-568-g53a3e28
In-Reply-To: <1440436186-7894-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276462>

We forgot to terminate the payload given to write_file() with LF,
resulting in files that ends with an incomplete line.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/am.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 4d34dc5..3423aa3 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -199,13 +199,13 @@ static inline const char *am_path(const struct am_state *state, const char *path
 static int write_state_text(const struct am_state *state,
 			    const char *name, const char *string)
 {
-	return write_file(am_path(state, name), 1, "%s", string);
+	return write_file(am_path(state, name), 1, "%s\n", string);
 }
 
 static int write_state_count(const struct am_state *state,
 			     const char *name, int value)
 {
-	return write_file(am_path(state, name), 1, "%d", value);
+	return write_file(am_path(state, name), 1, "%d\n", value);
 }
 
 static int write_state_bool(const struct am_state *state,
-- 
2.5.0-568-g53a3e28
