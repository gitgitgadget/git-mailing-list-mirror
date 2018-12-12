Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEDFF20A1E
	for <e@80x24.org>; Wed, 12 Dec 2018 00:25:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbeLLAZb (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Dec 2018 19:25:31 -0500
Received: from mail-qt1-f202.google.com ([209.85.160.202]:33410 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbeLLAZb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Dec 2018 19:25:31 -0500
Received: by mail-qt1-f202.google.com with SMTP id k90so16588504qte.0
        for <git@vger.kernel.org>; Tue, 11 Dec 2018 16:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=K6kAFiC05DzX/iyGxH9bdcRoMB1DNEWmpF7U6jArhYI=;
        b=icAnwJuiTTZ2+MWu+dy2svYL9dsHyOFk436XtkswzI3p9hSxkb6/n/jI4KSmY2lQrS
         h8e9lP8fsIKqZRR/epXkycTY0jSjEBMPNpLIiLt0jDXvR8LaTW7iiXWTPi/6wHixiYhi
         LT/ovEApfzAPRbJ2if5CTpeMTG/LkZkG0bT5yv73m4McNqQvkB+neSSDktpbt9okt/VD
         y8jX8vF8NzkOB98Ohy+65bblgtkz9J7cvhGZa4/S4LoixvXjD2aV+nkvqOuJnOECvbrl
         obzACVv0NiybNbbnRLlGv7M5YuszyCUyF+XIZnY606ivKvj/flfrCHhIuDmKVdKd476O
         9img==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=K6kAFiC05DzX/iyGxH9bdcRoMB1DNEWmpF7U6jArhYI=;
        b=hKfekwO9rUsYzbgBx4MoclAKx4xTMLLae6PYO9cy1PRB4iP+ZdvdYKmCYIn1mdn7GY
         sAbMT8j1VOk9J5iN+8745ehLG5CQjnWhJnNGwBvJMHxn2fyuvrCHhVLV7z6y7UtqleSQ
         b/IxYY1GMSKZl6o9EpvuuWHjKyAAuhlv3s6+L6eNgbxqF54Y7N2ZampXk3kYyuBiBLfO
         LanjpN0p5P3SgxhJ9R7qRilJ6k7XOGchQiKHFGGWANgo2zPOI5qS9A5VbKhph7h7XOqI
         VsnYeU6ILxYuTSnCc/+dWo9/QFv91UqXFGLWt3fz3rKmHMEBkh8ULeZZfjQE3w40LmBh
         N2Ig==
X-Gm-Message-State: AA+aEWYrAVMHU+yA6bB6CAAhtmH3l1JZGTpd1d6Cjbm/TBClicrSY5EH
        dZwpGXygsdE1eu0ZF17w0pxIj5Y54lXM40zBldyVxeqWuktv1k1fQPfm1/F5NzePbyieOZwhUI1
        6Jt4nTzJYjzbo3tP6jVqjtV2Yr2Eto218ttZoM8ibDRE48u8fS0SLRxbSm/SvV1s=
X-Google-Smtp-Source: AFSGD/UR8w5zB775WtGKrExchw+ZCSEx97L+E90Bd8y16Qn2WXnm+08u5ezmg06PBvYcH2edDf/VmpJSxl2zbQ==
X-Received: by 2002:a37:4788:: with SMTP id u130mr13302927qka.60.1544574330165;
 Tue, 11 Dec 2018 16:25:30 -0800 (PST)
Date:   Tue, 11 Dec 2018 16:25:18 -0800
In-Reply-To: <cover.1544572142.git.steadmon@google.com>
Message-Id: <22a1615030b562452a06be9d10a515eab96f4bc4.1544572142.git.steadmon@google.com>
Mime-Version: 1.0
References: <20181116084427.GA31493@sigill.intra.peff.net> <cover.1544572142.git.steadmon@google.com>
X-Mailer: git-send-email 2.20.0.rc2.403.gdbc3b29805-goog
Subject: [PATCH v3 4/4] lib-httpd, t5551: check server-side HTTP errors
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com, masayasuzuki@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add an HTTP path to the test server config that returns an ERR pkt-line
unconditionally. Verify in t5551 that remote-curl properly detects this
ERR message and aborts.

Signed-off-by: Josh Steadmon <steadmon@google.com>
Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/lib-httpd.sh                  | 1 +
 t/lib-httpd/apache.conf         | 4 ++++
 t/lib-httpd/error-smart-http.sh | 3 +++
 t/t5551-http-fetch-smart.sh     | 5 +++++
 4 files changed, 13 insertions(+)
 create mode 100644 t/lib-httpd/error-smart-http.sh

diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index a8729f8232..4e946623bb 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -131,6 +131,7 @@ prepare_httpd() {
 	mkdir -p "$HTTPD_DOCUMENT_ROOT_PATH"
 	cp "$TEST_PATH"/passwd "$HTTPD_ROOT_PATH"
 	install_script broken-smart-http.sh
+	install_script error-smart-http.sh
 	install_script error.sh
 	install_script apply-one-time-sed.sh
 
diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
index 581c010d8f..6de2bc775c 100644
--- a/t/lib-httpd/apache.conf
+++ b/t/lib-httpd/apache.conf
@@ -117,6 +117,7 @@ Alias /auth/dumb/ www/auth/dumb/
 </LocationMatch>
 ScriptAliasMatch /smart_*[^/]*/(.*) ${GIT_EXEC_PATH}/git-http-backend/$1
 ScriptAlias /broken_smart/ broken-smart-http.sh/
+ScriptAlias /error_smart/ error-smart-http.sh/
 ScriptAlias /error/ error.sh/
 ScriptAliasMatch /one_time_sed/(.*) apply-one-time-sed.sh/$1
 <Directory ${GIT_EXEC_PATH}>
@@ -125,6 +126,9 @@ ScriptAliasMatch /one_time_sed/(.*) apply-one-time-sed.sh/$1
 <Files broken-smart-http.sh>
 	Options ExecCGI
 </Files>
+<Files error-smart-http.sh>
+	Options ExecCGI
+</Files>
 <Files error.sh>
   Options ExecCGI
 </Files>
diff --git a/t/lib-httpd/error-smart-http.sh b/t/lib-httpd/error-smart-http.sh
new file mode 100644
index 0000000000..e65d447fc4
--- /dev/null
+++ b/t/lib-httpd/error-smart-http.sh
@@ -0,0 +1,3 @@
+echo "Content-Type: application/x-git-upload-pack-advertisement"
+echo
+printf "%s" "0019ERR server-side error"
diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index 8630b0cc39..ba83e567e5 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -429,5 +429,10 @@ test_expect_success 'GIT_TRACE_CURL_NO_DATA prevents data from being traced' '
 	! grep "=> Send data" err
 '
 
+test_expect_success 'server-side error detected' '
+	test_must_fail git clone $HTTPD_URL/error_smart/repo.git 2>actual &&
+	grep "server-side error" actual
+'
+
 stop_httpd
 test_done
-- 
2.20.0.rc2.403.gdbc3b29805-goog

