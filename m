From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v3 2/9] ref-filter: add option to filter only tags
Date: Sun, 19 Jul 2015 00:42:22 +0530
Message-ID: <1437246749-14423-3-git-send-email-Karthik.188@gmail.com>
References: <1437246749-14423-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 18 21:12:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGXXT-0001F8-V2
	for gcvg-git-2@plane.gmane.org; Sat, 18 Jul 2015 21:12:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752856AbbGRTMn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jul 2015 15:12:43 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:36850 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752090AbbGRTMn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jul 2015 15:12:43 -0400
Received: by pachj5 with SMTP id hj5so79046788pac.3
        for <git@vger.kernel.org>; Sat, 18 Jul 2015 12:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=881WytvL80jNq7QM+Er7G4ct4T9MmGBL7nNtCeReaTc=;
        b=v5arwg2q19ViPp+NAmc56Y4y+/bSr9Y4e90k5qrTJRByIDm9Kh2Ur+hWhVI+auXPMa
         JBC0oD07IPPzxAo//2/2F8c3HImEHsPltekl6x6ljcrWndgkAi3rKR/gH+/L1IsDxC4s
         8Y68nixSZEbg3/ktjO+9XNqAcO/RwK1Ex3oZ16U1C6QNVGa9/W0Mk/c8ep8omxUWa3GD
         UN0dFzhVYdxgnreIxUbFQIVX7B0mxhdcSpZVO6oh8ebu1jzJWXI63PeyuAcyh2tBXZ2I
         Z+S1OAaxPp/Ws8Evj96//Q2P7o+tKzB/LKAuVEELVyyanDZfFZ9ORACteEul/tgj0Hmj
         +qqg==
X-Received: by 10.70.44.199 with SMTP id g7mr9067135pdm.152.1437246762219;
        Sat, 18 Jul 2015 12:12:42 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id ra10sm15104498pab.19.2015.07.18.12.12.39
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 18 Jul 2015 12:12:41 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.4.6
In-Reply-To: <1437246749-14423-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274170>

From: Karthik Nayak <karthik.188@gmail.com>

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
index b81a08d..771c48d 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1149,6 +1149,8 @@ int filter_refs(struct ref_array *array, struct ref_filter *filter, unsigned int
 		ret = for_each_rawref(ref_filter_handler, &ref_cbdata);
 	else if (type & FILTER_REFS_ALL)
 		ret = for_each_ref(ref_filter_handler, &ref_cbdata);
+	else if (type & FILTER_REFS_TAGS)
+		ret = for_each_tag_ref(ref_filter_handler, &ref_cbdata);
 	else if (type)
 		die("filter_refs: invalid type");
 
diff --git a/ref-filter.h b/ref-filter.h
index 12ffbc5..c18781b 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -15,6 +15,7 @@
 
 #define FILTER_REFS_INCLUDE_BROKEN 0x1
 #define FILTER_REFS_ALL 0x2
+#define FILTER_REFS_TAGS 0x4
 
 struct atom_value {
 	const char *s;
-- 
2.4.6
