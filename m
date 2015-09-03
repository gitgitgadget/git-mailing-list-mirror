From: David Turner <dturner@twopensource.com>
Subject: [PATCH 21/43] refs-be-files.c: add method for for_each_reftype_...
Date: Wed,  2 Sep 2015 21:54:51 -0400
Message-ID: <1441245313-11907-22-git-send-email-dturner@twopensource.com>
References: <1441245313-11907-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Sep 03 03:56:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXJks-0006EB-RW
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 03:55:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932342AbbICBzs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2015 21:55:48 -0400
Received: from mail-qg0-f52.google.com ([209.85.192.52]:35041 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932163AbbICBzq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2015 21:55:46 -0400
Received: by qgt47 with SMTP id 47so18596036qgt.2
        for <git@vger.kernel.org>; Wed, 02 Sep 2015 18:55:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+Zi3DfpZxNDOVLD/mRAe+dlSozPH1v/BHBtPW9miwUw=;
        b=e4AOp2MLCUIoTs7dFyfdQwP0ZRb551B0FUuXxBybPWejxrkGGagaTsfD0N+GoPoc1G
         rA4MxWW9BviwtBPrDNKcWhefLnC9TB7z2XktaLrF0XYboqjy/BSVyIJfMdF1W5+p10Dh
         a9YuiXxhfePEqkimM48rbnL9nZ+q7CHinNwmMGi/lnhs7wI8hvmtbCGoQh0KIPRT74Qt
         7ksVzDGY10WD2CgYeJmLCCVMZIa+Dat3Zhj2XwKIFP0Wa7OpuQVZHLKPCKYYcYILLUvH
         f+jeLo+YA0U5cloU5ix/KObkLJJVp0joCxmvJnjANtKKVQWXHQi/jef+8lPeB0wsJGo6
         Sjhw==
X-Gm-Message-State: ALoCoQnAH+0jIUubRy6u8KTKanDmMOq8/8WBMxM3EgpzvYoYny0+CtXffmJdtIe1xY/yitYNYR37
X-Received: by 10.141.28.210 with SMTP id f201mr65193460qhe.28.1441245345777;
        Wed, 02 Sep 2015 18:55:45 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id 95sm11108155qgt.12.2015.09.02.18.55.44
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Sep 2015 18:55:44 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
In-Reply-To: <1441245313-11907-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277148>

Add method for for_each_reftype_fullpath.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs-be-files.c | 3 ++-
 refs.c          | 5 +++++
 refs.h          | 2 ++
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/refs-be-files.c b/refs-be-files.c
index 19bf12b..85257b9 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
@@ -1947,7 +1947,7 @@ static int files_for_each_replace_ref(each_ref_fn fn, void *cb_data)
 			       strlen(git_replace_ref_base), 0, cb_data);
 }
 
-int for_each_reftype_fullpath(each_ref_fn fn, char *type, unsigned int broken, void *cb_data)
+static int files_for_each_reftype_fullpath(each_ref_fn fn, char *type, unsigned int broken, void *cb_data)
 {
 	unsigned int flag = 0;
 
@@ -3857,4 +3857,5 @@ struct ref_be refs_be_files = {
 	files_for_each_rawref,
 	files_for_each_namespaced_ref,
 	files_for_each_replace_ref,
+	files_for_each_reftype_fullpath,
 };
diff --git a/refs.c b/refs.c
index c478683..082c540 100644
--- a/refs.c
+++ b/refs.c
@@ -1046,3 +1046,8 @@ int for_each_replace_ref(each_ref_fn fn, void *cb_data)
 {
 	return the_refs_backend->for_each_replace_ref(fn, cb_data);
 }
+
+int for_each_reftype_fullpath(each_ref_fn fn, char *type, unsigned int broken, void *cb_data)
+{
+	return the_refs_backend->for_each_reftype_fullpath(fn, type, broken, cb_data);
+}
diff --git a/refs.h b/refs.h
index 8376abb..234496f 100644
--- a/refs.h
+++ b/refs.h
@@ -575,6 +575,7 @@ typedef int (*for_each_ref_in_submodule_fn)(const char *submodule,
 typedef int (*for_each_rawref_fn)(each_ref_fn fn, void *cb_data);
 typedef int (*for_each_namespaced_ref_fn)(each_ref_fn fn, void *cb_data);
 typedef int (*for_each_replace_ref_fn)(each_ref_fn fn, void *cb_data);
+typedef int (*for_each_reftype_fullpath_fn)(each_ref_fn fn, char *type, unsigned int broken, void *cb_data);
 
 struct ref_be {
 	struct ref_be *next;
@@ -601,6 +602,7 @@ struct ref_be {
 	for_each_rawref_fn for_each_rawref;
 	for_each_namespaced_ref_fn for_each_namespaced_ref;
 	for_each_replace_ref_fn for_each_replace_ref;
+	for_each_reftype_fullpath_fn for_each_reftype_fullpath;
 };
 
 
-- 
2.0.4.315.gad8727a-twtrsrc
