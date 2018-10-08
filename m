Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D08F61F97E
	for <e@80x24.org>; Mon,  8 Oct 2018 22:04:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbeJIFRx (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Oct 2018 01:17:53 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:49412 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725782AbeJIFRx (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 9 Oct 2018 01:17:53 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e17d:6d35:bfb8:6a25])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 2B23C6078F;
        Mon,  8 Oct 2018 22:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1539036241;
        bh=9afMoEYWJBKyRF4wNjJffChgD6iu4OJA9mRuDf+LvU4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=vjXNKTSc2Em1G8NXDvw4uMWJgvlGJ3BzU25t6HUqEorhjqEC7hCYgKFzOr0Kp8T8J
         ynwwaUEYZJAW4QtgyLkyfCjsx9ohSXJdyQ3MuyClcZUwNrLHdzlrIGBO7aOkrae1Tt
         ayk5tzQHdCnRF/j48h4cnSad66J/+ZfxCbtTCswuOzSpVKhFSphAbFzeqtQmPH6KgV
         U3FR8n/e60Sr0I1UUJbMNs+VqVsQRdYFyI+FVk7s5kIVDGwU1atWHxvec79jVD5E0q
         nub0G9XlSvZDKxeKfkN5TbYifTA+sG9ngIiJ5NlrobeaDgDJ9Dmn3oFaWBUrfmmVNO
         BDtDdF3dv1Z88hOTK97IOHXT+KijcoWe83fuROWZlb0zmGZ2cTG8+g1P3cn9Vf430U
         7RnkypmrnHCjwqASanDNLgI/aOydyRjmvB1O0tk8KjsueWIm7JmKS98CjMXQbyDWi7
         7CBsbWi+TQcQyhPWdzk2VjX6GG70yAnNa3HSrCFbyH2QpG/oyq/
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 1/2] editorconfig: provide editor settings for Git developers
Date:   Mon,  8 Oct 2018 22:03:52 +0000
Message-Id: <20181008220353.780301-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.19.1.331.ge82ca0e54c
In-Reply-To: <20181008220353.780301-1-sandals@crustytoothpaste.net>
References: <20181008220353.780301-1-sandals@crustytoothpaste.net>
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

Set the line length for commit messages to 72 characters, which is the
generally accepted line length for emails, since we send patches by
email.

Don't specify an end of line type.  While the Git community uses
Unix-style line endings in the repository, some Windows users may use
Git's auto-conversion support and forcing Unix-style line endings might
cause problems for those users.

Finally, leave out a root directive, which would prevent reading other
EditorConfig files higher up in the tree, in case someone wants to set
the end of line type for their system in such a file.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 .editorconfig | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 .editorconfig

diff --git a/.editorconfig b/.editorconfig
new file mode 100644
index 0000000000..8667740e1d
--- /dev/null
+++ b/.editorconfig
@@ -0,0 +1,14 @@
+[*]
+charset = utf-8
+insert_final_newline = true
+
+[*.{c,h,sh,perl,pl,pm}]
+indent_style = tab
+tab_width = 8
+
+[*.py]
+indent_style = space
+indent_size = 4
+
+[COMMIT_EDITMSG]
+max_line_length = 72
