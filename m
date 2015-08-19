From: Dave Borowitz <dborowitz@google.com>
Subject: [PATCH v2 9/9] Add a config option push.gpgSign for default signed pushes
Date: Wed, 19 Aug 2015 11:26:47 -0400
Message-ID: <1439998007-28719-10-git-send-email-dborowitz@google.com>
References: <1439998007-28719-1-git-send-email-dborowitz@google.com>
Cc: Dave Borowitz <dborowitz@google.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Aug 19 17:27:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZS5H0-0004yA-2Q
	for gcvg-git-2@plane.gmane.org; Wed, 19 Aug 2015 17:27:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752005AbbHSP1Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2015 11:27:25 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:35959 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751948AbbHSP1W (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2015 11:27:22 -0400
Received: by igxp17 with SMTP id p17so108042741igx.1
        for <git@vger.kernel.org>; Wed, 19 Aug 2015 08:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6B4TjdC+2nPyxZ99Sc5Atr+XgYg9ROntbL931MmPE4c=;
        b=YEpRa6huXjJTa9+M87k6YeOcDy4VgX7dxpx9asoSrYnb1gO+vSP2yTwVUnsfIk9Z7O
         csZknvUcrZLmJftlRKVtLkdMBiCSNmytpNXC3RcPI++Ep8MphOL/34FOlepXI2zdyd1P
         C1X+qjd3WbW+5cfnvbpFbWA6vz9MGg90PwiQCwanpg5qQ6uoTX8y5hsOWNNIx0KsJWx/
         FAv1anuuz1bYO6ovWUHNUVm85v4bKYnDuYHAfTJhrZAKTrPHCDsBszjDE+kLKOtSbwyH
         apAOX9gpNEq/MEAi/WK32NLjtwXfNt6ndQU3tEkSj3nnEm0HFx6Hag4IF01fD7YT7lrO
         20bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6B4TjdC+2nPyxZ99Sc5Atr+XgYg9ROntbL931MmPE4c=;
        b=D1sdh22FyHbHipHv8F6yildHMs+1Zw3iOPydjXIeHFh+jcjWqyeNpqSvbrkNadhqtR
         4tz9mm/pn7N2LmcaFQwELa/rxzCwsn9nFeKZIFDNDASDHwjWen3YSDFBLmi2mrpZKkHv
         7l3/r4Xdn3WuSTUtxoSPZV3juSklrKDfYWrkbtG9nySBKyPm+FUP8J6QaTEANvyF0tbT
         S6HXid2XUUt8M0FuOC43K/3+uzhVPGY5eA6ZlrT9LAyxiUxqEiAuJYtElJhTH50VOhbD
         kRbPTF6moq6ecOrOJAtx5NQIALEwabCF34p1qLK2SIuBa4Pmce9iG48Je743awdwxUNL
         C4lA==
X-Gm-Message-State: ALoCoQnUT1lqq8WFPrLn19TdC3PjAyu9dBh7P2EzrcySrX+tZb50Pu0rK+8GvIy0oihq+mWR1u0p
X-Received: by 10.50.62.193 with SMTP id a1mr2047160igs.61.1439998041516;
        Wed, 19 Aug 2015 08:27:21 -0700 (PDT)
Received: from serval.arb.corp.google.com ([172.29.229.12])
        by smtp.gmail.com with ESMTPSA id o19sm2347819igs.18.2015.08.19.08.27.20
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 19 Aug 2015 08:27:20 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.276.gf5e568e
In-Reply-To: <1439998007-28719-1-git-send-email-dborowitz@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276186>

Signed-off-by: Dave Borowitz <dborowitz@google.com>
---
 Documentation/config.txt |  8 ++++++++
 builtin/push.c           | 50 ++++++++++++++++++++++++++++++++++--------------
 builtin/send-pack.c      | 27 +++++++++++++++++++++++++-
 3 files changed, 70 insertions(+), 15 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 016f6e9..4ba0e4b 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2178,6 +2178,14 @@ push.followTags::
 	may override this configuration at time of push by specifying
 	'--no-follow-tags'.
 
+push.gpgSign::
+	May be set to a boolean value, or the string 'if-asked'. A true
+	value causes all pushes to be GPG signed, as if '--signed' is
+	passed to linkgit:git-push[1]. The string 'if-asked' causes
+	pushes to be signed if the server supports it, as if
+	'--signed=if-asked' is passed to 'git push'. A false value may
+	override a value from a lower-priority config file. An explicit
+	command-line flag always overrides this config option.
 
 rebase.stat::
 	Whether to show a diffstat of what changed upstream since the last
diff --git a/builtin/push.c b/builtin/push.c
index 85a82cd..3bda430 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -472,6 +472,24 @@ static int option_parse_recurse_submodules(const struct option *opt,
 	return 0;
 }
 
+static void set_push_cert_flags(int *flags, int v)
+{
+	switch (v) {
+	case SEND_PACK_PUSH_CERT_NEVER:
+		*flags &= ~(TRANSPORT_PUSH_CERT_ALWAYS | TRANSPORT_PUSH_CERT_IF_ASKED);
+		break;
+	case SEND_PACK_PUSH_CERT_ALWAYS:
+		*flags |= TRANSPORT_PUSH_CERT_ALWAYS;
+		*flags &= ~TRANSPORT_PUSH_CERT_IF_ASKED;
+		break;
+	case SEND_PACK_PUSH_CERT_IF_ASKED:
+		*flags |= TRANSPORT_PUSH_CERT_IF_ASKED;
+		*flags &= ~TRANSPORT_PUSH_CERT_ALWAYS;
+		break;
+	}
+}
+
+
 static int git_push_config(const char *k, const char *v, void *cb)
 {
 	int *flags = cb;
@@ -487,6 +505,23 @@ static int git_push_config(const char *k, const char *v, void *cb)
 		else
 			*flags &= ~TRANSPORT_PUSH_FOLLOW_TAGS;
 		return 0;
+	} else if (!strcmp(k, "push.gpgsign")) {
+		const char *value;
+		if (!git_config_get_value("push.gpgsign", &value)) {
+			switch (git_config_maybe_bool("push.gpgsign", value)) {
+			case 0:
+				set_push_cert_flags(flags, SEND_PACK_PUSH_CERT_NEVER);
+				break;
+			case 1:
+				set_push_cert_flags(flags, SEND_PACK_PUSH_CERT_ALWAYS);
+				break;
+			default:
+				if (value && !strcasecmp(value, "if-asked"))
+					set_push_cert_flags(flags, SEND_PACK_PUSH_CERT_IF_ASKED);
+				else
+					return error("Invalid value for '%s'", k);
+			}
+		}
 	}
 
 	return git_default_config(k, v, NULL);
@@ -538,6 +573,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 	packet_trace_identity("push");
 	git_config(git_push_config, &flags);
 	argc = parse_options(argc, argv, prefix, options, push_usage, 0);
+	set_push_cert_flags(&flags, push_cert);
 
 	if (deleterefs && (tags || (flags & (TRANSPORT_PUSH_ALL | TRANSPORT_PUSH_MIRROR))))
 		die(_("--delete is incompatible with --all, --mirror and --tags"));
@@ -552,20 +588,6 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		set_refspecs(argv + 1, argc - 1, repo);
 	}
 
-	switch (push_cert) {
-	case SEND_PACK_PUSH_CERT_NEVER:
-		flags &= ~(TRANSPORT_PUSH_CERT_ALWAYS | TRANSPORT_PUSH_CERT_IF_ASKED);
-		break;
-	case SEND_PACK_PUSH_CERT_ALWAYS:
-		flags |= TRANSPORT_PUSH_CERT_ALWAYS;
-		flags &= ~TRANSPORT_PUSH_CERT_IF_ASKED;
-		break;
-	case SEND_PACK_PUSH_CERT_IF_ASKED:
-		flags |= TRANSPORT_PUSH_CERT_IF_ASKED;
-		flags &= ~TRANSPORT_PUSH_CERT_ALWAYS;
-		break;
-	}
-
 	rc = do_push(repo, flags);
 	if (rc == -1)
 		usage_with_options(push_usage, options);
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 0ce3bc8..f6e5d64 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -97,6 +97,31 @@ static void print_helper_status(struct ref *ref)
 	strbuf_release(&buf);
 }
 
+static int send_pack_config(const char *k, const char *v, void *cb)
+{
+	git_gpg_config(k, v, NULL);
+
+	if (!strcmp(k, "push.gpgsign")) {
+		const char *value;
+		if (!git_config_get_value("push.gpgsign", &value)) {
+			switch (git_config_maybe_bool("push.gpgsign", value)) {
+			case 0:
+				args.push_cert = SEND_PACK_PUSH_CERT_NEVER;
+				break;
+			case 1:
+				args.push_cert = SEND_PACK_PUSH_CERT_ALWAYS;
+				break;
+			default:
+				if (value && !strcasecmp(value, "if-asked"))
+					args.push_cert = SEND_PACK_PUSH_CERT_IF_ASKED;
+				else
+					return error("Invalid value for '%s'", k);
+			}
+		}
+	}
+	return 0;
+}
+
 int cmd_send_pack(int argc, const char **argv, const char *prefix)
 {
 	int i, nr_refspecs = 0;
@@ -153,7 +178,7 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
-	git_config(git_gpg_config, NULL);
+	git_config(send_pack_config, NULL);
 	argc = parse_options(argc, argv, prefix, options, send_pack_usage, 0);
 	if (argc > 0) {
 		dest = argv[0];
-- 
2.5.0.276.gf5e568e
