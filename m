Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 044842022D
	for <e@80x24.org>; Tue,  8 Nov 2016 00:53:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752458AbcKHAxR (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Nov 2016 19:53:17 -0500
Received: from chiark.greenend.org.uk ([212.13.197.229]:46599 "EHLO
        chiark.greenend.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752240AbcKHAxH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2016 19:53:07 -0500
Received: from [172.18.45.5] (helo=zealot.relativity.greenend.org.uk)
        by chiark.greenend.org.uk (Debian Exim 4.84_2 #1) with esmtp
        (return-path ijackson@chiark.greenend.org.uk)
        id 1c3uev-0003Jx-Gx; Tue, 08 Nov 2016 00:53:05 +0000
From:   Ian Jackson <ijackson@chiark.greenend.org.uk>
To:     git@vger.kernel.org
Cc:     Ian Jackson <ijackson@chiark.greenend.org.uk>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 5/6] config docs: Provide for config to specify tags not to abbreviate
Date:   Tue,  8 Nov 2016 00:52:41 +0000
Message-Id: <20161108005241.19888-6-ijackson@chiark.greenend.org.uk>
X-Mailer: git-send-email 2.10.1
In-Reply-To: <20161108005241.19888-1-ijackson@chiark.greenend.org.uk>
References: <20161108005241.19888-1-ijackson@chiark.greenend.org.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tags matching a new multi-valued config option log.noAbbrevTags
should not be abbreviated.  Currently this config option is
used only by gitk (and the patch to gitk will come via the
gitk maintainer tree).

The config setting is in git config logs.* rather than gitk's
own configuration, because:

 - Tools which manage git trees may want to set this, depending
   on their knowledge of the nature of the tags likely to be
   present;

 - Whether this property ought to be set is mostly a property of the
   contents of the tag namespaces in the tree, not a user preference.
   (Although of course user preferences are supported.)

 - Other git utilities (or out of tree utilities) may want to
   reference this setting for their own display purposes.

Background motivation:

Debian's dgit archive gateway tool generates and uses tags called
archive/debian/VERSION.  If such a tag refers to a Debian source tree,
it is probably very interesting because it refers to a version
actually uploaded to Debian by the Debian package maintainer.

We would therefore like a way to specify that such tags should be
displayed in full.  dgit will be able to set an appropriate config
setting in the trees it deals with.

Signed-off-by: Ian Jackson <ijackson@chiark.greenend.org.uk>
---
 Documentation/config.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index a0ab66a..6aade4f 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2002,6 +2002,14 @@ log.abbrevCommit::
 	linkgit:git-whatchanged[1] assume `--abbrev-commit`. You may
 	override this option with `--no-abbrev-commit`.
 
+log.noAbbrevTags::
+	Each value is a glob pattern, specifying tag nammes which
+	should always be displayed in full, even when other tags may
+	be omitted or abbreviated (for example, by linkgit:gitk[1]).
+	Values starting with `^` specify tags which should be
+	abbreviated.  The order is important: the last match, in the
+	most-local configuration, wins.
+
 log.date::
 	Set the default date-time mode for the 'log' command.
 	Setting a value for log.date is similar to using 'git log''s
-- 
2.10.1

