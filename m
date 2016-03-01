From: David Turner <dturner@twopensource.com>
Subject: [PATCH v7 29/33] setup: configure ref storage on setup
Date: Mon, 29 Feb 2016 19:53:02 -0500
Message-ID: <1456793586-22082-30-git-send-email-dturner@twopensource.com>
References: <1456793586-22082-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, peff@peff.net, mhagger@alum.mit.edu,
	pclouds@gmail.com
X-From: git-owner@vger.kernel.org Tue Mar 01 01:54:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaYa8-0007RW-FI
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 01:54:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753906AbcCAAyQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 19:54:16 -0500
Received: from mail-qg0-f48.google.com ([209.85.192.48]:34870 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753562AbcCAAyB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 19:54:01 -0500
Received: by mail-qg0-f48.google.com with SMTP id y89so130589842qge.2
        for <git@vger.kernel.org>; Mon, 29 Feb 2016 16:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=u5TYg41UICYJ2RaLnmuczEiVdGbgGvgcqC/STR15pl4=;
        b=NspZeYq1Ucsj3bHyVaqGlvu0JhbISKIZRQqbDQCOssJOhMbkNyJ2vYbGEnfou8UguY
         m58KZL8a8LknBjYXpXdsB2koFRAfNeHED1wBprbkUXvJUZwbv9gLG8BiXxTIqnnaNTuv
         hwRaaH7oKGyLxa4DUpgNUXksBNFLwvqA3jY8H80Ifl7Gb+YqSvt1jzbxbuoOyltZLF1j
         uCIbPHuZ0wvYvRXK5ntYvkS1TCelvHgaWGiPICbU7blCM0cx+Ry0yPgtG48P+gKPiUZT
         IjfZ4PoE+B+3QcKMrqiTwtIndP5cnLbJVW7+JoYoaXNT4F9xZMAzLKRQCrJFSPuU3y4x
         i6Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=u5TYg41UICYJ2RaLnmuczEiVdGbgGvgcqC/STR15pl4=;
        b=K+Roya8GCYMzgyxHy+2nR0QvvIcyUX6adYbxzblh7gb7kbRg0DOeNb/AYOp9AUXn1D
         bOUwfMIG+dlKIEFikw1sjecPiW+3Z4yPWfDffDWwvjyGKbt0h0BNRs9rGY07mfjbsOCc
         n0FSA5bGMZyRmpVAiGKEoxCCjGRMaZ2sCPdKbGE4uMrmn8pNZUaD6qalUOQV+kH6Szmi
         J1/K5jxJsi4Xl3FCrVOzLdTsrgYEjfFsAKqUtGK6Oqds0khjlHHISHfU4IT1DT/IAb/T
         ZzPoPMw2XI9E5h7s/fLzxOKHy2frHWGzKDoYMJziJKXK8DWYYolH/YL8XUHxNp66xw4O
         C6EA==
X-Gm-Message-State: AD7BkJKWmt+wUUzbvUxvffYOBWmL37wY1olGOIZk7uQs9NnF3Z6QvnuSC+3gg+56CjJT4g==
X-Received: by 10.140.157.7 with SMTP id d7mr24489641qhd.17.1456793640536;
        Mon, 29 Feb 2016 16:54:00 -0800 (PST)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id z62sm12094715qka.26.2016.02.29.16.53.59
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 29 Feb 2016 16:53:59 -0800 (PST)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1456793586-22082-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287965>

This sets up the existing backend early, so that other code which
reads refs is reading from the right place.

Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 config.c | 1 +
 setup.c  | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/config.c b/config.c
index 9ba40bc..cca7e28 100644
--- a/config.c
+++ b/config.c
@@ -11,6 +11,7 @@
 #include "strbuf.h"
 #include "quote.h"
 #include "hashmap.h"
+#include "refs.h"
 #include "string-list.h"
 #include "utf8.h"
 
diff --git a/setup.c b/setup.c
index bd3a2cf..e2e1220 100644
--- a/setup.c
+++ b/setup.c
@@ -457,6 +457,10 @@ static int check_repository_format_gently(const char *gitdir, int *nongit_ok)
 		ret = -1;
 	}
 
+	register_ref_storage_backends();
+	if (set_ref_storage_backend(ref_storage_backend))
+		die(_("Unknown ref storage backend %s"), ref_storage_backend);
+
 	strbuf_release(&sb);
 	return ret;
 }
-- 
2.4.2.767.g62658d5-twtrsrc
