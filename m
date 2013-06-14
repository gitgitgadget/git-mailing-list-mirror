From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 2/3] sh-setup: add new peel_committish() helper
Date: Fri, 14 Jun 2013 18:47:51 +0530
Message-ID: <1371215872-9796-3-git-send-email-artagnon@gmail.com>
References: <1371215872-9796-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 14 15:20:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnTv6-0004tR-Sw
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 15:20:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752796Ab3FNNTy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jun 2013 09:19:54 -0400
Received: from mail-pd0-f175.google.com ([209.85.192.175]:60239 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752660Ab3FNNTx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jun 2013 09:19:53 -0400
Received: by mail-pd0-f175.google.com with SMTP id 4so566795pdd.6
        for <git@vger.kernel.org>; Fri, 14 Jun 2013 06:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=/7lK4uBFf9JMaklrFC4Vop+eq0mGJhW2ZHSHmN2dvuA=;
        b=kg0yYRNIlxPRzoNbRSSBo4HQkrn99Gm8Axd99GtesrBwMK3Zw16fQ2/wa96V4IHi/X
         8sb5s7sw40jvX+ObHES69Dtc9+ZmjJf8ochmxZU0reTTPQLKB+EcYLGMo0Pbl6vDiWi9
         kXdLMXihqS36IQwh4QBybI0zx+/yW1iH1J+6jWl0Lcki8JaRflm5iNKU6rc2OdGwPoH1
         /LCP4i3i1RnnhRxeuDFkziixHg0aMr8hy/GW29QLtiNFLb9UcG/h3NRqcFtLQqvuVhta
         yHgjZT6Z0dAgeV3I5MsfEa8YJcK5SgQfbDHswDoY/lzlv3hDH7eokx0a/8K9sfVvVRHQ
         IUfQ==
X-Received: by 10.68.231.37 with SMTP id td5mr2568019pbc.52.1371215991237;
        Fri, 14 Jun 2013 06:19:51 -0700 (PDT)
Received: from localhost.localdomain ([122.164.213.38])
        by mx.google.com with ESMTPSA id i16sm2422081pag.18.2013.06.14.06.19.48
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 14 Jun 2013 06:19:50 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.381.g12ca056.dirty
In-Reply-To: <1371215872-9796-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227828>

The normal way to check whether a certain revision resolves to a valid
commit is:

  $ git rev-parse --verify $REV^0

Unfortunately, this does not work when $REV is of the type :/quuxery.
Write a helper to work around this limitation.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 git-sh-setup.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index 2f78359..7a964ad 100644
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -313,3 +313,15 @@ then
 	}
 	: ${GIT_OBJECT_DIRECTORY="$GIT_DIR/objects"}
 fi
+
+peel_committish () {
+	case "$1" in
+	:/*)
+		peeltmp=$(git rev-parse --verify "$1") &&
+		git rev-parse --verify "${peeltmp}^0"
+		;;
+	*)
+		git rev-parse --verify "${1}^0"
+		;;
+	esac
+}
-- 
1.8.3.1.381.g12ca056.dirty
