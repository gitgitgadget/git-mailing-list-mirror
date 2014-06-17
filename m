From: Caleb Thompson <caleb@calebthompson.io>
Subject: [PATCH v6 2/4] commit test: Use write_script
Date: Tue, 17 Jun 2014 14:38:58 -0500
Message-ID: <fa7260f688bccac09138c8ef5ef1982cee0f0dde.1403033723.git.caleb@calebthompson.io>
References: <cover.1403033723.git.caleb@calebthompson.io>
Cc: Jeff King <peff@peff.net>, Jeremiah Mahler <jmmahler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 17 21:39:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwzE9-0007ID-Ab
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jun 2014 21:39:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756489AbaFQTjY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2014 15:39:24 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:52250 "EHLO
	new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933049AbaFQTjV (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Jun 2014 15:39:21 -0400
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 4477A692;
	Tue, 17 Jun 2014 15:39:21 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute5.internal (MEProxy); Tue, 17 Jun 2014 15:39:21 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=calebthompson.io;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references; s=mesmtp; bh=6w5QIMsMCRmK/TcW0zMyTPQlje
	o=; b=AslKiWiX/XfTsI7hIpvm7NC0uj8sTdd8wIRhNQucTzSnq7ucjSMoWAgCf5
	Z/n0wA8I0iK6hJNOlMhxjXfIIPi8tHO5XonqrR5Z8etIGHm0ph2xC4GPlMY1711C
	FNfFtV56+RA7OqgHVK9j8EmGO5g8jOHqMzDs5DeUT8ws6lFds=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:in-reply-to:references; s=smtpout; bh=6w
	5QIMsMCRmK/TcW0zMyTPQljeo=; b=a3ZKEtwzfPCQNz+N9JOjy4Mup0JMYGhSM8
	dtkGb0DzSIW9ZEDN+ZN3eIC1WDSXFXwyuZ4LIkjuf4y1sx9cXbQCDy9AyS9p++Ug
	dO8SCIFBmS0zPw7BZpWWPhIUNNNYeoPQ/raoBKe6mLzvrpGeQE+YOAb6ijO7z/wW
	1z/AiPHqw=
X-Sasl-enc: rpVN6IkAbiQYWkmDi81egJLUQWqK7XfLxfbbI+gtjcuu 1403033951
Received: from localhost.localdomain (unknown [67.78.97.126])
	by mail.messagingengine.com (Postfix) with ESMTPA id 9D53CC007B8;
	Tue, 17 Jun 2014 15:39:11 -0400 (EDT)
X-Mailer: git-send-email 2.0.0
In-Reply-To: <cover.1403033723.git.caleb@calebthompson.io>
In-Reply-To: <cover.1403033723.git.caleb@calebthompson.io>
References: <cover.1403033723.git.caleb@calebthompson.io>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251940>

Use write_script from t/test-lib-functions.sh instead of cat, shebang,
and chmod. This aids in readability for creating the script by using the
named function and allows us to turn off interpolation in the heredoc of
the script body to avoid extra escaping, since $SHELL_PATH is handled
for us.

Signed-off-by: Caleb Thompson <caleb@calebthompson.io>
Reviewed-by: Jeremiah Mahler <jmmahler@gmail.com>
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
