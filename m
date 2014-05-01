From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v6 35/42] refs.c: pass NULL as *flags to read_ref_full
Date: Thu,  1 May 2014 13:37:35 -0700
Message-ID: <1398976662-6962-36-git-send-email-sahlberg@google.com>
References: <1398976662-6962-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 01 22:39:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wfxle-0002fU-Rl
	for gcvg-git-2@plane.gmane.org; Thu, 01 May 2014 22:39:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752157AbaEAUio (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2014 16:38:44 -0400
Received: from mail-qa0-f73.google.com ([209.85.216.73]:59666 "EHLO
	mail-qa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752451AbaEAUh7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2014 16:37:59 -0400
Received: by mail-qa0-f73.google.com with SMTP id hw13so146637qab.2
        for <git@vger.kernel.org>; Thu, 01 May 2014 13:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1P0lY0L9NfVDTgWHqEyVl1OEveJv33kMMggG1ez8boY=;
        b=louffSYy78pOArvUyYY59bVKrgGziF77ZtTCN06P4wjFDHRlIfZgnNN+COQppfM/Ww
         RmrYlu14n5ZcSAuOI9mUrUZwnZarGm6+JkkAuriBw8pu1r302nzwYPFHs5EA0Ynga13k
         ogY98ClklwEwwGQO+z/PDSAgGsyNtGvGIlxFFQ7ESgCyKvcWWAZhU45w/2cfKM97NDG3
         awevvskvsVoECE8APdJ7lIzQqDZFAOPPbpp8PSvKVrq652R4J1p69+FcPBmwylB/o2UQ
         lFh8PeGTiFXPLyPf5Yl0RrkwkuCF7dKqWj24NNlfaBnc4xMRK/v5ZM4U8Mu62JKz3Hdo
         70lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1P0lY0L9NfVDTgWHqEyVl1OEveJv33kMMggG1ez8boY=;
        b=lEN1YFpNzbdNfdXJb0K1eVLlGHgL3gFOxKvNM86PBAktykR2Dq0V9wSyJepaU/3fTQ
         AVML9vJ/00iEh9DB5Ugd7/qlxAwWm93v2ZADQ7lag4dRs6+nU2wufyvCxBUnfJ/NSwX7
         OVjGznkJxX5Iy9KbeN+SNJF5Zy0rMhaTtBetKdq8RBqwAVGyGfoOBwEQuoGxIRtifg+p
         /Ok1K1I4E+nPCDcruzUP0EtUcJNWT+29w3VW0H+OPPvEPn5O5Zqe2qNQNrVRHd5Sg1gw
         OFXVW7zaKny7a/421WGt0kjFt0ctsWEG/WekAc3q2mYOmbi0xGhx/YUAkmA9GtYKHgNE
         BEZg==
X-Gm-Message-State: ALoCoQnVyXH/ynX8wh8peVaod8FIxLrG3PZpXk8oE8YykM/TvpjZvyoo9sL6YMWi0REvl9jrcct9
X-Received: by 10.236.84.141 with SMTP id s13mr6645183yhe.5.1398976679176;
        Thu, 01 May 2014 13:37:59 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id c50si2611488yhl.7.2014.05.01.13.37.59
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 May 2014 13:37:59 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 0DB1A5A4241;
	Thu,  1 May 2014 13:37:58 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id B7495E0A5B; Thu,  1 May 2014 13:37:58 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc1.351.g4d2c8e4
In-Reply-To: <1398976662-6962-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247862>

We call read_ref_full with a pointer to flags from rename_ref but since
we never actually use the returned flags we can just pass NULL here instead.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 7e58693..e1f919e 100644
--- a/refs.c
+++ b/refs.c
@@ -2600,7 +2600,7 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 		goto rollback;
 	}
 
-	if (!read_ref_full(newrefname, sha1, 1, &flag) &&
+	if (!read_ref_full(newrefname, sha1, 1, NULL) &&
 	    delete_ref(newrefname, sha1, REF_NODEREF)) {
 		if (errno==EISDIR) {
 			if (remove_empty_directories(git_path("%s", newrefname))) {
-- 
2.0.0.rc1.351.g4d2c8e4
