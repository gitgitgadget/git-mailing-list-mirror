Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0AA5C433F5
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 19:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99D2861108
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 19:36:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234294AbhJVTi5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Oct 2021 15:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234043AbhJVTio (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Oct 2021 15:38:44 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BBC4C061764
        for <git@vger.kernel.org>; Fri, 22 Oct 2021 12:36:26 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id r7so3858415wrc.10
        for <git@vger.kernel.org>; Fri, 22 Oct 2021 12:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kmBk057MADwf3Hiz0M6RNSfV69uEK+bbWEu36CyNcyk=;
        b=mEuBE9SST+kgnIpyfPbNqfPFV1GV5GcaC2+FMDhBCdB7amKDF+Zm6Walu6i0SGu7KC
         du968fZYGa8Xl5qZrZkKOhVxl8YDO/RFkdL4d8IixMswIBu2EHcxm0qtA2ffv0zPixUM
         PiosNRD/AzEp5HHgw0DrKGkR258Xwt6fMQYq3CBjjEg/i9BU6+kaUd8IPjj4Fi3e/OdS
         ztoXn6BhVX781M4KXH7YnLLH6vFx/NpEe4fsTP2Lsq63EN5DhNfrtXWyhEr/jaI/FXdd
         TUbKwmaCBHSg5LGtfC+PBZUxausDcQ9MiWMlnBDs4xkVAjOkvfpALX0chbMLul19her/
         5EQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kmBk057MADwf3Hiz0M6RNSfV69uEK+bbWEu36CyNcyk=;
        b=R94YiVW7NZMEnTpfJC9CndTH44lr9177fwXZCmfFZSLUkbvLpcSjOHUR9Cn96Vy+t9
         QJSJbg9cWfgB5Ye+0jgtKzkPvNxqiYCLd7aht7JTrjxhha7dozP8iNZjsyqxwZcmHZ+3
         pUrOtDSxdFQtKNawYiZKpMKZpcGi6LugSQFO5GaAGucIDygBoQ7GCbt9w3W3n2dsk04s
         63zxs30XRp4pRGPW5Cyyqx0zMsx7Ky74nLYU4G/R8ZTTcUoq7W2vSeHgQ9ZYXDoFVwhj
         rjellJmIqu8WnghhgzWHKtUPawBt3D+m2WqwreVYQgykIgoCLjy0e6ZFl6kgCi7AdjyU
         bC+w==
X-Gm-Message-State: AOAM532Ih5WcSlzL3aCODRMj4QlbFcMa0mvJFJ/f9U1Q5DBgT9cZ+5bV
        aBGbe3TgK+PC9Z38eapDusAIdosjhGhaBA==
X-Google-Smtp-Source: ABdhPJyDIPpuL0yFyHU4emgMboBIu6WfOIq5z6MszLQoVXedC2t9IALa+Pb6qzj4Ug1HsSjzi5oQDA==
X-Received: by 2002:adf:a486:: with SMTP id g6mr2242007wrb.130.1634931384845;
        Fri, 22 Oct 2021 12:36:24 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q7sm8871814wrs.73.2021.10.22.12.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 12:36:24 -0700 (PDT)
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
Subject: [PATCH v2 10/10] generate-cmdlist.sh: replace "cut", "tr" and "grep" with pure-shell
Date:   Fri, 22 Oct 2021 21:36:14 +0200
Message-Id: <patch-v2-10.10-e10a43756d1-20211022T193027Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1505.g075a284c562
In-Reply-To: <cover-v2-00.10-00000000000-20211022T193027Z-avarab@gmail.com>
References: <cover-0.8-00000000000-20211020T183533Z-avarab@gmail.com> <cover-v2-00.10-00000000000-20211022T193027Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Extend the pure-shell parsing of command-list.txt by using having
command_list() take an argument indicating whether we're interested in
the "$cmd" part of the line, or just the "$rest".

That takes care of the "cut -d", and printf's auto-repeat feature can
replace the "tr". We don't need the "grep -v" either, as we're not
emitting any empty lines here (the command-list.txt doesn't have any).

This doesn't make things any faster or slower in my tests, but as with
the preceding commit let's do it just to get rid of command
invocations, it'll probably help on e.g. Windows.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 generate-cmdlist.sh | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/generate-cmdlist.sh b/generate-cmdlist.sh
index 2b184bbc65f..394443c66df 100755
--- a/generate-cmdlist.sh
+++ b/generate-cmdlist.sh
@@ -17,7 +17,12 @@ command_list () {
 				*":$cmd:"*)
 				;;
 			*)
-				echo "$cmd $rest"
+				if test -n "$1"
+				then
+					printf "%s\n" $rest
+				else
+					echo "$cmd $rest"
+				fi
 				;;
 			esac
 		esac
@@ -25,10 +30,7 @@ command_list () {
 }
 
 category_list () {
-	command_list <"$1" |
-	cut -d' ' -f2- |
-	tr ' ' '\012' |
-	grep -v '^$' |
+	command_list --no-cat <"$1" |
 	LC_ALL=C sort -u
 }
 
-- 
2.33.1.1505.g075a284c562

