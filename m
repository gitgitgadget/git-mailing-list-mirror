From: Krzysztof Mazur <krzysiek@podlesie.net>
Subject: [PATCH 1/5] git-send-email: remove garbage after email address
Date: Thu, 22 Nov 2012 19:12:08 +0100
Message-ID: <1353607932-10436-1-git-send-email-krzysiek@podlesie.net>
References: <7v8v9vrgc9.fsf@alter.siamese.dyndns.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Felipe Balbi <balbi@ti.com>,
	Tomi Valkeinen <tomi.valkeinen@ti.com>,
	Krzysztof Mazur <krzysiek@podlesie.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 22 19:31:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TbbYo-0005mS-9y
	for gcvg-git-2@plane.gmane.org; Thu, 22 Nov 2012 19:31:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752997Ab2KVSbQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2012 13:31:16 -0500
Received: from [93.179.225.50] ([93.179.225.50]:45839 "EHLO shrek.podlesie.net"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752981Ab2KVSbP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2012 13:31:15 -0500
Received: from geronimo.kostuchna.emnet (localhost [127.0.0.1])
	by shrek.podlesie.net (Postfix) with ESMTP id 636E75E5;
	Thu, 22 Nov 2012 19:12:53 +0100 (CET)
X-Mailer: git-send-email 1.8.0.411.g71a7da8
In-Reply-To: <7v8v9vrgc9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210180>

In some cases it's very useful to add some additional information
after email in Cc-list, for instance:

"Cc: Stable kernel <stable@vger.kernel.org> #v3.4 v3.5 v3.6"

Currently the git refuses to add such invalid email to Cc-list,
when the Email::Valid perl module is available or just uses whole line
as the email address.

Now in sanitize_address() everything after the email address is
removed, so the resulting line is correct email address and Email::Valid
validates it correctly.

Signed-off-by: Krzysztof Mazur <krzysiek@podlesie.net>
Tested-by: Felipe Balbi <balbi@ti.com>
---
 git-send-email.perl | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/git-send-email.perl b/git-send-email.perl
index 5a7c29d..9840d0a 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -924,6 +924,10 @@ sub quote_subject {
 # use the simplest quoting being able to handle the recipient
 sub sanitize_address {
 	my ($recipient) = @_;
+
+	# remove garbage after email address
+	$recipient =~ s/(.*>).*$/$1/;
+
 	my ($recipient_name, $recipient_addr) = ($recipient =~ /^(.*?)\s*(<.*)/);
 
 	if (not $recipient_name) {
-- 
1.8.0.393.gcc9701d
