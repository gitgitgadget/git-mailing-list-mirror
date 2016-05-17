From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 3/3] rev-parse: free all memory
Date: Mon, 16 May 2016 20:22:47 -0700
Message-ID: <20160517032247.25092-4-sbeller@google.com>
References: <20160517032247.25092-1-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <stefanbeller@gmail.com>,
	Stefan Beller <sbeller@google.com>
To: jrnieder@gmail.com
X-From: git-owner@vger.kernel.org Tue May 17 05:23:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2VbB-0002HJ-1w
	for gcvg-git-2@plane.gmane.org; Tue, 17 May 2016 05:23:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752643AbcEQDXE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2016 23:23:04 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:33930 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752888AbcEQDXC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2016 23:23:02 -0400
Received: by mail-pa0-f42.google.com with SMTP id qo8so1714214pab.1
        for <git@vger.kernel.org>; Mon, 16 May 2016 20:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/0u1E9cGkhzHN4djy0uf2jfIglse2q4FnqpGFtzpLFw=;
        b=owbatBjFYESHk19J/274kO3U/BvoktHNiwqiMjZmpobJbzAB5tATeMe996spr3j1fn
         7BwdwWT3OEchm4sCiLDMw3optMZT+4z1Ubk8Z6QnsarRJc0I0bDnzMAQWLK9DvigLCNm
         lXSpxBXueB7ohCr5g2e5oN0+Q+nUhdJ5FooegQRpHB9KBkbUIunYcAMefd4KXFKFSX4b
         PLjpOsmJTpIQBsI6ddD5oWmTnZNzFT0+JKIZA5ofKUdBMmal4twczFCj8ePWbqDNBtAj
         chIn3bwep0T4mk/sVXB47o0NM1sWvAN0u3SahQbN7UfGofU/PwrvlLFYciXcKZDdl2mh
         jaIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/0u1E9cGkhzHN4djy0uf2jfIglse2q4FnqpGFtzpLFw=;
        b=MsA7KfY4GcjIzcGbwnBkL8P5pArTxg+ZTApKZ+zjunPhxnIyPy6aBjLdBTaqFAfcNh
         MUv5TRdV0Uu/AxOWghQORS0/a26dASzr3ny/RU5GniFtyzuur79fxJZHWdiWkhZjHyex
         J+Dq03BUe3wdXm+vQCNsW4PkXqjpsNQzl3nbw0Jcd24swTDGoIwPeoQawthVH8NW136C
         vTAhxU5t8NVhSqW5fsKCPepQqVB9rtqIqqRw6/u83AtTXpevZF6u/GVDueXv4qVG6nDa
         Iobr4qXbn+Zftm3z27sM3ITk3jFyskOqghuRz2GHIwDPbOIQx+aYqGjOZ8ir7pWrRWpm
         TvcA==
X-Gm-Message-State: AOPr4FURtzThV6+3logsiJcNh/EBfEoT6/Yszn8wRo0B8XSzOhcszmTxVNYgy6Y2kP/zrc3S
X-Received: by 10.66.232.226 with SMTP id tr2mr50791817pac.44.1463455376614;
        Mon, 16 May 2016 20:22:56 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:d9b2:8bac:9e16:6023])
        by smtp.gmail.com with ESMTPSA id fv10sm507380pad.40.2016.05.16.20.22.55
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 16 May 2016 20:22:56 -0700 (PDT)
X-Mailer: git-send-email 2.8.2.401.g9c0faef
In-Reply-To: <20160517032247.25092-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294842>

From: Stefan Beller <stefanbeller@gmail.com>

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/rev-parse.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index c961b74..3296d22 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -371,7 +371,7 @@ static int cmd_parseopt(int argc, const char **argv, const char *prefix)
 	static const char * const flag_chars = "*=?!";
 
 	struct strbuf sb = STRBUF_INIT, parsed = STRBUF_INIT;
-	const char **usage = NULL;
+	const char **usage = NULL, **curr_usage;
 	struct option *opts = NULL;
 	int onb = 0, osz = 0, unb = 0, usz = 0;
 
@@ -472,6 +472,16 @@ static int cmd_parseopt(int argc, const char **argv, const char *prefix)
 	strbuf_addf(&parsed, " --");
 	sq_quote_argv(&parsed, argv, 0);
 	puts(parsed.buf);
+
+#ifdef FREE_ALL_MEMORY
+	curr_usage = usage;
+	while (curr_usage) {
+		free(*curr_usage);
+		curr_usage++;
+	}
+	free(usage);
+#endif
+
 	return 0;
 }
 
-- 
2.8.2.401.g9c0faef
