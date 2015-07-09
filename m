From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 02/10] ref-filter: add option to filter only tags
Date: Thu,  9 Jul 2015 15:57:43 +0530
Message-ID: <1436437671-25600-2-git-send-email-karthik.188@gmail.com>
References: <CAOLa=ZQyHwza6L9r6iFX1GkVrC+F-XNwegO=bGyxafjY3JoYpw@mail.gmail.com>
 <1436437671-25600-1-git-send-email-karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 09 12:29:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZD94w-0004AO-1F
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jul 2015 12:29:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753270AbbGIK2o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2015 06:28:44 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:36616 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753140AbbGIK17 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2015 06:27:59 -0400
Received: by pdjr16 with SMTP id r16so1968013pdj.3
        for <git@vger.kernel.org>; Thu, 09 Jul 2015 03:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mGwZqINQX4gjIS5CD5O6CftCMTFrKwF9dM3n6YfcW5k=;
        b=N8z8QemIrv1OgiwPu1gIpGYsvbAQu6S/OExxs4FUJcMQauytwOSsDgFWnKjGKMR1y3
         vEhsJYqlopMOy9GPSr2yacqOotyqOWL78BP3j4OYA1uWNzCsrx+lO2h9IfFDANMAs6d4
         +d/qxQSTfvN02EonSX6A0AYB5rt7vJRv9LEfBt+SKMqB2f+wh6jlHRzaX5EootL2j5AC
         QvuVM1Oh0t57fEDUYX7Vu3J/YQbGNMLo0RE/M3j5CMwVPtgCi7q7/JzCjBdqVxAXDObA
         GWcvDxfftkDpolslvpKmq0KjWTV/PH1+yybLCmZEWUth30LtQCLn6hd/8BgACYI6Xu/Q
         kPvA==
X-Received: by 10.68.94.131 with SMTP id dc3mr29909817pbb.127.1436437679464;
        Thu, 09 Jul 2015 03:27:59 -0700 (PDT)
Received: from ashley.localdomain ([49.201.133.206])
        by smtp.gmail.com with ESMTPSA id b10sm5449836pdo.84.2015.07.09.03.27.56
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 09 Jul 2015 03:27:58 -0700 (PDT)
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1436437671-25600-1-git-send-email-karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273737>

Add an option in 'filter_refs()' to use 'for_each_tag_ref()'
and filter refs. This type checking is done by adding a
'FILTER_REFS_TAGS' in 'ref-filter.h'

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 ref-filter.c | 2 ++
 ref-filter.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/ref-filter.c b/ref-filter.c
index 3098497..e690177 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1152,6 +1152,8 @@ int filter_refs(struct ref_array *array, struct ref_filter *filter, unsigned int
 		ret = for_each_rawref(ref_filter_handler, &ref_cbdata);
 	else if (type & FILTER_REFS_ALL)
 		ret = for_each_ref(ref_filter_handler, &ref_cbdata);
+	else if (type & FILTER_REFS_TAGS)
+		ret = for_each_tag_ref(ref_filter_handler, &ref_cbdata);
 	else if (type)
 		die("filter_refs: invalid type");
 
diff --git a/ref-filter.h b/ref-filter.h
index 6bf27d8..449ddb8 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -15,6 +15,7 @@
 
 #define FILTER_REFS_INCLUDE_BROKEN 0x1
 #define FILTER_REFS_ALL 0x2
+#define FILTER_REFS_TAGS 0x4
 
 struct atom_value {
 	const char *s;
-- 
2.4.5
