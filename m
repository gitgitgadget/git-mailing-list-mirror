From: Robert Schiele <rschiele@gmail.com>
Subject: [PATCH] add definitions for global variables to shell.c
Date: Mon, 18 Aug 2008 14:37:27 +0200
Message-ID: <20080818123727.GB11842@schiele.dyndns.org>
Reply-To: Robert Schiele <rschiele@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 18 14:38:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KV40J-0002N7-SM
	for gcvg-git-2@gmane.org; Mon, 18 Aug 2008 14:38:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751921AbYHRMhb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2008 08:37:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752028AbYHRMhb
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Aug 2008 08:37:31 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:15836 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751072AbYHRMha (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2008 08:37:30 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1635714fgg.17
        for <git@vger.kernel.org>; Mon, 18 Aug 2008 05:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:to:cc:subject
         :message-id:mime-version:content-type:content-disposition:user-agent
         :from:reply-to;
        bh=E65OwRYTvFlv+RxC9zMO9GwyuJzrHfJQY7kOiFqzrs8=;
        b=eZAy7ERUGvts3gQXNa+zl6q4XCWHInM87mpHPmrvintbdGFTIApBu6owNqBTg3/Eww
         k/iDv5v+WNlDrtbOeriL9NAJnykXVENAWUlwqmlABODfq5ps7nR3F8OnEWJk0hiEE16w
         mvjUoEoRESxpo+KuBA99iw2Jsnf0PQm2rS60s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent:from:reply-to;
        b=u4Er6E3TW/BVPzHB+TaxBFP2t3gPhAJ2IzHuH+CqAiXpztnZ3jVRMAhh/mlNUBdf69
         SSgy4y4et/SHHmtA9zYw7GuDYiWmk3F6JOMMNlgBrXIkTAXBKLjUZkxp34DlYj8vdreq
         +fIdutjDHuV1g3imB2OoTEZihwzT4Dkx5gUXk=
Received: by 10.86.23.17 with SMTP id 17mr4537176fgw.44.1219063048748;
        Mon, 18 Aug 2008 05:37:28 -0700 (PDT)
Received: from sigkill.schiele.dyndns.org ( [91.18.110.73])
        by mx.google.com with ESMTPS id 12sm11165616fgg.0.2008.08.18.05.37.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 18 Aug 2008 05:37:28 -0700 (PDT)
Received: by sigkill.schiele.dyndns.org (Postfix, from userid 1000)
	id 989091604F; Mon, 18 Aug 2008 14:37:27 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92702>

Commit 5b8e6f85 introduced stubs for three functions that make no sense
for git-shell.  But those stubs defined libgit.a functions a second time
so that a linker can complain.  While commit 78568448 fixes this problem
it introduces a new issue on the affected systems: Some versions of the
Sun compiler generate references to global variables when they see
extern declarations for those, even when they are never used in the
code.

This patch does a similar workaround for this problem as commit 5b8e6f85
did for the functions.

Signed-off-by: Robert Schiele <rschiele@gmail.com>
---
 shell.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/shell.c b/shell.c
index 6a48de0..8902ea5 100644
--- a/shell.c
+++ b/shell.c
@@ -3,12 +3,17 @@
 #include "exec_cmd.h"
 #include "strbuf.h"
 
-/* Stubs for functions that make no sense for git-shell. These stubs
- * are provided here to avoid linking in external redundant modules.
+/* Stubs for functions and external variables that make no sense for
+ * git-shell. These stubs are provided here to avoid linking in
+ * external redundant modules.
  */
 void release_pack_memory(size_t need, int fd){}
 void trace_argv_printf(const char **argv, const char *fmt, ...){}
 void trace_printf(const char *fmt, ...){}
+int trust_executable_bit;
+const unsigned char null_sha1[20];
+const signed char hexval_table[256];
+int has_symlinks;
 
 
 static int do_generic_cmd(const char *me, char *arg)
-- 
1.5.4.5
