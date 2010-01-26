From: Johan Herland <johan@herland.net>
Subject: [PATCH] builtin-config: Fix crash when using "-f <relative path>" from non-root dir
Date: Tue, 26 Jan 2010 16:02:16 +0100
Message-ID: <201001261602.16876.johan@herland.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 26 16:03:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZmxD-0005sR-MJ
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jan 2010 16:03:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753597Ab0AZPDk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2010 10:03:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753405Ab0AZPDk
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jan 2010 10:03:40 -0500
Received: from smtp.opera.com ([213.236.208.81]:35835 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753262Ab0AZPDj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2010 10:03:39 -0500
Received: from johanh.eng.oslo.osa (pat-tdc.opera.com [213.236.208.22])
	(authenticated bits=0)
	by smtp.opera.com (8.14.3/8.14.3/Debian-5) with ESMTP id o0QEwpCZ032427
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 26 Jan 2010 14:59:01 GMT
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138039>

When your current directory is not at the root of the working tree, and you
use the "-f" option with a relative path, the current code segfaults since
argv has already been parsed, and argv[2] is now is a NULL pointer.
This patch replaces the incorrect argv[2] with the variable holding the
given config file name.

The bug was introduced by d64ec16... (git config: reorganize to use parseopt).

Signed-off-by: Johan Herland <johan@herland.net>
---

This is probably v1.7.0 material, and maybe even suitable for 'maint'.
AFAICS, d64ec16... has been with us since before v1.6.3-rc0.

...Johan


 builtin-config.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-config.c b/builtin-config.c
index 2e3ef91..4bc46b1 100644
--- a/builtin-config.c
+++ b/builtin-config.c
@@ -358,7 +358,7 @@ int cmd_config(int argc, const char **argv, const char *unused_prefix)
 		if (!is_absolute_path(given_config_file) && prefix)
 			config_exclusive_filename = prefix_filename(prefix,
 								    strlen(prefix),
-								    argv[2]);
+								    given_config_file);
 		else
 			config_exclusive_filename = given_config_file;
 	}
-- 
1.6.6.rc2.5.g49666
-- 
Johan Herland, <johan@herland.net>
www.herland.net
