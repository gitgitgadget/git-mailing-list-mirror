From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 12/13] refs.c: use a bit for ref_update have_old
Date: Thu,  4 Dec 2014 00:29:22 -0800
Message-ID: <1417681763-32334-13-git-send-email-sbeller@google.com>
References: <1417681763-32334-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: ronniesahlberg@gmail.com, mhagger@alum.mit.edu, jrnieder@gmail.com,
	gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Dec 04 09:30:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwRnW-0005oD-Bs
	for gcvg-git-2@plane.gmane.org; Thu, 04 Dec 2014 09:30:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753261AbaLDI34 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2014 03:29:56 -0500
Received: from mail-ie0-f182.google.com ([209.85.223.182]:41685 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752997AbaLDI3u (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2014 03:29:50 -0500
Received: by mail-ie0-f182.google.com with SMTP id x19so15591813ier.13
        for <git@vger.kernel.org>; Thu, 04 Dec 2014 00:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gqBvHUISyJHpR2B2Mg7akKKWOAwQuptQ5zWJJ7P/s7s=;
        b=cr5zOVoevq277hrPuVn1Iqw2U4fMovbMLHOl/XCZ+l6jePE2h005erGpdFkFXv3mt2
         N6i7SgAwpQ7DT7UiwQf+Y97u7nOuhQYvtOwagiHy4+DNx/pvO9+9j/k2w/pF83vWz6qP
         hgh3w/hbwwHvfq68hkr9ITh61vtfA0Y3Dg7oROnknN1obebaMT3TrA64NpVk9uAGdb7I
         hgqqvZP8SU+onBNozTbikSNffoiTBqw467OY6wnHSQTv90K0Sz6qtc6XWymlvb5kPD0B
         IvQdY2iGXulT6Hmx3CLR/tOZhLXGrlVyFiD8VaoJ9y+6Ol4jykYx3a/BOl3mDJekbq6P
         71KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gqBvHUISyJHpR2B2Mg7akKKWOAwQuptQ5zWJJ7P/s7s=;
        b=AgMxgF0IjEN4zG32g1C/f5+EspB9xe8mdiMT4XKBtjF/KMDF3zW/32e3OplHbtEDCO
         e5sNB49qoyfeIDJjwgkIT6K8f3LPg0OiUo9VzeG8g3y3ne9lRNfZ0S7c8dT85ojcOTX9
         97JXOa2IEXiGAoz/CWToxpc+xS5OLsv+YEFZZub950Cp/ZBf/2LeNboIVIdOhP2tecWK
         VUWBrOf/F9DERSvIAri1lsCub7trCa0Fa16r82OdXlVuubZ1PHTu81VnnXUfOJCSKswR
         a9YaAMVrG9hWoB+ibYh/Q2krk8zkF9K7YCnwaqHQIsg/QS4dxTnT/YvJkOGcub9+XHGv
         gVsg==
X-Gm-Message-State: ALoCoQnxNej/Iab5tpIaCB8Nv9HFWnEA+TOHQ3MXyusQNBApDBIRXqmlJtRv1MheHZHDqbOUYc5e
X-Received: by 10.42.78.208 with SMTP id o16mr10373004ick.41.1417681789127;
        Thu, 04 Dec 2014 00:29:49 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:5d2c:9a2d:3064:bc4])
        by mx.google.com with ESMTPSA id h15sm4809152igq.6.2014.12.04.00.29.48
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 04 Dec 2014 00:29:48 -0800 (PST)
X-Mailer: git-send-email 2.2.0
In-Reply-To: <1417681763-32334-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260739>

Signed-off-by: Stefan Beller <sbeller@google.com>
---

Notes:
    Also a patch, which hasn't been posted on the mailing list before.

 refs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index b54b5b3..2942227 100644
--- a/refs.c
+++ b/refs.c
@@ -3532,7 +3532,7 @@ struct ref_update {
 	unsigned char new_sha1[20];
 	unsigned char old_sha1[20];
 	int flags; /* REF_NODEREF? */
-	int have_old; /* 1 if old_sha1 is valid, 0 otherwise */
+	int have_old:1; /* 1 if old_sha1 is valid, 0 otherwise */
 	struct ref_lock *lock;
 	int type;
 	char *msg;
-- 
2.2.0
