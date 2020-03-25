Return-Path: <SRS0=ys1m=5K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C3FC54FD0
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 14:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0214A20777
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 14:36:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JciNqq0V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbgCYOgW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Mar 2020 10:36:22 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35811 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727585AbgCYOgW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Mar 2020 10:36:22 -0400
Received: by mail-pg1-f196.google.com with SMTP id 7so1237704pgr.2
        for <git@vger.kernel.org>; Wed, 25 Mar 2020 07:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1808Pz+mPCQBfoTtNaHgUSvBIgKMS/DSbanMQj/f8fY=;
        b=JciNqq0VkAjmGj60GVx0egyPDALdUC7e1joXHId/+3U4TFPz6p4nn3mvDBs4wg+Qp+
         hmaQT8Q55SBcDp1mUrhQNfsKQK/AuThfxCMHugtWDgVnUf5es9WkjzUCwchzBOcyBzHR
         bZX0PgYJMR793pGMdOh8HG+vQS/MLNv8qe7UFMZhVIFWoJagzM8B7DT8Ync7sj4YkbL4
         5SyPBkWA61Ifcp0ruSvf1YFfs/htoRQ3dLNgNNHhddd+inLbJa/M82J1txudP+WJms/2
         rVlzTa9VrvX6X9G4RxK0wz7ZFlEVswv5QRrAF8o7XKM7TmX8hU2VXKB9+/K8W4SYTIHp
         s2sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1808Pz+mPCQBfoTtNaHgUSvBIgKMS/DSbanMQj/f8fY=;
        b=hWFZal7Q01JN+d59eSp/vXPcVnl5jf8wZ864UqDBcSM6kEwvkPoVRQDr3/DltleVjC
         +7orZgiHUIyt//My+/Hi5ZBwJHRSfmg9MCRnOslATnRZv7oEQSWJQzCijbnn9HCguGc5
         P4lgcCqKKIQjUuFa1UZ5DUR9AWuMMMrBv0NP3uQ3ufo9yrQUnhnNue40v/x6KrLQ7rGD
         +zF+boZeoASEO5D6tvYYPp8pmD8WRzOcHQMmkVxfBIqMCnSr7UTUdtWLBtzPsaeiW80G
         g/qDDju5IWQkTpOLoUVUjQZ5CXg87bjwWjGSAlUx8EUU5mJvjfCQ3KoxEWd6waC10jJM
         cmNw==
X-Gm-Message-State: ANhLgQ2y1MUwFSFUePsPzM58L26G2TIrEXMDejkRJZVI3qJX87JoUj4s
        P1NGvUjPwo0MQx3HcdXlMp4=
X-Google-Smtp-Source: ADFU+vuYG2S+klk3JP/jz5loYn6kSDaK5Dw3STYealfGtfTdz/7pzyb/9V/0KCywiDyCTILP7QYeqg==
X-Received: by 2002:a63:de53:: with SMTP id y19mr3384583pgi.445.1585146979329;
        Wed, 25 Mar 2020 07:36:19 -0700 (PDT)
Received: from localhost.localdomain ([47.89.83.3])
        by smtp.gmail.com with ESMTPSA id f127sm18180423pfa.112.2020.03.25.07.36.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Mar 2020 07:36:18 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
X-Google-Original-From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Emily Shaffer <emilyshaffer@google.com>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH 0/3] Never report references we not push
Date:   Wed, 25 Mar 2020 22:36:05 +0800
Message-Id: <20200325143608.45141-1-zhiyou.jx@alibaba-inc.com>
X-Mailer: git-send-email 2.26.0.3.ga7a9d752d4
In-Reply-To: <20200322131815.11872-3-worldhello.net@gmail.com>
References: <20200322131815.11872-3-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A strange behavior is found when writing test cases for topic
'jx/proc-receive-hook':

> # TODO: report for the failure of master branch is unnecessary.
> test_expect_success "no proc-receive hook, fail all for atomic push" '
> 	(
> 		cd workbench &&
> 		test_must_fail git push --atomic origin \
> 			HEAD:next \
> 			HEAD:refs/for/master/topic
> 	) >out 2>&1 &&
> 	format_git_output <out >actual &&
> 	cat >expect <<-EOF &&
> 	remote: # pre-receive hook
> 	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
> 	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
> 	remote: error: cannot to find hook "proc-receive"
> 	To ../upstream
> 	 ! [rejected]        master (atomic push failed)

We do not push "master" branch, but git reports status for it.

> 	 ! [remote rejected] HEAD -> next (fail to run proc-receive hook)
> 	 ! [remote rejected] HEAD -> refs/for/master/topic (fail to run proc-receive hook)
> 	error: failed to push some refs to "../upstream"
> 	EOF
> 	test_cmp expect actual &&
> 	(
> 		cd upstream &&
> 		git show-ref
> 	) >out &&
> 	format_git_output <out >actual &&
> 	cat >expect <<-EOF &&
> 	<COMMIT-A> refs/heads/master
> 	EOF
> 	test_cmp expect actual
> '

This issue is introduced by commit v2.22.0-1-g3bca1e7f9f (transport-helper:
enforce atomic in push_refs_with_push, 2019-07-11).  That commit wanted to
fix report issue of HTTP protocol, but marked all remote references failure
for atomic push.

--

Jiang Xin (3):
  t5543: never report what we do not push
  send-pack: mark failure of atomic push properly
  transport-helper: enforce atomic in push_refs_with_push

 send-pack.c                |  2 +
 t/t5541-http-push-smart.sh | 12 ++++-
 t/t5543-atomic-push.sh     | 92 ++++++++++++++++++++++++++++++++++++++
 transport-helper.c         | 15 +++++++
 transport.c                | 14 ------
 5 files changed, 119 insertions(+), 16 deletions(-)

-- 
2.26.0.3.ga7a9d752d4

