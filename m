From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 6/9] gettext.h: Avoid using a non-standard C construct
Date: Thu, 07 Apr 2011 19:41:48 +0100
Message-ID: <4D9E056C.1070906@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>, bebarino@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 07 20:53:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7uKu-00059q-CK
	for gcvg-git-2@lo.gmane.org; Thu, 07 Apr 2011 20:53:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756658Ab1DGSxj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2011 14:53:39 -0400
Received: from anchor-post-3.mail.demon.net ([195.173.77.134]:48594 "EHLO
	anchor-post-3.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756628Ab1DGSxj (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Apr 2011 14:53:39 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-3.mail.demon.net with esmtp (Exim 4.69)
	id 1Q7uKn-0001Ry-pV; Thu, 07 Apr 2011 18:53:38 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171073>


In particular, standard C does not allow a parenthesized string
as an array initializer. Some compilers, for example GCC and MSVC,
allow this syntax as an extension, but it is (obviously) not a
portable construct.

In order to avoid such a construct, for example while initialising
the array 'ignore_error' (builtin/add.c line 309), we simply
remove the parenthesis from the definition of the N_() macro.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

For example, tcc can not parse this syntax.

Note that sparse issues warnings like the following:
    builtin/add.c:309:1: warning: too long initializer-string for \
        array of char
which is actually a bug in sparse that is tickled by a parenthesized
string initializer (it doesn't determine the correct size of the
string). Again I have a patch ...

 gettext.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gettext.h b/gettext.h
index 1b253b7..24d9182 100644
--- a/gettext.h
+++ b/gettext.h
@@ -35,6 +35,6 @@ const char *Q_(const char *msgid, const char *plu, unsigned long n)
 }
 
 /* Mark msgid for translation but do not translate it. */
-#define N_(msgid) (msgid)
+#define N_(msgid) msgid
 
 #endif
-- 
1.7.4
