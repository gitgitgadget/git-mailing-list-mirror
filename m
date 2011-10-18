From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: [PATCH] inet_ntop.c: Work around GCC 4.6's detection of uninitialized
 variables
Date: Tue, 18 Oct 2011 18:25:50 +0200
Message-ID: <4E9DA88E.40500@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, mschub@elegosoft.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 18 18:28:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGCWC-00040K-KE
	for gcvg-git-2@lo.gmane.org; Tue, 18 Oct 2011 18:27:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933202Ab1JRQ1v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Oct 2011 12:27:51 -0400
Received: from lo.gmane.org ([80.91.229.12]:58737 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932353Ab1JRQ1u (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Oct 2011 12:27:50 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1RGCW6-0003wg-3Z
	for git@vger.kernel.org; Tue, 18 Oct 2011 18:27:50 +0200
Received: from jambul.zib.de ([130.73.68.203])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 18 Oct 2011 18:27:50 +0200
Received: from sschuberth by jambul.zib.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 18 Oct 2011 18:27:50 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: jambul.zib.de
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183886>

GCC 4.6 claims that

    error: 'best.len' may be used uninitialized in this function

so silence that warning which is treated as an error by also initializing
the "len" members of the struct.

Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
---
 compat/inet_ntop.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/compat/inet_ntop.c b/compat/inet_ntop.c
index ea249c6..60b5a1d 100644
--- a/compat/inet_ntop.c
+++ b/compat/inet_ntop.c
@@ -98,7 +98,9 @@ inet_ntop6(const u_char *src, char *dst, size_t size)
 	for (i = 0; i < NS_IN6ADDRSZ; i++)
 		words[i / 2] |= (src[i] << ((1 - (i % 2)) << 3));
 	best.base = -1;
+	best.len = 0;
 	cur.base = -1;
+	cur.len = 0;
 	for (i = 0; i < (NS_IN6ADDRSZ / NS_INT16SZ); i++) {
 		if (words[i] == 0) {
 			if (cur.base == -1)
-- 
1.7.7.msysgit.1
