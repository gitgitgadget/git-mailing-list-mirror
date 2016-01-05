From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v3 03/15] ref-filter: bump 'used_atom' and related code to the top
Date: Tue,  5 Jan 2016 13:33:02 +0530
Message-ID: <1451980994-26865-4-git-send-email-Karthik.188@gmail.com>
References: <1451980994-26865-1-git-send-email-Karthik.188@gmail.com>
Cc: gitster@pobox.com, sunshine@sunshineco.com,
	Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 05 09:03:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGMa4-0007qp-Fa
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jan 2016 09:03:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752022AbcAEICz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jan 2016 03:02:55 -0500
Received: from mail-pa0-f52.google.com ([209.85.220.52]:34413 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751846AbcAEICu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jan 2016 03:02:50 -0500
Received: by mail-pa0-f52.google.com with SMTP id uo6so191791720pac.1
        for <git@vger.kernel.org>; Tue, 05 Jan 2016 00:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CoFy01m/RI0u7ydzPJ4UMqMiOMDxHcCQpL0EeCV/18o=;
        b=tE+F2EA2G1xuYHOI+ZMnv5EPh8plUdJwqxy/APmf6OggwDOY86wqV2bebzgPP9wVxg
         AZV/jgy70CN9iRHVIAMW53MV6b826H75vv1KheQ9XJ+cCdnsDnjLYrLfRCTR3OMOL94c
         iaXe4OopLmY4WRIoDdRZthmVXDrWLvngZKu85KmtFwfMsE5qah99xHfNvjrTajhk+rG0
         YcPJ4AbVCmz0GFknWZmIS0zV/ldhO4qsBxk15z6ajObJkOj7p/jI5Ebmfc8yxIxeTuCk
         CehmHSWYcuH7OrO3HVw/xJ3OjX6LaAut4XyaYXA88PY2q/Wwymy1v71Z5S9mQ0ig1W1M
         j7+A==
X-Received: by 10.66.140.39 with SMTP id rd7mr132430206pab.86.1451980970210;
        Tue, 05 Jan 2016 00:02:50 -0800 (PST)
Received: from ashley.localdomain ([106.51.242.38])
        by smtp.gmail.com with ESMTPSA id q190sm125814275pfq.59.2016.01.05.00.02.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 05 Jan 2016 00:02:49 -0800 (PST)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1451980994-26865-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283354>

Bump code to the top for usage in further patches.
---
 ref-filter.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 6263710..388e2dd 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -16,6 +16,21 @@
 
 typedef enum { FIELD_STR, FIELD_ULONG, FIELD_TIME } cmp_type;
 
+/*
+ * An atom is a valid field atom listed above, possibly prefixed with
+ * a "*" to denote deref_tag().
+ *
+ * We parse given format string and sort specifiers, and make a list
+ * of properties that we need to extract out of objects.  ref_array_item
+ * structure will hold an array of values extracted that can be
+ * indexed with the "atom number", which is an index into this
+ * array.
+ */
+static const char **used_atom;
+static cmp_type *used_atom_type;
+static int used_atom_cnt, need_tagged, need_symref;
+static int need_color_reset_at_eol;
+
 static struct {
 	const char *name;
 	cmp_type cmp_type;
@@ -92,21 +107,6 @@ struct atom_value {
 };
 
 /*
- * An atom is a valid field atom listed above, possibly prefixed with
- * a "*" to denote deref_tag().
- *
- * We parse given format string and sort specifiers, and make a list
- * of properties that we need to extract out of objects.  ref_array_item
- * structure will hold an array of values extracted that can be
- * indexed with the "atom number", which is an index into this
- * array.
- */
-static const char **used_atom;
-static cmp_type *used_atom_type;
-static int used_atom_cnt, need_tagged, need_symref;
-static int need_color_reset_at_eol;
-
-/*
  * Used to parse format string and sort specifiers
  */
 int parse_ref_filter_atom(const char *atom, const char *ep)
-- 
2.6.4
