From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 2/2] pack-refs.c: Add missing call to git_config()
Date: Sat, 15 Jun 2013 21:30:00 +0100
Message-ID: <51BCCEC8.5000803@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 15 22:32:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Unx9F-0007f1-6Q
	for gcvg-git-2@plane.gmane.org; Sat, 15 Jun 2013 22:32:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754626Ab3FOUcW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Jun 2013 16:32:22 -0400
Received: from mdfmta009.mxout.tbr.inty.net ([91.221.168.50]:36607 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754598Ab3FOUcK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Jun 2013 16:32:10 -0400
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id D0F18384080;
	Sat, 15 Jun 2013 21:32:09 +0100 (BST)
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id 47AD638407C;
	Sat, 15 Jun 2013 21:32:09 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP;
	Sat, 15 Jun 2013 21:32:07 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
X-MDF-HostID: 4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227972>


At present, 'git pack-refs' ignores any attempt to set config
variables (e.g. core.checkstat) from the command line using
the -c option to git. In order to enable such usage, add the
missing call to git_config() from cmd_pack_refs().

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 builtin/pack-refs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/builtin/pack-refs.c b/builtin/pack-refs.c
index b20b1ec..ade1ae5 100644
--- a/builtin/pack-refs.c
+++ b/builtin/pack-refs.c
@@ -15,6 +15,9 @@ int cmd_pack_refs(int argc, const char **argv, const char *prefix)
 		OPT_BIT(0, "prune", &flags, N_("prune loose refs (default)"), PACK_REFS_PRUNE),
 		OPT_END(),
 	};
+
+	git_config(git_default_config, NULL);
+
 	if (parse_options(argc, argv, prefix, opts, pack_refs_usage, 0))
 		usage_with_options(pack_refs_usage, opts);
 	return pack_refs(flags);
-- 
1.8.3
