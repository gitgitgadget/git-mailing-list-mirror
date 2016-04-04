From: santiago@nyu.edu
Subject: [PATCH v4 5/6] tag: use pgp_verify_function in tag -v call
Date: Mon,  4 Apr 2016 18:22:14 -0400
Message-ID: <1459808535-8895-6-git-send-email-santiago@nyu.edu>
References: <1459808535-8895-1-git-send-email-santiago@nyu.edu>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Santiago Torres <santiago@nyu.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 05 00:22:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anCtS-0007kR-E5
	for gcvg-git-2@plane.gmane.org; Tue, 05 Apr 2016 00:22:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756602AbcDDWWe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2016 18:22:34 -0400
Received: from mail-qg0-f50.google.com ([209.85.192.50]:33032 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756463AbcDDWW3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2016 18:22:29 -0400
Received: by mail-qg0-f50.google.com with SMTP id j35so165059233qge.0
        for <git@vger.kernel.org>; Mon, 04 Apr 2016 15:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xWLvxS5BQWqBOimvTwP1AAwivIr2XOhRiPYzJlXm6yE=;
        b=DwOG+oMyOoArwmFYXI1ptssKkdVpC6cn8IxHIC+htgX9VGPmDtncZskdC/r77zw+K0
         kzdA05KnUSZDyX/YpyD8Uehux3GZfrVM7AMwYcLnkYuciPWhYPt5zT6PzXR6JCMR2hCd
         lULyLbTBXLO1wUoPS8UYP7c6fuBnIlJOfhFDpWSO2jWOc1lJZZUEJ/DHnV6QGAurWjYM
         if31htsxRfpWQcs1d8PHHcZTftAIN0frMSDSgaHOjKOsJRy5SM4gzwSV9OAgIKgS81hV
         rwOwnT/lcCi/hE9PcxledBWQ1oXPk7xd2nAI9/V3w5kdqI46V1eC4K1NdYsIolEuPuW4
         QSfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xWLvxS5BQWqBOimvTwP1AAwivIr2XOhRiPYzJlXm6yE=;
        b=Y+vAJOykyKao4SOuuYKGsMSNW0XOWuait/nSfVki5isrULyukK51wf7vEctB+k/OBg
         POz2neZP9XBFD8+CI5hixdKWO8BK1hGnI/+7gBVkEjYZBO2QokWkw2cPkkPA4GBu0sH4
         HDOIBIRteiv9Ue1nrD7f/oyZSKQM6TqdIX/pf13YGmiTmfjmUk2y1hcLRCI8v2DnGDVy
         DWczvhHZRaLRlVLWPazlmft9fP220M2OCM/6on51WQ6dAsNLVB1dOtKcqOo41SXsJsFl
         uFWXsZcsWx4lBZhlwk9f2yoIMPywWO+dr7sWsXCxvBiIsoPhHS3ZOIDbp6FQUl/nZW5C
         Zrlw==
X-Gm-Message-State: AD7BkJK2jLOvONCY++ymxA4NupgQ4tvU8SeCDC3hnYbkV2aR09gt6hTXAJTHUGSvXRKd4KiL
X-Received: by 10.140.246.136 with SMTP id r130mr17422401qhc.12.1459808548023;
        Mon, 04 Apr 2016 15:22:28 -0700 (PDT)
Received: from LykOS.localdomain (NYUFWA-WLESSAUTHCLIENTS-17.NATPOOL.NYU.EDU. [216.165.95.6])
        by smtp.gmail.com with ESMTPSA id h9sm13180670qhh.29.2016.04.04.15.22.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 Apr 2016 15:22:27 -0700 (PDT)
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1459808535-8895-1-git-send-email-santiago@nyu.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290735>

From: Santiago Torres <santiago@nyu.edu>

Instead of running the verify-tag plumbing command, we use the
pgp_verify_tag(). This avoids the usage of an extra fork call. To do
this, we extend the number of parameters that tag.c takes, and
verify-tag passes. Redundant calls done in the pgp_verify_tag function
are removed.

Signed-off-by: Santiago Torres <santiago@nyu.edu>
---
	Note: This follows Peff's suggestion to use an adapter, instead of 
changing the the fn* pointer structure to match gpg_verify_tag.

 builtin/tag.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index 1705c94..f4450f8 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -104,13 +104,7 @@ static int delete_tag(const char *name, const char *ref,
 static int verify_tag(const char *name, const char *ref,
 				const unsigned char *sha1)
 {
-	const char *argv_verify_tag[] = {"verify-tag",
-					"-v", "SHA1_HEX", NULL};
-	argv_verify_tag[2] = sha1_to_hex(sha1);
-
-	if (run_command_v_opt(argv_verify_tag, RUN_GIT_CMD))
-		return error(_("could not verify the tag '%s'"), name);
-	return 0;
+	return gpg_verify_tag(name, GPG_VERIFY_VERBOSE);
 }
 
 static int do_sign(struct strbuf *buffer)
-- 
2.8.0
