Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14EB5C433F5
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 14:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDEE061076
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 14:08:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233173AbhKEOK7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Nov 2021 10:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232410AbhKEOKy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Nov 2021 10:10:54 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBADDC061205
        for <git@vger.kernel.org>; Fri,  5 Nov 2021 07:08:14 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id d27so13950077wrb.6
        for <git@vger.kernel.org>; Fri, 05 Nov 2021 07:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B5Swx9VdjvtamvSVW37GGIJEyh7h5iebvID3bk1d5ow=;
        b=qQHXlBFK3MRF8FHuujRxxpBHm3iYGYe7KAcf00ZgEaTiViMJSVgKHr2eYgQ6o4ad3n
         c4rXz57HPZAJeBZUMT8PrphPoVUULHXT/5M5FNHi90UQd+AOQ2BsF1uRpLD2eFITVu92
         wl11Cyb5CrU49CDgW5lp75PcRvavCLE0x/86dTbItxFen8bMHVKb0jxqqcXM7f2ZlqhF
         qMkG+x0vGY9cRBpEgjt8utK1xizUP24kucw+akr3zi6Xrh/k6HdCHdUSomNxUR4ginZj
         m9d3T5oEV4xmW5Gc4PE4vy+CjeRhTikRzSevkNkfYOsNG9JIl+c3kiwkzVdEXdFC/0g2
         Q4cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B5Swx9VdjvtamvSVW37GGIJEyh7h5iebvID3bk1d5ow=;
        b=XNFlBpd7iDZX0RuZsNQFy25Ej0712ZCNRIJWrMooV9Szz5yBYPMJp1twycSZZUNW+0
         GdBrwhWDfQjtV9wPAplO/z0TLToXC+wUAt455M9uSQigNymILVc+C77GmLo+YuG9IA8O
         le4pg5uK3+z4u7YigRaZPl3gbSUKuw6/y/EIEeEAiW3jxzhwVHRhjyGSqlLwdF6TcTNF
         JUjfv85pC9ZOy4YW96FaH3d6GiaHpWHIZLZG1P6g+pxd5Ala2qESCODVo6z43sH0mKo/
         tv1rxHly+9HCBNp5beC5Wb6opCQ0F29/Dg3z/D4lYfG5Nf9/hazFi4O6XLvImqYW0EAY
         U16w==
X-Gm-Message-State: AOAM5318799cegVWjfNjdX0H5krD8tFQ2DogTvfQF0kifxDu+Ik+Jcfe
        8ab/+3yFO+nEYTYTtBexhwfSDfR0ClL6Vg==
X-Google-Smtp-Source: ABdhPJxrCr5hve1lvo5id6des6gOmm0T0VfiIIM399bRQ7SbWAda3ysYtZnfeMDVCHOVng/rRi4VLw==
X-Received: by 2002:adf:f60c:: with SMTP id t12mr65157439wrp.341.1636121293152;
        Fri, 05 Nov 2021 07:08:13 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c15sm7821556wrs.19.2021.11.05.07.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 07:08:12 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 03/10] generate-cmdlist.sh: spawn fewer processes
Date:   Fri,  5 Nov 2021 15:08:01 +0100
Message-Id: <patch-v3-03.10-737cca59d99-20211105T135058Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.rc1.741.gab7bfd97031
In-Reply-To: <cover-v3-00.10-00000000000-20211105T135058Z-avarab@gmail.com>
References: <cover-v2-00.10-00000000000-20211022T193027Z-avarab@gmail.com> <cover-v3-00.10-00000000000-20211105T135058Z-avarab@gmail.com>
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
2.34.0.rc1.721.ga0c1db665bc

