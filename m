From: Adrian Johnson <ajohnson@redneon.com>
Subject: [PATCH v2] userdiff: update Ada patterns
Date: Mon, 03 Feb 2014 22:03:16 +1030
Message-ID: <52EF7E7C.3070504@redneon.com>
References: <52EE234C.1060002@redneon.com> <20140202233531.GE16196@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 03 12:33:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAHmE-0002kF-Vw
	for gcvg-git-2@plane.gmane.org; Mon, 03 Feb 2014 12:33:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751949AbaBCLdT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Feb 2014 06:33:19 -0500
Received: from redneon.com ([66.221.1.90]:56859 "EHLO redneon.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751030AbaBCLdS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Feb 2014 06:33:18 -0500
Received: from bearcat.lan (ppp121-45-65-240.lns20.adl6.internode.on.net [121.45.65.240])
	by redneon.com (Postfix) with ESMTPA id 47E8753C10C8
	for <git@vger.kernel.org>; Mon,  3 Feb 2014 22:03:18 +1030 (CST)
Received: from [192.168.1.1] (bearcat.lan [192.168.1.1])
	by bearcat.lan (Postfix) with ESMTP id 7514A4C8D0
	for <git@vger.kernel.org>; Mon,  3 Feb 2014 22:03:16 +1030 (CST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <20140202233531.GE16196@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241425>

- Allow extra space in "is new" and "is separate"
- Fix bug in word regex for numbers

Signed-off-by: Adrian Johnson <ajohnson@redneon.com>
---
 t/t4034/ada/expect | 2 +-
 userdiff.c         | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t4034/ada/expect b/t/t4034/ada/expect
index be2376e..a682d28 100644
--- a/t/t4034/ada/expect
+++ b/t/t4034/ada/expect
@@ -4,7 +4,7 @@
 <BOLD>+++ b/post<RESET>
 <CYAN>@@ -1,13 +1,13 @@<RESET>
 Ada.Text_IO.Put_Line("Hello World<RED>!<RESET><GREEN>?<RESET>");
-1 1e<RED>-<RESET>10 16#FE12#E2 3.141_592 '<RED>x<RESET><GREEN>y<RESET>'
+1 <RED>1e-10<RESET><GREEN>1e10<RESET> 16#FE12#E2 3.141_592 '<RED>x<RESET><GREEN>y<RESET>'
 <RED>a<RESET><GREEN>x<RESET>+<RED>b a<RESET><GREEN>y x<RESET>-<RED>b<RESET>
 <RED>a<RESET><GREEN>y<RESET>
 <GREEN>x<RESET>*<RED>b a<RESET><GREEN>y x<RESET>/<RED>b<RESET>
diff --git a/userdiff.c b/userdiff.c
index ea43a03..10b61ec 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -15,13 +15,13 @@ static int drivers_alloc;
 	  word_regex "|[^[:space:]]|[\xc0-\xff][\x80-\xbf]+" }
 static struct userdiff_driver builtin_drivers[] = {
 IPATTERN("ada",
-	 "!^(.*[ \t])?(is new|renames|is separate)([ \t].*)?$\n"
+	 "!^(.*[ \t])?(is[ \t]+new|renames|is[ \t]+separate)([ \t].*)?$\n"
 	 "!^[ \t]*with[ \t].*$\n"
 	 "^[ \t]*((procedure|function)[ \t]+.*)$\n"
 	 "^[ \t]*((package|protected|task)[ \t]+.*)$",
 	 /* -- */
 	 "[a-zA-Z][a-zA-Z0-9_]*"
-	 "|[0-9][-+0-9#_.eE]"
+	 "|[-+]?[0-9][0-9#_.aAbBcCdDeEfF]*([eE][+-]?[0-9_]+)?"
 	 "|=>|\\.\\.|\\*\\*|:=|/=|>=|<=|<<|>>|<>"),
 IPATTERN("fortran",
 	 "!^([C*]|[ \t]*!)\n"
-- 
1.8.3.2
