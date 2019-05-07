Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_HK_NAME_DR shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCB631F45F
	for <e@80x24.org>; Tue,  7 May 2019 10:45:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbfEGKpp (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 May 2019 06:45:45 -0400
Received: from vwp8955.webpack.hosteurope.de ([176.28.35.119]:58026 "EHLO
        vwp8955.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725844AbfEGKpp (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 7 May 2019 06:45:45 -0400
Received: from 200116b8467f8b0031021c7e41c85f0b.dip.versatel-1u1.de ([2001:16b8:467f:8b00:3102:1c7e:41c8:5f0b] helo=adam-MS-7A63.fritz.box); authenticated
        by vwp8955.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1hNxbS-0006OS-PX; Tue, 07 May 2019 12:45:42 +0200
From:   "Dr. Adam Nielsen" <admin@in-ici.net>
To:     git@vger.kernel.org
Cc:     "Dr. Adam Nielsen" <admin@in-ici.net>
Subject: [PATCH] make slash-rules more readable
Date:   Tue,  7 May 2019 12:45:07 +0200
Message-Id: <20190507104507.18735-1-admin@in-ici.net>
X-Mailer: git-send-email 2.17.1
X-bounce-key: webpack.hosteurope.de;admin@in-ici.net;1557225944;ee5f28a8;
X-HE-SMSGID: 1hNxbS-0006OS-PX
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

gitignore.txt: make slash-rules more readable

Make all paragraphs valid, even if they are not read
in strict order. Make paragraph better understandable
for pattern without slash. Add paragraph for pattern
with slash. Be precise whenever a trailing slashes
would make a difference. Add some examples.

Signed-off-by: Dr. Adam Nielsen <admin@in-ici.net>

---
 Documentation/gitignore.txt | 37 ++++++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
index b5bc9dbff0..7d7fbd202e 100644
--- a/Documentation/gitignore.txt
+++ b/Documentation/gitignore.txt
@@ -89,24 +89,35 @@ PATTERN FORMAT
    Put a backslash ("`\`") in front of the first "`!`" for patterns
    that begin with a literal "`!`", for example, "`\!important!.txt`".
 
- - If the pattern ends with a slash, it is removed for the
-   purpose of the following description, but it would only find
+ - If the pattern ends with a slash, it would only find
    a match with a directory.  In other words, `foo/` will match a
    directory `foo` and paths underneath it, but will not match a
    regular file or a symbolic link `foo` (this is consistent
    with the way how pathspec works in general in Git).
 
- - If the pattern does not contain a slash '/', Git treats it as
-   a shell glob pattern and checks for a match against the
-   pathname relative to the location of the `.gitignore` file
-   (relative to the toplevel of the work tree if not from a
-   `.gitignore` file).
-
- - Otherwise, Git treats the pattern as a shell glob: "`*`" matches
-   anything except "`/`", "`?`" matches any one character except "`/`"
-   and "`[]`" matches one character in a selected range. See
-   fnmatch(3) and the FNM_PATHNAME flag for a more detailed
-   description.
+ - If the pattern contains no slash "`/`" (except an optional trailing slash),
+   the pattern is matched against all files and folders (recursively)
+   from the location of the `.gitignore` file.
+   For example, `frotz/` matches `frotz` and `a/frotz` that
+   is a directory (relative from the `.gitignore` file).
+
+ - A pattern that contains a non-trailing slash is matched
+   relative to the location of the `.gitignore` file.
+   For example, `doc/frotz/` matches `doc/frotz` directory, but not
+   `a/doc/frotz` (relative from the `.gitignore` file).
+   Note that the pattern `doc/frotz` and `/doc/frotz` have the
+   same effect in any `.gitignore` file, while `/bar` and `bar`
+   have not the same effect (`/bar` will not match `foo/bar`).
+
+ - An asterisk "`*`" matches anything except a slash.
+   A pattern "foo/*", for example, matches "foo/test.json"
+   (a regular file), "foo/bar" (a diretory), but it does not match
+   "foo/bar/hello.c" (a regular file), as the asterisk in the
+   patter does not match "bar/hello.c" which has a slash in it.
+   The character "`?`" matches any one character except "`/`".
+   The range notation, e.g. `[a-zA-Z]`, can be used to match
+   one of the characters in a range. See fnmatch(3) and the
+   FNM_PATHNAME flag for a more detailed description.
 
  - A leading slash matches the beginning of the pathname.
    For example, "/{asterisk}.c" matches "cat-file.c" but not
-- 
2.17.1

