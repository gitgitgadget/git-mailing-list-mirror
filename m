From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v12 01/13] ref-filter: move `struct atom_value` to ref-filter.c
Date: Wed, 19 Aug 2015 00:07:20 +0530
Message-ID: <1439923052-7373-2-git-send-email-Karthik.188@gmail.com>
References: <1439923052-7373-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 18 20:37:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZRllT-0008CK-2j
	for gcvg-git-2@plane.gmane.org; Tue, 18 Aug 2015 20:37:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753953AbbHRShd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2015 14:37:33 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:33752 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751612AbbHRShb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2015 14:37:31 -0400
Received: by pabyb7 with SMTP id yb7so138278684pab.0
        for <git@vger.kernel.org>; Tue, 18 Aug 2015 11:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SKYv6oVOmXdHHtStYTG9549UPn717gy1v2MQT9ferP4=;
        b=OnBe4pbdAvMh9lLKjHBw1KeJxh8fpsUZ9RjKIA/0D2XdP2ckmSVSE3mtuGxpY0+lMq
         BFER2Y81sICyF36PE5+bPuRpAC5fQRk3D3i9a3QwefZ1k8jlMFfxwKGPrI23TtHClztd
         AsmnlgAJjAMZl0GUBcKt+wJkwkXXq54iAFYQX9y7ulb+oXfRGdc4bLjh8AVUo6UMh+7W
         QOF0ZK2oll2Hg16Xx/89NIotkzq6MAuMbAIW2aR0AJKPvrL0tTJcG3K50WTocmKpfhS8
         9AKkDrO5O4cwXER/KZX2iFK2cZbd1lmHkjBxhCluqSZkPvYyigHx0Vso1nnD97sZlSmr
         Bv/Q==
X-Received: by 10.66.244.230 with SMTP id xj6mr16175944pac.53.1439923050405;
        Tue, 18 Aug 2015 11:37:30 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id i9sm18858190pbq.44.2015.08.18.11.37.27
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Aug 2015 11:37:29 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1439923052-7373-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276136>

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
2.5.0
