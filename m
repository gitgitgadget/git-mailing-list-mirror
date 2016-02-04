From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv8 4/9] submodule-config: slightly simplify lookup_or_create_by_name
Date: Thu,  4 Feb 2016 14:09:31 -0800
Message-ID: <1454623776-3347-5-git-send-email-sbeller@google.com>
References: <1454623776-3347-1-git-send-email-sbeller@google.com>
Cc: jrnieder@gmail.com, Jens.Lehmann@web.de,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Feb 04 23:10:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRS6d-0007qL-9i
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 23:10:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965790AbcBDWKO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2016 17:10:14 -0500
Received: from mail-pf0-f172.google.com ([209.85.192.172]:35257 "EHLO
	mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934313AbcBDWJu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2016 17:09:50 -0500
Received: by mail-pf0-f172.google.com with SMTP id 65so56788034pfd.2
        for <git@vger.kernel.org>; Thu, 04 Feb 2016 14:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Qx6abqzNp1oI57lPPZdodDDROcI5l8k1Wa+lmFYJnX4=;
        b=oaqbIwSFsJwnmZox3npIBwQL+NgcLc76OUyy+6BF/70PSd6KENXE7PKKf6tJe8PYRO
         XI5wY53z5eupUrIl768UJywBWnP851zXzOUakxw70fKO08ZmPAx60LTNUHoZGsov1Clu
         OtDHq4UQTw6RYLujGiYHvV/B58J1AcC3KaN2QJGW1nJPtA2HwEkm9dMYXi+qNOcVpuo/
         S/UpqgDsz2C5fFF209zxMt2l7O5S60qKWA91QElxC6PhOuFhiJ2LlPI/w4hTzLRjTfn7
         YKrOKpxzy6l/K7QjzSXhiDNr14JGVt6Wuq4JicnTh98x2bO4o2qi5JiM7kPXvznG80Ck
         QLLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Qx6abqzNp1oI57lPPZdodDDROcI5l8k1Wa+lmFYJnX4=;
        b=d/VS70iZD/R3/goZz4q4dPOysutbGqBVirCpytrML378eJMV1RjzyGRAe4i6cedLEr
         c3ejd1owY4/Z/F/7OdbVsWg7Ob1jFKfLSPoAMc66Ytx92OgKWSALVgcaSrHQ3R7wnQWz
         Tu8mwmuz+zmtfw2O9/bRNy2I0LMXUkJDm5caJenyyVa+ZmsgmTmO0ICJVV4p4zpTdH63
         VIgAxI+Q47Pw5pjNGv4nTv7u+1fBqR6H8saDQuw0fz+exyHdKciWzEIhWFmZlhKzTsjx
         qTSuf50CMVLVxZ2edcg225tznKjmSjtTIevGN6EvQ135C0NUQj1HOUPVBMYee7Pgggjk
         7pFA==
X-Gm-Message-State: AG10YOSSAdNriEO/w4IwJ1mqMHFYxjuPOUEYmOQV6qBvhbMO5GCqX+LtgTg57XAV4GppwMFP
X-Received: by 10.98.34.198 with SMTP id p67mr14712652pfj.93.1454623789285;
        Thu, 04 Feb 2016 14:09:49 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:5194:ebf5:4051:c1fd])
        by smtp.gmail.com with ESMTPSA id b28sm19425730pfd.24.2016.02.04.14.09.48
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 04 Feb 2016 14:09:48 -0800 (PST)
X-Mailer: git-send-email 2.7.0.rc0.41.gd102984.dirty
In-Reply-To: <1454623776-3347-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285509>

No need for a strbuf, when all we use it for, is duplicating a string.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule-config.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/submodule-config.c b/submodule-config.c
index c08ee7f..e375730 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -165,7 +165,6 @@ static struct submodule *lookup_or_create_by_name(struct submodule_cache *cache,
 		const unsigned char *gitmodules_sha1, const char *name)
 {
 	struct submodule *submodule;
-	struct strbuf name_buf = STRBUF_INIT;
 
 	submodule = cache_lookup_name(cache, gitmodules_sha1, name);
 	if (submodule)
@@ -173,9 +172,7 @@ static struct submodule *lookup_or_create_by_name(struct submodule_cache *cache,
 
 	submodule = xmalloc(sizeof(*submodule));
 
-	strbuf_addstr(&name_buf, name);
-	submodule->name = strbuf_detach(&name_buf, NULL);
-
+	submodule->name = xstrdup(name);
 	submodule->path = NULL;
 	submodule->url = NULL;
 	submodule->update = NULL;
-- 
2.7.0.rc0.41.gd102984.dirty
