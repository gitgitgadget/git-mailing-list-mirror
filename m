Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A16BACD6115
	for <git@archiver.kernel.org>; Mon,  9 Oct 2023 17:56:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345624AbjJIR4P (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Oct 2023 13:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233372AbjJIR4O (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2023 13:56:14 -0400
Received: from mail.smrk.net (mail.smrk.net [IPv6:2001:19f0:6c01:2788:5400:4ff:fe27:adaa])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43CBB91
        for <git@vger.kernel.org>; Mon,  9 Oct 2023 10:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smrk.net; s=20221002;
        t=1696874165;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AIFkcHA7Y7uvU4uCIXCq1pDkHDKAAuyhj1e5gwKkXqM=;
        b=NJMWZwGHO5Lra3VdV8vPZcvFlfukAEwNBMJjbsUkF5Ws+VIRelpnSiPCFhLViF3uc3plTm
        UgGHKU7AfW//vojYv8oiPT4Glcyag6LEQH1ZN32UcWLcQ/FEQ1D5B+iCydx0OpL/cfQzSI
        BFZ6lrV/uW2b/xodCIHJ+rrcSPOP7qb+6o8y9HFku0QfMunfrYrFcouF9AZBj/idqeC1t9
        GujOXUOXt5h3DHen97xrpZMvMHY1ZczT8SATVqOGy+IlydetsSfBAhluyUjQgq3MVkcW45
        WvmdaSiGhudfv9KOnaNAFoj6aE0Ssj762/F8uWcjioY+x38MDZbVHPBrHQZ1PQ==
Received: from localhost (<unknown> [192.168.5.2])
        by smrk (OpenSMTPD) with ESMTPSA id b84146fa (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 9 Oct 2023 19:56:05 +0200 (CEST)
From:   =?UTF-8?q?=C5=A0t=C4=9Bp=C3=A1n=20N=C4=9Bmec?= <stepnem@smrk.net>
To:     peff@peff.net
Cc:     git@vger.kernel.org, avarab@gmail.com
Subject: [PATCH] doc/cat-file: make synopsis and description less confusing
Date:   Mon,  9 Oct 2023 19:56:04 +0200
Message-ID: <20231009175604.2361700-1-stepnem@smrk.net>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009155603.GA3251575@coredump.intra.peff.net>
References: <20231009155603.GA3251575@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The DESCRIPTION's "first form" is actually the 1st, 2nd, 3rd and 5th
form in SYNOPSIS, the "second form" is the 4th one.

Interestingly, this state of affairs was introduced in
97fe7250753b (cat-file docs: fix SYNOPSIS and "-h" output, 2021-12-28)
with the claim of "Now the two will match again." ("the two" being
DESCRIPTION and SYNOPSIS)...

The description also suffers from other correctness and clarity issues,
e.g., the "first form" paragraph discusses -p, -s and -t, but leaves out
-e, which is included in the corresponding SYNOPSIS section; the second
paragraph mentions <format>, which doesn't occur in SYNOPSIS at all, and
of the three batch options, really only describes the behavior of
--batch-check.  Also the mention of "drivers" seems an implementation
detail not adding much clarity in a short summary (and isn't expanded
upon in the rest of the man page, either).

Rather than trying to maintain one-to-one (or N-to-M) correspondence
between the DESCRIPTION and SYNOPSIS forms, creating duplication and
providing opportunities for error, shorten the former into a concise
summary describing the two general modes of operation: batch and
non-batch, leaving details to the subsequent manual sections.

While here, fix a grammar error in the description of -e and make the
following further minor improvements:

  NAME:
    shorten ("content or type and size" isn't the whole story; say
    "details" and leave the actual details to later sections)

  SYNOPSIS and --help:
    move the (--textconv | --filters) form before --batch, closer
    to the other non-batch forms

Signed-off-by: Štěpán Němec <stepnem@smrk.net>
---
On Mon, 09 Oct 2023 11:56:03 -0400
Jeff King wrote:

> On Mon, Oct 09, 2023 at 10:36:51AM +0200, Štěpán Němec wrote:
>
>> > Ah, true, I was thinking that the DESCRIPTION section would be the first
>> > thing users would read, but I didn't notice the headline. I agree that
>> > what it says is probably sufficient (though arguably "type and size" is
>> > slightly inaccurate there; I said "details" in my proposed text but
>> > maybe that is too vague).
>> 
>> We could also leave the NAME vague(r) and put an additional sentence at
>> the beginning of DESCRIPTION:
>
> Yup, that is a good suggestion. Do you want to wrap all of this
> discussion up as a patch?

Certainly, here it is.  I just wanted to hash out some of the details
first and found the plain text more fit for that purpose.

Thanks.

To anyone not following the whole thread: this is a slightly more
ambitious version of [1] ("[PATCH] doc/cat-file: clarify description
regarding various command forms"), intended to supersede it.

[1]
https://lore.kernel.org/git/20231003082513.3003520-1-stepnem@smrk.net/

 Documentation/git-cat-file.txt | 30 ++++++++++++++----------------
 builtin/cat-file.c             |  4 ++--
 2 files changed, 16 insertions(+), 18 deletions(-)

diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
index 0e4936d18263..bd95a6c10a7d 100644
--- a/Documentation/git-cat-file.txt
+++ b/Documentation/git-cat-file.txt
@@ -3,8 +3,7 @@ git-cat-file(1)
 
 NAME
 ----
-git-cat-file - Provide content or type and size information for repository objects
-
+git-cat-file - Provide contents or details of repository objects
 
 SYNOPSIS
 --------
@@ -12,25 +11,24 @@ SYNOPSIS
 'git cat-file' <type> <object>
 'git cat-file' (-e | -p) <object>
 'git cat-file' (-t | -s) [--allow-unknown-type] <object>
+'git cat-file' (--textconv | --filters)
+	     [<rev>:<path|tree-ish> | --path=<path|tree-ish> <rev>]
 'git cat-file' (--batch | --batch-check | --batch-command) [--batch-all-objects]
 	     [--buffer] [--follow-symlinks] [--unordered]
 	     [--textconv | --filters] [-Z]
-'git cat-file' (--textconv | --filters)
-	     [<rev>:<path|tree-ish> | --path=<path|tree-ish> <rev>]
 
 DESCRIPTION
 -----------
-In its first form, the command provides the content or the type of an object in
-the repository. The type is required unless `-t` or `-p` is used to find the
-object type, or `-s` is used to find the object size, or `--textconv` or
-`--filters` is used (which imply type "blob").
+Output the contents or other properties such as size, type or delta
+information of one or more objects.
 
-In the second form, a list of objects (separated by linefeeds) is provided on
-stdin, and the SHA-1, type, and size of each object is printed on stdout. The
-output format can be overridden using the optional `<format>` argument. If
-either `--textconv` or `--filters` was specified, the input is expected to
-list the object names followed by the path name, separated by a single
-whitespace, so that the appropriate drivers can be determined.
+This command can operate in two modes, depending on whether an option
+from the `--batch` family is specified.
+
+In non-batch mode, the command provides information on an object
+named on the command line.
+
+In batch mode, arguments are read from standard input.
 
 OPTIONS
 -------
@@ -51,8 +49,8 @@ OPTIONS
 
 -e::
 	Exit with zero status if `<object>` exists and is a valid
-	object. If `<object>` is of an invalid format exit with non-zero and
-	emits an error on stderr.
+	object. If `<object>` is of an invalid format, exit with non-zero
+	status and emit an error on stderr.
 
 -p::
 	Pretty-print the contents of `<object>` based on its type.
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 694c8538df2f..ea8ad601ecc0 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -922,11 +922,11 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 		N_("git cat-file <type> <object>"),
 		N_("git cat-file (-e | -p) <object>"),
 		N_("git cat-file (-t | -s) [--allow-unknown-type] <object>"),
+		N_("git cat-file (--textconv | --filters)\n"
+		   "             [<rev>:<path|tree-ish> | --path=<path|tree-ish> <rev>]"),
 		N_("git cat-file (--batch | --batch-check | --batch-command) [--batch-all-objects]\n"
 		   "             [--buffer] [--follow-symlinks] [--unordered]\n"
 		   "             [--textconv | --filters] [-Z]"),
-		N_("git cat-file (--textconv | --filters)\n"
-		   "             [<rev>:<path|tree-ish> | --path=<path|tree-ish> <rev>]"),
 		NULL
 	};
 	const struct option options[] = {

base-commit: 3a06386e314565108ad56a9bdb8f7b80ac52fb69
-- 
2.42.0

