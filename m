Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C87E61F453
	for <e@80x24.org>; Thu, 20 Sep 2018 18:04:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387925AbeITXs5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Sep 2018 19:48:57 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:39647 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732340AbeITXs5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Sep 2018 19:48:57 -0400
Received: by mail-io1-f65.google.com with SMTP id l7-v6so8676775iok.6
        for <git@vger.kernel.org>; Thu, 20 Sep 2018 11:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=A+vGjWgxO8q2rhk97ewcoXKKj4H3RgeoDPtYlJeteug=;
        b=QX8LxJ1NBxXTM2DVmBMClUS4QmUZ0XtZubR7NR/xeJ7LfnNQd0k1fRYPQTVKXJUBrn
         BGb2cKyQnFyA8XvO5P37F8nrvkiXvd65RVJEMssV2GSQWYDuwF880aUm1SIoJ7koTYYh
         0XasHY8yySI7gOLDmq1LARsOMm4s3k/QchWBY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=A+vGjWgxO8q2rhk97ewcoXKKj4H3RgeoDPtYlJeteug=;
        b=YRnRunC7c+YNgMqlj8JWl6dekBB+Rh6fVG0u60dt4GZLvcw4ZYtFAN1AxPUQXS0JJn
         +1K3VCFNuRXykmQT0jyGvdUj+YffcZfV37XPErnoIRWW6YYzgzGYjmgFZ7LVbSFB5ECf
         oMRHoBoGgWRZEDBMdNhvgFlOSF41r16iizS4y4SKG52ePJNbQVtDfp93UGQXjTPhIfxK
         V/NEWnExVRKkYC86eFGbOQTeN1WnggTuHSz+sXyd7CR8dRoLiuSXVJsYr5G1z0RXki8R
         Tf4wmDBnDWJxQgD5mOMrGlMU5oT5fNRI+R6QfoBD/P1A2LXQIMEUGhVknZLDtV9qGMWD
         YVhA==
X-Gm-Message-State: APzg51AciFPcOdmFnoUGI1DmcpAD4E8jazS/v6lgOSHZ40+ktZhKwaLY
        EefhYJmDF5FoPH86hWjsxRxZiVoQYBbU0vGTtAJkBmYPnfKyIXNE+NhpOXC8qgdLIWUn8LrbB27
        uN85Cy6KXTWmMqyXaZGwnFtm0tK8wEqI+8u2fWSpJFescOhjND4T3DEAQT5pAvQ==
X-Google-Smtp-Source: ANB0VdbNo2OCNm/udmLX02XAvwpCviPjE3+cNClrxSC710jIx5XqtlmQ2IuHhKMyAQTSt2B+iJ2MiQ==
X-Received: by 2002:a02:b106:: with SMTP id r6-v6mr38081647jah.115.1537466655410;
        Thu, 20 Sep 2018 11:04:15 -0700 (PDT)
Received: from localhost ([173.225.52.219])
        by smtp.gmail.com with ESMTPSA id x68-v6sm1353315ita.2.2018.09.20.11.04.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 11:04:14 -0700 (PDT)
From:   Taylor Blau <ttaylorr@github.com>
X-Google-Original-From: Taylor Blau <me@ttaylorr.com>
Date:   Thu, 20 Sep 2018 14:04:13 -0400
To:     git@vger.kernel.org
Cc:     peff@peff.net
Subject: [PATCH 3/3] transport.c: introduce core.alternateRefsPrefixes
Message-ID: <3639e9058859b326f64600fcd0b608171b56ce9f.1537466087.git.me@ttaylorr.com>
References: <cover.1537466087.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1537466087.git.me@ttaylorr.com>
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
      git -C "$1" for-each-ref refs/tags \
      --format="%(objectname) %(refname)" \
    '

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
 Documentation/config.txt |  6 ++++++
 t/t5410-receive-pack.sh  | 11 +++++++++++
 transport.c              |  5 +++++
 3 files changed, 22 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index b908bc5825..d768c57310 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -622,6 +622,12 @@ core.alternateRefsCommand::
 	linkgit:git-for-each-ref[1]. The first argument is the path of the alternate.
 	Output must be of the form: `%(objectname) SPC %(refname)`.
 
+core.alternateRefsPrefixes::
+	When listing references from an alternate, list only references that begin
+	with the given prefix. To list multiple prefixes, separate them with a
+	whitespace character. If `core.alternateRefsCommand` is set, setting
+	`core.alternateRefsPrefixes` has no effect.
+
 core.bare::
 	If true this repository is assumed to be 'bare' and has no
 	working directory associated with it.  If this is the case a
diff --git a/t/t5410-receive-pack.sh b/t/t5410-receive-pack.sh
index 09fb3f39a1..df2830e9f6 100755
--- a/t/t5410-receive-pack.sh
+++ b/t/t5410-receive-pack.sh
@@ -44,4 +44,15 @@ test_expect_success 'with core.alternateRefsCommand' '
 	test_cmp expect actual
 '
 
+test_expect_success 'with core.alternateRefsPrefixes' '
+	test_config -C fork core.alternateRefsPrefixes "refs/tags" &&
+	cat >expect <<-EOF &&
+	$(git rev-parse one) .have
+	$(git rev-parse three) .have
+	$(git rev-parse two) .have
+	EOF
+	printf "0000" | git receive-pack fork | extract_haves >actual &&
+	test_cmp expect actual
+'
+
 test_done
diff --git a/transport.c b/transport.c
index e7d2cdf00b..9323e5c3cd 100644
--- a/transport.c
+++ b/transport.c
@@ -1341,6 +1341,11 @@ static void fill_alternate_refs_command(struct child_process *cmd,
 		argv_array_pushf(&cmd->args, "--git-dir=%s", repo_path);
 		argv_array_push(&cmd->args, "for-each-ref");
 		argv_array_push(&cmd->args, "--format=%(objectname) %(refname)");
+
+		if (!git_config_get_value("core.alternateRefsPrefixes", &value)) {
+			argv_array_push(&cmd->args, "--");
+			argv_array_split(&cmd->args, value);
+		}
 	}
 
 	cmd->env = local_repo_env;
-- 
2.19.0
