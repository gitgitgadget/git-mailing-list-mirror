From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] Release config lock if the regex is invalid
Date: Sun, 07 May 2006 17:36:12 -0400
Message-ID: <20060507213612.27887.28600.stgit@dv.roinet.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Sun May 07 23:36:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FcqvL-0004KF-3Z
	for gcvg-git@gmane.org; Sun, 07 May 2006 23:36:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932236AbWEGVgO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 May 2006 17:36:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932238AbWEGVgO
	(ORCPT <rfc822;git-outgoing>); Sun, 7 May 2006 17:36:14 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:2455 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S932236AbWEGVgO
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 7 May 2006 17:36:14 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1FcqvF-0003vk-Co
	for git@vger.kernel.org; Sun, 07 May 2006 17:36:13 -0400
Received: from localhost.roinet.com ([127.0.0.1] helo=dv.roinet.com)
	by dv.roinet.com with esmtp (Exim 4.62)
	(envelope-from <proski@gnu.org>)
	id 1FcqvE-0007Fu-GQ
	for git@vger.kernel.org; Sun, 07 May 2006 17:36:12 -0400
To: git@vger.kernel.org
User-Agent: StGIT/0.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19720>

Signed-off-by: Pavel Roskin <proski@gnu.org>
---

 config.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/config.c b/config.c
index 41066e4..61eacef 100644
--- a/config.c
+++ b/config.c
@@ -516,6 +516,8 @@ int git_config_set_multivar(const char* 
 				fprintf(stderr, "Invalid pattern: %s\n",
 					value_regex);
 				free(store.value_regex);
+				close(fd);
+				unlink(lock_file);
 				ret = 6;
 				goto out_free;
 			}
