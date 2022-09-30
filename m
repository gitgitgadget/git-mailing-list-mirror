Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 590D0C433F5
	for <git@archiver.kernel.org>; Fri, 30 Sep 2022 18:08:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbiI3SIs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Sep 2022 14:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231983AbiI3SIb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2022 14:08:31 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1BCC1E554D
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 11:08:27 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id bq9so8014938wrb.4
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 11:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=ktSYxbnRuDqJ9tFuiHIx8TaUEBHEnBnK88Mi291je3M=;
        b=hKqpYBoHRif96JIsuwEsXXnp3k0aEKqwisjoKdi0upMlZvG98bAreorYpd0lMClBz+
         c4Z807R88GB/YQTtTqIbI0RDfhFeDnTqx+Z909JShhCI+0u1HmvhbTQ932aYRKJOCNXF
         rsTw0xBZQzNqNaStGmj2fVDKt1rF3yd/H6I9lBwDA/stVo2bPwncFTyUVbow7QtQ81l0
         jGP3aG9WSSl/YtTSc8zp6m3IsFa6Svdju1gF3cu1usAXgYZeO6K4awmvROaojpPb7s5/
         YZDGTkPPSgH9rzRR8oy/jIkcmg8jhK6SJsaMHleyGtSUcSJYOhJg4y0sxdB+syUb6YaF
         K79w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ktSYxbnRuDqJ9tFuiHIx8TaUEBHEnBnK88Mi291je3M=;
        b=ikppzAivvULjjqjImygmlp/UZ2JdYu2b00fazzM38yi/jnhlWiZ40AHWxTuGajk8Zb
         fvHWLlX1UosZOlepmE0Y+uBH59PYg0Vp9qqtuqx3jvYH8Y3Lxl4OM8Wnl/NmoAvlE4/4
         oNebxXjN8W+5zBoOvK1jBUrFC2JmkxDiGFPFcg3vdmhhpzPEW2/WWIPTyGGtY2uoCZPh
         T5G6Yi2EzyrRMV4+EfoZz2KXMZBbhoSwX5oAx4IuR/EHA49f3DwLXXtBcIVDdSzzlibv
         gKJgG/IqWukUepo/e9PGUkL8YN7MyDEQGd0StBZHxqI/a4i0DTtDNw4grnp0By8NS606
         F/LA==
X-Gm-Message-State: ACrzQf1rArwZeSDEV5VZxscdL5Nu0opBaElcZvsgtbE7PQt4U7AkLITp
        wBGxKltcmx6JIDu5Dvh4HkySiNOq1IIPcw==
X-Google-Smtp-Source: AMsMyM5psRJ9gwUtNoL4Zpe52LBS5cRvqUfEoz7at4ko58qFo4tFHviHSzWybZjynIIrx0PP80e3dg==
X-Received: by 2002:a05:6000:168f:b0:22e:4c3:de09 with SMTP id y15-20020a056000168f00b0022e04c3de09mr1563579wrd.40.1664561305833;
        Fri, 30 Sep 2022 11:08:25 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h9-20020a1c2109000000b003b4fac020c8sm7102703wmh.16.2022.09.30.11.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 11:08:24 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 05/36] doc SYNOPSIS: don't use ' for subcommands
Date:   Fri, 30 Sep 2022 20:07:28 +0200
Message-Id: <patch-v3-05.36-ec977f7c8fe-20220930T180415Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc2.935.g6b421ae1592
In-Reply-To: <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com>
References: <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com> <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Almost all of our documentation doesn't use "'" syntax for
subcommands, but these did, let's make them consistent with the
rest.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-reflog.txt | 2 +-
 Documentation/git-rerere.txt | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-reflog.txt b/Documentation/git-reflog.txt
index db9d46edfa9..0537d4645be 100644
--- a/Documentation/git-reflog.txt
+++ b/Documentation/git-reflog.txt
@@ -17,7 +17,7 @@ The command takes various subcommands, and different options
 depending on the subcommand:
 
 [verse]
-'git reflog' ['show'] [<log-options>] [<ref>]
+'git reflog' [show] [<log-options>] [<ref>]
 'git reflog expire' [--expire=<time>] [--expire-unreachable=<time>]
 	[--rewrite] [--updateref] [--stale-fix]
 	[--dry-run | -n] [--verbose] [--all [--single-worktree] | <refs>...]
diff --git a/Documentation/git-rerere.txt b/Documentation/git-rerere.txt
index 4cfc8833780..4b613d4140c 100644
--- a/Documentation/git-rerere.txt
+++ b/Documentation/git-rerere.txt
@@ -8,7 +8,7 @@ git-rerere - Reuse recorded resolution of conflicted merges
 SYNOPSIS
 --------
 [verse]
-'git rerere' ['clear'|'forget' <pathspec>|'diff'|'remaining'|'status'|'gc']
+'git rerere' [clear|forget <pathspec>|diff|remaining|status|gc]
 
 DESCRIPTION
 -----------
-- 
2.38.0.rc2.935.g6b421ae1592

