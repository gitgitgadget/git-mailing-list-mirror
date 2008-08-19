From: Jim Meyering <meyering@redhat.com>
Subject: [PATCH] * remote.c (valid_fetch_refspec): remove useless if-before-free test
Date: Tue, 19 Aug 2008 20:46:30 +0200
Message-ID: <87k5ecx2pl.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 19 20:47:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVWF5-000409-Ph
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 20:47:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753128AbYHSSqd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 14:46:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750916AbYHSSqc
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 14:46:32 -0400
Received: from smtp6-g19.free.fr ([212.27.42.36]:36099 "EHLO smtp6-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751171AbYHSSqc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 14:46:32 -0400
Received: from smtp6-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp6-g19.free.fr (Postfix) with ESMTP id CD2161979D
	for <git@vger.kernel.org>; Tue, 19 Aug 2008 20:46:30 +0200 (CEST)
Received: from mx.meyering.net (mx.meyering.net [82.230.74.64])
	by smtp6-g19.free.fr (Postfix) with ESMTP id A35F417233
	for <git@vger.kernel.org>; Tue, 19 Aug 2008 20:46:30 +0200 (CEST)
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id 8640338BA4; Tue, 19 Aug 2008 20:46:30 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92898>

We removed a handful of these useless if-before-free tests
several months ago.  This change removes a new one that snuck back in.

Signed-off-by: Jim Meyering <meyering@redhat.com>
---
There are four in regex.c, too, but that's imported code,
so probably not worth modifying in git:

    compat/regex.c: if (var) free (var)
    compat/regex.c: if (preg->buffer != NULL)
        free (preg->buffer)
    compat/regex.c: if (preg->fastmap != NULL)
        free (preg->fastmap)
    compat/regex.c: if (preg->translate != NULL)
        free (preg->translate)

 remote.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/remote.c b/remote.c
index f61a3ab..105668f 100644
--- a/remote.c
+++ b/remote.c
@@ -579,8 +579,7 @@ int valid_fetch_refspec(const char *fetch_refspec_str)
 	struct refspec *refspec;

 	refspec = parse_refspec_internal(1, fetch_refspec, 1, 1);
-	if (refspec)
-		free(refspec);
+	free(refspec);
 	return !!refspec;
 }

--
1.6.0.9.gae2e487
