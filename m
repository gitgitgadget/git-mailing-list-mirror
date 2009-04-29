From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] improve error message in config.c
Date: Wed, 29 Apr 2009 23:27:54 +0200
Message-ID: <20090429212754.GB12981@blimp.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 29 23:28:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzHKF-0006xo-Pc
	for gcvg-git-2@gmane.org; Wed, 29 Apr 2009 23:28:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758632AbZD2V2H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2009 17:28:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755490AbZD2V2G
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 17:28:06 -0400
Received: from mout1.freenet.de ([195.4.92.91]:48164 "EHLO mout1.freenet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753992AbZD2V2F (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2009 17:28:05 -0400
Received: from [195.4.92.20] (helo=10.mx.freenet.de)
	by mout1.freenet.de with esmtpa (ID alexander.riesen@freenet.de) (port 25) (Exim 4.69 #88)
	id 1LzHJx-0005II-Dq; Wed, 29 Apr 2009 23:28:01 +0200
Received: from x6432.x.pppool.de ([89.59.100.50]:51540 helo=tigra.home)
	by 10.mx.freenet.de with esmtpsa (ID alexander.riesen@freenet.de) (TLSv1:AES256-SHA:256) (port 587) (Exim 4.69 #79)
	id 1LzHJx-0005rj-8U; Wed, 29 Apr 2009 23:28:01 +0200
Received: from blimp.localdomain (blimp.home [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id DDA4E277D8;
	Wed, 29 Apr 2009 23:27:54 +0200 (CEST)
Received: by blimp.localdomain (Postfix, from userid 1000)
	id 9F38436D28; Wed, 29 Apr 2009 23:27:54 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117951>

Show errno if opening a lockfile fails.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

I miss them error codes greately. Especially when a problem is hard
to reproduce.

 config.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/config.c b/config.c
index 1750cfb..8bd953c 100644
--- a/config.c
+++ b/config.c
@@ -996,7 +996,7 @@ int git_config_set_multivar(const char* key, const char* value,
 	lock = xcalloc(sizeof(struct lock_file), 1);
 	fd = hold_lock_file_for_update(lock, config_filename, 0);
 	if (fd < 0) {
-		error("could not lock config file %s", config_filename);
+		error("could not lock config file %s: %s", config_filename, strerror(errno));
 		free(store.key);
 		ret = -1;
 		goto out_free;
-- 
1.6.3.rc3.39.g49fd5
