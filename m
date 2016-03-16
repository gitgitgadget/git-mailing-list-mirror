From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: [PATCH v3] submodule-config: use hashmap_iter_first()
Date: Wed, 16 Mar 2016 13:46:31 +0600
Message-ID: <1458114391-2235-1-git-send-email-kuleshovmail@gmail.com>
Cc: Git <git@vger.kernel.org>,
	Alexander Kuleshov <kuleshovmail@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 16 08:46:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ag6AS-00042z-Eh
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 08:46:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933877AbcCPHqw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2016 03:46:52 -0400
Received: from mail-lb0-f177.google.com ([209.85.217.177]:35868 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932395AbcCPHqv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2016 03:46:51 -0400
Received: by mail-lb0-f177.google.com with SMTP id x1so42278738lbj.3
        for <git@vger.kernel.org>; Wed, 16 Mar 2016 00:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=S4CmeC4TwUE3dkCA5RjJx2QLOrnuO9Tj1Y3XzuTtE4s=;
        b=Ka7eO0exPNeKIX3gjQcncA3i5FSnqdbRJ7ixPHHf+zdNPkLGlPTFaDfa9eC/TteiZ9
         pwUxxqtNVDuzdh0bhv/zlRnU3iCHQ6N9FPywncHWtqtfFVuTg6hYI/Clg0xTYYGLWQTL
         TzzjMF7q2wJkPMK7vWI+wRr1vvU2pD1BE0ul0Kq3zMi4c5t8xObSJNFGxHOTe6Kx7umL
         XffJcOpdpJHQeuSH5pCIi6EUz/ivqHCNQA+3g6b2G8uEsYEmsaww9NQK5L4XLShHIUGQ
         xaKyy1mMz+dlhOLFIlg2dK+09LA65LlGuiMmh5OLT0KYWSYn+KEEHEF3/gHnV05SHmDv
         ebRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=S4CmeC4TwUE3dkCA5RjJx2QLOrnuO9Tj1Y3XzuTtE4s=;
        b=MoLeeX2xLkocg/8fRfskrGHqzx2ZOuW18tBBMDQn2DD7rOueBg478EXW8XocFoctL/
         h7YakkRtXaaGulT88tSwJ4uIJqiaCnxKR+n0KI5zbOtB/uDTofPy35pW603ioVFIxRbW
         sYaRcYluNWfpGlo4ul9a+yWnU/tzwHxXioi/2bf0WpoDnUL5lSZkYRk3nTf1DIeLwiHo
         q/pKKA8MEG2NqUea/XUiI1pHMtktvIUY1eDp+YADka6KAlBz6C+8MlCBciifajsfSLC6
         DSmyks+YyxiE5s/PdwkUJVdbwm1WXc/Oa0FRETs1OQhmPJ2gAhNs0DSSA9J+a58+yIFu
         xeHw==
X-Gm-Message-State: AD7BkJLxICemdFzGvRsr7t56y5pGZtNL6WV/x63DNe4Umxse21b94STU+3yC+NYhotATwg==
X-Received: by 10.112.171.70 with SMTP id as6mr817830lbc.85.1458114409295;
        Wed, 16 Mar 2016 00:46:49 -0700 (PDT)
Received: from localhost.localhost ([37.150.78.168])
        by smtp.gmail.com with ESMTPSA id rx1sm299875lbb.22.2016.03.16.00.46.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Mar 2016 00:46:48 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.rc2.216.g1477fb2.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288949>

The hashmap API provides hashmap_iter_first() helper for initialion
and getting the first entry of a hashmap. Let's use it instead of
doing initialization manually and then get the first entry.

There are no functional changes, just cleanup.

Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
Reviewed-by: Stefan Beller <sbeller@google.com>
---
Changelog v3: commit message edited.

 submodule-config.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/submodule-config.c b/submodule-config.c
index b82d1fb..8ac5031 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -405,8 +405,7 @@ static const struct submodule *config_from(struct submodule_cache *cache,
 		struct hashmap_iter iter;
 		struct submodule_entry *entry;
 
-		hashmap_iter_init(&cache->for_name, &iter);
-		entry = hashmap_iter_next(&iter);
+		entry = hashmap_iter_first(&cache->for_name, &iter);
 		if (!entry)
 			return NULL;
 		return entry->config;
-- 
2.8.0.rc2.216.g1477fb2.dirty
