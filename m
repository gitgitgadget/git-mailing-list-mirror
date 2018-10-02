Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E12491F453
	for <e@80x24.org>; Tue,  2 Oct 2018 23:28:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbeJCGOk (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Oct 2018 02:14:40 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33445 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725724AbeJCGOk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Oct 2018 02:14:40 -0400
Received: by mail-pf1-f194.google.com with SMTP id d4-v6so733109pfn.0
        for <git@vger.kernel.org>; Tue, 02 Oct 2018 16:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zu8UIzmsN792SU20Q0HRoobP4FBBh8TERIVTGoKk/Rg=;
        b=SU0jSvrr4/qDt5iCQPLwv4mS0UeAAWssGajchoio18szxTSfbtnk3gOyIZPs5goFDC
         /cyLEWuv3Ls9k6QRYa1ahjb6FwMyBJ/USrtwDm1hnEQX43EsID/PMBT8xHZ6R5NzZT8g
         47Jw5s19O5yieObO11I8HvmbdxncyXeww6ZUCkg1vazP3ofM9K8J1GDznru3gxtqDcK3
         kpzmlVyRpuosLx98gLsg+zRgkJ/0r2QvnjmoSFPcX8BLCBRdmarAvgq4Izz5qFDU85ED
         bcuzOh1W3xV7WcAscN0tRNAMFbaF+Ml2IOd1PA8hTu2aluIfQx0tsicm3r1qvKEk0S3H
         IofA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zu8UIzmsN792SU20Q0HRoobP4FBBh8TERIVTGoKk/Rg=;
        b=on4uPJ8VT24j2Uyqtd6L5IpA/pz7EnfUomGRspNsJwKzOQ05S992McTw9VDlogiIsa
         7X6OAeyP+tnsIXu1vdifbNd2XTgyjICQ9wVb3CcB7he72lxaUXFH6IsYnikNZiGDORwq
         cR1PksluPH/IvJa9kjo2R9+3UlkCwousfzUFVvuqWgINOBlsx+bBMugqIYEV54ahs3cq
         I9CzTe3a41AS0fWEIwG3X6xfJh2Zzf6fg+GyByzK60rcTACdy8AvxXJap1RkjN8gxA4g
         7Je4BSGeaO87gTxxWXM+y5HzCEnIid/xnehzrJxoiKOhotaDKSrgRvo0c+4R0quoq5Rq
         m/1g==
X-Gm-Message-State: ABuFfoh4gDVay797iJWYZBLwO2ekHfEPaBpDTGMjGnoxWMLIpu4udF4a
        z/lLBHBAwxD2hRuT2XGEVj0mcY+ZMOQj0Q==
X-Google-Smtp-Source: ACcGV629PGyMDnUNUax1Be3snv1k7Lt9RA5ahV3A15NTowzx5RNTHaWaFBf4nPkv+35l7P0jnyKnfg==
X-Received: by 2002:a62:1906:: with SMTP id 6-v6mr9244694pfz.9.1538522931521;
        Tue, 02 Oct 2018 16:28:51 -0700 (PDT)
Received: from localhost ([2601:602:9200:32b0:e958:2ad1:68d0:890f])
        by smtp.gmail.com with ESMTPSA id h130-v6sm22498286pgc.88.2018.10.02.16.28.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 16:28:50 -0700 (PDT)
Date:   Tue, 2 Oct 2018 16:28:40 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org, ramsay@ramsayjones.plus.com
Cc:     peff@peff.net, gitster@pobox.com, sunshine@sunshineco.com,
        sbeller@google.com
Subject: [PATCH v4 4/4] transport.c: introduce core.alternateRefsPrefixes
Message-ID: <20181002232840.GA31540@syl>
References: <aeee4d8f-b224-2b1b-40fb-d484dbaabae3@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeee4d8f-b224-2b1b-40fb-d484dbaabae3@ramsayjones.plus.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 02, 2018 at 04:13:13PM +0100, Ramsay Jones wrote:
>
> On 02/10/18 03:24, Taylor Blau wrote:
> [snip]
> > diff --git a/t/t5410-receive-pack-alternates.sh b/t/t5410-receive-pack-alternates.sh
> > index 49d0fe44fb..94794c35da 100755
> > --- a/t/t5410-receive-pack-alternates.sh
> > +++ b/t/t5410-receive-pack-alternates.sh
> > @@ -30,4 +30,12 @@ test_expect_success 'with core.alternateRefsCommand' '
> >  	test_cmp expect actual.haves
> >  '
> >
> > +test_expect_success 'with core.alternateRefsPrefixes' '
> > +	test_config -C fork core.alternateRefsPrefixes "refs/heads/private" &&
> > +	git rev-parse private/branch expect &&
>
> s/expect/>expect/ ?

Ah, certainly. Thanks for catching my mistake. I've resent 4/4 as below.

Junio -- if you find this re-roll to be acceptable, please queue this
patch instead of the one that it is in reply to.

-- >8 --

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
