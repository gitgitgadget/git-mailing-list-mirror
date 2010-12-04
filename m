From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 03/14] msvc: Fix build by adding missing INTMAX_MAX define
Date: Sat, 04 Dec 2010 18:57:30 +0000
Message-ID: <4CFA8F1A.3040402@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j6t@kdbg.org>,
	GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 04 21:38:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POysi-0000Ke-9R
	for gcvg-git-2@lo.gmane.org; Sat, 04 Dec 2010 21:38:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755811Ab0LDUia (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Dec 2010 15:38:30 -0500
Received: from anchor-post-2.mail.demon.net ([195.173.77.133]:63294 "EHLO
	anchor-post-2.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753477Ab0LDUia (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Dec 2010 15:38:30 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-2.mail.demon.net with esmtp (Exim 4.69)
	id 1POysG-0005ZU-mM; Sat, 04 Dec 2010 20:38:29 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162902>


Commit c03c831 (do not depend on signed integer overflow,
05-10-2010) provokes an msvc build failure. The cause of the
failure is a missing definition of the INTMAX_MAX constant,
used in the new maximum_signed_value_of_type(a) macro, which
would normally be defined in the C99 <stdint.h> header file.

In order the fix the compilation error, we add an appropriate
definition of the INTMAX_MAX constant, along with INTMAX_MIN
and UINTMAX_MAX, to an msvc compat header file.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 compat/vcbuild/include/unistd.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/compat/vcbuild/include/unistd.h b/compat/vcbuild/include/unistd.h
index 2a4f276..b14fcf9 100644
--- a/compat/vcbuild/include/unistd.h
+++ b/compat/vcbuild/include/unistd.h
@@ -45,6 +45,10 @@ typedef unsigned long long uintmax_t;
 
 typedef int64_t off64_t;
 
+#define INTMAX_MIN  _I64_MIN
+#define INTMAX_MAX  _I64_MAX
+#define UINTMAX_MAX _UI64_MAX
+
 #define STDOUT_FILENO 1
 #define STDERR_FILENO 2
 
-- 
1.7.3
