Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 34DD31F404
	for <e@80x24.org>; Mon, 17 Sep 2018 23:03:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730268AbeIREcl (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Sep 2018 00:32:41 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:59992 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730031AbeIREcl (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 18 Sep 2018 00:32:41 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:68ab:e3d3:c0a3:4717])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 3E4AD60482;
        Mon, 17 Sep 2018 23:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1537225392;
        bh=YyvJ4rsSbDVInDZ6kUlVpXoRQecMS/veMYhHZO1bWgs=;
        h=From:To:Cc:Subject:Date:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=1anCXysjlRzqsk5lCr7JZm9eccKpw79GHSRr9M5smM9qCIgYljIwMT8c3a9E07bDB
         jOMsMVQoC/GBDzS/lDThBBYph0DC0G+repvHJzHeSQdTm/QX2HrKUwFWIFRSYYZErX
         zmPW6KuQap9TPDwhUOvXUf11NjOTitxJeMAcUBP3JTBA+cEogWTbfw972l1hQfl2nT
         Q5C/2mRdkYD+UK9OprYRlx+v0/M5OfWv6t+mmrqTkGSL1UtrgDHF4EsRPcHjwrNWl8
         Kv6NnuCZe8A8EF2pATMhiX+DUMEpPamXABVMPVaqQwmq7TTQ5Jkk5wpMVXO2POHIBu
         TCknVsXHtHDqhnW9vtVRS9DGb7E1lQIdRXlGjKZtEjh9uCwgh9BjuldG1sTZOtCuRS
         R7UjEzPG8nBBPZwvacRYV3U3UiGmaZ8ccRpMP1BzEcOSsPk6bKHGABNYreTTKy/vkD
         7IAWEyxfk/iDgSjqCJc4xuV5SkCzy4ix7vUtWAkn1aHHpZAsOZi
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>
Subject: [PATCH] Add an EditorConfig file
Date:   Mon, 17 Sep 2018 23:03:07 +0000
Message-Id: <20180917230307.588334-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.19.0.397.gdd90340f6a
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Contributors to Git use a variety of editors, each with their own
configuration files.  Because C lacks the defined norms on how to indent
and style code that other languages, such as Ruby and Rust, have, it's
possible for various contributors, especially new ones, to have
configured their editor to use a style other than the style the Git
community prefers.

To make automatically configuring one's editor easier, provide an
EditorConfig file.  This is an INI-style configuration file that can be
used to specify editor settings and can be understood by a wide variety
of editors.  Some editors include this support natively; others require
a plugin.  Regardless, providing such a file allows users to
automatically configure their editor of choice with the correct settings
by default.

Provide global settings to set the character set to UTF-8 and insert a
final newline into files.  Provide language-specific settings for C,
Shell, Perl, and Python files according to what CodingGuidelines already
specifies.  Since the indentation of other files varies, especially
certain AsciiDoc files, don't provide any settings for them until a
clear consensus forward emerges.

Don't specify an end of line type.  While the Git community uses
Unix-style line endings in the repository, some Windows users may use
Git's auto-conversion support and forcing Unix-style line endings might
cause problems for those users.

Finally, leave out a root directive, which would prevent reading other
EditorConfig files higher up in the tree, in case someone wants to set
the end of line type for their system in such a file.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
I was incentivized to write this when I started using worktrees for
development and found that I had inserted spaces into all the work I was
doing because I was outside of my normal git.git clone.

This is the easiest way to set per-repo configuration across editors,
especially since people may work on various C codebases with different
indentation standards.

 .editorconfig | 11 +++++++++++
 1 file changed, 11 insertions(+)
 create mode 100644 .editorconfig

diff --git a/.editorconfig b/.editorconfig
new file mode 100644
index 0000000000..8963d83fdb
--- /dev/null
+++ b/.editorconfig
@@ -0,0 +1,11 @@
+[*]
+charset = utf-8
+insert_final_newline = true
+
+[*.{c,h,sh,perl}]
+indent_style = tab
+tab_width = 8
+
+[*.py]
+indent_style = space
+indent_size = 4
