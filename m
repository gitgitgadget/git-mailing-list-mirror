Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B02C33CB1
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 06:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFA7B20728
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 06:14:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SodpoDT/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730294AbgAPGOr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jan 2020 01:14:47 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40490 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730216AbgAPGOq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jan 2020 01:14:46 -0500
Received: by mail-wr1-f66.google.com with SMTP id c14so17874022wrn.7
        for <git@vger.kernel.org>; Wed, 15 Jan 2020 22:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=uelOHNzNyRvdZZtak6GGDhRz/+hDTkDonlmeCQJdjLI=;
        b=SodpoDT/LyFd5Yul8KxJBwCNYoDeF08bca5IB8LSZTf1f1HH0u0gCPdDGTHCcOfnD7
         9wvjHKVIulY1RHZKaDicIyFuO6wnPwSiQ9WdA7fYGmLE1c3t8yXWToNfk+WP4YDj3bir
         R3aGzs+b1ugyyTVS/TgoR8XAvltcZdfRtsjFtCGjBv/JYokSh7Nztf3shwv0ZnSTKA7R
         KmxaL0khE/2LBtptVfTNq3Fzmf0mRF4H/LG7RZS1PmD4gln5tLAEHuCUkYG4BrxjjnIU
         k0QrOsVFLDgiRPLn2kjtFGF2a1cfUuMSR6EfIVvw/M4gY9FNMhCvHM/R5PEMj1rvj8et
         rQ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=uelOHNzNyRvdZZtak6GGDhRz/+hDTkDonlmeCQJdjLI=;
        b=cBBhujANK+VYJ7ZO9YvO8HsAWSkxqWDx6wDb3Iy/x1RzYyXXlBDI5OW+XwVLWbWt16
         CLmXaL9bt/XXSeZqTvWEJDU4N6YjTx+r4OJV97Tmetw2SuTfxOXcq3tjufGu/Ii89jOz
         Cyf/U2IBNfoY3VJyi+X4nvxsbizP2GMbREK8z+FRl4xGND9+jG1jHDFk0CSEdlnS9DHY
         9sgGzSkK8I4ZYTLbw6liqTYSER5LtIG9n9HgkZKoJdH0wWS9HQ8hGkgUsnz2mxgiwQLC
         tOrlHbLHHWDqJMtfXPcwdco/2oz9DFZWBAr3VowDMLVis9Ao2oPyXxd2Sl5UHZxVGlwy
         TEfA==
X-Gm-Message-State: APjAAAU2A9Ex/QgA5HsbTmi7mfPMNpfQ48g5wPr+AcQQxC2TTtosVYeM
        XtCUK1sSkTVcfRnw6O/4zr4zYkQY
X-Google-Smtp-Source: APXvYqwFfwhOWIC4KLSdWZI+k6JDaPwnFHS9syeeF2noZv0FuSfPiSlX7fjJFr9pL4IvsEMxjFlOGA==
X-Received: by 2002:adf:ffc7:: with SMTP id x7mr1286306wrs.159.1579155283857;
        Wed, 15 Jan 2020 22:14:43 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f207sm1927302wme.9.2020.01.15.22.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 22:14:43 -0800 (PST)
Message-Id: <b50a1741e0b0d96c918a3f143226fd222b42baea.1579155273.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.679.v4.git.git.1579155273.gitgitgadget@gmail.com>
References: <pull.679.v3.git.git.1577217299.gitgitgadget@gmail.com>
        <pull.679.v4.git.git.1579155273.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 16 Jan 2020 06:14:25 +0000
Subject: [PATCH v4 11/19] git-rebase.txt: add more details about behavioral
 differences of backends
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, phillip.wood@dunelm.org.uk,
        liu.denton@gmail.com, gitster@pobox.com, plroskin@gmail.com,
        alban.gruin@gmail.com, szeder.dev@gmail.com, jrnieder@gmail.com,
        emilyshaffer@google.com, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-rebase.txt | 85 +++++++++++++++++++++++++++++++++---
 1 file changed, 80 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 551a91d764..df02d76e2d 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -414,7 +414,7 @@ with `--keep-base` in order to drop those commits from your branch.
 
 --ignore-whitespace::
 --whitespace=<option>::
-	These flag are passed to the 'git apply' program
+	These flags are passed to the 'git apply' program
 	(see linkgit:git-apply[1]) that applies the patch.
 +
 See also INCOMPATIBLE OPTIONS below.
@@ -561,8 +561,8 @@ The following options:
 
  * --committer-date-is-author-date
  * --ignore-date
- * --whitespace
  * --ignore-whitespace
+ * --whitespace
  * -C
 
 are incompatible with the following options:
@@ -613,9 +613,84 @@ handling commits that become empty.
 Directory rename detection
 ~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-Directory rename heuristics are enabled in the merge and interactive
-backends.  Due to the lack of accurate tree information, directory
-rename detection is disabled in the am backend.
+Due to the lack of accurate tree information (arising from
+constructing fake ancestors with the limited information available in
+patches), directory rename detection is disabled in the am backend.
+Disabled directory rename detection means that if one side of history
+renames a directory and the other adds new files to the old directory,
+then the new files will be left behind in the old directory without
+any warning at the time of rebasing that you may want to move these
+files into the new directory.
+
+Directory rename detection works with the merge and interactive
+backends to provide you warnings in such cases.
+
+Context
+~~~~~~~
+
+The am backend works by creating a sequence of patches (by calling
+`format-patch` internally), and then applying the patches in sequence
+(calling `am` internally).  Patches are composed of multiple hunks,
+each with line numbers, a context region, and the actual changes.  The
+line numbers have to be taken with some fuzz, since the other side
+will likely have inserted or deleted lines earlier in the file.  The
+context region is meant to help find how to adjust the line numbers in
+order to apply the changes to the right lines.  However, if multiple
+areas of the code have the same surrounding lines of context, the
+wrong one can be picked.  There are real-world cases where this has
+caused commits to be reapplied incorrectly with no conflicts reported.
+Setting diff.context to a larger value may prevent such types of
+problems, but increases the chance of spurious conflicts (since it
+will require more lines of matching context to apply).
+
+The interactive backend works with a full copy of each relevant file,
+insulating it from these types of problems.
+
+Labelling of conflicts markers
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+When there are content conflicts, the merge machinery tries to
+annotate each side's conflict markers with the commits where the
+content came from.  Since the am backend drops the original
+information about the rebased commits and their parents (and instead
+generates new fake commits based off limited information in the
+generated patches), those commits cannot be identified; instead it has
+to fall back to a commit summary.  Also, when merge.conflictStyle is
+set to diff3, the am backend will use "constructed merge base" to
+label the content from the merge base, and thus provide no information
+about the merge base commit whatsoever.
+
+The interactive backend works with the full commits on both sides of
+history and thus has no such limitations.
+
+Hooks
+~~~~~
+
+The am backend has not traditionally called the post-commit hook,
+while the merge/interactive backend has.  However, this was by
+accident of implementation rather than by design.  Both backends
+should have the same behavior, though it is not clear which one is
+correct.
+
+Miscellaneous differences
+~~~~~~~~~~~~~~~~~~~~~~~~~
+
+There are a few more behavioral differences that most folks would
+probably consider inconsequential but which are mentioned for
+completeness:
+
+* Reflog: The two backends will use different wording when describing
+  the changes made in the reflog, though both will make use of the
+  word "rebase".
+
+* Progress, informational, and error messages: The two backends
+  provide slightly different progress and informational messages.
+  Also, the am backend writes error messages (such as "Your files
+  would be overwritten...") to stdout, while the interactive backend
+  writes them to stderr.
+
+* State directories: The two backends keep their state in different
+  directories under .git/
 
 include::merge-strategies.txt[]
 
-- 
gitgitgadget

