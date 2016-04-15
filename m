From: David Turner <dturner@twopensource.com>
Subject: [PATCH/RFC 1/6] http-backend: use argv_array functions
Date: Fri, 15 Apr 2016 15:19:04 -0400
Message-ID: <1460747949-3514-2-git-send-email-dturner@twopensource.com>
References: <1460747949-3514-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 15 21:20:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ar9HS-0006Y9-8k
	for gcvg-git-2@plane.gmane.org; Fri, 15 Apr 2016 21:19:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753398AbcDOTTg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2016 15:19:36 -0400
Received: from mail-qk0-f173.google.com ([209.85.220.173]:34729 "EHLO
	mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752541AbcDOTTd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2016 15:19:33 -0400
Received: by mail-qk0-f173.google.com with SMTP id r184so41217550qkc.1
        for <git@vger.kernel.org>; Fri, 15 Apr 2016 12:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=s/prTXhwggLqzsY3DFe0OmLnJ3UnGgDEr+BQDMIdIwA=;
        b=Br8dHGGWX5f683X2k9UMUuVMqNMhjuGx5SZzoJ7H7UdnxqJwCoLb3DwQ0lZHh0ra0b
         CELaSyhJ5jfk+mhKbj8mRF5PtYlPcpBfwqlLuQalYMq1e/nCBKeAiDYTvhJFsKbzp/Qf
         pujLmjUrSDLYMC6humtMXztUDoKwFHWvdE0mKrCaqU9cP92TDCG2jSY8aT8calNKAlze
         yfoAUyedsJ2uHFx2qs2CGh3Gzi0M132IhUWEIdYI+juVZZ8hIfEQwplHtmNrhfzTJ0C0
         iIpMDQK7UWIoXrUJ65+RdvwhvzDU4lijAi50PbhZQ98kXPczfH93uZiiKndd475rCtBY
         hD6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=s/prTXhwggLqzsY3DFe0OmLnJ3UnGgDEr+BQDMIdIwA=;
        b=cqIqpdPxEIaGMCmpckYSoKpEfzwY5sXYEZkJTu+/XHUyY2T/RwgHiqnEPOde+IqFwX
         ZlFpdYXjg899+NTKuTioF5qL4QUuDmO7NMPt9T0Nz29qHfhSXgCiQQVHoApdM4T+AP3N
         W3YrZ5/QlTd3IYLkvT4cgVxXpoLcDuVAiz4NlrK+QrIw64RIXB7hD5OICHBOgSQHhNwg
         WrITq367R7EDjm71lz3ahOZu1fSTGrDqnbt0C/HYZt9k1ZppY+5Vn4hpH0zVQAPpcb4/
         eKu4T9yeLmTvTc7fln15Vxh0WWqu8jx0qvU4qXD4q0KatUruOF/0jl8VQH3dWtzXtKDb
         1t9A==
X-Gm-Message-State: AOPr4FW7eCSpVP83yClVUSrVb6UkTEH8SnnTvNqg8ivWchY02BQnwJV9uwG0wuP1PGZxmA==
X-Received: by 10.55.164.76 with SMTP id n73mr28209916qke.78.1460747972445;
        Fri, 15 Apr 2016 12:19:32 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id c2sm21077097qkb.41.2016.04.15.12.19.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 15 Apr 2016 12:19:31 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1460747949-3514-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291645>

Signed-off-by: David Turner <dturner@twopensource.com>
---
 http-backend.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/http-backend.c b/http-backend.c
index 8870a26..a4f0066 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -450,9 +450,7 @@ static void get_info_refs(char *arg)
 	hdr_nocache();
 
 	if (service_name) {
-		const char *argv[] = {NULL /* service name */,
-			"--stateless-rpc", "--advertise-refs",
-			".", NULL};
+		struct argv_array argv = ARGV_ARRAY_INIT;
 		struct rpc_service *svc = select_service(service_name);
 
 		strbuf_addf(&buf, "application/x-git-%s-advertisement",
@@ -463,9 +461,13 @@ static void get_info_refs(char *arg)
 		packet_write(1, "# service=git-%s\n", svc->name);
 		packet_flush(1);
 
-		argv[0] = svc->name;
-		run_service(argv, 0);
+		argv_array_push(&argv, svc->name);
+		argv_array_push(&argv, "--stateless-rpc");
+		argv_array_push(&argv, "--advertise-refs");
 
+		argv_array_push(&argv, ".");
+		run_service(argv.argv, 0);
+		argv_array_clear(&argv);
 	} else {
 		select_getanyfile();
 		for_each_namespaced_ref(show_text_ref, &buf);
-- 
2.4.2.767.g62658d5-twtrsrc
