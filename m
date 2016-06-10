From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v6 34/44] write_or_die: use warning() instead of fprintf(stderr, ...)
Date: Fri, 10 Jun 2016 22:11:08 +0200
Message-ID: <20160610201118.13813-35-chriscool@tuxfamily.org>
References: <20160610201118.13813-1-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 10 22:13:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBSnv-0004Bg-Mz
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 22:13:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752531AbcFJUNO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2016 16:13:14 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36192 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752323AbcFJUMi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2016 16:12:38 -0400
Received: by mail-wm0-f66.google.com with SMTP id m124so1037180wme.3
        for <git@vger.kernel.org>; Fri, 10 Jun 2016 13:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RXkxTPH/DaP3LYnRoZ7zqmIK0n15WZe7R5tFzCtwpNY=;
        b=cyZrYb8ZMUGAJbHN9/p+3/QchxhnG7QHWg8F3dVwzsCvh+WM0mSiAynnDem4hy2lJ5
         ZnGsTocxZGTkUzkgJ6N2lSIlHHHq9TrUTNTxWU9snRbGBbOx0GQargNTsw4OqZg+Bksf
         lzIMx7Fs6++CI65oyFIHOQFiaHW6Lbg4NvhRArRL6WlwKW6PwsKIT4W1RjJj6MY+qFY8
         bX5A7QenZdw7xDUdViScPzK7mzcdoKiAmLJpXPlcydIwZlGGyXTmaR+ZvdKW5dapaAv1
         U2WFjyTsBC/Xj5QBQrVBBoFMKICpoi1pUThXxXB0y4R/Y6g/EgSYBR6wL8CVubaDYP+a
         2l4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RXkxTPH/DaP3LYnRoZ7zqmIK0n15WZe7R5tFzCtwpNY=;
        b=Vh51FCqvs+1cc8btlm4mFmYo1bIh2SiXAHgmLqgjk6v4rQv6WMNqW3UMoWp3MLVF8D
         iQYXa7SCw/B72OqwfFAB1aIMWTKVYUyzY920MZZLvshq0Zp2i1d1BYuFZGPOGM6V763T
         h6UclC6tpgWQv8euBCB4PO+7SH8aGYXBZskJDOmN5qf6xLOIwzTztfBWQRZdI4RUTEx8
         MmzDeYriqlnf+TU4wIF8NULsyMtKfSJ4pHf2fUaSLJU7B63fsotzx2ym9N0YtfdMSS6w
         i28x6rp7Zma42uJUhYRg9aqScXs19HKdn2hXWlqGzAq3O3xFDi6S9Utjl7lW6EurM3S3
         jq5g==
X-Gm-Message-State: ALyK8tItdwaNKu0kMTXBtJV4HuHFB5waGmyf0InZj2diFw0s6Bl9T6PJX8OVyxknhp+Mtg==
X-Received: by 10.194.22.169 with SMTP id e9mr3759295wjf.128.1465589557295;
        Fri, 10 Jun 2016 13:12:37 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id o129sm689125wmb.17.2016.06.10.13.12.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 10 Jun 2016 13:12:36 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.rc2.362.g3cd93d0
In-Reply-To: <20160610201118.13813-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297054>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 write_or_die.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/write_or_die.c b/write_or_die.c
index 49e80aa..c29f677 100644
--- a/write_or_die.c
+++ b/write_or_die.c
@@ -87,8 +87,7 @@ int write_or_whine_pipe(int fd, const void *buf, size_t count, const char *msg)
 {
 	if (write_in_full(fd, buf, count) < 0) {
 		check_pipe(errno);
-		fprintf(stderr, "%s: write error (%s)\n",
-			msg, strerror(errno));
+		warning("%s: write error (%s)\n", msg, strerror(errno));
 		return 0;
 	}
 
@@ -98,8 +97,7 @@ int write_or_whine_pipe(int fd, const void *buf, size_t count, const char *msg)
 int write_or_whine(int fd, const void *buf, size_t count, const char *msg)
 {
 	if (write_in_full(fd, buf, count) < 0) {
-		fprintf(stderr, "%s: write error (%s)\n",
-			msg, strerror(errno));
+		warning("%s: write error (%s)\n", msg, strerror(errno));
 		return 0;
 	}
 
-- 
2.9.0.rc2.362.g3cd93d0
