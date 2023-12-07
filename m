Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2212C137
	for <git@vger.kernel.org>; Wed,  6 Dec 2023 23:26:32 -0800 (PST)
Received: (qmail 10037 invoked by uid 109); 7 Dec 2023 07:26:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 07 Dec 2023 07:26:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1099 invoked by uid 111); 7 Dec 2023 07:26:36 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 07 Dec 2023 02:26:36 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 7 Dec 2023 02:26:31 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: [PATCH 8/9] gpg-interface: drop pointless config_error_nonbool()
 checks
Message-ID: <20231207072631.GH1277973@coredump.intra.peff.net>
References: <20231207072338.GA1277727@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231207072338.GA1277727@coredump.intra.peff.net>

Config callbacks which use git_config_string() or git_config_pathname()
have no need to check for a NULL value. This is handled automatically
by those helpers.

Signed-off-by: Jeff King <peff@peff.net>
---
 gpg-interface.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/gpg-interface.c b/gpg-interface.c
index 48f43c5a21..25c42cb9fd 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -762,23 +762,14 @@ static int git_gpg_config(const char *var, const char *value,
 		return 0;
 	}
 
-	if (!strcmp(var, "gpg.ssh.defaultkeycommand")) {
-		if (!value)
-			return config_error_nonbool(var);
+	if (!strcmp(var, "gpg.ssh.defaultkeycommand"))
 		return git_config_string(&ssh_default_key_command, var, value);
-	}
 
-	if (!strcmp(var, "gpg.ssh.allowedsignersfile")) {
-		if (!value)
-			return config_error_nonbool(var);
+	if (!strcmp(var, "gpg.ssh.allowedsignersfile"))
 		return git_config_pathname(&ssh_allowed_signers, var, value);
-	}
 
-	if (!strcmp(var, "gpg.ssh.revocationfile")) {
-		if (!value)
-			return config_error_nonbool(var);
+	if (!strcmp(var, "gpg.ssh.revocationfile"))
 		return git_config_pathname(&ssh_revocation_file, var, value);
-	}
 
 	if (!strcmp(var, "gpg.program") || !strcmp(var, "gpg.openpgp.program"))
 		fmtname = "openpgp";
-- 
2.43.0.664.ga12c899002

