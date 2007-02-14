From: Alexandre Julliard <julliard@winehq.org>
Subject: [PATCH] sha1_file.c: Round the mmap offset to half the window size.
Date: Wed, 14 Feb 2007 18:11:40 +0100
Message-ID: <878xf08y0j.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 14 18:11:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHNfc-0005Au-6t
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 18:11:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750752AbXBNRLq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 12:11:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750739AbXBNRLp
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 12:11:45 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:55165 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750752AbXBNRLp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 12:11:45 -0500
Received: from adsl-62-167-48-140.adslplus.ch ([62.167.48.140] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1HHNfU-0007xC-4W
	for git@vger.kernel.org; Wed, 14 Feb 2007 11:11:44 -0600
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id CCC184FB65; Wed, 14 Feb 2007 18:11:40 +0100 (CET)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.92 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39690>

This ensures that a given area is mapped at most twice, and greatly
reduces the virtual address space usage.

Signed-off-by: Alexandre Julliard <julliard@winehq.org>
---
 sha1_file.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 8ad7fad..a217c3c 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -665,7 +665,7 @@ unsigned char* use_pack(struct packed_git *p,
 			if (!page_size)
 				page_size = getpagesize();
 			win = xcalloc(1, sizeof(*win));
-			win->offset = (offset / page_size) * page_size;
+			win->offset = (offset / (packed_git_window_size/2)) * (packed_git_window_size/2);
 			win->len = p->pack_size - win->offset;
 			if (win->len > packed_git_window_size)
 				win->len = packed_git_window_size;
-- 
1.5.0.7.g2fa71

-- 
Alexandre Julliard
julliard@winehq.org
