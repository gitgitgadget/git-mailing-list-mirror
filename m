Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9450EC433EF
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 18:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C194610D0
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 18:40:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbhJTSmX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Oct 2021 14:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbhJTSmV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Oct 2021 14:42:21 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E609C06161C
        for <git@vger.kernel.org>; Wed, 20 Oct 2021 11:40:06 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id e12so198025wra.4
        for <git@vger.kernel.org>; Wed, 20 Oct 2021 11:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qZ6JRiQL3N/PzUvDAXxR5kFqKHWDmOsT8kp1tgOJClc=;
        b=qgugUdXszZGFTHZwOVf9jwgK3gN9HThXqjxAa7klnnl5wSUoPgRftUHKU86YQ+OrKT
         N5q+d65i1b5zTSXbZ6bqKRjn6fUUQcusGxZduhjyk0cEojbqPeHAGda45ItV5qLP5t8K
         ORfNms9lv6QO21W18WeNuVzb9O367bbsij7LDGtu5eqb47iqa/iZAJIWBF0OeiQvuzQ2
         jrCbAwjXsr7EG3nnNeQ4lTvZbiHQTbCoaRivu9mAVwT5N4GvWX42gBp9LH+92wWAlqp2
         7oJijcDbK4UR89/SXdoxoE5xVWXP3ZeHtf/gxOR9gl6/VHmtIqdh+fsqdSKYtJ+soldh
         wwDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qZ6JRiQL3N/PzUvDAXxR5kFqKHWDmOsT8kp1tgOJClc=;
        b=CiQ0BKRf0cR6NPLL6okI8XbVu5DEg+6GeCq3+utjfKoVMZZ/jIruio/UzI9EMYEqWp
         awjGnAfc3IFlfyZxYh+x7gVAyv7fP14uoqEC9NpEkP13BuNam+5+fcRJtPL9GGu/ETQ/
         XzLxKscDn+qxVc84y51SF9ShNyjTSejwe83gnMrlJwUvqZGqkbBNGoJfZbXqVpILSDaN
         Py22799tO9+nh0M7wnGXr9cRC0vDqLbKbaZ2xC9XE72t7OmQt8qyyIXnFlWINaMzr2Iz
         ibQTkY5264qY0e0L3ocsr5QH/DfoPH5173M2PNm3rA70pBFAEQxbgVWYHkaLwUWinrWI
         3ZPw==
X-Gm-Message-State: AOAM5311p+AU/DsAuE5X19oVZYD/6ZYNNCMKYz7BTmhHUTKumWH2apSI
        Kk+n2LBeNOvZd29CNU3dGalKferBpl2EAA==
X-Google-Smtp-Source: ABdhPJxAIpvtGawU0AYKXgDvfsuk8lOrMTV1kbqyDbGtwZIO5zzcoRnQ/jXh4z2L6VftjTH+GqkBCQ==
X-Received: by 2002:adf:bb88:: with SMTP id q8mr1124973wrg.390.1634755204742;
        Wed, 20 Oct 2021 11:40:04 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d8sm2813835wrv.80.2021.10.20.11.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 11:40:03 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/8] generate-cmdlist.sh: spawn fewer processes
Date:   Wed, 20 Oct 2021 20:39:54 +0200
Message-Id: <patch-3.8-6b4de6a6088-20211020T183533Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1338.g20da966911a
In-Reply-To: <cover-0.8-00000000000-20211020T183533Z-avarab@gmail.com>
References: <YNqBtrXzUlJiuc7y@coredump.intra.peff.net> <cover-0.8-00000000000-20211020T183533Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Sixt <j6t@kdbg.org>

The function get_categories() is invoked in a loop over all commands.
As it runs several processes, this takes an awful lot of time on
Windows. To reduce the number of processes, move the process that
filters empty lines to the other invoker of the function, where it is
needed. The invocation of get_categories() in the loop does not need
the empty line filtered away because the result is word-split by the
shell, which eliminates the empty line automatically.

Furthermore, use sort -u instead of sort | uniq to remove yet another
process.

[Ævar: on Linux this seems to speed things up a bit, although with
hyperfine(1) the results are fuzzy enough to land within the
confidence interval]:

$ git show HEAD~:generate-cmdlist.sh >generate-cmdlist.sh.old
$ hyperfine --warmup 1 -L s ,.old -p 'make clean' 'sh generate-cmdlist.sh{s} command-list.txt'
Benchmark #1: sh generate-cmdlist.sh command-list.txt
  Time (mean ± σ):     371.3 ms ±  64.2 ms    [User: 430.4 ms, System: 72.5 ms]
  Range (min … max):   320.5 ms … 517.7 ms    10 runs

Benchmark #2: sh generate-cmdlist.sh.old command-list.txt
  Time (mean ± σ):     489.9 ms ± 185.4 ms    [User: 724.7 ms, System: 141.3 ms]
  Range (min … max):   346.0 ms … 885.3 ms    10 runs

Summary
  'sh generate-cmdlist.sh command-list.txt' ran
    1.32 ± 0.55 times faster than 'sh generate-cmdlist.sh.old command-list.txt'

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 generate-cmdlist.sh | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/generate-cmdlist.sh b/generate-cmdlist.sh
index 5114f46680a..27367915611 100755
--- a/generate-cmdlist.sh
+++ b/generate-cmdlist.sh
@@ -11,15 +11,14 @@ command_list () {
 
 get_categories () {
 	tr ' ' '\012' |
-	grep -v '^$' |
-	sort |
-	uniq
+	LC_ALL=C sort -u
 }
 
 category_list () {
 	command_list "$1" |
 	cut -c 40- |
-	get_categories
+	get_categories |
+	grep -v '^$'
 }
 
 get_synopsis () {
-- 
2.33.1.1338.g20da966911a

