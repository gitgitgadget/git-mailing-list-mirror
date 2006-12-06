X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git UI nit
Date: Wed, 6 Dec 2006 15:46:46 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612061546190.28348@wbgn013.biozentrum.uni-wuerzburg.de>
References: <el6jmt$mej$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Wed, 6 Dec 2006 14:47:03 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <el6jmt$mej$1@sea.gmane.org>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33461>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gry2u-0004WM-Bs for gcvg-git@gmane.org; Wed, 06 Dec
 2006 15:46:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1760662AbWLFOqt (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 09:46:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760664AbWLFOqt
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 09:46:49 -0500
Received: from mail.gmx.net ([213.165.64.20]:51229 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S1760662AbWLFOqs
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec 2006 09:46:48 -0500
Received: (qmail invoked by alias); 06 Dec 2006 14:46:46 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp010) with SMTP; 06 Dec 2006 15:46:46 +0100
To: Han-Wen Nienhuys <hanwen@xs4all.nl>
Sender: git-owner@vger.kernel.org

Hi,

On Wed, 6 Dec 2006, Han-Wen Nienhuys wrote:

> 
> When merging changes into a dirty working copy, one may get 
> 
> ..
> Updating 62a005d..7bbd698
> Makefile: needs update
> README: needs update
> config.mak.in: needs update
> configure.ac: needs update
> fatal: Entry 'Makefile' not uptodate. Cannot merge.
> ..
> 
> 
> This is bad error message; "uptodate" suggests that Makefile is too old. 
> The problem is the reverse.  The Makefile has been
> edited and hence it is 'newer'.  

Something like this?

-- snip --
[PATCH] Replace "needs update" by "dirty; needs commit"

This should clarify why a merge was not even started.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

 read-cache.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index eae4745..0d22de2 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -721,7 +721,7 @@ int refresh_cache(unsigned int flags)
 			}
 			if (quiet)
 				continue;
-			printf("%s: needs update\n", ce->name);
+			printf("%s: dirty; needs commit\n", ce->name);
 			has_errors = 1;
 			continue;
