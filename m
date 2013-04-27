From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 3/6] compat/regex/regexec.c: Fix some sparse warnings
Date: Sat, 27 Apr 2013 19:43:05 +0100
Message-ID: <517C1C39.2060508@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 27 21:46:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWB4p-0008A7-Kc
	for gcvg-git-2@plane.gmane.org; Sat, 27 Apr 2013 21:46:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756266Ab3D0TqZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Apr 2013 15:46:25 -0400
Received: from mdfmta009.mxout.tbr.inty.net ([91.221.168.50]:33041 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756340Ab3D0TqY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Apr 2013 15:46:24 -0400
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id 474ED384084;
	Sat, 27 Apr 2013 20:46:23 +0100 (BST)
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id 9B8AC38407C;
	Sat, 27 Apr 2013 20:46:22 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP;
	Sat, 27 Apr 2013 20:46:22 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
X-MDF-HostID: 4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222666>


Sparse issues an "Using plain integer as NULL pointer" warning along
with two "symbol was not declared. Should it be static?" type warnings
for the 'merge_state_with_log' and 'find_recover_state' functions.

In order to suppress the warnings, we replace the use of '0' as a null
pointer constant with NULL and add the static modifier to the function
definitions.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 compat/regex/regexec.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/compat/regex/regexec.c b/compat/regex/regexec.c
index 0194965..0cd6e0e 100644
--- a/compat/regex/regexec.c
+++ b/compat/regex/regexec.c
@@ -2313,7 +2313,7 @@ transit_state (reg_errcode_t *err, re_match_context_t *mctx,
 }
 
 /* Update the state_log if we need */
-re_dfastate_t *
+static re_dfastate_t *
 internal_function
 merge_state_with_log (reg_errcode_t *err, re_match_context_t *mctx,
 		      re_dfastate_t *next_state)
@@ -2326,7 +2326,7 @@ merge_state_with_log (reg_errcode_t *err, re_match_context_t *mctx,
       mctx->state_log[cur_idx] = next_state;
       mctx->state_log_top = cur_idx;
     }
-  else if (mctx->state_log[cur_idx] == 0)
+  else if (mctx->state_log[cur_idx] == NULL)
     {
       mctx->state_log[cur_idx] = next_state;
     }
@@ -2392,7 +2392,7 @@ merge_state_with_log (reg_errcode_t *err, re_match_context_t *mctx,
 /* Skip bytes in the input that correspond to part of a
    multi-byte match, then look in the log for a state
    from which to restart matching.  */
-re_dfastate_t *
+static re_dfastate_t *
 internal_function
 find_recover_state (reg_errcode_t *err, re_match_context_t *mctx)
 {
-- 
1.8.2
