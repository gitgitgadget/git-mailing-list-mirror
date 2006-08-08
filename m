From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] mv: strcat -> strcpy to account for uninitialized memory
Date: Wed, 9 Aug 2006 00:36:35 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0608090031390.1800@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0607261941210.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <17624.55600.423000.61479@lapjr.intranet.kiel.bmiag.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jon Smirl <jonsmirl@gmail.com>, git@vger.kernel.org,
	junkio@cox.net, Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
X-From: git-owner@vger.kernel.org Wed Aug 09 00:36:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GAaBm-0000l9-Vg
	for gcvg-git@gmane.org; Wed, 09 Aug 2006 00:36:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965061AbWHHWgk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 Aug 2006 18:36:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965062AbWHHWgk
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Aug 2006 18:36:40 -0400
Received: from mail.gmx.de ([213.165.64.20]:27031 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S965061AbWHHWgj (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Aug 2006 18:36:39 -0400
Received: (qmail invoked by alias); 08 Aug 2006 22:36:37 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp027) with SMTP; 09 Aug 2006 00:36:37 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Juergen Ruehle <j.ruehle@bmiag.de>
In-Reply-To: <17624.55600.423000.61479@lapjr.intranet.kiel.bmiag.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25095>


At one stage, the code assumed erroneously that the memory was initialized 
to zero.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---

	On Tue, 8 Aug 2006, Juergen Ruehle wrote:

	> This might have been fixed already (my tree is a couple of days old),
	> but the strcat fails for me, because the alloced memory is not
	> cleared.
	> 
	> Johannes Schindelin writes:
	>  > +static const char *add_slash(const char *path)
	>  > +{
	>  > +	int len = strlen(path);
	>  > +	if (path[len - 1] != '/') {
	>  > +		char *with_slash = xmalloc(len + 2);
	>  > +		memcpy(with_slash, path, len);
	>  > +		strcat(with_slash + len, "/");

	Oops. That strcat should be a strcpy, obviously.

 builtin-mv.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-mv.c b/builtin-mv.c
index e47942c..5f57870 100644
--- a/builtin-mv.c
+++ b/builtin-mv.c
@@ -48,7 +48,7 @@ static const char *add_slash(const char 
 	if (path[len - 1] != '/') {
 		char *with_slash = xmalloc(len + 2);
 		memcpy(with_slash, path, len);
-		strcat(with_slash + len, "/");
+		strcpy(with_slash + len, "/");
 		return with_slash;
 	}
 	return path;
-- 
1.4.2.rc3.g6b27-dirty
