Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5FA7E1F70F
	for <e@80x24.org>; Wed, 25 Jan 2017 09:56:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751811AbdAYJ4y (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 04:56:54 -0500
Received: from mx0.elegosoft.com ([78.47.87.163]:48602 "EHLO mx0.elegosoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751676AbdAYJ4w (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 04:56:52 -0500
Received: from localhost (x4e340422.dyn.telefonica.de [78.52.4.34])
        by mx0.elegosoft.com (Postfix) with ESMTPSA id 98D9D16C790;
        Wed, 25 Jan 2017 10:56:49 +0100 (CET)
From:   Patrick Steinhardt <patrick.steinhardt@elego.de>
To:     git@vger.kernel.org
Cc:     Patrick Steinhardt <patrick.steinhardt@elego.de>,
        Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v3 0/4] urlmatch: allow regexp-based matches
Date:   Wed, 25 Jan 2017 10:56:44 +0100
Message-Id: <20170125095648.4116-1-patrick.steinhardt@elego.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170123130635.29577-1-patrick.steinhardt@elego.de>
References: <20170123130635.29577-1-patrick.steinhardt@elego.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

This is version three of my patch series. The previous version
can be found at [1]. The use case is to be able to configure an
HTTP proxy for all subdomains of a domain where there are
hundreds of subdomains.

This version addresses a comment by Philip Oakley regarding the
documentation. You can find the interdiff below.

Regards
Patrick

[1]: http://public-inbox.org/git/20170124170031.18069-1-patrick.steinhardt@elego.de/T/#u

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

diff --git a/Documentation/config.txt b/Documentation/config.txt
index a78921c2b..078e9b490 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1915,9 +1915,9 @@ http.<url>.*::
 
 . Host/domain name (e.g., `example.com` in `https://example.com/`).
   This field must match between the config key and the URL. It is
-  possible to use globs in the config key to match all subdomains, e.g.
-  `https://*.example.com/` to match all subdomains of `example.com`. Note
-  that a glob only every matches a single part of the hostname.
+  possible to specify a `*` as part of the host name to match all subdomains
+  at this level. `https://*.example.com/` for example would match
+  `https://foo.example.com/`, but not `https://foo.bar.example.com/`.
 
 . Port number (e.g., `8080` in `http://example.com:8080/`).
   This field must match exactly between the config key and the URL.
-- 
2.11.0
