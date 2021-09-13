Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CACD9C433FE
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 08:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2BA860241
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 08:56:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238076AbhIMI5r (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 04:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238308AbhIMI5q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 04:57:46 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3243EC061574
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 01:56:31 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id u4so5585725qvb.6
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 01:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2wC7lyCziR8JUTBlLrwj6AYRVSTAv0sL6gqPdiKtmOU=;
        b=dxE8OET9mdduPRuMVIUTeIIo1l8ShBYk1kTFI5UoCpGmxkoKyqHBApZACxuRZX+bHW
         41fQ2z/S55YkOvYKxXol3XjPQMxNhioTcOiNKg+GIfxlPAwtRCc6/qQn6TcXDo1kSt2l
         oAm6od8PqbtyMaWkVO2Y5ufh7f17sHcYcENIxtguxjMjaU0cWak2V6pVzUl6VqvYhsIv
         VWk1GjDzWx38k9DmHOKXlBEGv+AwwPzbBHvGuAOsIr4rm3HRJYc7CffnqwL3XnVL7Cn5
         UekSGQDTyDLLQIZW4hVxOCdrmfxETXk9noF5AV7B2XsIROfEiGyY5dmiaJ6YJkARqSHe
         Czqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2wC7lyCziR8JUTBlLrwj6AYRVSTAv0sL6gqPdiKtmOU=;
        b=Se4BYcY9qBhCUHW8fbdjmuTRmgVCzb/EBNHFjB1FxSJ36GL8Wgc7UDPh/uodniRWYD
         t3XDkjwhdb2sqaVzZ2DkTmcg1rcA0HRf5j+wKci7ElTNRmPqkZum7i768vY8HlyR1V3V
         6TxTWsutJQ5RgUoKs1D00zOdW0HkeOC/A9r60fm0Xq3gNPQ+J3qgDDRBPOxDD7UzeH2E
         kq963ys3QoojOw0HRXcVvDfMlcvihy+WMRlkisnmaGR9EHUNpn0KUzviAYqMMuxNKflm
         /0lk9S5xzL0Fnml+aWfMhlVdndMhr/ZgVoAmXxad0ZacYhtnVhyDlmUO4j4ZPW6qRb51
         s1KQ==
X-Gm-Message-State: AOAM5339LQ//7a+uWCOH+mKGjppII9+HMhqOesOVgyJjx1xo8gCtYqzc
        LRwtGhGM2tMxIS3gJE4Znisepfl6+Oo=
X-Google-Smtp-Source: ABdhPJwAvft8XasdtSrHFpJkLZVRcgYpszoFbOEd5a5RCIzs5nS21nTCY7h+jDYD7JG4ifk+hPxkkA==
X-Received: by 2002:ad4:5aee:: with SMTP id c14mr9449390qvh.19.1631523390209;
        Mon, 13 Sep 2021 01:56:30 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id q10sm4994321qke.108.2021.09.13.01.56.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Sep 2021 01:56:29 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     bagasdotme@gmail.com, gitster@pobox.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH v2 2/3] credential-cache: check for windows specific errors
Date:   Mon, 13 Sep 2021 01:55:59 -0700
Message-Id: <20210913085600.35506-3-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.481.g26d3bed244
In-Reply-To: <20210913085600.35506-1-carenas@gmail.com>
References: <20210912202830.25720-1-carenas@gmail.com>
 <20210913085600.35506-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Connect and reset errors aren't what will be expected by POSIX but
are compatible with the ones used by WinSock.

To avoid any possibility of confusion with other systems checks
for disconnection and availability had been abstracted into helper
functions that are platform specific.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
V2:
* Use helper functions to separate error handling as suggested by Junio

 builtin/credential-cache.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/builtin/credential-cache.c b/builtin/credential-cache.c
index e8a7415747..fd9f33d993 100644
--- a/builtin/credential-cache.c
+++ b/builtin/credential-cache.c
@@ -11,6 +11,32 @@
 #define FLAG_SPAWN 0x1
 #define FLAG_RELAY 0x2
 
+#ifdef _WIN32
+
+static int connection_closed(int error)
+{
+	return (error == EINVAL);
+}
+
+static int connection_fatally_broken(int error)
+{
+	return (error != ENOENT) && (error != ENETDOWN);
+}
+
+#else
+
+static int connection_closed(int error)
+{
+	return (error == ECONNRESET);
+}
+
+static int connection_fatally_broken(int error)
+{
+	return (error != ENOENT) && (error != ECONNREFUSED);
+}
+
+#endif
+
 static int send_request(const char *socket, const struct strbuf *out)
 {
 	int got_data = 0;
@@ -28,7 +54,7 @@ static int send_request(const char *socket, const struct strbuf *out)
 		int r;
 
 		r = read_in_full(fd, in, sizeof(in));
-		if (r == 0 || (r < 0 && errno == ECONNRESET))
+		if (r == 0 || (r < 0 && connection_closed(errno)))
 			break;
 		if (r < 0)
 			die_errno("read error from cache daemon");
@@ -75,7 +101,7 @@ static void do_cache(const char *socket, const char *action, int timeout,
 	}
 
 	if (send_request(socket, &buf) < 0) {
-		if (errno != ENOENT && errno != ECONNREFUSED)
+		if (connection_fatally_broken(errno))
 			die_errno("unable to connect to cache daemon");
 		if (flags & FLAG_SPAWN) {
 			spawn_daemon(socket);
-- 
2.33.0.481.g26d3bed244

