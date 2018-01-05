Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00CDD1F406
	for <e@80x24.org>; Fri,  5 Jan 2018 11:36:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751081AbeAELgQ convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 5 Jan 2018 06:36:16 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:18540 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750858AbeAELgQ (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 5 Jan 2018 06:36:16 -0500
X-IronPort-AV: E=Sophos;i="5.46,318,1511823600"; 
   d="scan'208";a="307770024"
Received: from orange.lip.ens-lyon.fr ([140.77.14.54])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/AES128-GCM-SHA256; 05 Jan 2018 12:36:09 +0100
From:   Matthieu Moy <Matthieu.Moy@univ-lyon1.fr>
To:     Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc:     Matthieu Moy <git@matthieu-moy.fr>, git@vger.kernel.org
Subject: Re: [PATCH] send-email: add test for Linux's get_maintainer.pl
References: <q7h9wp0wod8y.fsf@orange.lip.ens-lyon.fr>
        <1515147109-8077-1-git-send-email-git@matthieu-moy.fr>
        <87o9m8d09u.fsf@linaro.org>
Date:   Fri, 05 Jan 2018 12:36:00 +0100
In-Reply-To: <87o9m8d09u.fsf@linaro.org> ("Alex \=\?utf-8\?Q\?Benn\=C3\=A9e\=22's\?\=
 message of "Fri, 05
        Jan 2018 11:15:41 +0000")
Message-ID: <q7h9h8s0o7vj.fsf@orange.lip.ens-lyon.fr>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Bennée <alex.bennee@linaro.org> writes:

> I think you need to apply Eric's suggestions from:
>
>   From: Eric Sunshine <sunshine@sunshineco.com>
>   Date: Sat, 18 Nov 2017 21:54:46 -0500
>   Message-ID: <CAPig+cSh0tVVkh0xF9FwCfM4gngAWMSN_FXd2zhzHcy2trYXfw@mail.gmail.com>

Indeed. I'm squashing this into the patch:

diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index f126177..d13d8c3 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -173,8 +173,7 @@ test_expect_success $PREREQ 'cc trailer with various syntax' '
 '
 
 test_expect_success $PREREQ 'setup fake get_maintainer.pl script for cc trailer' "
-	cat >expected-cc-script.sh <<-EOF &&
-	#!/bin/sh
+	write_script expected-cc-script.sh <<-EOF &&
 	echo 'One Person <one@example.com> (supporter:THIS (FOO/bar))'
 	echo 'Two Person <two@example.com> (maintainer:THIS THING)'
 	echo 'Third List <three@example.com> (moderated list:THIS THING (FOO/bar))'
@@ -186,7 +185,6 @@ test_expect_success $PREREQ 'setup fake get_maintainer.pl script for cc trailer'
 "
 
 test_expect_success $PREREQ 'cc trailer with get_maintainer.pl output' '
-	test_commit cc-trailer-getmaint &&
 	clean_fake_sendmail &&
 	git send-email -1 --to=recipient@example.com \
 		--cc-cmd="./expected-cc-script.sh" \


-- 
Matthieu Moy
https://matthieu-moy.fr/
