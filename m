From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] We do not like "HEAD" as a new branch name
Date: Fri, 16 Dec 2005 02:40:25 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0512160238300.6530@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0512151244230.22400@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vacf2p320.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0512152339530.4962@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v4q5alyms.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 16 02:41:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1En4aN-00047g-3S
	for gcvg-git@gmane.org; Fri, 16 Dec 2005 02:40:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751276AbVLPBk3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Dec 2005 20:40:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751275AbVLPBk3
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Dec 2005 20:40:29 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:34009 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751274AbVLPBk0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Dec 2005 20:40:26 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id CE77C13F951; Fri, 16 Dec 2005 02:40:25 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id B047C9DEA1; Fri, 16 Dec 2005 02:40:25 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 9596E9B2A4; Fri, 16 Dec 2005 02:40:25 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 8022413F951; Fri, 16 Dec 2005 02:40:25 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v4q5alyms.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13726>

Hi,

On Thu, 15 Dec 2005, Junio C Hamano wrote:

> Just to futureproof ourselves, how about this?
> 
> 	/^(?:.*/)?(?:[A-Z0-9]+_)?HEAD$/
> 
> The last path component being "HEAD" or capital-or-digit
> followed by underscore followed by "HEAD".

Okay. Why not go the full nine yards, and not be difficult about it:

diff --git a/refs.c b/refs.c
--- a/refs.c
+++ b/refs.c
@@ -345,6 +345,11 @@ int check_ref_format(const char *ref)
 		if (!ch) {
 			if (level < 2)
 				return -1; /* at least of form "heads/blah" */
+
+			/* do not allow ref name to end in "HEAD" */
+			if (cp - ref > 4 && !strcmp(cp - 4, "HEAD"))
+				return -1;
+
 			return 0;
 		}
 	}

Ciao,
Dscho
