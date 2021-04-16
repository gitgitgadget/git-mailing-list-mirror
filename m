Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB64FC433ED
	for <git@archiver.kernel.org>; Fri, 16 Apr 2021 16:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A665161042
	for <git@archiver.kernel.org>; Fri, 16 Apr 2021 16:47:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236178AbhDPQrw convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 16 Apr 2021 12:47:52 -0400
Received: from mta-out-2-1.rz.uni-osnabrueck.de ([131.173.18.152]:53397 "EHLO
        mta-out-2-1.rz.uni-osnabrueck.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235595AbhDPQrw (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 16 Apr 2021 12:47:52 -0400
X-Greylist: delayed 1554 seconds by postgrey-1.27 at vger.kernel.org; Fri, 16 Apr 2021 12:47:51 EDT
Received: from vm411.rz.uni-osnabrueck.de (smtp-auth-1.serv.uni-osnabrueck.de [IPv6:2001:638:508:100::83ad:108f])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mta-out-2-1.rz.uni-osnabrueck.de (Postfix) with ESMTPS id 47C5F3000906
        for <git@vger.kernel.org>; Fri, 16 Apr 2021 18:21:30 +0200 (CEST)
Received: from pc.home.lkiesow.io (ip4d1546b6.dynamic.kabel-deutschland.de [77.21.70.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lkiesow)
        by vm411.rz.uni-osnabrueck.de (Postfix) with ESMTPSA id E62023050086
        for <git@vger.kernel.org>; Fri, 16 Apr 2021 18:21:22 +0200 (CEST)
Date:   Fri, 16 Apr 2021 18:21:21 +0200
From:   Lars Kiesow <lkiesow@uos.de>
To:     git@vger.kernel.org
Subject: Bug report: gitk unable to handle Unicode properly
Message-ID: <20210416182121.3c824c87@pc.home.lkiesow.io>
Organization: =?UTF-8?B?T3NuYWJyw7xjaw==?= University
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-PMX-Version: vm411.rz.uni-osnabrueck.de (Univ. Osnabrueck) with PMX 6.4.6.2792898, Antispam-Engine: 2.7.2.2107409, Antispam-Data: 2021.4.16.160915, AntiVirus-Engine: 5.82.0, AntiVirus-Data: 2021.4.15.5820001  
X-PMX-Spam: Gauge=X, Probability=10%, Report=
 TO_IN_SUBJECT 0.5, HTML_00_01 0.05, HTML_00_10 0.05, BODYTEXTP_SIZE_3000_LESS 0, BODY_SIZE_2000_2999 0, BODY_SIZE_5000_LESS 0, BODY_SIZE_7000_LESS 0, CT_TEXT_PLAIN_UTF8_CAPS 0, NO_CTA_FOUND 0, NO_CTA_URI_FOUND 0, NO_URI_HTTPS 0, __ANY_URI 0, __BODY_NO_MAILTO 0, __CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __FRAUD_MONEY_CURRENCY 0, __FRAUD_MONEY_CURRENCY_DOLLAR 0, __FROM_DOMAIN_NOT_IN_BODY 0, __FROM_NAME_NOT_IN_BODY 0, __HAS_FROM 0, __HAS_MSGID 0, __HAS_X_MAILER 0, __HIGHBITS 0, __MIME_TEXT_ONLY 0, __MIME_TEXT_P 0, __MIME_TEXT_P1 0, __MIME_VERSION 0, __NO_HTML_TAG_RAW 0, __PHISH_SPEAR_SUBJ_PREDICATE 0, __SANE_MSGID 0, __SUBJ_ALPHA_END 0, __SUBJ_ALPHA_NEGATE 0, __TO_IN_SUBJECT 0, __TO_IN_SUBJECT2 0, __TO_MALFORMED_2 0, __TO_NO_NAME 0, __URI_NO_MAILTO 0, __URI_NO_WWW 0
X-PMX-Spam-Level: X
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,
while fixing some Unicode problems in a project, I noticed that gitk
will not display Unicode characters correctly and may even crash if the
branch name consists of Unicode characters.

I'ts certainly not the end of the world (who is crazy enough to use 🖤
as a branch name) but could still cause problems.

Please find some additional information below.

Best regards,
Lars


What did you do before the bug happened? (Steps to reproduce your issue)

- Create a git branch named with a multi-byte Unicode character like:

        git checkout -b 🖤

- Launch gitk
    - Crash (see below)

- Switch to another branch

        git checkout xy

- Launch gitk
    - Branch names are not displayed properly


What did you expect to happen? (Expected behavior)

- Launching gitk, it should not crash and names like “🖤” should be
  displayed correctly


What happened instead? (Actual behavior)

- Launching while on the branch “🖤” crashed gitk.
  The reported error is:

        X Error of failed request:  BadLength (poly request too large or internal Xlib length error)
          Major opcode of failed request:  139 (RENDER)
          Minor opcode of failed request:  20 (RenderAddGlyphs)
          Serial number of failed request:  5225
          Current serial number in output stream:  5263

- Launching while on another branch but with the branch “🖤” makes that
  branch appear as ⌷⌷


What's different between what you expected and what actually happened?

- gitk should launch and display Unicode characters correctly


[System Info]
git version:
git version 2.30.2
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 5.11.11-200.fc33.x86_64 #1 SMP Tue Mar 30 16:53:32 UTC
2021 x86_64 compiler info: gnuc: 10.2
libc info: glibc: 2.32
$SHELL (typically, interactive shell): /bin/zsh


[Enabled Hooks]
