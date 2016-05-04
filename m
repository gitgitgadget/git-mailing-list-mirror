From: Brian Norris <computersforpeace@gmail.com>
Subject: [PATCH v2 3/3] http: expand http.cookieFile as a path
Date: Wed,  4 May 2016 11:42:15 -0700
Message-ID: <1462387335-57937-3-git-send-email-computersforpeace@gmail.com>
References: <1462387335-57937-1-git-send-email-computersforpeace@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Brian Norris <computersforpeace@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 04 20:43:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ay1lG-0000vX-CS
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 20:43:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752622AbcEDSmx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 14:42:53 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:35558 "EHLO
	mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750825AbcEDSmw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 14:42:52 -0400
Received: by mail-pf0-f178.google.com with SMTP id 77so28071534pfv.2
        for <git@vger.kernel.org>; Wed, 04 May 2016 11:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LOKvieJiHEqjHDQ4+N1F2YAfLBHSd9ps0s8SZjyIwvA=;
        b=tdOgxwqseIVur/vyJyb3Uq3a9WvrdeMxhmkiLla6vy77OND72jMo5GKMKoIec0sPli
         N1wWEUfRjLGrQqo8tHVhAl/ZFQB+k2EpNzNVd6UJzgCKvAJ1qRM0MhjFr5nHQOmruSwQ
         D1cd/hK2A13ioN7RzSGdCvDrra3ABHM82KDJP1N0/g67imA4VR9mjcyZ5jyijat4LkuU
         gwR5w+fgxGzZIEIjL1SsYHN17/IbQvkGm/9pbfjc7R1mIcJ91Xw3EfB+s3EwgOuEPd1V
         3upGXfIg7ecSEdaERu6Vb6HXUbxeGdv2s653p84pfbbR+FYyLfAk51F9K0mGUcsCKqBH
         wv8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LOKvieJiHEqjHDQ4+N1F2YAfLBHSd9ps0s8SZjyIwvA=;
        b=LaVeV7BWzSAjztfLfIftxHZz4Fm3RDOAKMgk1UtJEpvf3gJu9mVRiVhTR9CzKZoU+Q
         hl1oJlKsw6C6CqxC/7Y1f/yeg3g5dzP6aWxcAtGcqhjb2/hq/Fh0DgcDhDfDKrMtmCNS
         HqG8sSKW4EuxQpwCvOHt+tl8FyLOjgp4V0l0rgNmX+X2B/Lr3GTlfzwQvF9Ls5vQsxze
         863FAzrWcDNhLQexmWVthiccfqv6jPrZmovQjeSKAdq6TWUXghSWzlpXfbgk9HIrX9+J
         sMVnXBd7rT2Nw8hTubJxqjzMGaqcaGVsH1kElKATzOb5GxE/28S9Vq2EdOIpdgfPPvHt
         nEMw==
X-Gm-Message-State: AOPr4FU5MDVteCX9vAiIZP7HJJWjFdMYMYKFyoAJSC22fTNf+ot0jYO4IB470B/S/P037w==
X-Received: by 10.98.78.132 with SMTP id c126mr14158306pfb.129.1462387371256;
        Wed, 04 May 2016 11:42:51 -0700 (PDT)
Received: from ban.mtv.corp.google.com ([172.22.64.120])
        by smtp.gmail.com with ESMTPSA id k78sm7785955pfk.70.2016.05.04.11.42.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 04 May 2016 11:42:50 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1462387335-57937-1-git-send-email-computersforpeace@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293563>

This should handle .gitconfig files that specify things like:

[http]
	cookieFile = "~/.gitcookies"

Signed-off-by: Brian Norris <computersforpeace@gmail.com>
---
v2: rework documentation now that 'pathname' is documented centrally

 Documentation/config.txt | 3 ++-
 http.c                   | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index e655b9729a7d..4c3cd7621ad0 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1664,7 +1664,8 @@ http.emptyAuth::
 	authentication.
 
 http.cookieFile::
-	File containing previously stored cookie lines which should be used
+	The pathname of a file containing previously stored cookie lines,
+	which should be used
 	in the Git http session, if they match the server. The file format
 	of the file to read cookies from should be plain HTTP headers or
 	the Netscape/Mozilla cookie file format (see linkgit:curl[1]).
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
2.8.0.rc3.226.g39d4020
