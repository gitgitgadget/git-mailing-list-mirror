From: David Turner <dturner@twopensource.com>
Subject: [PATCH 12/24] resolve_ref_1(): reorder code
Date: Thu,  7 Apr 2016 15:02:59 -0400
Message-ID: <1460055791-23313-13-git-send-email-dturner@twopensource.com>
References: <1460055791-23313-1-git-send-email-dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Apr 07 21:03:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoFDV-0007CX-QT
	for gcvg-git-2@plane.gmane.org; Thu, 07 Apr 2016 21:03:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932343AbcDGTDh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2016 15:03:37 -0400
Received: from mail-qg0-f53.google.com ([209.85.192.53]:33131 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932215AbcDGTDe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Apr 2016 15:03:34 -0400
Received: by mail-qg0-f53.google.com with SMTP id j35so71758679qge.0
        for <git@vger.kernel.org>; Thu, 07 Apr 2016 12:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=k/4UdEGEyFaMCS1Rn/uPJ6RSSD12sYSEYymmwc3AU1c=;
        b=UR/FcatjHXDZPOrrPXmIOJuhfXbj2RWUFqRkgJj39aUSWU+X5om8wXNd+pIlKdJcVk
         TCYvrMIboNWFphZUNitHTG5UjXw1+7VrUON3UKkIv/7QJicrMSYtX03n3YEbQkVRYav6
         jqx7H9osr1f1XcaA81IzYNKVHqSELbzKEq0wZrx/WVbn5KVKbwVV64BZEEMbqVqnxZ3x
         sqoJvax/xx0sTanQmjBFAnvPAP2vsykRd45nIhgg9WstyEOHPtq/R8HgV6f2szz8eAYv
         7rYgH85XhkGzbCp+QpUQyhnFIhrGd/ydwR7XrjHtFyQUEm9weoVX+AGntGkoLNkNpXPN
         F19A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=k/4UdEGEyFaMCS1Rn/uPJ6RSSD12sYSEYymmwc3AU1c=;
        b=VsY4mV2R5EGLX0AkRi5DXeD+EI1XyaOxyF0yZW5VFphZW3FmTRcmmKZgWrKnHU5mOR
         wMSYA28KuUgXCxSp23eKSjFn2hfr4WIfLqPB19KVVRqE6cNaS1MmpOx8xjpXeP//BbeA
         wwyMTRiH2qdjYhlsbPL5MYTf2HNVyMeDqwu9anc3h1RqUayTv6abS1MBFj6h4pXoigQq
         H05vW7atx/8MUnJgEwXqS6lDw0IyNffSuzBGaxyMmrvcMinaeaRGZ5uMl0I6FYZGYit2
         PapHVzxE8tR9eGoT0nnMupbHCmJ/+qvsV/VfTffHzmRZaBxdjfSRN0qI0JkOtep6JDrt
         wzQA==
X-Gm-Message-State: AD7BkJJhhWIHjYMh+sjbZlXJq6t3tAYji4Sp4PfXkYWRFeiJcPMi3+dHyYKV4M5t5aypiQ==
X-Received: by 10.140.251.70 with SMTP id w67mr6092628qhc.99.1460055813542;
        Thu, 07 Apr 2016 12:03:33 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id e11sm3959273qkb.39.2016.04.07.12.03.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 07 Apr 2016 12:03:32 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1460055791-23313-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290959>

From: Michael Haggerty <mhagger@alum.mit.edu>

There is no need to adjust *flags if we're just about to fail.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 69ec903..60f1493 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1542,13 +1542,13 @@ static const char *resolve_ref_1(const char *refname,
 			return refname;
 		}
 		if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
-			*flags |= REF_ISBROKEN;
-
 			if (!(resolve_flags & RESOLVE_REF_ALLOW_BAD_NAME) ||
 			    !refname_is_safe(refname)) {
 				errno = EINVAL;
 				return NULL;
 			}
+
+			*flags |= REF_ISBROKEN;
 			bad_name = 1;
 		}
 	}
-- 
2.4.2.767.g62658d5-twtrsrc
