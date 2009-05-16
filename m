From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH 2/3] tests: Add tests for missing format-patch long options
Date: Sat, 16 May 2009 02:24:45 -0700
Message-ID: <1242465886-31769-2-git-send-email-bebarino@gmail.com>
References: <1242465886-31769-1-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 16 11:25:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M5G8Y-00060P-Io
	for gcvg-git-2@gmane.org; Sat, 16 May 2009 11:24:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754823AbZEPJYy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 May 2009 05:24:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754749AbZEPJYx
	(ORCPT <rfc822;git-outgoing>); Sat, 16 May 2009 05:24:53 -0400
Received: from mail-px0-f123.google.com ([209.85.216.123]:54633 "EHLO
	mail-px0-f123.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754416AbZEPJYw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 May 2009 05:24:52 -0400
Received: by pxi29 with SMTP id 29so1372431pxi.33
        for <git@vger.kernel.org>; Sat, 16 May 2009 02:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=62bqoujIVAJycqOty75c9+FLjAdDKWHUQQ2+rET4y5Q=;
        b=UgbIjInWxgN3moYAiWQCBn4v7yi2aPtzrfFaBrouCAB/pWevGrNGzmMNIEnUeiyRc1
         03ZEFuYrhJ34d0eK3KifO3JBuDKQ+LJzJCBJc+c4jvLjviVPLDumEomjuGvfvJIm+BHP
         X5dyeVdn88a4PNPcbjHMGi+FZaEiTZi5KWjgw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ka5U25YH7A4HjL3jpkfDSHkfKiLcm7HpKIVsdwNIZZ1qUVI5PZKAsBMqLonNHBs8Od
         HTUkDROuzDDGcB2IuPcVZTxO4ze7TcUMMqDM9fLpo0ILayk0HIfAYNZTUk+zWa7TqTxj
         tD1ne780lZ/91GnnoZXXKJVx1lRVtVZaOsYoE=
Received: by 10.114.81.1 with SMTP id e1mr6276639wab.136.1242465893319;
        Sat, 16 May 2009 02:24:53 -0700 (PDT)
Received: from earth ([76.89.212.195])
        by mx.google.com with ESMTPS id k14sm2425527waf.30.2009.05.16.02.24.51
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 16 May 2009 02:24:52 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Sat, 16 May 2009 02:24:50 -0700
X-Mailer: git-send-email 1.6.3.1.9.g95405b
In-Reply-To: <1242465886-31769-1-git-send-email-bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119345>

Exercise format-patch's --signoff, --in-reply-to and --start-number long
options.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---
 t/t4014-format-patch.sh          |   11 +++++++++++
 t/t4021-format-patch-numbered.sh |    6 ++++++
 2 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 11061dd..922a894 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -505,4 +505,15 @@ test_expect_success 'format-patch from a subdirectory (3)' '
 	test -f "$basename"
 '
 
+test_expect_success 'format-patch --in-reply-to' '
+	git format-patch -1 --stdout --in-reply-to "baz@foo.bar" > patch8 &&
+	grep "^In-Reply-To: <baz@foo.bar>" patch8 &&
+	grep "^References: <baz@foo.bar>" patch8
+'
+
+test_expect_success 'format-patch --signoff' '
+	git format-patch -1 --signoff --stdout |
+	grep "^Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>"
+'
+
 test_done
diff --git a/t/t4021-format-patch-numbered.sh b/t/t4021-format-patch-numbered.sh
index 390af23..3c27f0d 100755
--- a/t/t4021-format-patch-numbered.sh
+++ b/t/t4021-format-patch-numbered.sh
@@ -108,4 +108,10 @@ test_expect_success 'format.numbered = auto && --no-numbered' '
 
 '
 
+test_expect_success '--start-number && --numbered' '
+
+	git format-patch --start-number 3 --numbered --stdout HEAD~1 > patch8 &&
+	grep "^Subject: \[PATCH 3/3\]" patch8
+'
+
 test_done
-- 
1.6.3.1.9.g95405b
