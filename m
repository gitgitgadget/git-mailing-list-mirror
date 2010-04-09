From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH] Let check_preimage() use memset() to initialize "struct checkout"
Date: Fri, 09 Apr 2010 22:08:35 +0200
Message-ID: <4BBF8943.40407@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 09 22:08:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0KVO-0004mP-8l
	for gcvg-git-2@lo.gmane.org; Fri, 09 Apr 2010 22:08:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756505Ab0DIUIh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Apr 2010 16:08:37 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:35463 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754373Ab0DIUIg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Apr 2010 16:08:36 -0400
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate02.web.de (Postfix) with ESMTP id 8043E15D59DB5;
	Fri,  9 Apr 2010 22:08:35 +0200 (CEST)
Received: from [80.128.86.62] (helo=[192.168.178.26])
	by smtp08.web.de with asmtp (WEB.DE 4.110 #4)
	id 1O0KVH-0004ms-00; Fri, 09 Apr 2010 22:08:35 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX19+ybG3bB0olSZq8pry7VGIJ3e7VdYxH0IS0zU/
	ekU1kpxraMEkCCEyrD5jP13OcH3ur8RsfLTR7cqCPHqSlLXIcv
	F9MuIDEUJ+GIJff94F9g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144466>

Every code site except check_preimage() uses either memset() or declares
a static instance of "struct checkout" to achieve proper initialization.
Lets use memset() instead of explicit initialization of all members here
too to be on the safe side in case this structure is expanded someday.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---

 builtin/apply.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index ec755ac..d56cabf 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -2821,11 +2821,8 @@ static int check_preimage(struct patch *patch, struct cache_entry **ce, struct s
 		if (stat_ret < 0) {
 			struct checkout costate;
 			/* checkout */
+			memset(&costate, 0, sizeof(costate));
 			costate.base_dir = "";
-			costate.base_dir_len = 0;
-			costate.force = 0;
-			costate.quiet = 0;
-			costate.not_new = 0;
 			costate.refresh_cache = 1;
 			if (checkout_entry(*ce, &costate, NULL) ||
 			    lstat(old_name, st))
-- 
1.7.0.3.517.g0017
