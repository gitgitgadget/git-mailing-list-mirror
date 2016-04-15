From: David Turner <dturner@twopensource.com>
Subject: [PATCH/RFC 2/6] remote-curl.c: fix variable shadowing
Date: Fri, 15 Apr 2016 15:19:05 -0400
Message-ID: <1460747949-3514-3-git-send-email-dturner@twopensource.com>
References: <1460747949-3514-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 15 21:20:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ar9HW-0006Y9-Bw
	for gcvg-git-2@plane.gmane.org; Fri, 15 Apr 2016 21:19:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753422AbcDOTTv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2016 15:19:51 -0400
Received: from mail-qg0-f48.google.com ([209.85.192.48]:36570 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752866AbcDOTTf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2016 15:19:35 -0400
Received: by mail-qg0-f48.google.com with SMTP id f52so86789880qga.3
        for <git@vger.kernel.org>; Fri, 15 Apr 2016 12:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TtsPSMBRK6XFlCo0cEWaRUnQA830jpyuExzyo29Ri5w=;
        b=XR//Jn1xB3vuiEpXD2Hgls6kRlqB0FjoHM/d0sUrbTHn57HgQtuwB/nEd0Lojtm8B5
         y2gm1h1Vupe+nFI0Jx2Zx7nHVFYdJw3LeMpP4Eo7GLTe6PnTBSy+4O+9rnLgkvsaP+Xb
         ha/VKDqzs4YxyFitpvU1f2PH+mSQLimYJI6VDVfYGMlpjrlJCndhM+/cIAtQpS4fDEfB
         Ckz0zuoB48HIoBqvwySC1FzglhuMdlFhZMk5xbYNGgzSfMnNDC4S5Yjy1DixzHYO/9fx
         TPssZwSNKPV9p3QCBwdWI/8DDchLcV6iyU+s+3SObV+kysfun1r3kPE7rw7ZaRAtaUjh
         o/aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TtsPSMBRK6XFlCo0cEWaRUnQA830jpyuExzyo29Ri5w=;
        b=Z4wniwBlFBNK077gJpH1QP6gheWUfBeBWa5AxRd0M4KSrgG3nQVEveZO46YFAUJPVl
         d8GJAor0pDBKuS4BSMlp0x/Usl69IGbUMc6H0ZrYur8YUZS09MMCrvNhQJ/PGMQk7hr8
         ty6kspN9gi6ow+K1jWadhLN2gIl4v24v2GSt6Gw3Ymp36ZWzO4W4xknVqw0WA7eLw/mg
         rAnHqDoULxsSwLlKGiMwdzIAyQEiIA3i8IUvc4TxBp8hhhmERwHYzLZQsTuAGPQOekmj
         rxKasaszNR13UNHab80lX/9aXoorByljo2Djkjapyf04LhxsOtdfGhq28h35BeEWuj9Z
         rvAg==
X-Gm-Message-State: AOPr4FUoymDmeW5XVtzreGDRs8uA07rCLlCxEEGWnQn0AQ8yTVJu0OMI2D4eBJKZ55GwGw==
X-Received: by 10.140.104.11 with SMTP id z11mr19401133qge.22.1460747973628;
        Fri, 15 Apr 2016 12:19:33 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id c2sm21077097qkb.41.2016.04.15.12.19.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 15 Apr 2016 12:19:32 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1460747949-3514-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291642>

The local variable 'options' was shadowing a global of the same name.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 remote-curl.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index 15e48e2..b9b6a90 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -254,7 +254,7 @@ static struct discovery *discover_refs(const char *service, int for_push)
 	struct strbuf effective_url = STRBUF_INIT;
 	struct discovery *last = last_discovery;
 	int http_ret, maybe_smart = 0;
-	struct http_get_options options;
+	struct http_get_options get_options;
 
 	if (last && !strcmp(service, last->service))
 		return last;
@@ -271,15 +271,15 @@ static struct discovery *discover_refs(const char *service, int for_push)
 		strbuf_addf(&refs_url, "service=%s", service);
 	}
 
-	memset(&options, 0, sizeof(options));
-	options.content_type = &type;
-	options.charset = &charset;
-	options.effective_url = &effective_url;
-	options.base_url = &url;
-	options.no_cache = 1;
-	options.keep_error = 1;
+	memset(&get_options, 0, sizeof(get_options));
+	get_options.content_type = &type;
+	get_options.charset = &charset;
+	get_options.effective_url = &effective_url;
+	get_options.base_url = &url;
+	get_options.no_cache = 1;
+	get_options.keep_error = 1;
 
-	http_ret = http_get_strbuf(refs_url.buf, &buffer, &options);
+	http_ret = http_get_strbuf(refs_url.buf, &buffer, &get_options);
 	switch (http_ret) {
 	case HTTP_OK:
 		break;
-- 
2.4.2.767.g62658d5-twtrsrc
