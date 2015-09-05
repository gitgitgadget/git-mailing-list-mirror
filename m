From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v16 01/14] ref-filter: move `struct atom_value` to ref-filter.c
Date: Sun,  6 Sep 2015 00:22:02 +0530
Message-ID: <1441479135-5285-2-git-send-email-Karthik.188@gmail.com>
References: <1441479135-5285-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 05 20:52:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZYIZl-0001yq-PF
	for gcvg-git-2@plane.gmane.org; Sat, 05 Sep 2015 20:52:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752022AbbIESwa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Sep 2015 14:52:30 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:35886 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751483AbbIESwK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Sep 2015 14:52:10 -0400
Received: by pacwi10 with SMTP id wi10so54944513pac.3
        for <git@vger.kernel.org>; Sat, 05 Sep 2015 11:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nDd8KEB87YZyxrBrsgZKDPPLrEBxl9KKO1jFs2w9IJc=;
        b=SxXCJMbM8xwTgckWEFruAWNckEp2X77Vimp/oliNrwSlY1Xa6GrHbbqG/BSNZxBxPb
         TUujjmI+bsD/VKSO297l6NshN4xLYbF68ejmW3gzyOGh5oehOxhY7Y/p6a/CNM/4wmOE
         VUsb6CuCnI8XO7vnFaJZ7bj0xC0nfhWI+bEedErH8Y0gx5kNAw9ukGfxQTHe1IcU5DPD
         V1bq+I6YyKY6k+2GNrY1zfBXgmDYAuVspy28pEbpQfzs/GzmDBGc849BPKfPejHO3NiB
         kEYuh0sIBnVJ7oAncS2OYtPU1XBdZahlytwEhz3DL2mTU6KXNVAzkJjnKRL1g6N0i3e4
         CMWw==
X-Received: by 10.68.107.133 with SMTP id hc5mr23581431pbb.5.1441479129641;
        Sat, 05 Sep 2015 11:52:09 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id ch3sm6583639pbb.18.2015.09.05.11.52.07
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 05 Sep 2015 11:52:08 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1441479135-5285-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277395>

Since atom_value is only required for the internal working of
ref-filter it doesn't belong in the public header.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 ref-filter.c | 5 +++++
 ref-filter.h | 5 +----
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 46963a5..e53c77e 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -55,6 +55,11 @@ static struct {
 	{ "color" },
 };
 
+struct atom_value {
+	const char *s;
+	unsigned long ul; /* used for sorting when not FIELD_STR */
+};
+
 /*
  * An atom is a valid field atom listed above, possibly prefixed with
  * a "*" to denote deref_tag().
diff --git a/ref-filter.h b/ref-filter.h
index 6bf27d8..45026d0 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -16,10 +16,7 @@
 #define FILTER_REFS_INCLUDE_BROKEN 0x1
 #define FILTER_REFS_ALL 0x2
 
-struct atom_value {
-	const char *s;
-	unsigned long ul; /* used for sorting when not FIELD_STR */
-};
+struct atom_value;
 
 struct ref_sorting {
 	struct ref_sorting *next;
-- 
2.5.1
