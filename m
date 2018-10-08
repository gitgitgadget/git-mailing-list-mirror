Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4ADF11F97E
	for <e@80x24.org>; Mon,  8 Oct 2018 20:29:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbeJIDmq (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Oct 2018 23:42:46 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:49244 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726393AbeJIDmp (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 8 Oct 2018 23:42:45 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e17d:6d35:bfb8:6a25])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id A825360780;
        Mon,  8 Oct 2018 20:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1539030553;
        bh=WRMw1fnSSP+lIhCRVE5wdrrmU7BrUOPu7MJioegI81Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=r4iea+K/FLlimXOo6uonnkAuNbbfsgfz++l29O/Cg/+TchWC3oAu3ZvrMy1FbYT6g
         QHRiAHKjFr8de7EiNb+NAQYJ5AKd90WpSqYNyah367x4QjqNqigDnAIvBDqI2zV8KI
         JM/IXk1YzSVhQCHPGYLewSVutckRhCdMlJo+Q9qGcEtKPpUlqBr+x0ex63dPWhe8yn
         LPOOHz/NfqANCEQiUWp1ixnKh1wVolSKNjaa+wMJ0Pf0rlY9Pl59SzD8gK3sPHIKjt
         AhouEOip3Q0Y4QkiL0kk1eoG2fEunXwmWyMairZyMInCbLUomQzz27A1cM/ZDVUifI
         whb1EK24p/e+Mt4vhhe0Y5KBS6/PgltlZ7Re8PZr478UG3bqZ8/Epf0M8tfb1gUTYL
         tRvvidsxrklJmenFDhqmCZ3l6kIIkVN+FI+VaaFYo9UD5g4OxkPmatLLxFXBlw3VAs
         f5DnDj9Oe9YIyMveGPmESxm5lPtNcgb27LXjqLl+2XxbAjF96l/
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/2] editorconfig: provide editor settings for Git developers
Date:   Mon,  8 Oct 2018 20:29:02 +0000
Message-Id: <20181008202903.100166-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.19.1.331.ge82ca0e54c
In-Reply-To: <20181008202903.100166-1-sandals@crustytoothpaste.net>
References: <20181008202903.100166-1-sandals@crustytoothpaste.net>
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
index 0000000000..83227fa0b2
--- /dev/null
+++ b/.editorconfig
@@ -0,0 +1,14 @@
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
+
+[COMMIT_EDITMSG]
+max_line_length = 72
