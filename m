From: Caleb Thompson <caleb@calebthompson.io>
Subject: [PATCH v5 2/4] commit test: Use write_script
Date: Thu, 12 Jun 2014 14:39:00 -0500
Message-ID: <1402601942-45553-3-git-send-email-caleb@calebthompson.io>
References: <1402601942-45553-1-git-send-email-caleb@calebthompson.io>
Cc: Jeff King <peff@peff.net>, Jeremiah Mahler <jmmahler@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	David Kastrup <dak@gnu.org>,
	Junio C Hamano <gitster@pobox.com>,
	Mike Burns <mike@mike-burns.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 12 21:39:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvAqR-0006wg-TQ
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jun 2014 21:39:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752100AbaFLTjW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2014 15:39:22 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:53413 "EHLO
	new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751345AbaFLTjU (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Jun 2014 15:39:20 -0400
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 15F36632;
	Thu, 12 Jun 2014 15:39:20 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute5.internal (MEProxy); Thu, 12 Jun 2014 15:39:20 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=calebthompson.io;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references; s=
	mesmtp; bh=+fM+AD7KQtGQuWcP3jrmL7PET6w=; b=YWMPU61Hwal8eww6VeUvy
	U24IunTv/ZaY3M6g7cApF4J/QC++7ohJk7XPuE2TjrZsEY4pXORVzdRxXqmJG7v0
	KQqGEU4HKvZfeXC5ud3UnTK4DknWkptK0rIAhaIy9Ff3LOF0FycUJ8y5kGQLfViX
	aWILXFI0MQI02IWnsrILao=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references; s=smtpout; bh=+fM+AD7KQtGQuWcP3jrmL7PET
	6w=; b=B7W+yzlb4g0D0tYvtjqQLfuoaSrZIk24XkeD6tPUhdg2BIphCGLkcVWhh
	zNJ+HQu9wlQzC0tnh1dPFNky0Jwa4OFF86Gk2a2JoF3+eV/UPjthh4zLv71jCyBD
	RzqHYQGGU/KHBuN3ienD77P8Z0rSMGpbPvBMCqVbH13fhHCdSo=
X-Sasl-enc: qbjVJo6Jxvm7e6TVfLhHkrWpLHaNHkCPuHxIaWZ8+pFg 1402601959
Received: from localhost.localdomain (unknown [67.78.97.126])
	by mail.messagingengine.com (Postfix) with ESMTPA id E820E680156;
	Thu, 12 Jun 2014 15:39:18 -0400 (EDT)
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1402601942-45553-1-git-send-email-caleb@calebthompson.io>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251487>

Use write_script from t/test-lib-functions.sh instead of cat, shebang,
and chmod. This protects us from potential shell meta-characters in the
name of our trash directory, which would be interpreted if we set
$EDITOR directly.

Signed-off-by: Caleb Thompson <caleb@calebthompson.io>
---
 t/t7507-commit-verbose.sh | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/t/t7507-commit-verbose.sh b/t/t7507-commit-verbose.sh
index 6d778ed..db09107 100755
--- a/t/t7507-commit-verbose.sh
+++ b/t/t7507-commit-verbose.sh
@@ -3,11 +3,9 @@
 test_description='verbose commit template'
 . ./test-lib.sh
 
-cat >check-for-diff <<EOF
-#!$SHELL_PATH
-exec grep '^diff --git' "\$1"
+write_script check-for-diff <<-'EOF'
+	exec grep '^diff --git' "$1"
 EOF
-chmod +x check-for-diff
 test_set_editor "$PWD/check-for-diff"
 
 cat >message <<'EOF'
-- 
2.0.0
