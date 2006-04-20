From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] fix pack-object buffer size
Date: Thu, 20 Apr 2006 17:25:37 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0604201718000.2215@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Thu Apr 20 23:25:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FWged-0004Z4-5D
	for gcvg-git@gmane.org; Thu, 20 Apr 2006 23:25:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751321AbWDTVZc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Apr 2006 17:25:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751323AbWDTVZc
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Apr 2006 17:25:32 -0400
Received: from relais.videotron.ca ([24.201.245.36]:22318 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1751321AbWDTVZb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Apr 2006 17:25:31 -0400
Received: from xanadu.home ([74.56.108.184]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0IY100F88I6I03D0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 20 Apr 2006 17:25:30 -0400 (EDT)
X-X-Sender: nico@localhost.localdomain
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18998>

The input line has 40 _chars_ of sha1 and no 20 _bytes_. It should also 
account for the space before the pathname, and the terminating \n and \0.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---

I doubt anyone has ever used a repository with paths long enough to hit 
the limit, but better make it right nevertheless.

diff --git a/pack-objects.c b/pack-objects.c
index 09f4f2c..3c2767b 100644
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -1231,7 +1231,7 @@ static void setup_progress_signal(void)
 int main(int argc, char **argv)
 {
 	SHA_CTX ctx;
-	char line[PATH_MAX + 20];
+	char line[40 + 1 + PATH_MAX + 2];
 	int window = 10, depth = 10, pack_to_stdout = 0;
 	struct object_entry **list;
 	int num_preferred_base = 0;
