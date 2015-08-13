From: Dave Borowitz <dborowitz@google.com>
Subject: [PATCH 7/7] Add a config option push.gpgSign for default signed pushes
Date: Thu, 13 Aug 2015 15:00:51 -0400
Message-ID: <1439492451-11233-8-git-send-email-dborowitz@google.com>
References: <1439492451-11233-1-git-send-email-dborowitz@google.com>
Cc: Dave Borowitz <dborowitz@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 13 21:01:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPxkX-0003Bg-Sk
	for gcvg-git-2@plane.gmane.org; Thu, 13 Aug 2015 21:01:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753809AbbHMTBH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2015 15:01:07 -0400
Received: from mail-io0-f174.google.com ([209.85.223.174]:34568 "EHLO
	mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753784AbbHMTBC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2015 15:01:02 -0400
Received: by iodb91 with SMTP id b91so61908390iod.1
        for <git@vger.kernel.org>; Thu, 13 Aug 2015 12:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BVdvrdTrxTNjtyqQVfKnWm8ePXAp/g5Ow0/pD5ItmHc=;
        b=jIMDTVxzUTyCPPRlaSDHof4coofI9CPTv4oJIkN6xbtklrYUU5TWiZa7cfnBFX7+Nm
         88h6Gx5703Q6NHSRytupl3zvZtLr24H4WcSl74gpbcr7JkKk+p8jifS8fiPmuSh7rHBH
         pIVrnKzJCL9sAIOSUhfeRK6CeaVOkzB7ndW5lw0o4nYpOHWuhPvb1jHscft2CMMuNyoN
         sVwsrCgZ1KSHjr97nJLm2X0A7j8iNk7fKl1KM+5lp+8R6d1zYpa71qOa/ehii5Ovexgf
         DjaMxRrpWYtArsmWUuICML9r6c6xnNwBc3ya4iYm1yksQGpUD2gduY92G2yI9NSspDlF
         /lng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BVdvrdTrxTNjtyqQVfKnWm8ePXAp/g5Ow0/pD5ItmHc=;
        b=gw4yFnID/OEmRhdo4ztkIGmjOpRX67V8WM4lGWyF9iCVFN3/OAqLzaALnYiWEzZG3g
         9Xpg7ZxuELKYG1brsUPUP9Oht73dGKJIegxPL2EoZDyNS5tocjAVj4rTeTwgADfUr43b
         s4+AnvppxfBQ7BMQu36IPibBHhuPh2UbPzRnHxdokAFxVKKqFcu8JE/hRF/6qy216uOu
         nmGJ3m9ww16Oi0NLN3DKunksj/LnZsqmSELO0/yDwAIBnPdperl3WTiDZvxKBdfX6AXx
         IT0SMOpzmoWEL1tZjzHMR6CvRlFZkXVAJogHRctcdPTl3hlm/1+1ikesgsTyi5Mn3d1R
         ++Ig==
X-Gm-Message-State: ALoCoQlIuannsNEthsUmEni6049Yr+URINZS2lCUQgXOM0RIunc1DtS/StpgYmf4kHswJ48iRW2x
X-Received: by 10.107.40.147 with SMTP id o141mr38892646ioo.83.1439492461413;
        Thu, 13 Aug 2015 12:01:01 -0700 (PDT)
Received: from serval.arb.corp.google.com ([172.29.229.12])
        by smtp.gmail.com with ESMTPSA id c91sm2078646ioj.43.2015.08.13.12.01.00
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 13 Aug 2015 12:01:00 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.276.gf5e568e
In-Reply-To: <1439492451-11233-1-git-send-email-dborowitz@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275877>

---
 Documentation/config.txt |  8 ++++++++
 builtin/push.c           | 22 ++++++++++++++++++++++
 builtin/send-pack.c      | 27 ++++++++++++++++++++++++++-
 3 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 016f6e9..6804f5b 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2178,6 +2178,14 @@ push.followTags::
 	may override this configuration at time of push by specifying
 	'--no-follow-tags'.
 
+push.gpgSign::
+	May be set to a boolean value, or the string 'if-possible'. A
+	true value causes all pushes to be GPG signed, as if '--signed'
+	is passed to linkgit:git-push[1]. The string 'if-possible'
+	causes pushes to be signed if the server supports it, as if
+	'--signed-if-possible' is passed to 'git push'. A false value
+	may override a value from a lower-priority config file. An
+	explicit command-line flag always overrides this config option.
 
 rebase.stat::
 	Whether to show a diffstat of what changed upstream since the last
diff --git a/builtin/push.c b/builtin/push.c
index 95a67c5..8972193 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -491,6 +491,26 @@ static int git_push_config(const char *k, const char *v, void *cb)
 	return git_default_config(k, v, NULL);
 }
 
+static void set_push_cert_flags_from_config(int *flags)
+{
+	const char *value;
+	/* Ignore config if flags were set from command line. */
+	if (*flags & (TRANSPORT_PUSH_CERT_ALWAYS | TRANSPORT_PUSH_CERT_IF_POSSIBLE))
+		return;
+	if (!git_config_get_value("push.gpgsign", &value)) {
+		switch (git_config_maybe_bool("push.gpgsign", value)) {
+		case 1:
+			*flags |= TRANSPORT_PUSH_CERT_ALWAYS;
+			break;
+		default:
+			if (value && !strcmp(value, "if-possible"))
+				*flags |= TRANSPORT_PUSH_CERT_IF_POSSIBLE;
+			else
+				die(_("Invalid value for 'push.gpgsign'"));
+		}
+	}
+}
+
 int cmd_push(int argc, const char **argv, const char *prefix)
 {
 	int flags = 0;
@@ -537,6 +557,8 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 	git_config(git_push_config, &flags);
 	argc = parse_options(argc, argv, prefix, options, push_usage, 0);
 
+	set_push_cert_flags_from_config(&flags);
+
 	if (deleterefs && (tags || (flags & (TRANSPORT_PUSH_ALL | TRANSPORT_PUSH_MIRROR))))
 		die(_("--delete is incompatible with --all, --mirror and --tags"));
 	if (deleterefs && argc < 2)
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 8eebbf4..9c8b7de 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -92,6 +92,31 @@ static void print_helper_status(struct ref *ref)
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
+				if (value && !strcasecmp(value, "if-possible"))
+					args.push_cert = SEND_PACK_PUSH_CERT_IF_POSSIBLE;
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
@@ -114,7 +139,7 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 	int from_stdin = 0;
 	struct push_cas_option cas = {0};
 
-	git_config(git_gpg_config, NULL);
+	git_config(send_pack_config, NULL);
 
 	argv++;
 	for (i = 1; i < argc; i++, argv++) {
-- 
2.5.0.276.gf5e568e
