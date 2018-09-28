Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 276D01F453
	for <e@80x24.org>; Fri, 28 Sep 2018 04:25:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbeI1Kre (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Sep 2018 06:47:34 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35640 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728709AbeI1Krd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Sep 2018 06:47:33 -0400
Received: by mail-pf1-f195.google.com with SMTP id p12-v6so3405989pfh.2
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 21:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SkH+nTUcqPVFaxrJsX1SXjCH5JsF6bf9JOZ+z+Khy6k=;
        b=lCXDw3SHsPV1rM9qi7ZW8cSiHA5N3fDClfs0QR3NUhyoQuW1JyIfJtvxWT+5B+h3K6
         277LkUHGMLsAjr4Sq5qtQhfixpHz2djC41h/pXfB2UsCFfWZyCC6FjOHp3zJ3r6NQnOG
         GcjgttqzWsdp/6DGatXS00eKcN+5NTWQZEXW/85j03aGY/zz+512sBtsyC+HA5cvl4CQ
         x1iuyNNbdFTqtfxYgeqp42ZFMmbnthZoTy43QfLtH0oxl2vjPn6wv64eMRvVN8Tqbmnp
         ymj0QsiydlxJ8ohaTixjBr8ZKUETOAMTwRUeH4pMgfH1yVAGY7DoBlq0iByfRfjUjtM8
         gXsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SkH+nTUcqPVFaxrJsX1SXjCH5JsF6bf9JOZ+z+Khy6k=;
        b=DxI6w9Wl+7+8xqytLuqvYxjg5Egzn2FmvnJzgo8fp3ATKAwO9WHdDZP6R8Y55idpaH
         Za1ab7Remz5OKLGjKx46WTcuqzyaryNtmgunYqq143Bpujb8MRJewQaNOiyrfigrAkzN
         HC0cs4oKkcluBowEcUW67mifjSCnrD2aAFR1M/UuXDbnGX8SWhjRXYka7MmqjG5IV4D5
         p+Tc/qhj7IeDclJ03ugr91ResUqf9CXcT7WQoZryIzHkPhNmAiqLdJ4vVT7HqhFtCpFB
         l3GL4BI4lvxfhybW03qTTpTT3HYjOwlLA9sRkvabKOmpXOEDqwAJRkgNwCt9kRkAQmSz
         RQCQ==
X-Gm-Message-State: ABuFfogqbwbODLufMRzJbCnyjPqkyPqbzpgDarIK58/fYxtlk87KzL8d
        4LiEruj0HSaXiSsB3EkyF6IuX393Rokc9Q==
X-Google-Smtp-Source: ACcGV60WAoToQsrIdP31rj5gCKu7h9/fzx5lIRGodN3JM1s0nTiakXncAE/lrGe+IqplnSyZ2wS1tA==
X-Received: by 2002:a62:4bc6:: with SMTP id d67-v6mr14673950pfj.175.1538108747321;
        Thu, 27 Sep 2018 21:25:47 -0700 (PDT)
Received: from localhost ([2601:602:9200:32b0:1924:afac:8279:2210])
        by smtp.gmail.com with ESMTPSA id y3-v6sm6045146pfi.24.2018.09.27.21.25.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 21:25:46 -0700 (PDT)
Date:   Thu, 27 Sep 2018 21:25:45 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com, sunshine@sunshineco.com,
        sbeller@google.com
Subject: [PATCH v3 4/4] transport.c: introduce core.alternateRefsPrefixes
Message-ID: <48eb774c9e36f468549a278fd8cf703d8a34af28.1538108385.git.me@ttaylorr.com>
References: <cover.1537466087.git.me@ttaylorr.com>
 <cover.1538108385.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1538108385.git.me@ttaylorr.com>
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
      git -C "$1" for-each-ref refs/tags --format="%(objectname)"'

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
index afcb18331a..9ef792ef0d 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -627,6 +627,13 @@ alternate's references as ".have"'s. For example, to only advertise branch
 heads, configure `core.alternateRefsCommand` to the path of a script which runs
 `git --git-dir="$1" for-each-ref --format='%(objectname)' refs/heads`.
 
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
index 503dde35a4..3449967cc7 100755
--- a/t/t5410-receive-pack.sh
+++ b/t/t5410-receive-pack.sh
@@ -46,4 +46,12 @@ test_expect_success 'with core.alternateRefsCommand' '
 	test_cmp expect actual.haves
 '
 
+test_expect_success 'with core.alternateRefsPrefixes' '
+	test_config -C fork core.alternateRefsPrefixes "refs/tags" &&
+	git rev-parse one three two >expect &&
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
