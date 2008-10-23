From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] index-pack: don't leak leaf delta result
Date: Thu, 23 Oct 2008 15:05:59 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0810231502250.26244@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 23 21:08:18 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kt5XR-0006Np-4U
	for gcvg-git-2@gmane.org; Thu, 23 Oct 2008 21:08:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757107AbYJWTGx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Oct 2008 15:06:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756895AbYJWTGx
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Oct 2008 15:06:53 -0400
Received: from relais.videotron.ca ([24.201.245.36]:24402 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756575AbYJWTGw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Oct 2008 15:06:52 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K97009NRH1Z30PJ@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 23 Oct 2008 15:05:59 -0400 (EDT)
X-X-Sender: nico@xanadu.home
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98983>

Another (but minor this time) fallout from commit 9441b61dc5.

Signed-off-by: Nicolas Pitre <nico@cam.org>

diff --git a/index-pack.c b/index-pack.c
index 7f97faa..fe75332 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -550,8 +550,10 @@ static void find_unresolved_deltas(struct base_data *base,
 		find_delta_children(&base_spec, &ofs_first, &ofs_last);
 	}
 
-	if (ref_last == -1 && ofs_last == -1)
+	if (ref_last == -1 && ofs_last == -1) {
+		free(base->data);
 		return;
+	}
 
 	link_base_data(prev_base, base);
 


Nicolas
