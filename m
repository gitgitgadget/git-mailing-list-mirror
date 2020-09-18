Return-Path: <SRS0=7xvA=C3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B639BC43466
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 11:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A1702311C
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 11:39:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbgIRLjq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Sep 2020 07:39:46 -0400
Received: from mail001-2.aei.ca ([206.123.6.133]:36792 "EHLO mail001.aei.ca"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725882AbgIRLjq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Sep 2020 07:39:46 -0400
X-Greylist: delayed 380 seconds by postgrey-1.27 at vger.kernel.org; Fri, 18 Sep 2020 07:39:45 EDT
Received: (qmail 32114 invoked by uid 89); 18 Sep 2020 11:33:04 -0000
Received: by simscan 1.2.0 ppid: 32102, pid: 32108, t: 0.0484s
         scanners: regex: 1.2.0 attach: 1.2.0
Received: from mail002.aei.ca (HELO mta.aei.ca) (206.123.6.132)
  by mail001.aei.ca with (DHE-RSA-AES256-SHA encrypted) SMTP; 18 Sep 2020 11:33:03 -0000
Received: (qmail 1900 invoked by uid 89); 18 Sep 2020 11:33:04 -0000
Received: by simscan 1.2.0 ppid: 1869, pid: 1874, t: 1.5016s
         scanners: regex: 1.2.0 attach: 1.2.0 clamav: 0.97.8/m: spam: 3.3.1
Received: from dsl-216-221-52-235.mtl.contact.net (HELO dermoth.lan) (216.221.52.235)
  by mail.aei.ca with (AES256-SHA encrypted) SMTP; 18 Sep 2020 11:33:03 -0000
Received: from dermoth by dermoth.lan with local (Exim 4.92)
        (envelope-from <tguyot@gmail.com>)
        id 1kJEdR-0004Qw-TN; Fri, 18 Sep 2020 07:33:01 -0400
From:   Thomas Guyot-Sionnest <tguyot@gmail.com>
To:     git@vger.kernel.org
Cc:     dermoth@aei.ca
Subject: Allow passing pipes to diff --no-index + bugfix
Date:   Fri, 18 Sep 2020 07:32:54 -0400
Message-Id: <20200918113256.8699-1-tguyot@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

This set of patches adds the ability to generate diffs directly from
shell process substitution using the <(...) syntax. This is extremely
useful to generate diffs with files streamed directly form remote
systems or when it may be useful to filter them on the fly to generate
the diffs.

For example:

  $ git diff --stat \
    <(sed -r 's/^\S+\s//' /boot/System.map-4.19.0-8-amd64|sort) \
	<(sed -r 's/^\S+\s//' /boot/System.map-4.19.0-9-amd64|sort)

   /dev/fd/{63 => 62} | 9500 ++++++++++++++++++++++----------------------
   1 file changed, 4789 insertions(+), 4711 deletions(-)


Along with it a small fix in --stat and --numstat that affected one one
git range-diff test, where added/removed lines stts were missing (needed
for difffing the pipes too)

Regards,

Thomas Guyot-Sionnest


