From: Brian Norris <computersforpeace@gmail.com>
Subject: [PATCH 2/2] http: expand http.cookieFile as a path
Date: Fri, 29 Apr 2016 00:23:57 -0600
Message-ID: <20160429062357.12647-2-computersforpeace@gmail.com>
References: <20160429062357.12647-1-computersforpeace@gmail.com>
Cc: Brian Norris <computersforpeace@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 29 08:25:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aw1rV-0007af-44
	for gcvg-git-2@plane.gmane.org; Fri, 29 Apr 2016 08:25:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752811AbcD2GZG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2016 02:25:06 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:35761 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752416AbcD2GZE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2016 02:25:04 -0400
Received: by mail-pa0-f46.google.com with SMTP id iv1so41797802pac.2
        for <git@vger.kernel.org>; Thu, 28 Apr 2016 23:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dqqAdzdTJkVExATJ7OC2INw4NT4D4HqBjMP+drJTp/w=;
        b=gbBpk3wAccGlOwE/GZVZDqC0ALZB8SYwvgxtZ5AJgSOxg+ammvHSGVX1msww3tD53H
         TOsOxB3zkZMMFifLl+k6yDU+GgOCkU4Vuq6fuE/7GPNU6qXanBlrnuSFcDKEly7Ozg1n
         l973KKmmtXrKk4Qg/g/Kozo39WMLJuyXDU5tpXJzealuERmqa31DARc43W2+ABg0jWQH
         VusaNhfn+MO6FPP4oPtjlEvrisO/GOtjDRnRoRufHGmzsVkBbt2M416Ih+mQEc2q3+0Y
         Un2UgWYyuNI4UHOzDwEdEC17siU34OZfstIWZGLLoRUsJ172/8iRrBPXS6zeIf5/69r8
         rQsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dqqAdzdTJkVExATJ7OC2INw4NT4D4HqBjMP+drJTp/w=;
        b=hBJEA25KOvavbwluoAqFyYZxZvU9X1PgYm6B2VSAuSL9r30+rgiLEzvpqQdwVWjftR
         X62f+zfFjmXfI57b1Gv0UbMq0XWMZ3HyUYGsj3wOj5mBgqU9YHZ4VTozCADAGmN7+ELU
         YFmEj4alL0GLVUh2H90ehgwiADlaVm7vcTTxgFq0DY7mh9cVaXTVD7/NZDxK6aPbKvnt
         0GXCz0Pid7UO+7q+5sQTBb94jjCVqffHOKNmBLD+dX+Ceua5sMfS71Swu70n4hz+2bS9
         iBsWN1l0l8wLoRtYdDR6e9mA+u0Oi8zOjVKvsIOXfBweUfWExB7RhlyUX8cHKiRwyDmy
         9eSA==
X-Gm-Message-State: AOPr4FX4j6utFxCzq/kaG8Fw60MEjr2jYz8GKSkq703fPaSWigPLhw8GyZcdUay7dWUZnA==
X-Received: by 10.66.141.103 with SMTP id rn7mr26461537pab.70.1461911102760;
        Thu, 28 Apr 2016 23:25:02 -0700 (PDT)
Received: from briannorris-glaptop2.roam.corp.google.com ([66.232.90.194])
        by smtp.gmail.com with ESMTPSA id a64sm20044853pfa.6.2016.04.28.23.25.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 28 Apr 2016 23:25:02 -0700 (PDT)
X-Mailer: git-send-email 2.8.1.340.g018a5d0.dirty
In-Reply-To: <20160429062357.12647-1-computersforpeace@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292970>

This should handle .gitconfig files that specify things like:

[http]
	cookieFile = "~/.gitcookies"

Signed-off-by: Brian Norris <computersforpeace@gmail.com>
---
 Documentation/config.txt | 3 +++
 http.c                   | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index a775ad885a76..d3ef2d3b5d13 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1660,6 +1660,9 @@ http.cookieFile::
 	in the Git http session, if they match the server. The file format
 	of the file to read cookies from should be plain HTTP headers or
 	the Netscape/Mozilla cookie file format (see linkgit:curl[1]).
+	The value of `http.cookieFile` is subject to tilde expansion: `~/` is
+	expanded to the value of `$HOME`, and `~user/` to the specified user's
+	home directory.
 	NOTE that the file specified with http.cookieFile is used only as
 	input unless http.saveCookies is set.
 
diff --git a/http.c b/http.c
index 4304b80ad3ac..1044f9ba0e28 100644
--- a/http.c
+++ b/http.c
@@ -293,7 +293,7 @@ static int http_options(const char *var, const char *value, void *cb)
 		return git_config_string(&http_proxy_authmethod, var, value);
 
 	if (!strcmp("http.cookiefile", var))
-		return git_config_string(&curl_cookie_file, var, value);
+		return git_config_pathname(&curl_cookie_file, var, value);
 	if (!strcmp("http.savecookies", var)) {
 		curl_save_cookies = git_config_bool(var, value);
 		return 0;
-- 
2.8.1.340.g018a5d0.dirty
