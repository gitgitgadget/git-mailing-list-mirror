From: Karthik Nayak <karthik.188@gmail.com>
Subject: [RFC/PATCH 2/9] ref-filter: add option to filter only tags
Date: Thu, 25 Jun 2015 17:13:09 +0530
Message-ID: <1435232596-27466-2-git-send-email-karthik.188@gmail.com>
References: <CAOLa=ZSsVqFy4OrSt295qAZdjKTC7z44EVsx3cPEd2jb8Y-sHw@mail.gmail.com>
 <1435232596-27466-1-git-send-email-karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 25 13:43:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z85ZI-0006Ab-06
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jun 2015 13:43:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751345AbbFYLne (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2015 07:43:34 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:36612 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751069AbbFYLnc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2015 07:43:32 -0400
Received: by paceq1 with SMTP id eq1so48451745pac.3
        for <git@vger.kernel.org>; Thu, 25 Jun 2015 04:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qr8F+rrc/8+MhGnZrvA4nk2PuuRfgGixwozLJPen9H8=;
        b=q8lpQJ0vyuN0BAyoX6hjl5qgp8UoL/vjhfhFBvMcUPKMZTGgiOd4a3uFNi2xbWMgZX
         NGcYcXjZAYLJgJjpEjuhHn6upMJbmLhpiy/s6imvxAWDjom6P7dGcEWv5bJtYToPPQYZ
         Pz+0ToXtVJwc+wkQOp+P3twXd5ZcmyQqv0r+24PEqJiJX7ybcAv4i9a9A3063HoEo0OM
         dJw8AelmArRizl3NKVisnndDXqk+tdH8cOE50R4miE3l50FkIJdjqCwwidu8VFkJf2oi
         RltmC8N/amZ1oltaWecq77l1Xr+qgK5Th+87vff1NDZAYDGTrNSLpuHAzlF0OW35ofWs
         GzbA==
X-Received: by 10.70.48.34 with SMTP id i2mr90366865pdn.125.1435232612436;
        Thu, 25 Jun 2015 04:43:32 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by mx.google.com with ESMTPSA id xn2sm11575446pbc.44.2015.06.25.04.43.30
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 25 Jun 2015 04:43:31 -0700 (PDT)
X-Mailer: git-send-email 2.4.4
In-Reply-To: <1435232596-27466-1-git-send-email-karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272661>

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
index 299b048..97432d1 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1141,6 +1141,8 @@ int filter_refs(struct ref_array *array, struct ref_filter *filter, unsigned int
 		ret = for_each_rawref(ref_filter_handler, &ref_cbdata);
 	else if (type & FILTER_REFS_ALL)
 		ret = for_each_ref(ref_filter_handler, &ref_cbdata);
+	else if (type & FILTER_REFS_TAGS)
+		ret = for_each_tag_ref(ref_filter_handler, &ref_cbdata);
 	else if (type)
 		die("filter_refs: invalid type");
 
diff --git a/ref-filter.h b/ref-filter.h
index 3c59431..dd28d17 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -15,6 +15,7 @@
 
 #define FILTER_REFS_INCLUDE_BROKEN 0x1
 #define FILTER_REFS_ALL 0x2
+#define FILTER_REFS_TAGS 0x4
 
 struct atom_value {
 	const char *s;
-- 
2.4.4
