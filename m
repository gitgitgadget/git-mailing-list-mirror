From: Gabriel Souza Franco <gabrielfrancosouza@gmail.com>
Subject: [PATCH v2] fetch-pack: fix object_id of exact sha1
Date: Sun, 28 Feb 2016 19:22:24 -0300
Message-ID: <1456698144-11519-1-git-send-email-gabrielfrancosouza@gmail.com>
References: <xmqqh9gseiqk.fsf@gitster.mtv.corp.google.com>
Cc: Gabriel Souza Franco <gabrielfrancosouza@gmail.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 28 23:22:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aa9jn-0000Hy-32
	for gcvg-git-2@plane.gmane.org; Sun, 28 Feb 2016 23:22:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755254AbcB1WWn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Feb 2016 17:22:43 -0500
Received: from mail-yw0-f180.google.com ([209.85.161.180]:32973 "EHLO
	mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755048AbcB1WWm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Feb 2016 17:22:42 -0500
Received: by mail-yw0-f180.google.com with SMTP id u200so108096383ywf.0
        for <git@vger.kernel.org>; Sun, 28 Feb 2016 14:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=x8PvlzZXn/emN/C1Hvu7Qlmb1Q4njeHG5VlGr/Lhvvs=;
        b=nSWvR9gzVDz7FFdaTJQuPJ83QOcrQ6ynYBPzBu5rKZzbukuuv+EpR8sII3o+gi7GX1
         CCrpVc3jd6kuAO02xRAaEhdsDHYfLXZSBKPo39BYhXbNXhTELdm85HFq6k5jb/8b5cGM
         aCOpFlpnCGCg0r0sKuf75vI1207sHKgyKjrUs4MZTscFoeAix+S25FRBwMGvQJFNX0tL
         Z1aQEQLn2VLPiCBe3e2d2Lkj/OdOGxBc5dvoedVLUq948Uya28tEz89Et5CTW2bRuRyh
         kkZA+e7a217vbryQB/dND8IhTz58hUsNS6YAtmxX4QyR9gSnLYCk22PEmt3U/YzUnZcM
         +oRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=x8PvlzZXn/emN/C1Hvu7Qlmb1Q4njeHG5VlGr/Lhvvs=;
        b=L95VeHlCdyqjLU69Ig3fVXDdTVCLyxGGpNwnWZDWfgs2d6itIUZdOc0oXO4ibzvD2+
         WoAEuIfa4YIbyS9RzmCNcwEHtelfPIvH0wIo8MTgMu6/BbmZg2qGRMyEeIVu6ExtN6Az
         y92v2KCqbKlTbllM9bG2mwLZj7lPAoavUKkDsim4tbd2UxKt+8r24BCUkysmUJUUel+K
         5pzq0n4Li6RxHPxRpkqTB0jORpsrw8Ep9OSsM2N7Li5nroVh8jzhohHQS8ntFzLaiemv
         VKm7atYbgDcT2E+GNrCAHl9Zi9SmwJG7drFDA+bLzxFLulDF78mHSorFVW0SRc2mfuMY
         xeYQ==
X-Gm-Message-State: AD7BkJI+iy4EylVoFkkNsEtcRC2fJpwAL8EzipYx9d2fT+PLfQx56a+z5/lyRp5anY/KeQ==
X-Received: by 10.129.156.204 with SMTP id t195mr6736521ywg.288.1456698161925;
        Sun, 28 Feb 2016 14:22:41 -0800 (PST)
Received: from ghost.localdomain ([201.82.54.180])
        by smtp.gmail.com with ESMTPSA id p199sm18517936ywp.37.2016.02.28.14.22.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 28 Feb 2016 14:22:41 -0800 (PST)
X-Mailer: git-send-email 2.7.2
In-Reply-To: <xmqqh9gseiqk.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287792>

Commit 58f2ed0 (remote-curl: pass ref SHA-1 to fetch-pack as well,
2013-12-05) added support for specifying a SHA-1 as well as a ref name.
Add support for specifying just a SHA-1 and set the ref name to the same
value in this case.

Signed-off-by: Gabriel Souza Franco <gabrielfrancosouza@gmail.com>
---

Not the cleanest conditional I've ever written, but it should handle
all cases correctly.

 builtin/fetch-pack.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 79a611f..763f510 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -16,10 +16,12 @@ static void add_sought_entry(struct ref ***sought, int *nr, int *alloc,
 	struct ref *ref;
 	struct object_id oid;
 
-	if (!get_oid_hex(name, &oid) && name[GIT_SHA1_HEXSZ] == ' ')
-		name += GIT_SHA1_HEXSZ + 1;
-	else
+	if (get_oid_hex(name, &oid) ||
+			(name[GIT_SHA1_HEXSZ] != ' ' &&
+			 name[GIT_SHA1_HEXSZ] != '\0'))
 		oidclr(&oid);
+	else if (name[GIT_SHA1_HEXSZ] == ' ')
+		name += GIT_SHA1_HEXSZ + 1;
 
 	ref = alloc_ref(name);
 	oidcpy(&ref->old_oid, &oid);
-- 
2.7.2
