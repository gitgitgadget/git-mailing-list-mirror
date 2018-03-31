Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C31B11F404
	for <e@80x24.org>; Sat, 31 Mar 2018 12:40:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752153AbeCaMgZ (ORCPT <rfc822;e@80x24.org>);
        Sat, 31 Mar 2018 08:36:25 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:34338 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751678AbeCaMgY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Mar 2018 08:36:24 -0400
Received: by mail-wm0-f42.google.com with SMTP id w2so258338wmw.1
        for <git@vger.kernel.org>; Sat, 31 Mar 2018 05:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j97e6k39J4F+3eXaWiPFx8UeZavDF7OYbW72RRsXQGk=;
        b=pSO0yIWO4Ro03VzuNsfJLJtHaE5U/h0ufcBxtnphK5uS3eg8qIi+/Qy0NJ2xVp0y69
         UxjwNRxWqiptheNJJJDWnSXYKJhU/ATA1ctcq+gXN9QSaM/gYHyxxdzwAnDhpfHbu6gz
         7iUbrn1XEWjzofyyTCvQIOQReRIZYR/odTZwmGj2xjru6xmbPi37cKcKTLCFvFrhE6sZ
         fkKjeP6MxqmB2XsX/rXhTcQx3qip7KYYQ/EztUX97/olFunWrke8IFMTMS+EaPVC0YJi
         WotbWNumsXMEcs/iL9/OhAkpwauLmMnpoZ4NSeRMf/TLhJV5Bvtq1DxrV9fxBzaRRcfg
         H1UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j97e6k39J4F+3eXaWiPFx8UeZavDF7OYbW72RRsXQGk=;
        b=bshTD+8gWRCVmjtLc5/ROLQPwFFyCbiCqQbky6TamwXFK+kI4G5eEKtr9JhKyT4hvg
         K62f2gLeR02Lyi5VuqqeiQfBX2Erj77ibagAfgjeUHpKub57CcIvmiqmywg/+rkUQC/b
         yNB2Ggc0LMVgmOsQ88Of1Hi1L2lZ6xWqXBTYeKvdNFyFx9PCzsSj02ZvSJKoDHMAhuDD
         ruiFR8+BGMI3YDpeCBzIFCTuhaVh99khY5MynhA3bPsOIMUHccRPoFuOU+0xEdHoP+3s
         N3nyW7GRH9rT4FaCNy3grMS/WUmnj5Am3rAJ14vtNRjbtSN5lCUWT/xw5SPh/svGPwfU
         Nbgg==
X-Gm-Message-State: AElRT7GPEUerzt3dctX++/GBqzJhAUM++VMGp2rFrXiTP54w1CTmSAmQ
        HetfHwscSPuBk3ZGJHw3dH/ov0XE
X-Google-Smtp-Source: AIpwx48M8hRAB32J9ljDqAzuELPgKV34jqrqiq23db+zm3QgeVIByl+rCeyiHiNjBz4RaANqpe+ZfA==
X-Received: by 10.28.231.2 with SMTP id e2mr1411118wmh.32.1522499782424;
        Sat, 31 Mar 2018 05:36:22 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id u110sm18663487wrc.72.2018.03.31.05.36.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 31 Mar 2018 05:36:21 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] add -p: fix 2.17.0-rc* regression due to moved code
Date:   Sat, 31 Mar 2018 12:36:05 +0000
Message-Id: <20180331123605.30076-1-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.rc1.321.gba9d0f2565
In-Reply-To: <20180213103241.6789-3-phillip.wood@talktalk.net>
References: <20180213103241.6789-3-phillip.wood@talktalk.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a regression in 88f6ffc1c2 ("add -p: only bind search key if
there's more than one hunk", 2018-02-13) which is present in
2.17.0-rc*, but not 2.16.0.

In Perl regex variables like $1 always refer to the last regex
match. When the added a new regex match between the old match and the
code that was expecting its $1, the $1 variable would always become
undef.

As a result the "/" feature to search for a string in a hunk by regex
completely broke, on git.git:

    $ perl -pi -e 's/Git/Tig/g' README.md
    $ ./git --exec-path=$PWD add -p
    [..]
    Stage this hunk [y,n,q,a,d,j,J,g,/,s,e,?]? s
    Split into 4 hunks.
    [...]
    Stage this hunk [y,n,q,a,d,j,J,g,/,s,e,?]? /Many
    Use of uninitialized value $1 in string eq at /home/avar/g/git/git-add--interactive line 1568, <STDIN> line 1.
    search for regex? Many

I.e. the initial "/regex" command wouldn't work, and would always emit
a warning and ask again for a regex, now it works as intended again.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

Junio: You'll want this for 2.17.0 final. I didn't have time to add
tests for this, but looking over t3701-add-interactive.sh it seems
doable. Phillip: Maybe something you'd be interested in?

 git-add--interactive.perl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index d190469cd8..c1f52e457f 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -1564,7 +1564,7 @@ sub patch_update_file {
 					error_msg __("No other hunks to search\n");
 					next;
 				}
-				if ($1 eq "") {
+				if ($regex eq "") {
 					print colored $prompt_color, __("search for regex? ");
 					$regex = <STDIN>;
 					if (defined $regex) {
-- 
2.17.0.rc1.321.gba9d0f2565

