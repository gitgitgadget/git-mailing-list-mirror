Return-Path: <SRS0=Vx3J=3N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A45AFC35240
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 03:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7426E22522
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 03:35:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IWdO1fYJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729949AbgAXDfg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jan 2020 22:35:36 -0500
Received: from mail-pg1-f202.google.com ([209.85.215.202]:33422 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729880AbgAXDfe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jan 2020 22:35:34 -0500
Received: by mail-pg1-f202.google.com with SMTP id s23so592326pgg.0
        for <git@vger.kernel.org>; Thu, 23 Jan 2020 19:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=k9JufkulLGwySzhRbUjAmjY2tNQfo+MMSJLRQyRBhdc=;
        b=IWdO1fYJw2P+uX6h/ubLxp7roml7YLw9o0+Pef6bTsq8vh++oW52HKq1fGj26Y4WJD
         chRp1OCLk/hHJLVQiLrd5qiZyL805eEftiPnIIh7QKUeyPj9JcsiiK2zNNRcdqFF0uDN
         jdLRhvGje2Qg55J6htqaEkcZ5pqOn542Z6b/x/yvp/OAPsxZRM9lZclMo2Yd4ssmBQKe
         N3HEAohsXP61L5m3Gawyt6+7dCOKTkuTsDFsp20ScoaD+nU8rUZvgsjuQnsPcxKC4c5P
         SFm6qWOeYafM4oERQfkh0+AiJR970g5r+eSkUVjOxovk6FdkLsarENMk+gsjETQkLSXo
         no8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=k9JufkulLGwySzhRbUjAmjY2tNQfo+MMSJLRQyRBhdc=;
        b=bu9YHemKngD1GbMWBhzwthDJ2WRS7H7B9RFNd6Fxqv2B5RITAcRwag8a45t7FGwe2B
         Be0gmRpS60JJN0Nby1s0+8kRyEs05HkXnm3okN61Ij6pmvWq5jEKuZpxRC5sfEMuvBwm
         HGXywTVrckxXBbD+b9MY9gOePo9qIUrmz0mGrA79wmuTHSnf6TIgnrDsfxY99CJ9khc+
         vhcKVHhBOr+tjuwcogTG1kCnDdHaKykC0JVyeul+LpW1wFyurMJS7Vors8Rd1uNoluBL
         UYpQ0oq2gOujdOmtSRehasP/9pygurKxy5pKdDuOsMPKOtx38ztWptsqXS4twWeSdEFO
         PJug==
X-Gm-Message-State: APjAAAWjTvJqsHxW+oBdDemV46gWFgytu1M7V1Yt4KmbzqlMPNjsprKu
        ussRsGLuZmaJiNL8vZanD8h7u88rj4QzajknBgFTiYbUCEup1Hvvcl75tbDDcHUbzbcwSistpzB
        Bpf57msYIXtEeL8THRr5AssWFbIhKctiExV67pzU/FhWxN2MmBlt6E3Wu8jaQbNQ0JzqUX92RDg
        ==
X-Google-Smtp-Source: APXvYqwAq3SGG44fJtscuCb0hOhYrbEFYp1LYamFUk5KB29qhPBvq7KkyVMemlRwrzA+kK+e4xNG6MAK/AQ2UiFdxU8=
X-Received: by 2002:a63:3104:: with SMTP id x4mr1722009pgx.369.1579836934077;
 Thu, 23 Jan 2020 19:35:34 -0800 (PST)
Date:   Thu, 23 Jan 2020 19:34:31 -0800
In-Reply-To: <20200124033436.81097-1-emilyshaffer@google.com>
Message-Id: <20200124033436.81097-11-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20200124033436.81097-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v5 10/15] bugreport: add config values from safelist
From:   emilyshaffer@google.com
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Emily Shaffer <emilyshaffer@google.com>

Teach bugreport to gather the values of config options which are present
in 'bugreport-config-safelist.h'.

Many config options are sensitive, and many Git add-ons use config
options which git-core does not know about; it is better only to gather
config options which we know to be safe, rather than excluding options
which we know to be unsafe.

Taking the build-time generated array and putting it into a set saves us
time - since git_config_bugreport() is called for every option the user
has configured, performing option lookup in constant time is a useful
optimization.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 Makefile    |  2 +-
 bugreport.c | 75 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 76 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 2bc9f112ea..eb17ece120 100644
--- a/Makefile
+++ b/Makefile
@@ -2465,7 +2465,7 @@ endif
 git-%$X: %.o GIT-LDFLAGS $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS)
 
-git-bugreport$X: bugreport.o GIT-LDFLAGS $(GITLIBS)
+git-bugreport$X: bugreport-config-safelist.h bugreport.o GIT-LDFLAGS $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(LIBS)
 
diff --git a/bugreport.c b/bugreport.c
index 07b84b9c94..7a9fd36b60 100644
--- a/bugreport.c
+++ b/bugreport.c
@@ -6,6 +6,9 @@
 #include "help.h"
 #include "compat/compiler.h"
 #include "run-command.h"
+#include "config.h"
+#include "bugreport-config-safelist.h"
+#include "khash.h"
 
 static void get_curl_version_info(struct strbuf *curl_info)
 {
@@ -18,6 +21,40 @@ static void get_curl_version_info(struct strbuf *curl_info)
 	    strbuf_addstr(curl_info, "'git-remote-https --build-info' not supported\n");
 }
 
+KHASH_INIT(cfg_set, const char*, int, 0, kh_str_hash_func, kh_str_hash_equal);
+
+struct cfgset {
+	kh_cfg_set_t set;
+};
+
+struct cfgset safelist;
+
+static void cfgset_init(struct cfgset *set, size_t initial_size)
+{
+	memset(&set->set, 0, sizeof(set->set));
+	if (initial_size)
+		kh_resize_cfg_set(&set->set, initial_size);
+}
+
+static int cfgset_insert(struct cfgset *set, const char *cfg_key)
+{
+	int added;
+	kh_put_cfg_set(&set->set, cfg_key, &added);
+	return !added;
+}
+
+static int cfgset_contains(struct cfgset *set, const char *cfg_key)
+{
+	khiter_t pos = kh_get_cfg_set(&set->set, cfg_key);
+	return pos != kh_end(&set->set);
+}
+
+static void cfgset_clear(struct cfgset *set)
+{
+	kh_release_cfg_set(&set->set);
+	cfgset_init(set, 0);
+}
+
 static void get_system_info(struct strbuf *sys_info)
 {
 	struct strbuf version_info = STRBUF_INIT;
@@ -54,6 +91,36 @@ static void get_system_info(struct strbuf *sys_info)
 	strbuf_complete_line(sys_info);
 }
 
+static void gather_safelist(void)
+{
+	int index;
+	int safelist_len = sizeof(bugreport_config_safelist) / sizeof(const char *);
+	cfgset_init(&safelist, safelist_len);
+	for (index = 0; index < safelist_len; index++)
+		cfgset_insert(&safelist, bugreport_config_safelist[index]);
+
+}
+
+static int git_config_bugreport(const char *var, const char *value, void *cb)
+{
+	struct strbuf *config_info = (struct strbuf *)cb;
+
+	if (cfgset_contains(&safelist, var))
+		strbuf_addf(config_info,
+			    "%s (%s) : %s\n",
+			    var, config_scope_to_string(current_config_scope()),
+			    value);
+
+	return 0;
+}
+
+static void get_safelisted_config(struct strbuf *config_info)
+{
+	gather_safelist();
+	git_config(git_config_bugreport, config_info);
+	cfgset_clear(&safelist);
+}
+
 static const char * const bugreport_usage[] = {
 	N_("git bugreport [-o|--output <file>]"),
 	NULL
@@ -94,12 +161,17 @@ int cmd_main(int argc, const char **argv)
 	FILE *report;
 	time_t now = time(NULL);
 	char *option_output = NULL;
+	int nongit_ok = 0;
 
 	const struct option bugreport_options[] = {
 		OPT_STRING('o', "output", &option_output, N_("path"),
 			   N_("specify a destination for the bugreport file")),
 		OPT_END()
 	};
+
+	/* Prerequisite for hooks and config checks */
+	setup_git_directory_gently(&nongit_ok);
+
 	argc = parse_options(argc, argv, "", bugreport_options,
 			     bugreport_usage, 0);
 
@@ -118,6 +190,9 @@ int cmd_main(int argc, const char **argv)
 	get_header(&buffer, "System Info");
 	get_system_info(&buffer);
 
+	get_header(&buffer, "Safelisted Config Info");
+	get_safelisted_config(&buffer);
+
 	report = fopen_for_writing(report_path.buf);
 	strbuf_write(&buffer, report);
 	fclose(report);
-- 
2.25.0.341.g760bfbb309-goog

