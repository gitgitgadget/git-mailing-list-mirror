Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 407C7C433FE
	for <git@archiver.kernel.org>; Tue,  4 Oct 2022 13:26:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbiJDN0t (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Oct 2022 09:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbiJDN0L (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2022 09:26:11 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D317912751
        for <git@vger.kernel.org>; Tue,  4 Oct 2022 06:24:50 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id j7so15946390wrr.3
        for <git@vger.kernel.org>; Tue, 04 Oct 2022 06:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eP+nJP+tJd2xv8J0rYfnLMDNiZkg2VWyZtcxsq+Enl4=;
        b=chPRnejrUgxgBJNcXrZPbkRziI0NMX6huLa7GEr0B9w+Av8D0pPg/K9GyRjHGkQ+i9
         w63I4be06t9Hg0XgKbaZcBBH5/14iOk0aoPZL9Kajhkm/+Wbk+3pTZe2dxiAMiEU5Dbf
         npWSWxvoaUr4/OygQmCTC/bPSKyVyBPLn5nBNgRPiW80E1GaaCu/sIGtaEYbCPkOiF0a
         iSZn4SyMqkh6/ykOIdCjkJv9JAiPlgNvZdMB2Xymf9eXOehYzyOBlKC6eiieuzGBHkEY
         ALi/K8axcrAWG/G/MhmLlPtRCjsb94bRXAXo3WksDo1dTE0j3u9abI0DFOnScEAEceIp
         vshQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eP+nJP+tJd2xv8J0rYfnLMDNiZkg2VWyZtcxsq+Enl4=;
        b=L4EcBIkEUths+pDtJQETmuDZ18UCl2B+arpep6ZyAkpjEBFnhnxEfdFL4ys629c8n8
         UsOobzIN46auRj5K4O2FeBFZtntRG/EhHmSzCl6LZod3MIUdbfgFtLrDHCMJkKjnDRMJ
         atEmKCdvfh/TudZtW41TECYXnppnlpInO8cAchH6RLlHTL94sdWDcRiiqmKl1eZpK7oo
         L+kQeLLRp6URGTXllZ1UN5vpKx1pIElrIjEIE224z7nRteKBAa2hX1yhzH8kz6Wgpjss
         mrE+MYBlmY33GKKrRBnAFIRC0G4YCEXey/rkb/QVdOtOm0piIvbW7FFRtvzRYhvtgwgs
         TInA==
X-Gm-Message-State: ACrzQf0wvHMItwTQEk5FVjsjnVrc7n2eiiE3HIzsdeQOtkF24wJRQnT5
        zTEKIvsUnt1NyLx0mArvqoF6WZ7Ds7dSHg==
X-Google-Smtp-Source: AMsMyM7Lz1LQVihz4SGuVPBw/t5KDfyHD8H54xSCt9YJ1MZarl6JXBsZN46OMML5iQcSFnLWIPzeaQ==
X-Received: by 2002:adf:fac7:0:b0:22e:4773:23a9 with SMTP id a7-20020adffac7000000b0022e477323a9mr4193134wrs.537.1664889869501;
        Tue, 04 Oct 2022 06:24:29 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t187-20020a1c46c4000000b003b4a699ce8esm19666022wma.6.2022.10.04.06.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 06:24:28 -0700 (PDT)
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
Subject: [PATCH v4 30/34] reflog doc: list real subcommands up-front
Date:   Tue,  4 Oct 2022 15:23:44 +0200
Message-Id: <patch-v4-30.34-2452157548b-20221004T132211Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc2.935.g6b421ae1592
In-Reply-To: <cover-v4-00.34-00000000000-20221004T132211Z-avarab@gmail.com>
References: <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com> <cover-v4-00.34-00000000000-20221004T132211Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the "git reflog" documentation to exhaustively list the
subcommands it accepts in the SYNOPSIS, as opposed to leaving that for
a "[verse]" in the DESCRIPTION section. This documentation style was
added in cf39f54efc6 (git reflog show, 2007-02-08), but isn't how
other commands which take subcommands are documented.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-reflog.txt | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-reflog.txt b/Documentation/git-reflog.txt
index 0537d4645be..ec64cbff4c6 100644
--- a/Documentation/git-reflog.txt
+++ b/Documentation/git-reflog.txt
@@ -8,14 +8,6 @@ git-reflog - Manage reflog information
 
 SYNOPSIS
 --------
-[verse]
-'git reflog' <subcommand> <options>
-
-DESCRIPTION
------------
-The command takes various subcommands, and different options
-depending on the subcommand:
-
 [verse]
 'git reflog' [show] [<log-options>] [<ref>]
 'git reflog expire' [--expire=<time>] [--expire-unreachable=<time>]
@@ -25,6 +17,10 @@ depending on the subcommand:
 	[--dry-run | -n] [--verbose] <ref>@{<specifier>}...
 'git reflog exists' <ref>
 
+DESCRIPTION
+-----------
+This command manages the information recorded in the reflogs.
+
 Reference logs, or "reflogs", record when the tips of branches and
 other references were updated in the local repository. Reflogs are
 useful in various Git commands, to specify the old value of a
@@ -33,7 +29,8 @@ moves ago", `master@{one.week.ago}` means "where master used to point
 to one week ago in this local repository", and so on. See
 linkgit:gitrevisions[7] for more details.
 
-This command manages the information recorded in the reflogs.
+The command takes various subcommands, and different options
+depending on the subcommand:
 
 The "show" subcommand (which is also the default, in the absence of
 any subcommands) shows the log of the reference provided in the
-- 
2.38.0.rc2.935.g6b421ae1592

