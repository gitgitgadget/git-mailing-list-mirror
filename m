Return-Path: <SRS0=VWjS=46=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EFC7C2BB1D
	for <git@archiver.kernel.org>; Fri, 13 Mar 2020 12:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B20F20746
	for <git@archiver.kernel.org>; Fri, 13 Mar 2020 12:23:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XZajg8df"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgCMMXr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Mar 2020 08:23:47 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44772 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbgCMMXr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Mar 2020 08:23:47 -0400
Received: by mail-pf1-f194.google.com with SMTP id b72so5135037pfb.11
        for <git@vger.kernel.org>; Fri, 13 Mar 2020 05:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ekPZz8iOLJx4/6kv+ASWoRDXpr4PcLjcUGJbkcLghXg=;
        b=XZajg8dfF4aD7Wsy7ZKUw6Pcr/smVi6cZiooptZy9x58d9SEEadkT67LoMWHLpw+E6
         BwXA+C4iuEgZ/4ECvLYm/VsWoj4GfCEYw7fG2kXPXdPYezqqUllhU4zJ4lq1N0HtVAT/
         5XfzKRUpaFbtKlrsdA5codMhn/lgjt4zUP/Y5D4HeiRkYmTFP1C9KWU02B9mO0U1ssrf
         DlcVA5sLERGw9KfNKYQzma5idgT8UFXVehAc/9HExqvAEeYep8KunsoG1OmD1CurrnjS
         yMhaQLCScUu+HG8Gqdg15R+oU1iMwcYSGhEf22NL1rr7amKB38XA93TueN3ev9MfHUx7
         h9Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ekPZz8iOLJx4/6kv+ASWoRDXpr4PcLjcUGJbkcLghXg=;
        b=RaG/3d9Jo4svohBHPVWqKeFGUmCVEtPkoHZaoxnXu6s3sJfOYvs74tNfS+1/Iy60Ov
         +kwPckpjF8bBx7IlGz5PTwmLGwjCA3rrgYHOtrqrgMyMyOr6dZInyrclTJw9Td0iar52
         MHJOs7REb6HqWSvzZRoQukcvhWJdN135lvRNQw5WlfVPTEZfyA87qo304I6abYhDWLK9
         gWyk4CQyBuKAEWx53WyUqtJLfYqjlhHA5yRGg939qLTv2Ks0wkwfpDtd9BPm+HT3HL7X
         qtVPJWbgnERP3Z184gHfGddcZWyxHA2WG3eqjwA/ouXj6PEm/u6nUlsC1jpnXsISgLSd
         mAQA==
X-Gm-Message-State: ANhLgQ2CxeosphRo4whr61LE5DVVsruvvnrJkFrVAs0UlxTydGMPcmij
        r2X6LfTrRG/N8wT0VIsaosI=
X-Google-Smtp-Source: ADFU+vvf0xJ2j+wjXNK4Rc6DGbDhy0AA27ZMYcYSY4Fgrpi5Hihv2MU0EfC9g6OkIy3Zsf9x/YSA/A==
X-Received: by 2002:a63:87c1:: with SMTP id i184mr12414348pge.287.1584102225901;
        Fri, 13 Mar 2020 05:23:45 -0700 (PDT)
Received: from localhost.localdomain ([47.89.83.4])
        by smtp.gmail.com with ESMTPSA id 134sm5346690pfy.27.2020.03.13.05.23.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Mar 2020 05:23:45 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
X-Google-Original-From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v3 4/4] receive-pack: new config receive.procReceiveRefs
Date:   Fri, 13 Mar 2020 20:23:18 +0800
Message-Id: <20200313122318.78000-5-zhiyou.jx@alibaba-inc.com>
X-Mailer: git-send-email 2.26.0.rc1.5.gca1e965b06
In-Reply-To: <CANYiYbHvqLX_OozgAXJ8MbuLipqUdj4CpbExe0oiCcyUyb=Osw@mail.gmail.com>
References: <CANYiYbHvqLX_OozgAXJ8MbuLipqUdj4CpbExe0oiCcyUyb=Osw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a new multi-valued config variable "receive.procReceiveRefs"
for `receive-pack` command, like the follows:

    git config --system --add receive.procReceiveRefs refs/for/
    git config --system --add receive.procReceiveRefs refs/drafts/

If the specific prefix strings match the reference names of the commands
which are sent by git client to `receive-pack`, these commands will be
executed by an external hook (named "proc-receive"), instead of the
internal `execute_commands` function.

For example, if it is set to "refs/for/", pushing to a reference such as
"refs/for/master" will not create or update reference "refs/for/master",
but may create or update a pull request directly by running the external
hook.

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 Documentation/config/receive.txt | 14 +++++++++
 builtin/receive-pack.c           | 49 ++++++++++++++++++++++++++------
 2 files changed, 54 insertions(+), 9 deletions(-)

diff --git a/Documentation/config/receive.txt b/Documentation/config/receive.txt
index 65f78aac37..0178f2d478 100644
--- a/Documentation/config/receive.txt
+++ b/Documentation/config/receive.txt
@@ -114,6 +114,20 @@ receive.hideRefs::
 	An attempt to update or delete a hidden ref by `git push` is
 	rejected.
 
+receive.procReceiveRefs::
+	This is a multi-valued variable that defines reference prefixes
+	to match the commands in `receive-pack`.  Commands matching the
+	prefixes will be executed by an external hooks "proc-receive",
+	instead of the internal `execute_commands` function.  If this
+	variable is not defined, the "proc-receive" hook will never be
+	used, and all commands will be executed by the internal
+	`execute_commands` function.
+
+	For example, if this variable is set to "refs/for/", pushing to
+	reference such as "refs/for/master" will not create or update a
+	reference named "refs/for/master", but may create or update a
+	pull request directly by running an external hook.
+
 receive.updateServerInfo::
 	If set to true, git-receive-pack will run git-update-server-info
 	after receiving data from git-push and updating refs.
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 23f1ae3795..2b796e654d 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -76,6 +76,7 @@ static struct object_id push_cert_oid;
 static struct signature_check sigcheck;
 static const char *push_cert_nonce;
 static const char *cert_nonce_seed;
+static struct string_list proc_receive_refs;
 
 static const char *NONCE_UNSOLICITED = "UNSOLICITED";
 static const char *NONCE_BAD = "BAD";
@@ -228,6 +229,20 @@ static int receive_pack_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (strcmp(var, "receive.procreceiverefs") == 0) {
+		char *prefix;
+		int len;
+
+		if (!value)
+			return config_error_nonbool(var);
+		prefix = xstrdup(value);
+		len = strlen(prefix);
+		while (len && prefix[len - 1] == '/')
+			prefix[--len] = '\0';
+		string_list_insert(&proc_receive_refs, prefix);
+		return 0;
+	}
+
 	return git_default_config(var, value, cb);
 }
 
@@ -1713,17 +1728,30 @@ static void execute_commands(struct command **orig_commands,
 	/* Try to find commands that have special prefix in their reference names,
 	 * and mark them to run an external "proc-receive" hook later.
 	 */
-	for (cmd = commands; cmd; cmd = cmd->next) {
-		if (!should_process_cmd(cmd))
-			continue;
+	if (proc_receive_refs.nr > 0) {
+		struct strbuf refname_full = STRBUF_INIT;
+		size_t prefix_len;
 
-		/* TODO: replace the fixed prefix by looking up git config variables. */
-		if (!strncmp(cmd->ref_name, "refs/for/", 9)) {
-			cmd->have_special_ref = 1;
-			have_special_ref = 1;
-		} else {
-			have_normal_ref = 1;
+		strbuf_addstr(&refname_full, get_git_namespace());
+		prefix_len = refname_full.len;
+
+		for (cmd = commands; cmd; cmd = cmd->next) {
+			if (!should_process_cmd(cmd))
+				continue;
+
+			strbuf_setlen(&refname_full, prefix_len);
+			strbuf_addstr(&refname_full, cmd->ref_name);
+			if (ref_is_matched(&proc_receive_refs, cmd->ref_name, refname_full.buf)) {
+				cmd->have_special_ref = 1;
+				have_special_ref = 1;
+			} else {
+				have_normal_ref = 1;
+			}
 		}
+
+		strbuf_release(&refname_full);
+	} else {
+		have_normal_ref = 1;
 	}
 
 	if (run_receive_hook(commands, "pre-receive", 0, push_options)) {
@@ -2187,6 +2215,8 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
+	string_list_init(&proc_receive_refs, 0);
+
 	packet_trace_identity("receive-pack");
 
 	argc = parse_options(argc, argv, prefix, options, receive_pack_usage, 0);
@@ -2302,5 +2332,6 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 	oid_array_clear(&shallow);
 	oid_array_clear(&ref);
 	free((void *)push_cert_nonce);
+	string_list_clear(&proc_receive_refs, 0);
 	return 0;
 }
-- 
2.26.0.rc1.5.gca1e965b06

