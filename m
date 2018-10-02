Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D72C1F453
	for <e@80x24.org>; Tue,  2 Oct 2018 02:24:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbeJBJEy (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Oct 2018 05:04:54 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:55987 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726715AbeJBJEy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Oct 2018 05:04:54 -0400
Received: by mail-it1-f196.google.com with SMTP id c23-v6so1291242itd.5
        for <git@vger.kernel.org>; Mon, 01 Oct 2018 19:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=B7lGpwVzoTTTl71QZYzO24ADdLeKcqQoJ9sWAkF4ea4=;
        b=LIoyRAY3X/+bByf5JIuVNNd2k6SgbzO6d/mR5yQgojrmLCGoq1Df/+cImYBO+bdP2x
         AVrhOSE3kXwC/3keTdbTEr2Ted70ZlIOrNj7aNbmlCyj4NliDhwjT7sV1COVomB2Ykd0
         0aOcWePmCPyugIej4UrIZfqZo952RpKV9mi/Z3j4//UharKkdVzmseX9YQhctwyXbnJk
         IuQjxecQ/FlfdmrHr35AnP9STN5ppBK+pyssL69dIBf4EwqzMBPyJl6cR5n0+uZYWzz7
         r9lMbHQMPXLzHo2tQ5IdjxyTlSA5iftHTRJmNBFq+A3Rb8wilJ2yzsBIC28CnoELY/RR
         ppZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=B7lGpwVzoTTTl71QZYzO24ADdLeKcqQoJ9sWAkF4ea4=;
        b=eXIlnuGAQq9FNQtFkrQH+Li5bDMgvp+m7PRxYtQxVhnj/L4nlYDAqJkfu78z0Ai77U
         s5s0VIV8mG1SdCH6QxyGJMK3toSremED1fjxXZNBYnBW7CJ/i66b/aYqVkCC0o09Hlms
         GxpklTYkIDHvsiaGzsyICHERj0iBRGYF0OwD+tXKfIugaetiY5bc15Vn6/Jy2gtU063D
         fgbJOeRNeQDyyOG3Hq3scCZ0o70qTWiXYs/UCAPrlYbhgzEk6Vm3toloC1tse1ViTKbs
         ZTpUnSLPQYwFA9+HNDlG8FhqfKfUnsg7Ov/dRdxN8ZTYDzPqJ1MWAk7ePAyMGl7K6hWu
         UUZQ==
X-Gm-Message-State: ABuFfojx6Rx6wGTkJCxoHY5+TxkERLzxijO1tzvMYvnR8uFQnlTVBJbN
        fr409QAkTpWNF38EdtnOCDHi3jbLowJhxQ==
X-Google-Smtp-Source: ACcGV63T5vFnXq9UG1p2vuu7sXlin4B7oihGK80kaJ1bGLLclfKdQNoUsgYPKaKKhIJVFvqPTod30g==
X-Received: by 2002:a63:2441:: with SMTP id k62-v6mr12719931pgk.26.1538447043228;
        Mon, 01 Oct 2018 19:24:03 -0700 (PDT)
Received: from localhost ([2601:602:9200:32b0:e958:2ad1:68d0:890f])
        by smtp.gmail.com with ESMTPSA id t4-v6sm2545596pfh.45.2018.10.01.19.24.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 19:24:02 -0700 (PDT)
Date:   Mon, 1 Oct 2018 19:24:01 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com, sunshine@sunshineco.com,
        sbeller@google.com
Subject: [PATCH v4 4/4] transport.c: introduce core.alternateRefsPrefixes
Message-ID: <0d3521e92a55377d3e37ecd24ff7667dab50d61d.1538446827.git.me@ttaylorr.com>
References: <cover.1537466087.git.me@ttaylorr.com>
 <cover.1538446826.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1538446826.git.me@ttaylorr.com>
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
index ac0577d288..1dc5eb3cfa 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -632,6 +632,13 @@ Note that the configured value is executed in a shell, and thus
 linkgit:git-for-each-ref[1] by itself does not work, as scripts have to handle
 the path argument specially.
 
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
index 49d0fe44fb..94794c35da 100755
--- a/t/t5410-receive-pack-alternates.sh
+++ b/t/t5410-receive-pack-alternates.sh
@@ -30,4 +30,12 @@ test_expect_success 'with core.alternateRefsCommand' '
 	test_cmp expect actual.haves
 '
 
+test_expect_success 'with core.alternateRefsPrefixes' '
+	test_config -C fork core.alternateRefsPrefixes "refs/heads/private" &&
+	git rev-parse private/branch expect &&
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
