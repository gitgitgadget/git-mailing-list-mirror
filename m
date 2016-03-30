From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/6] imap-send.c, cram: allocate enough memory for null terminated string
Date: Tue, 29 Mar 2016 17:38:49 -0700
Message-ID: <1459298333-21899-3-git-send-email-sbeller@google.com>
References: <1459298333-21899-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Mar 30 02:39:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1al4AI-00046b-57
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 02:39:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753061AbcC3AjE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 20:39:04 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:36202 "EHLO
	mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752184AbcC3AjB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 20:39:01 -0400
Received: by mail-pf0-f180.google.com with SMTP id e128so6449407pfe.3
        for <git@vger.kernel.org>; Tue, 29 Mar 2016 17:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KF1KtlEpppkEAjl0LwRJhGGn5YhXKQ78s3v4AiT2Ka8=;
        b=fkuQw6CXVxgzhyGEFSuz4NhADuXaMZs9368VUd8MCVFp1S2Ej01U/26J/BNurkkl2E
         iQkFnh1okk3iUERmytzHeEaE4BIC4pK0TEJs2BB/FAstdWOmL5Z8tIqHO9H9TZRkkWuT
         EjIS4euXLEtGVY45k+yU3yp6MmQF5mnLGaMz9cQ63YpUap2ggGUzbkVHtCr+DA56DKbX
         PYbwp5DVRjWZowNDvghcofJXAlHZv5873341qOGg1P1ib1wwmYEGucWURA842QaZVHhe
         6vi14vS7Jg2dFy+51laHB747Di/+mQw6nsJHmwr9ogyoXQ0CxHokQlryx9/e84KYuP86
         fsJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KF1KtlEpppkEAjl0LwRJhGGn5YhXKQ78s3v4AiT2Ka8=;
        b=IdbG2cTWSSqbHHXsNK1pSkuoNqbnWxLF4Oz+1hRQjFfX2kCHJQvhOWAsLD5fB3XizF
         lJu2eEPxAro/lOYFNmkN4149m7HmCJJl+fLNWp2mlJ+YQEDt6FsGqrrdZtLN6RmTCHsv
         Q9lMbKwcXBvgqJ62fpyP47gUJ/o5zjdznV8ZN8o3f16NjS+E6Tr98JoPxGWVAY3bOt73
         lXTQGgSCgZElPdk7du/s1+brN22o8cDptgaKtfQRKtv16qsnqLMmdrcuB1He5zkBHnvp
         lsHw2m6RgDzJ26rANdA0CNInNTBxmFY3fOWtBf0yzHk2i8vgMrzs7Jfz6FWrYmWbGdpw
         yjzQ==
X-Gm-Message-State: AD7BkJK6gZpb6UjJZcJTQINm9JHza2xyTo7jAfq6btZb4m84FgIJTF3v/tpQITn2BvLH7X4d
X-Received: by 10.98.79.7 with SMTP id d7mr8038242pfb.77.1459298340273;
        Tue, 29 Mar 2016 17:39:00 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:9cc5:9f4:3ffe:cd1])
        by smtp.gmail.com with ESMTPSA id o71sm987375pfj.68.2016.03.29.17.38.59
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 29 Mar 2016 17:38:59 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.8.g27a27a6.dirty
In-Reply-To: <1459298333-21899-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290238>

`strlen` returns the length of a string without the terminating null byte.
To make sure enough memory is allocated we need to pass `strlen(..) + 1`
to the allocation function.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 imap-send.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/imap-send.c b/imap-send.c
index 2c52027..f7e9909 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -872,7 +872,7 @@ static char *cram(const char *challenge_64, const char *user, const char *pass)
 	 * enough upper bound for challenge (decoded result).
 	 */
 	encoded_len = strlen(challenge_64);
-	challenge = xmalloc(encoded_len);
+	challenge = xmalloc(encoded_len + 1);
 	decoded_len = EVP_DecodeBlock((unsigned char *)challenge,
 				      (unsigned char *)challenge_64, encoded_len);
 	if (decoded_len < 0)
-- 
2.8.0.8.g27a27a6.dirty
