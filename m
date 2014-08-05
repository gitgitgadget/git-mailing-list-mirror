From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH] cache.h: add missing NORETURN on git_die_config*()
Date: Tue, 05 Aug 2014 14:57:52 +0100
Message-ID: <53E0E2E0.2070709@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 05 15:58:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XEfFg-0008GS-9h
	for gcvg-git-2@plane.gmane.org; Tue, 05 Aug 2014 15:58:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753040AbaHEN6D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Aug 2014 09:58:03 -0400
Received: from mdfmta005.mxout.tch.inty.net ([91.221.169.46]:44462 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752530AbaHEN6C (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Aug 2014 09:58:02 -0400
Received: from mdfmta005.tch.inty.net (unknown [127.0.0.1])
	by mdfmta005.tch.inty.net (Postfix) with ESMTP id 27E4518CC80;
	Tue,  5 Aug 2014 14:58:12 +0100 (BST)
Received: from mdfmta005.tch.inty.net (unknown [127.0.0.1])
	by mdfmta005.tch.inty.net (Postfix) with ESMTP id CA04718CCD3;
	Tue,  5 Aug 2014 14:58:11 +0100 (BST)
Received: from [192.168.254.10] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mdfmta005.tch.inty.net (Postfix) with ESMTP;
	Tue,  5 Aug 2014 14:58:11 +0100 (BST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:31.0) Gecko/20100101 Thunderbird/31.0
X-MDF-HostID: 18
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254804>


Commit 3a2a9527 ("config: add `git_die_config()` to the config-set
API", 01-08-2014) added git_die_config() and git_die_config_linenr()
functions, but forgot to include the NORETURN attribute in their
declarations. Sparse complains like so:

        SP config.c
    config.c:1567:6: error: symbol 'git_die_config_linenr' redeclared \
        with different type (originally declared at cache.h:1419) \
        - different modifiers
    config.c:1579:6: error: symbol 'git_die_config' redeclared with \
        different type (originally declared at cache.h:1418) \
        - different modifiers

Suppress the sparse errors by adding NORETURN to the function
declarations in the cache.h header file.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Hi Tanay,

If you need to re-roll the patches in the 'ta/config-set-1' branch,
could you please squash this into the relevant patch. Thanks!

At present there are no callers outside of config.c (but that will
change right!;-), but since three of the four call sights for these
functions appear _before_ the definitions, only a single call could
possibly benefit from the NORETURN (line 1585).

HTH

ATB,
Ramsay Jones


 cache.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/cache.h b/cache.h
index 9faea51..d82a5c3 100644
--- a/cache.h
+++ b/cache.h
@@ -1415,8 +1415,8 @@ extern int git_config_get_bool(const char *key, int *dest);
 extern int git_config_get_bool_or_int(const char *key, int *is_bool, int *dest);
 extern int git_config_get_maybe_bool(const char *key, int *dest);
 extern int git_config_get_pathname(const char *key, const char **dest);
-extern void git_die_config(const char *key);
-extern void git_die_config_linenr(const char *key, const char *filename, int linenr);
+extern NORETURN void git_die_config(const char *key);
+extern NORETURN void git_die_config_linenr(const char *key, const char *filename, int linenr);
 
 extern int committer_ident_sufficiently_given(void);
 extern int author_ident_sufficiently_given(void);
-- 
2.0.0
