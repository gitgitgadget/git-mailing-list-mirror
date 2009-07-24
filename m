From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH/RFC] SunOS grep does not understand -C<n>
Date: Thu, 23 Jul 2009 22:30:07 -0700
Message-ID: <7vr5w6tzq8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 24 07:30:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUDMN-0000Ba-Pv
	for gcvg-git-2@gmane.org; Fri, 24 Jul 2009 07:30:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751393AbZGXFaN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2009 01:30:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751334AbZGXFaN
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jul 2009 01:30:13 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:48992 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751257AbZGXFaM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2009 01:30:12 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 401B8F3E2;
	Fri, 24 Jul 2009 01:30:11 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 85FFFF3E0; Fri, 24 Jul 2009
 01:30:09 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0E98EB16-7813-11DE-9193-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123901>

I noticed that the first "grep -C1" test in t7002 does not pass on my 
SunOS-5.11-i86pc, and that is not because our way to spawn external
grep is broken, but because the native grep does not understand -C<n>.

Is it just me and my installation (i.e. I might have failed to install
saner grep from the distribution that everybody uses), or everybody on
SunOS is using this option himself because our Makefile doesn't do that
automatically for them?

Just in case it is the latter, here is a proposed patch.

---
 Makefile |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index bde27ed..daf4296 100644
--- a/Makefile
+++ b/Makefile
@@ -728,6 +728,7 @@ ifeq ($(uname_S),SunOS)
 	NO_MKDTEMP = YesPlease
 	NO_MKSTEMPS = YesPlease
 	NO_REGEX = YesPlease
+	NO_EXTERNAL_GREP = YesPlease
 	ifeq ($(uname_R),5.7)
 		NEEDS_RESOLV = YesPlease
 		NO_IPV6 = YesPlease
