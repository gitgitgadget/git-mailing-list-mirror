Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FF011F97E
	for <e@80x24.org>; Mon,  8 Oct 2018 18:09:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbeJIBW2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Oct 2018 21:22:28 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41646 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726529AbeJIBW2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Oct 2018 21:22:28 -0400
Received: by mail-pl1-f196.google.com with SMTP id q17-v6so10420047plr.8
        for <git@vger.kernel.org>; Mon, 08 Oct 2018 11:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gVAytk9f9rkr6ixJ8lvF+32eUIQN30kaYtL62ymwnrY=;
        b=Xsip05ojA+0L2v5CtVysLCrmUdL07iXDELyolluDdXge87jCBupqZJzYw7HWK2M+Vp
         XElJ6yCoABH+6P/3kvA7vrHrCcrvCdSTbxLvCc6RiyyuFhs4TsP5ZjJEgAXfZ4qWBjQL
         j2wKVOmLalR9366UAKyqKrEVSqb+JVCHL9cZodzNMJJUPho47nnr7hITCWvB6mOx1pz0
         Scxr38mhCdpJ4hlLXYVkV7Xj6/WzCLoY8BA29mtvN1XaMuwCU5pj4bXddbq3q4g9shux
         cVyzeFadq6cAipkgnjMcnVyK7TJLqDqx24Bx+/N3xYgGKw1t+5ohi1ok5VPWRfXdZCBm
         Qy1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gVAytk9f9rkr6ixJ8lvF+32eUIQN30kaYtL62ymwnrY=;
        b=qdCirYVKfUgTtgde5Kf29E0jfAO6Oqi84rTaTfBpnQZrE+c/JNaSjWwAo49Nxf4grL
         u5k9SNJLL6tfbVxvDNb78DmbIA3gsjy+m2ugPhHZn0g6sNPPYUctREefoM2KzZpEzAq1
         VVC/5lM8DzBt6mGfq/d64LdftZcEFyj0974OyqZUEm0uluUxFsibqboH9ZgGm9mtnn/r
         NIXn1uZJj/DWnaPlCgMf9Ux0quTR+DCdLoTqy2edd/b4dDtiT+tX1truKqmJaAam3IXi
         Kp1/USl7cyWh47/YN2DBvOsxp/tea8DFE1T7p9gVmnO20dkO95wLw/HWV2I6ncYVsBpq
         gf0A==
X-Gm-Message-State: ABuFfoj0NRhyFIGQVdPBfrATEHFanesz12JsU5BC6IRweRXBMjuXmOVA
        WCis9B1nXMPTzSvhtyll1MIYH76HlFE=
X-Google-Smtp-Source: ACcGV63Ahca3c3XrEfvbYOLf+nug/I0ty8UxIePrVa22MIhe7Ag6zMqvD+YgpzmM4o8Kn4cDqGtrWw==
X-Received: by 2002:a17:902:7246:: with SMTP id c6-v6mr25273119pll.304.1539022171720;
        Mon, 08 Oct 2018 11:09:31 -0700 (PDT)
Received: from localhost ([205.175.107.112])
        by smtp.gmail.com with ESMTPSA id l6-v6sm23995459pfl.169.2018.10.08.11.09.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Oct 2018 11:09:31 -0700 (PDT)
Date:   Mon, 8 Oct 2018 11:09:30 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com, sunshine@sunshineco.com,
        sbeller@google.com, ramsay@ramsayjones.plus.com
Subject: [PATCH v5 4/4] transport.c: introduce core.alternateRefsPrefixes
Message-ID: <28cbbe63f73b14315f8b1b7c7049b1f81f27057f.1539021825.git.me@ttaylorr.com>
References: <cover.1537466087.git.me@ttaylorr.com>
 <cover.1539021825.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1539021825.git.me@ttaylorr.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The recently-introduced "core.alternateRefsCommand" allows callers to
specify with high flexibility the tips that they wish to advertise from
alternates. This flexibility comes at the cost of some inconvenience
when the caller only wishes to limit the advertisement to one or more
prefixes.

For example, to advertise only tags, a caller using
'core.alternateRefsCommand' would have to do:

  $ git config core.alternateRefsCommand ' \
      f() { git -C "$1" for-each-ref \
              refs/tags --format="%(objectname)" }; f "$@"'

The above is cumbersome to write, so let's introduce a
"core.alternateRefsPrefixes" to address this common case. Instead, the
caller can run:

  $ git config core.alternateRefsPrefixes 'refs/tags'

Which will behave identically to the longer example using
"core.alternateRefsCommand".

Since the value of "core.alternateRefsPrefixes" is appended to 'git
for-each-ref' and then executed, include a "--" before taking the
configured value to avoid misinterpreting arguments as flags to 'git
for-each-ref'.

In the case that the caller wishes to specify multiple prefixes, they
may separate them by whitespace. If "core.alternateRefsCommand" is set,
it will take precedence over "core.alternateRefsPrefixes".

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/config.txt           | 7 +++++++
 t/t5410-receive-pack-alternates.sh | 8 ++++++++
 transport.c                        | 5 +++++
 3 files changed, 20 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index c51e82d8a5..a133a709f3 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -627,6 +627,13 @@ Note that you cannot generally put `git for-each-ref` directly into the config
 value, as it does not take a repository path as an argument (but you can wrap
 the command above in a shell script).
 
+core.alternateRefsPrefixes::
+	When listing references from an alternate, list only references that begin
+	with the given prefix. Prefixes match as if they were given as arguments to
+	linkgit:git-for-each-ref[1]. To list multiple prefixes, separate them with
+	whitespace. If `core.alternateRefsCommand` is set, setting
+	`core.alternateRefsPrefixes` has no effect.
+
 core.bare::
 	If true this repository is assumed to be 'bare' and has no
 	working directory associated with it.  If this is the case a
diff --git a/t/t5410-receive-pack-alternates.sh b/t/t5410-receive-pack-alternates.sh
index 49d0fe44fb..457c20c2a5 100755
--- a/t/t5410-receive-pack-alternates.sh
+++ b/t/t5410-receive-pack-alternates.sh
@@ -30,4 +30,12 @@ test_expect_success 'with core.alternateRefsCommand' '
 	test_cmp expect actual.haves
 '
 
+test_expect_success 'with core.alternateRefsPrefixes' '
+	test_config -C fork core.alternateRefsPrefixes "refs/heads/private" &&
+	git rev-parse private/branch >expect &&
+	printf "0000" | git receive-pack fork >actual &&
+	extract_haves <actual >actual.haves &&
+	test_cmp expect actual.haves
+'
+
 test_done
diff --git a/transport.c b/transport.c
index e271b66603..83474add28 100644
--- a/transport.c
+++ b/transport.c
@@ -1341,6 +1341,11 @@ static void fill_alternate_refs_command(struct child_process *cmd,
 		argv_array_pushf(&cmd->args, "--git-dir=%s", repo_path);
 		argv_array_push(&cmd->args, "for-each-ref");
 		argv_array_push(&cmd->args, "--format=%(objectname)");
+
+		if (!git_config_get_value("core.alternateRefsPrefixes", &value)) {
+			argv_array_push(&cmd->args, "--");
+			argv_array_split(&cmd->args, value);
+		}
 	}
 
 	cmd->env = local_repo_env;
-- 
2.19.0.221.g150f307af
