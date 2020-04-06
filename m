Return-Path: <SRS0=cWmm=5W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D80C2BA1B
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 18:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D64DA206B8
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 18:12:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dEfY7AhU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbgDFSMf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Apr 2020 14:12:35 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34242 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbgDFSMf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Apr 2020 14:12:35 -0400
Received: by mail-pl1-f196.google.com with SMTP id a23so149492plm.1
        for <git@vger.kernel.org>; Mon, 06 Apr 2020 11:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4v9gAbfFHBRKfo1lpY5/MNKDi+wjvaXSczhZ5f0+AGg=;
        b=dEfY7AhU6MULtF3NPtU7DgR4qmT67bTobuewz2k7k8TPHrYD+XrGGi/RxXUt/w5FQl
         BKKQxTzjvrplttaEPkZIkCOiENBSmzb6bcsRbXpX4i7LGKBFQxDwBravXw5DGVl93gMx
         TCENL+xyIkPvhDwPLFQ+LNMzYs4app4IzGanCKWELp+XLVN1cY6RzD6E8S0GVSywoUty
         5Cpo70Fh9oCYCW4MHRqWmxUmcFiaXv8vQFFw6K9IZwLeujeiHD7csK5j5UwRj+7y+kyg
         795iJsudCEuvIvW21sC/8r8YP4kdiYOEyFBUXcAQ4tmKtsRV9v8Hl7dmLSklZhKi/FBg
         jYkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4v9gAbfFHBRKfo1lpY5/MNKDi+wjvaXSczhZ5f0+AGg=;
        b=G0+Sx8GExsGcar7WajLAWdxVmGE1Z5y70OLCtWKO+vGNnb+0sr7iiwUeh8hUQH8Khu
         ZAn9YqoWf3oBfTspRWQ2Cz6UkZI8IoMAtQ1hKVYt97GTNv5SEg0kXSzop55rGgly2ETg
         yJz9Mvigiib2amh84CL6LFmS1duwcXyP7iqb4xepGe9Y0h3MKiZWqbU1JByFeut3TmD6
         rhodS3sCnWF1dWyYksyIj20mq/YyHia8pSCY2YmyOZNJNy+wFY1a3ZLlI7jjwm1Ep0lM
         v0wu/disy04BhZDEI+Y1vGec2cF3QM7wJ8fld/7s0sDTDSLQjMNuXJf6PabLvtoEJvQh
         sYVA==
X-Gm-Message-State: AGi0PuZCJWVDrnzwfcEdmHhFp0qMgXYy/BCjJHtzvUGOMKYfHKUpv/6z
        ZGqinTIHCGeIxVXYH7WL6RX0ZyhR+UCUQg==
X-Google-Smtp-Source: APiQypLc/jRg95PLfdBwKbTS72JaQDFe6msnUjLNoWUdntX6kHTF43YIUdAzA9D49qdXv5S9gfYiqw==
X-Received: by 2002:a17:90a:25a8:: with SMTP id k37mr686329pje.14.1586196752325;
        Mon, 06 Apr 2020 11:12:32 -0700 (PDT)
Received: from konoha.iitr.ac.in ([103.37.201.174])
        by smtp.gmail.com with ESMTPSA id l22sm246543pjq.15.2020.04.06.11.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 11:12:31 -0700 (PDT)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sandals@crustytoothpaste.net,
        emilyshaffer@google.com, martin.agren@gmail.com,
        Shourya Shukla <shouryashukla.oo@gmail.com>
Subject: [PATCH 1/2] gitfaq: cleanup gitfaq.txt
Date:   Mon,  6 Apr 2020 23:42:15 +0530
Message-Id: <20200406181216.5340-2-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200406181216.5340-1-shouryashukla.oo@gmail.com>
References: <20200406181216.5340-1-shouryashukla.oo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The file contained a lot of whitespace errors as well as some
grammatical mistakes. Amend them.

Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
---
 Documentation/gitfaq.txt | 110 +++++++++++++++++++--------------------
 1 file changed, 55 insertions(+), 55 deletions(-)

diff --git a/Documentation/gitfaq.txt b/Documentation/gitfaq.txt
index 1cf83df118..3ca16b1092 100644
--- a/Documentation/gitfaq.txt
+++ b/Documentation/gitfaq.txt
@@ -23,7 +23,7 @@ Configuration
 What should I put in `user.name`?::
 	You should put your personal name, generally a form using a given name
 	and family name.  For example, the current maintainer of Git uses "Junio
-	C Hamano".  This will be the name portion that is stored in every commit
+	C Hamano". This will be the name portion that is stored in every commit
 	you make.
 +
 This configuration doesn't have any effect on authenticating to remote services;
@@ -32,7 +32,7 @@ for that, see `credential.username` in linkgit:git-config[1].
 [[http-postbuffer]]
 What does `http.postBuffer` really do?::
 	This option changes the size of the buffer that Git uses when pushing
-	data to a remote over HTTP or HTTPS.  If the data is larger than this
+	data to a remote over HTTP or HTTPS. If the data is larger than this
 	size, libcurl, which handles the HTTP support for Git, will use chunked
 	transfer encoding since it isn't known ahead of time what the size of
 	the pushed data will be.
@@ -40,15 +40,15 @@ What does `http.postBuffer` really do?::
 Leaving this value at the default size is fine unless you know that either the
 remote server or a proxy in the middle doesn't support HTTP/1.1 (which
 introduced the chunked transfer encoding) or is known to be broken with chunked
-data.  This is often (erroneously) suggested as a solution for generic push
+data. This is often (erroneously) suggested as a solution for generic push
 problems, but since almost every server and proxy supports at least HTTP/1.1,
-raising this value usually doesn't solve most push problems.  A server or proxy
+raising this value usually doesn't solve most push problems. A server or proxy
 that didn't correctly support HTTP/1.1 and chunked transfer encoding wouldn't be
 that useful on the Internet today, since it would break lots of traffic.
 +
 Note that increasing this value will increase the memory used on every relevant
 push that Git does over HTTP or HTTPS, since the entire buffer is allocated
-regardless of whether or not it is all used.  Thus, it's best to leave it at the
+regardless of whether or not it is all used. Thus, it's best to leave it at the
 default unless you are sure you need a different value.
 
 [[configure-editor]]
@@ -56,13 +56,13 @@ How do I configure a different editor?::
 	If you haven't specified an editor specifically for Git, it will by default
 	use the editor you've configured using the `VISUAL` or `EDITOR` environment
 	variables, or if neither is specified, the system default (which is usually
-	`vi`).  Since some people find `vi` difficult to use or prefer a different
+	`vi`). Since some people find `vi` difficult to use or prefer a different
 	editor, it may be desirable to change the editor used.
 +
 If you want to configure a general editor for most programs which need one, you
 can edit your shell configuration (e.g., `~/.bashrc` or `~/.zshenv`) to contain
 a line setting the `EDITOR` or `VISUAL` environment variable to an appropriate
-value.  For example, if you prefer the editor `nano`, then you could write the
+value. For example, if you prefer the editor `nano`, then you could write the
 following:
 +
 ----
@@ -70,15 +70,15 @@ export VISUAL=nano
 ----
 +
 If you want to configure an editor specifically for Git, you can either set the
-`core.editor` configuration value or the `GIT_EDITOR` environment variable.  You
+`core.editor` configuration value or the `GIT_EDITOR` environment variable. You
 can see linkgit:git-var[1] for details on the order in which these options are
 consulted.
 +
 Note that in all cases, the editor value will be passed to the shell, so any
-arguments containing spaces should be appropriately quoted.  Additionally, if
+arguments containing spaces should be appropriately quoted. Additionally, if
 your editor normally detaches from the terminal when invoked, you should specify
 it with an argument that makes it not do that, or else Git will not see any
-changes.  An example of a configuration addressing both of these issues on
+changes. An example of a configuration addressing both of these issues on
 Windows would be the configuration `"C:\Program Files\Vim\gvim.exe" --nofork`,
 which quotes the filename with spaces and specifies the `--nofork` option to
 avoid backgrounding the process.
@@ -89,11 +89,11 @@ Credentials
 [[http-credentials]]
 How do I specify my credentials when pushing over HTTP?::
 	The easiest way to do this is to use a credential helper via the
-	`credential.helper` configuration.  Most systems provide a standard
-	choice to integrate with the system credential manager.  For example,
+	`credential.helper` configuration. Most systems provide a standard
+	choice to integrate with the system credential manager. For example,
 	Git for Windows provides the `wincred` credential manager, macOS has the
 	`osxkeychain` credential manager, and Unix systems with a standard
-	desktop environment can use the `libsecret` credential manager.  All of
+	desktop environment can use the `libsecret` credential manager. All of
 	these store credentials in an encrypted store to keep your passwords or
 	tokens secure.
 +
@@ -102,7 +102,7 @@ in your home directory, or the `cache` credential manager, which does not
 permanently store your credentials, but does prevent you from being prompted for
 them for a certain period of time.
 +
-You can also just enter your password when prompted.  While it is possible to
+You can also just enter your password when prompted. While it is possible to
 place the password (which must be percent-encoded) in the URL, this is not
 particularly secure and can lead to accidental exposure of credentials, so it is
 not recommended.
@@ -113,8 +113,8 @@ How do I read a password or token from an environment variable?::
 	shell command that produces the credential protocol on standard output.
 	This is useful when passing credentials into a container, for example.
 +
-Such a shell command can be specified by starting the option value with an
-exclamation point.  If your password or token were stored in the `GIT_TOKEN`,
+Such a shell command can be specified by putting an exclamation point before
+the option. If your password or token were stored in the `GIT_TOKEN`,
 you could run the following command to set your credential helper:
 +
 ----
@@ -125,10 +125,10 @@ $ git config credential.helper \
 [[http-reset-credentials]]
 How do I change the password or token I've saved in my credential manager?::
 	Usually, if the password or token is invalid, Git will erase it and
-	prompt for a new one.  However, there are times when this doesn't always
-	happen.  To change the password or token, you can erase the existing
-	credentials and then Git will prompt for new ones.  To erase
-	credentials, use a syntax like the following (substituting your username
+	prompt for a new one. However, there are times when this doesn't always
+	happen. To change the password or token, you can erase the existing
+	credentials and then Git will prompt for new ones. To erase credentials,
+	use a syntax like the following (substituting your username
 	and the hostname):
 +
 ----
@@ -138,12 +138,12 @@ $ echo url=https://author@git.example.org | git credential reject
 [[multiple-accounts-http]]
 How do I use multiple accounts with the same hosting provider using HTTP?::
 	Usually the easiest way to distinguish between these accounts is to use
-	the username in the URL.  For example, if you have the accounts `author`
+	the username in the URL. For example, if you have the accounts `author`
 	and `committer` on `git.example.org`, you can use the URLs
 	https://author@git.example.org/org1/project1.git and
-	https://committer@git.example.org/org2/project2.git.  This way, when you
+	https://committer@git.example.org/org2/project2.git. This way, when you
 	use a credential helper, it will automatically try to look up the
-	correct credentials for your account.  If you already have a remote set
+	correct credentials for your account. If you already have a remote set
 	up, you can change the URL with something like `git remote set-url
 	origin https://author@git.example.org/org1/project1.git` (see
 	linkgit:git-remote[1] for details).
@@ -151,17 +151,17 @@ How do I use multiple accounts with the same hosting provider using HTTP?::
 [[multiple-accounts-ssh]]
 How do I use multiple accounts with the same hosting provider using SSH?::
 	With most hosting providers that support SSH, a single key pair uniquely
-	identifies a user.  Therefore, to use multiple accounts, it's necessary
-	to create a key pair for each account.  If you're using a reasonably
+	identifies a user. Therefore, to use multiple accounts, it's necessary
+	to create a key pair for each account. If you're using a reasonably
 	modern OpenSSH version, you can create a new key pair with something
-	like `ssh-keygen -t ed25519 -f ~/.ssh/id_committer`.  You can then
+	like `ssh-keygen -t ed25519 -f ~/.ssh/id_committer`. You can then
 	register the public key (in this case, `~/.ssh/id_committer.pub`; note
 	the `.pub`) with the hosting provider.
 +
 Most hosting providers use a single SSH account for pushing; that is, all users
-push to the `git` account (e.g., `git@git.example.org`).  If that's the case for
+push to the `git` account (e.g., `git@git.example.org`). If that's the case for
 your provider, you can set up multiple aliases in SSH to make it clear which key
-pair to use.  For example, you could write something like the following in
+pair to use. For example, you could write something like the following in
 `~/.ssh/config`, substituting the proper private key file:
 +
 ----
@@ -189,29 +189,29 @@ Common Issues
 -------------
 
 [[last-commit-amend]]
-I've made a mistake in the last commit.  How do I change it?::
+I've made a mistake in the last commit. How do I change it?::
 	You can make the appropriate change to your working tree, run `git add
 	<file>` or `git rm <file>`, as appropriate, to stage it, and then `git
-	commit --amend`.  Your change will be included in the commit, and you'll
+	commit --amend`. Your change will be included in the commit, and you'll
 	be prompted to edit the commit message again; if you wish to use the
 	original message verbatim, you can use the `--no-edit` option to `git
 	commit` in addition, or just save and quit when your editor opens.
 
 [[undo-previous-change]]
-I've made a change with a bug and it's been included in the main branch.  How should I undo it?::
-	The usual way to deal with this is to use `git revert`.  This preserves
+I've made a change with a bug and it's been included in the main branch. How should I undo it?::
+	The usual way to deal with this is to use `git revert`. This preserves
 	the history that the original change was made and was a valuable
 	contribution, but also introduces a new commit that undoes those changes
-	because the original had a problem.  The commit message of the revert
+	because the original had a problem. The commit message of the revert
 	indicates the commit which was reverted and is usually edited to include
 	an explanation as to why the revert was made.
 
 [[ignore-tracked-files]]
-How do I ignore changes to a tracked file?::
-	Git doesn't provide a way to do this.  The reason is that if Git needs
+How do I ignore changes made to a tracked file?::
+	Git doesn't provide a way to do this. The reason is that if Git needs
 	to overwrite this file, such as during a checkout, it doesn't know
 	whether the changes to the file are precious and should be kept, or
-	whether they are irrelevant and can safely be destroyed.  Therefore, it
+	whether they are irrelevant and can safely be destroyed. Therefore, it
 	has to take the safe route and always preserve them.
 +
 It's tempting to try to use certain features of `git update-index`, namely the
@@ -220,7 +220,7 @@ purpose and shouldn't be used this way.
 +
 If your goal is to modify a configuration file, it can often be helpful to have
 a file checked into the repository which is a template or set of defaults which
-can then be copied alongside and modified as appropriate.  This second, modified
+can then be copied alongside and modified as appropriate. This second, modified
 file is usually ignored to prevent accidentally committing it.
 
 Hooks
@@ -230,12 +230,12 @@ Hooks
 How do I use hooks to prevent users from making certain changes?::
 	The only safe place to make these changes is on the remote repository
 	(i.e., the Git server), usually in the `pre-receive` hook or in a
-	continuous integration (CI) system.  These are the locations in which
+	continuous integration (CI) system. These are the locations in which
 	policy can be enforced effectively.
 +
 It's common to try to use `pre-commit` hooks (or, for commit messages,
 `commit-msg` hooks) to check these things, which is great if you're working as a
-solo developer and want the tooling to help you.  However, using hooks on a
+solo developer and want the tooling to help you. However, using hooks on a
 developer machine is not effective as a policy control because a user can bypass
 these hooks with `--no-verify` without being noticed (among various other ways).
 Git assumes that the user is in control of their local repositories and doesn't
@@ -251,24 +251,24 @@ Cross-Platform Issues
 
 [[windows-text-binary]]
 I'm on Windows and my text files are detected as binary.::
-	Git works best when you store text files as UTF-8.  Many programs on
+	Git works best when you store text files as UTF-8. Many programs on
 	Windows support UTF-8, but some do not and only use the little-endian
-	UTF-16 format, which Git detects as binary.  If you can't use UTF-8 with
+	UTF-16 format, which Git detects as binary. If you can't use UTF-8 with
 	your programs, you can specify a working tree encoding that indicates
 	which encoding your files should be checked out with, while still
-	storing these files as UTF-8 in the repository.  This allows tools like
+	storing these files as UTF-8 in the repository. This allows tools like
 	linkgit:git-diff[1] to work as expected, while still allowing your tools
 	to work.
 +
 To do so, you can specify a linkgit:gitattributes[5] pattern with the
-`working-tree-encoding` attribute.  For example, the following pattern sets all
+`working-tree-encoding` attribute. For example, the following pattern sets all
 C files to use UTF-16LE-BOM, which is a common encoding on Windows:
 +
 ----
 *.c	working-tree-encoding=UTF-16LE-BOM
 ----
 +
-You will need to run `git add --renormalize` to have this take effect.  Note
+You will need to run `git add --renormalize` to have this take effect. Note
 that if you are making these changes on a project that is used across platforms,
 you'll probably want to make it in a per-user configuration file or in the one
 in `$GIT_DIR/info/attributes`, since making it in a `.gitattributes` file in the
@@ -279,13 +279,13 @@ and see linkgit:gitattributes[5] for more information about attribute files.
 
 [[windows-diff-control-m]]
 I'm on Windows and git diff shows my files as having a `^M` at the end.::
-	By default, Git expects files to be stored with Unix line endings.  As such,
+	By default, Git expects files to be stored with Unix line endings. As such,
 	the carriage return (`^M`) that is part of a Windows line ending is shown
-	because it is considered to be trailing whitespace.  Git defaults to showing
+	because it is considered to be trailing whitespace. Git defaults to showing
 	trailing whitespace only on new lines, not existing ones.
 +
 You can store the files in the repository with Unix line endings and convert
-them automatically to your platform's line endings.  To do that, set the
+them automatically to your platform's line endings. To do that, set the
 configuration option `core.eol` to `native` and see the following entry for
 information about how to configure files as text or binary.
 +
@@ -295,28 +295,28 @@ don't wish to remove the carriage returns from your line endings.
 [[recommended-storage-settings]]
 What's the recommended way to store files in Git?::
 	While Git can store and handle any file of any type, there are some
-	settings that work better than others.  In general, we recommend that
+	settings that work better than others. In general, we recommend that
 	text files be stored in UTF-8 without a byte-order mark (BOM) with LF
-	(Unix-style) endings.  We also recommend the use of UTF-8 (again,
-	without BOM) in commit messages.  These are the settings that work best
+	(Unix-style) endings. We also recommend the use of UTF-8 (again,
+	without BOM) in commit messages. These are the settings that work best
 	across platforms and with tools such as `git diff` and `git merge`.
 +
 Additionally, if you have a choice between storage formats that are text based
 or non-text based, we recommend storing files in the text format and, if
-necessary, transforming them into the other format.  For example, a text-based
+necessary, transforming them into the other format. For example, a text-based
 SQL dump with one record per line will work much better for diffing and merging
-than an actual database file.  Similarly, text-based formats such as Markdown
+than an actual database file. Similarly, text-based formats such as Markdown
 and AsciiDoc will work better than binary formats such as Microsoft Word and
 PDF.
 +
 Similarly, storing binary dependencies (e.g., shared libraries or JAR files) or
-build products in the repository is generally not recommended.  Dependencies and
+build products in the repository is generally not recommended. Dependencies and
 build products are best stored on an artifact or package server with only
 references, URLs, and hashes stored in the repository.
 +
 We also recommend setting a linkgit:gitattributes[5] file to explicitly mark
-which files are text and which are binary.  If you want Git to guess, you can
-set the attribute `text=auto`.  For example, the following might be appropriate
+which files are text and which are binary. If you want Git to guess, you can
+set the attribute `text=auto`. For example, the following might be appropriate
 in some projects:
 +
 ----
-- 
2.20.1

