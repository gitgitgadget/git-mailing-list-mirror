Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,T_HK_NAME_DR shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B32A1F609
	for <e@80x24.org>; Sun,  2 Jun 2019 09:04:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbfFBJEW (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Jun 2019 05:04:22 -0400
Received: from vwp8955.webpack.hosteurope.de ([176.28.35.119]:33888 "EHLO
        vwp8955.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725953AbfFBJEW (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 2 Jun 2019 05:04:22 -0400
Received: from [2001:16b8:5cd7:8100:8dda:81bf:d984:b26b] (helo=adam-MS-7A63.fritz.box); authenticated
        by vwp8955.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1hXMPc-0005Tz-8C; Sun, 02 Jun 2019 11:04:20 +0200
From:   "Dr. Adam Nielsen" <admin@in-ici.net>
To:     git@vger.kernel.org
Cc:     "Dr. Adam Nielsen" <admin@in-ici.net>
Subject: [PATCH] make slash-rules more readable
Date:   Sun,  2 Jun 2019 11:04:15 +0200
Message-Id: <20190602090415.5889-1-admin@in-ici.net>
X-Mailer: git-send-email 2.17.1
X-bounce-key: webpack.hosteurope.de;admin@in-ici.net;1559466261;f1b6301a;
X-HE-SMSGID: 1hXMPc-0005Tz-8C
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

gitignore.txt: make slash-rules more readable

Remove meta-rule in a paragraph for trailing-slash.
Be precise whenever a trailing slash would make a 
difference. Improve or add paragraphs relevant 
for pattern with slash. Add some slash examples 
in example section.

Signed-off-by: Dr. Adam Nielsen <admin@in-ici.net>

---
 Documentation/gitignore.txt | 69 ++++++++++++++++++++++++++-----------
 1 file changed, 48 insertions(+), 21 deletions(-)

diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
index b5bc9dbff0..46195649f1 100644
--- a/Documentation/gitignore.txt
+++ b/Documentation/gitignore.txt
@@ -89,28 +89,39 @@ PATTERN FORMAT
    Put a backslash ("`\`") in front of the first "`!`" for patterns
    that begin with a literal "`!`", for example, "`\!important!.txt`".
 
- - If the pattern ends with a slash, it is removed for the
-   purpose of the following description, but it would only find
+ - A slash `/` is used as a directory separator. A leading and trailing
+   slash have special meaning and are explained in the following.
+
+ - If the pattern ends with a slash, it would only find
    a match with a directory.  In other words, `foo/` will match a
-   directory `foo` and paths underneath it, but will not match a
-   regular file or a symbolic link `foo` (this is consistent
-   with the way how pathspec works in general in Git).
-
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
-
- - A leading slash matches the beginning of the pathname.
-   For example, "/{asterisk}.c" matches "cat-file.c" but not
-   "mozilla-sha1/sha1.c".
+   directory `foo`, but will not match a regular file or a
+   symbolic link `foo` (this is consistent with the way how
+   pathspec works in general in Git).
+
+ - If the pattern does not end with a slash, it would find a match
+   with a file or directory.
+
+ - The pattern is matched relative to the location of
+   the `.gitignore` file. Except if the pattern contains
+   no slash (or no slash but a trailing slash), then the pattern is
+   matched against all files and folders (recursively)
+   from the location of the `.gitignore` file.
+   For example, `doc/frotz/` matches `doc/frotz` directory, but not
+   a/doc/frotz`; however `frotz/` matches `frotz` and `a/frotz` that
+   is a directory (all paths are relative from the `.gitignore` file).
+
+ - If the pattern contains a leading slash, the pattern
+   is matched relative to the location of the
+   `.gitignore` file (this is actually a direct consequence
+   of the previous paragraph). For example, `/bar` only matches
+   the file or folder `bar` but not `a/bar`,
+   whereas the pattern `bar` would match both.
+
+ - An asterisk "`*`" matches anything except a slash.
+   The character "`?`" matches any one character except "`/`".
+   The range notation, e.g. `[a-zA-Z]`, can be used to match
+   one of the characters in a range. See fnmatch(3) and the
+   FNM_PATHNAME flag for a more detailed description.
 
 Two consecutive asterisks ("`**`") in patterns matched against
 full pathname may have special meaning:
@@ -152,6 +163,22 @@ To stop tracking a file that is currently tracked, use
 EXAMPLES
 --------
 
+ - The pattern 'hello.*' matches any file or folder
+   whose name begins with 'hello'. If one wants to restrict
+   this only to the directory and not in its subdirectories,
+   one can prepend the pattern with a slash, i.e. '/hello.*';
+   the pattern now matches 'hello.txt', 'hello.c' but not
+   'a/hello.java'.
+
+ - The pattern `doc/frotz` and `/doc/frotz` have the same effect
+   in any `.gitignore` file. Both pattern match relative to the
+   location of the `.gitignore` file.
+
+ - The pattern "foo/*", matches "foo/test.json"
+   (a regular file), "foo/bar" (a directory), but it does not match
+   "foo/bar/hello.c" (a regular file), as the asterisk in the
+   pattern does not match "bar/hello.c" which has a slash in it.
+
 --------------------------------------------------------------
     $ git status
     [...]
-- 
2.17.1

