From: David Turner <dturner@twopensource.com>
Subject: [PATCH v2 41/43] refs: add register_refs_backend
Date: Mon, 28 Sep 2015 18:02:16 -0400
Message-ID: <1443477738-32023-42-git-send-email-dturner@twopensource.com>
References: <1443477738-32023-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Tue Sep 29 00:03:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZggWS-0001Gw-6q
	for gcvg-git-2@plane.gmane.org; Tue, 29 Sep 2015 00:03:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754767AbbI1WDl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Sep 2015 18:03:41 -0400
Received: from mail-qg0-f50.google.com ([209.85.192.50]:36217 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754752AbbI1WDi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2015 18:03:38 -0400
Received: by qgx61 with SMTP id 61so133703344qgx.3
        for <git@vger.kernel.org>; Mon, 28 Sep 2015 15:03:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=T1TNP0EDAgKw9IQ63pghzuTRJpvZzRK7WcOM7/yxb5s=;
        b=htiWQbXiVPeH+M8Rj8M8pc7jBaaBW0FXYyi6awLmoOBeqVcx3ME9U4Kra6wuWBIDuN
         aBgQBgu8S4KV4AXhPNz3wH5sku8faUQaDopr68H+9AxNEGMD2LU9xJfYsh3AHGNw3FYc
         Aquhj/z4Tq9/l0Ow98Ml30XYSm/qN3YLi0NSj/411Wgrwq4ybGAziQuBdWNSlSu3BPZD
         vUZCSt0ptEFoRZDzeZH3d+YReHzOAc8E3TFDHD3OfO6OeU9w+2msH532GaVcQIbb3k8I
         //GZcNmyO8922r73gLS7pyBO9ufAurXurzUCYmNioz8qzGSpgw7oAKF6fJzIm8pUOtLs
         vgvA==
X-Gm-Message-State: ALoCoQm9c290tNTyS5fYVkN2ixG7mXR6shgiHdyeNtls6E9t8iPo6WlexHc8jb+tshd+0s9XYBQA
X-Received: by 10.140.236.203 with SMTP id h194mr25362516qhc.73.1443477817448;
        Mon, 28 Sep 2015 15:03:37 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id 128sm7949979qhe.9.2015.09.28.15.03.36
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Sep 2015 15:03:36 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.644.g97b850b-twtrsrc
In-Reply-To: <1443477738-32023-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278769>

Add register_refs_backend, to allow refs backends to be registered.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs.c | 6 ++++++
 refs.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/refs.c b/refs.c
index 4f2ab25..4195657 100644
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
index cf1780e..ac88371 100644
--- a/refs.h
+++ b/refs.h
@@ -764,5 +764,6 @@ struct ref_be {
 
 extern struct ref_be refs_be_files;
 int set_refs_backend(const char *name, void *init_data);
+void register_refs_backend(struct ref_be *be);
 
 #endif /* REFS_H */
-- 
2.4.2.644.g97b850b-twtrsrc
