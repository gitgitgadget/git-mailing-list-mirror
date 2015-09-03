From: David Turner <dturner@twopensource.com>
Subject: [PATCH 41/43] refs: add register_refs_backend
Date: Wed,  2 Sep 2015 21:55:11 -0400
Message-ID: <1441245313-11907-42-git-send-email-dturner@twopensource.com>
References: <1441245313-11907-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Sep 03 03:56:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXJlf-0006mV-HZ
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 03:56:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932414AbbICB4m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2015 21:56:42 -0400
Received: from mail-qg0-f43.google.com ([209.85.192.43]:34533 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932404AbbICB4Z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2015 21:56:25 -0400
Received: by qgez77 with SMTP id z77so18755821qge.1
        for <git@vger.kernel.org>; Wed, 02 Sep 2015 18:56:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=D+oQrNKlCVvHkJAIwfEUons6Byk19oIH7CD68/vcnZM=;
        b=RiC8MjksaRjEqTif5z6EeZ+xJdNuvj00AR3KPHEzWROwYTwZPufUo2tFec6zJiI/Jh
         BRZMnRDhoBK9CcuU3SlGSyUmGo21/MuIKNbvFif+Kml5nrjjf39ixGhq5B36Ny9Az8rr
         7ca0T9oQhbx2ibnOhctnbM1a3a6D3rdyF87cC3aWYPtymvHUkWbnA2EiLxZi5djS22Bf
         Q7Ssj6D8pHcDnf5xSgBBb2F/gBVdHApoJgyOpNWE4Cp4119xTXYWUlnjMoF9KxOnuDS9
         feRO8PPEdRdw3BULGwQYTU0ZV8Hz9ju4yrJXh5ewzXxbNjBT4vlyMjHiC98IUou2XLez
         zYQA==
X-Gm-Message-State: ALoCoQk3/h4kohPhYVAmT95YN/4mL9xIMgEdLu1PQbcuHDamn8jX1x1dwIAlsEnN1imvZJYXM4b7
X-Received: by 10.140.16.74 with SMTP id 68mr2307622qga.7.1441245384347;
        Wed, 02 Sep 2015 18:56:24 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id 95sm11108155qgt.12.2015.09.02.18.56.23
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Sep 2015 18:56:23 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
In-Reply-To: <1441245313-11907-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277158>

Add register_refs_backend, to allow refs backends to be registered.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs.c | 6 ++++++
 refs.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/refs.c b/refs.c
index 3a2cafb..9bdd51f 100644
--- a/refs.c
+++ b/refs.c
@@ -18,6 +18,12 @@ struct ref_be *refs_backends = &refs_be_files;
 
 const char *refs_backend_type;
 
+void register_refs_backend(struct ref_be *be)
+{
+	be->next = refs_backends;
+	refs_backends = be;
+}
+
 /*
  * This function is used to switch to an alternate backend.
  */
diff --git a/refs.h b/refs.h
index fe7c249..0f0873c 100644
--- a/refs.h
+++ b/refs.h
@@ -755,5 +755,6 @@ struct ref_be {
 
 extern struct ref_be refs_be_files;
 int set_refs_backend(const char *name, void *init_data);
+void register_refs_backend(struct ref_be *be);
 
 #endif /* REFS_H */
-- 
2.0.4.315.gad8727a-twtrsrc
