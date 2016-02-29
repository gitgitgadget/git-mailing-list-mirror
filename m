From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v6 3/7] submodule: check argc count for git submodule--helper clone
Date: Mon, 29 Feb 2016 14:58:31 -0800
Message-ID: <1456786715-24256-4-git-send-email-jacob.e.keller@intel.com>
References: <1456786715-24256-1-git-send-email-jacob.e.keller@intel.com>
Cc: Jeff King <peff@peff.net>,
	Mark Strapetz <marc.strapetz@syntevo.com>,
	Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jacob Keller <jacob.keller@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 29 23:58:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaWmG-0005VE-8S
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 23:58:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752450AbcB2W6l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 17:58:41 -0500
Received: from mga03.intel.com ([134.134.136.65]:52381 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750966AbcB2W6k (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 17:58:40 -0500
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP; 29 Feb 2016 14:58:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,521,1449561600"; 
   d="scan'208";a="661447398"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([134.134.3.65])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Feb 2016 14:58:38 -0800
X-Mailer: git-send-email 2.7.1.429.g45cd78e
In-Reply-To: <1456786715-24256-1-git-send-email-jacob.e.keller@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287929>

From: Jacob Keller <jacob.keller@gmail.com>

Extra unused arguments to git submodule--helper clone subcommand were
being silently ignored. Add a check to the argc count after options
handling to ensure that no extra arguments were left on the argv array.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 builtin/submodule--helper.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index f4c3eff179b5..1e18075ed90f 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -194,6 +194,10 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, module_clone_options,
 			     git_submodule_helper_usage, 0);
 
+	if (argc)
+		usage_with_options(git_submodule_helper_usage,
+				   module_clone_options);
+
 	strbuf_addf(&sb, "%s/modules/%s", get_git_dir(), name);
 	sm_gitdir = strbuf_detach(&sb, NULL);
 
-- 
2.7.1.429.g45cd78e
