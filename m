Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D5831F89C
	for <e@80x24.org>; Tue, 24 Jan 2017 17:00:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750738AbdAXRAx (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jan 2017 12:00:53 -0500
Received: from mx0.elegosoft.com ([78.47.87.163]:45510 "EHLO mx0.elegosoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750716AbdAXRAx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jan 2017 12:00:53 -0500
Received: from localhost (x4e340422.dyn.telefonica.de [78.52.4.34])
        by mx0.elegosoft.com (Postfix) with ESMTPSA id 8DC4D16C78E;
        Tue, 24 Jan 2017 18:00:50 +0100 (CET)
From:   Patrick Steinhardt <patrick.steinhardt@elego.de>
To:     git@vger.kernel.org
Cc:     Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <patrick.steinhardt@elego.de>
Subject: [PATCH v2 0/4] urlmatch: allow regexp-based matches
Date:   Tue, 24 Jan 2017 18:00:27 +0100
Message-Id: <20170124170031.18069-1-patrick.steinhardt@elego.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170123130635.29577-1-patrick.steinhardt@elego.de>
References: <20170123130635.29577-1-patrick.steinhardt@elego.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

This is version two of my patch series.

The use case is to be able to configure an HTTP proxy for all
subdomains of a domain where there are hundreds of subdomains.

Previously, I have been using complete regular expressions with
an escape-mechanism to match the configuration key's URLs.
According to Junio's comments, I changed this mechanism to a much
simpler one, where the user is only allowed to use globbing for
the host part of the URL. That is a user can now specify a key
`http.https://*.example.com` to match all sub-domains of
`example.com`. For now I've decided to implement it such that a
single `*` matches a single subdomain only, so for example
`https://foo.bar.example.com` would not match in this case. This
is similar to how shell-globbing works usually, so it should not
be of much surprise. It's also highlighted in the documentation.

I did not include an interdiff as too much has changed between
the two versions.

Regards
Patrick

Patrick Steinhardt (4):
  mailmap: add Patrick Steinhardt's work address
  urlmatch: enable normalization of URLs with globs
  urlmatch: split host and port fields in `struct url_info`
  urlmatch: allow globbing for the URL host part

 .mailmap                 |  1 +
 Documentation/config.txt |  5 +++-
 t/t1300-repo-config.sh   | 36 +++++++++++++++++++++++++
 urlmatch.c               | 68 +++++++++++++++++++++++++++++++++++++++++-------
 urlmatch.h               |  9 ++++---
 5 files changed, 104 insertions(+), 15 deletions(-)

-- 
2.11.0

