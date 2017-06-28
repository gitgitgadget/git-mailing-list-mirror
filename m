Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3556A1FCCA
	for <e@80x24.org>; Wed, 28 Jun 2017 17:17:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751528AbdF1RRI (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Jun 2017 13:17:08 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36409 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751492AbdF1RRG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jun 2017 13:17:06 -0400
Received: by mail-pg0-f65.google.com with SMTP id u36so8906985pgn.3
        for <git@vger.kernel.org>; Wed, 28 Jun 2017 10:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:user-agent:mime-version;
        bh=gPtMkwbtcvoZ6/tfpljVnNH/c8Ne8Gsz/7bFTLt+VlQ=;
        b=JE+Yf4/WL5E7GALERpC0ITlIF4wwSoaq2NMNggBtZPRyP0lMReN+/2IiQNEPH1b9h/
         6VLlhUt1Xq/p1Q19QDrg85VNqdjEloH0C39ir7NWsOL7UtJ1c8jGInnGL3R7kREP+N0o
         Jl9VT3Gm78AIr4QOr8o5uGKMTRHeUFl/AsI/MdXs7bjED3+A/BRgE+7o7o0xLkmVPlS2
         X4cb1sZWoJyqnguvvW0R0dv8/JaWAkUOigTdpdOZ2eGEMkPkJJT0A6jITrJJEmnnMtdO
         RmzsIzvpJlPePTQftsBZ0FezPk/uY4xJ90uG+RKktpcxyRPkrlduChr+1g9FhUNjs84T
         KnOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :user-agent:mime-version;
        bh=gPtMkwbtcvoZ6/tfpljVnNH/c8Ne8Gsz/7bFTLt+VlQ=;
        b=YNy+zbPvr0WGp7/bB+LNBcLkLk2iH+ZLNkMDDqmUJ6ayrP7Rij/wh/JDqXZPkfv78p
         nBQGQAvDV7pMoYG3WQNNKB8nDLUcRVT6vZdLCTUtA5nbV8ahpZqdd3VTod6u/zci344V
         XG38QA7Se8NBDHhdMiecttDKUAWq+4d5Pr5ByHSK6O0Qe+tnTYPgIi+sh+ScgKi0X5Aw
         YERiiAkLLwR6lCw73ev5nTjNTg6n6I7EBCmv52S0E7zqqh3n2qKNmQMPzRsJ3+iGqba3
         nMKpR5DO3/v25gnlNcuZ7CLPoZ+TYt7H8FpvKUzYWaGYEghKoDTGRPXEzq1+aqFPSNoa
         kCqQ==
X-Gm-Message-State: AKS2vOzECy7SSD9GBDxZmKn02dq/PDE2dIrGHJV53kd/35HxYRP3n4EV
        fLfh0BixPj3XhgzMSEg=
X-Received: by 10.84.215.203 with SMTP id g11mr13242369plj.287.1498670225676;
        Wed, 28 Jun 2017 10:17:05 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:88a2:2d61:9b86:f64d])
        by smtp.gmail.com with ESMTPSA id z70sm3875117pgz.3.2017.06.28.10.17.04
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 28 Jun 2017 10:17:05 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Michael Kebe <michael.kebe@gmail.com>
Subject: [PATCH] t1450: use egrep for regexp "alternation"
Date:   Wed, 28 Jun 2017 10:17:04 -0700
Message-ID: <xmqqinjgvxpr.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

GNU grep allows "\(A\|B\)" as alternation in BRE, but this is an
extension not understood by some other implementations of grep
(Michael Kebe reported an breakage on Solaris).

Rewrite the offending test to ERE and use egrep instead.

Noticed-by: Michael Kebe <michael.kebe@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t1450-fsck.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 8f52da2771..30e217dea2 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -541,7 +541,7 @@ test_expect_success 'fsck --name-objects' '
 		remove_loose_object $(git rev-parse julius:caesar.t) &&
 		test_must_fail git fsck --name-objects >out &&
 		tree=$(git rev-parse --verify julius:) &&
-		grep "$tree (\(refs/heads/master\|HEAD\)@{[0-9]*}:" out
+		egrep "$tree \((refs/heads/master|HEAD)@\{[0-9]*\}:" out
 	)
 '
 
-- 
2.13.2-655-gbf99380098

