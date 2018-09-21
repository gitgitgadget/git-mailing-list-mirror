Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E4D81F453
	for <e@80x24.org>; Fri, 21 Sep 2018 18:47:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391253AbeIVAh7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Sep 2018 20:37:59 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:40644 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391243AbeIVAh6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Sep 2018 20:37:58 -0400
Received: by mail-it1-f194.google.com with SMTP id h23-v6so3068226ita.5
        for <git@vger.kernel.org>; Fri, 21 Sep 2018 11:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DQeShH8Z6dTYiTO3fW9HmuaF28YFRisVcTLwHCxx5BA=;
        b=cxvcKJZ0CKXTYu77P972vOMk3sV+xjFUp7vXSvl+Kz8I05TWetGl4tYu8FkT/sMhDU
         J8aTNq1hrcJV+Uq1geZNiAw1P9WInmnDxWFPYL7qMtI99ezDMgscXWf/gVGzZDrIzi/O
         Wv5XNEYDWbnCXXHOKAivT8vElgLNqW9qdX9ys1dcmnDjb5SGyRuO8DcyX3xT/d+k4q4Z
         glEdwWl5UdcRpBhcWme3dG5ic9uZnabULkA0X0iuLhASuW8Jx0M8dBq+VmDlJdcpcCbt
         fBNmQQM7Dq++B/R2Vj1BKdd2U7nN0ye5A/ZGWBcMxye2yKWDF58/gWgx2nJrXuAsM3Vh
         bGWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DQeShH8Z6dTYiTO3fW9HmuaF28YFRisVcTLwHCxx5BA=;
        b=gw7YnkMU6SO2PL4UpvN2wnYKLXqpK2dJ+4F8b5clBzXinE69NWMoat+HH+dTpduEkv
         ati3tta4gpuI2N+InkpUPOo2e3ASsL5AYgYF3uOqdneTyRvGPlT2T9Ws3MVUa/0oLMfi
         cc2M8rOZyv9uRlRB+ugpbdjDOdNKlUv3G6YpZCltWDI47nppkX8qsNIldWRMp49VhZ88
         I0vgJM7ctUehz6z58kgQH6tfCPjTggZq8tfEfGhNlk8fF+sLr2NumR7kU9+dDuDq7wUH
         nC3MnXu3FsM8Fz58C46m4gqvdJUmWGQeRay8HMbkkUDMr7kkevZRWiG6p2mtHJ3bbjy4
         em/A==
X-Gm-Message-State: APzg51BGi9LW25dnbOpfSuxxh9BQ5w6ZDNYLu/kecQVsMWT3x0oZRRxm
        sAyZSQrW0QWI/wD1IvAz2WIQGAEK4z0=
X-Google-Smtp-Source: ANB0VdYUkpk0PKxNesLSMC7+6lAyHNDTqOKHtfj/IkN2bdbXQMX8n2oRPrZM0Sc5k6+Nc13v6hGuvw==
X-Received: by 2002:a02:6552:: with SMTP id u79-v6mr5445273jab.102.1537555668218;
        Fri, 21 Sep 2018 11:47:48 -0700 (PDT)
Received: from localhost ([173.225.52.220])
        by smtp.gmail.com with ESMTPSA id q196-v6sm10336716iod.23.2018.09.21.11.47.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 11:47:46 -0700 (PDT)
Date:   Fri, 21 Sep 2018 14:47:45 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com, sunshine@sunshineco.com,
        sbeller@google.com
Subject: [PATCH v2 3/3] transport.c: introduce core.alternateRefsPrefixes
Message-ID: <6e8f65a16dc0be84234d2be93bb4a5c9a585dd57.1537555544.git.me@ttaylorr.com>
References: <cover.1537466087.git.me@ttaylorr.com>
 <cover.1537555544.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1537555544.git.me@ttaylorr.com>
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
 Documentation/config.txt | 7 +++++++
 t/t5410-receive-pack.sh  | 8 ++++++++
 transport.c              | 5 +++++
 3 files changed, 20 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 526557e494..7df6c22925 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -627,6 +627,13 @@ alternate's references as ".have"'s. For example, to only advertise branch
 heads, configure `core.alternateRefsCommand` to the path of a script which runs
 `git --git-dir="$1" for-each-ref refs/heads`.
 
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
diff --git a/t/t5410-receive-pack.sh b/t/t5410-receive-pack.sh
index 2f21f1cb8f..b656c9b30c 100755
--- a/t/t5410-receive-pack.sh
+++ b/t/t5410-receive-pack.sh
@@ -51,4 +51,12 @@ test_expect_success 'with core.alternateRefsCommand' '
 	test_cmp expect actual.haves
 '
 
+test_expect_success 'with core.alternateRefsPrefixes' '
+	test_config -C fork core.alternateRefsPrefixes "refs/tags" &&
+	expect_haves one three two >expect &&
+	printf "0000" | git receive-pack fork >actual &&
+	extract_haves <actual >actual.haves &&
+	test_cmp expect actual.haves
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
2.19.0.221.g150f307af
