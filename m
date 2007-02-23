From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-bundle: assorted fixes
Date: Fri, 23 Feb 2007 02:56:31 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702230249340.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0702220157130.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.63.0702221913250.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45DE4507.7090206@verizon.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, junkio@cox.net, Nicolas Pitre <nico@cam.org>,
	Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
To: Mark Levedahl <mdl123@verizon.net>
X-From: git-owner@vger.kernel.org Fri Feb 23 02:56:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKPfs-00052H-TR
	for gcvg-git@gmane.org; Fri, 23 Feb 2007 02:56:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751546AbXBWB4e (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Feb 2007 20:56:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752126AbXBWB4e
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Feb 2007 20:56:34 -0500
Received: from mail.gmx.net ([213.165.64.20]:53756 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751546AbXBWB4d (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Feb 2007 20:56:33 -0500
Received: (qmail invoked by alias); 23 Feb 2007 01:56:31 -0000
X-Provags-ID: V01U2FsdGVkX191sc1zOlt11YpItAk0O4+QaSSXPBHg4z5bN46Y/g
	VfLw==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <45DE4507.7090206@verizon.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40407>

Hi,

On Thu, 22 Feb 2007, Mark Levedahl wrote:

> Johannes Schindelin wrote:
> 
> I built this under cygwin, it is running but I find two regressions compared
> to my git-bundle.sh:
> 
> 1) git bundle create --all  <whatever>

Are you sure you did not provide a bundle filename?

But indeed, my test shows that "--all" does not leave any refs. Bad.

This fixes it:

-- snip --
 revision.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/revision.c b/revision.c
index 4cf697e..823bbd1 100644
--- a/revision.c
+++ b/revision.c
@@ -480,7 +480,7 @@ static int handle_one_ref(const char *path, const unsigned char *sha1, int flag,
 	struct all_refs_cb *cb = cb_data;
 	struct object *object = get_reference(cb->all_revs, path, sha1,
 					      cb->all_flags);
-	add_pending_object(cb->all_revs, object, "");
+	add_pending_object(cb->all_revs, object, path);
 	return 0;
 }
-- snap --

but I think this adds a memory leak, and I don't know what else is 
affected by it.
 
> 2) git bundle verify  reports only a single sha1 if prerequisites are not
> met.

With the two follow-up patches I sent, this issue should be resolved, no?

Ciao,
Dscho
