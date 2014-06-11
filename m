From: "" <caleb@calebthompson.io>
Subject: [PATCH v4 2/4] commit test: Use write_script
Date: Wed, 11 Jun 2014 13:24:37 -0500
Message-ID: <1402511079-17735-3-git-send-email-caleb@calebthompson.io>
References: <1402511079-17735-1-git-send-email-caleb@calebthompson.io>
Cc: Jeff King <peff@peff.net>, Jeremiah Mahler <jmmahler@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	David Kastrup <dak@gnu.org>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 11 20:32:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WunKM-0003Zp-MR
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jun 2014 20:32:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754887AbaFKScn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2014 14:32:43 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:58872 "EHLO
	new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753665AbaFKSce (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Jun 2014 14:32:34 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id F2F65637;
	Wed, 11 Jun 2014 14:25:10 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute1.internal (MEProxy); Wed, 11 Jun 2014 14:25:11 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=calebthompson.io;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references; s=
	mesmtp; bh=+fM+AD7KQtGQuWcP3jrmL7PET6w=; b=INeD9wQ/+ZhNj1q+HP6C0
	N5XhFXPnnU8X524IR7jKx6gx1qvfdmyBtfjG7GVWWS8WWGGvzSuE6LycEq4gpMxK
	XguQHoUToFbaTH90DWTqM47kM+YvtZuA2a0zrgR9JmUTGqEdVqNFlu4hjyfpUsfI
	nJMVm/kJLDtC22NMd//7V4=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references; s=smtpout; bh=+fM+AD7KQtGQuWcP3jrmL7PET
	6w=; b=uSU9PfqjiINU53To7iQ92L8VoB1F6L8IdyTSWLq51bGQk1690SwFo3tCl
	w4Ak+IB3ZKzZngeLz6sNkwzpDwMBloAGP/jdZUhy3jmJc2r62bvirzYlQWG6n/Fk
	L88La7N2ZauZJ4/D58kA/nmFV/aM/pGNUNqvrk0j9v9uEztoJM=
X-Sasl-enc: sIqhBPl1L42l81eyKK5sIA0UpRL/kkQpEQn1Y2I9fT/0 1402511110
Received: from localhost.localdomain (unknown [67.78.97.126])
	by mail.messagingengine.com (Postfix) with ESMTPA id 15329680276;
	Wed, 11 Jun 2014 14:25:10 -0400 (EDT)
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1402511079-17735-1-git-send-email-caleb@calebthompson.io>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251378>

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
