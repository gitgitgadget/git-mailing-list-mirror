Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D85C433DB
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 23:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77DE164E75
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 23:22:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbhBHXWt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Feb 2021 18:22:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbhBHXWs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Feb 2021 18:22:48 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E10C061788
        for <git@vger.kernel.org>; Mon,  8 Feb 2021 15:22:08 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id ew18so7849884qvb.4
        for <git@vger.kernel.org>; Mon, 08 Feb 2021 15:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5bBRAINJnC1QrG2V6pcgEMtbW6c9FhHrxmCUK4h9mFM=;
        b=OVcfwqPDhD+XmWdBI+ovVtTFPmhb/JB68eor5kHO98s7WKPmw0lfluxcKEFXdufi2p
         enabZwB1KkDKoMDDQRvBEImrAGYSqYUSIJU7Y9A6oxRfjRQBE/1eghQZd7hrU7N0ot0x
         Jg/OIZhy0B8M8PnNEoQMTnBQAuteuahOLDEY6YLAEaYqyttLwBv7+LJlsiBYnTNaCWl8
         UoljLFGwDnExYKbbfbPIrCe/NsEf/wce+QMob0t0dFOFVIS44C0bHbsWeFj4HXQl1RyK
         P8sDF898mTRKubMlbSQhOCugdgYJxTcvzTA9oxQdOTbKapj633BoJ4x96ntnO0xXluc3
         iodg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5bBRAINJnC1QrG2V6pcgEMtbW6c9FhHrxmCUK4h9mFM=;
        b=Me7NzRiqlS4oSz7dAulDcXc7wla5OIJaVngF7ObJ1hBeDCRR4uPj7rm/vsv27K+yuN
         D9Rv/ZEA9uWkajZidYjSTOnjqpDWbGDW8n6ysMYFWR1Xjpfeb6Ip6zMDJry7bQNGXh8D
         nnHLiXZiOeD0i8ulskBCmKWPAEzCorSNoghx737/VS4ZXSsCGgQE910QKTNCylgTBVEr
         SEsFeKzcf8tjNq3aLi3JhWCMDgDdtJAIYtIGwkGWcLSbxxdArGhejBtYkkuSXnZM2Ake
         0je+FDXCoR+WY2f2hEUR1/eQP9r4XWf7jQVn1wG/tw0GgfcKeOwLLEwPFFQ5Lfeh6TAz
         wjnw==
X-Gm-Message-State: AOAM5314viedPZeIpqWh5nZnyKfq3HmQgANViUq24FDARnFQRm5m9EPP
        40MlYWi2Ew0eLxyqRanJPvDlK6TB4WURkg==
X-Google-Smtp-Source: ABdhPJz6lWLrkYC2TUjfh9ylWhc/jHUpz7S9sCt+NN+ltnJcL2EkAPWPq+F14/A4/zwURizcbyYffg==
X-Received: by 2002:a05:6214:1341:: with SMTP id b1mr18581228qvw.57.1612826527220;
        Mon, 08 Feb 2021 15:22:07 -0800 (PST)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id l35sm15913089qtd.90.2021.02.08.15.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 15:22:06 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] grep: error out if --untracked is used with --cached
Date:   Mon,  8 Feb 2021 20:21:59 -0300
Message-Id: <20210208232159.100543-1-matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <YCGxos2vB6mgHOTA@nand.local>
References: <YCGxos2vB6mgHOTA@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Feb 8, 2021 at 6:48 PM Taylor Blau <me@ttaylorr.com> wrote:
>
> On Mon, Feb 08, 2021 at 04:43:28PM -0300, Matheus Tavares wrote:
> > The options --untracked and --cached are not compatible, but if they are
> > used together, grep just silently ignores --cached and searches the
> > working tree. Error out, instead, to avoid any potential confusion.
> >
> > Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> > ---
> >  builtin/grep.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/builtin/grep.c b/builtin/grep.c
> > index ca259af441..392acf8cab 100644
> > --- a/builtin/grep.c
> > +++ b/builtin/grep.c
> > @@ -1157,6 +1157,9 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
> >       if (!use_index && (untracked || cached))
> >               die(_("--cached or --untracked cannot be used with --no-index"));
> >
> > +     if (untracked && cached)
> > +             die(_("--untracked cannot be used with --cached"));
> > +
>
> Are these really incompatible? --untracked says that untracked files are
> searched in addition to tracked ones in the working tree.
> --cached says that the index is searched instead of tracked files. From
> my reading, that seems to imply that the combination you're proposing
> getting rid of would mean: "search the index,and untracked files".

Yeah, I agree that there is nothing conceptually wrong with the use case
"search the index, and untracked files". The problem is that git-grep is
currently not able to search both these places in the same execution.
In fact, I don't think it can combine working tree and index searches
in any way (besides with --assume-unchanged paths).

When --cached is used with --untracked, git-grep silently ignores
--cached and searches the working tree only:

$ echo 'cached A' >A
$ git add A
$ git commit -m A
$ echo 'modified A' >A
$ echo 'untracked' >B
$ git grep --cached --untracked .
A:modified A
B:untracked

Perhaps, instead of erroring out with this currently invalid
combination, should we make it valid by teaching git-grep how to search
the two places on a single run? I.e. something like:

diff --git a/builtin/grep.c b/builtin/grep.c
index ca259af441..b0e99096ff 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -699,7 +699,7 @@ static int grep_objects(struct grep_opt *opt, const struct pathspec *pathspec,
 }

 static int grep_directory(struct grep_opt *opt, const struct pathspec *pathspec,
-			  int exc_std, int use_index)
+			  int exc_std, int use_index, int untracked_only)
 {
 	struct dir_struct dir;
 	int i, hit = 0;
@@ -712,7 +712,13 @@ static int grep_directory(struct grep_opt *opt, const struct pathspec *pathspec,

 	fill_directory(&dir, opt->repo->index, pathspec);
 	for (i = 0; i < dir.nr; i++) {
-		hit |= grep_file(opt, dir.entries[i]->name);
+		struct dir_entry *ent = dir.entries[i];
+
+		if (untracked_only &&
+		    !index_name_is_other(opt->repo->index, ent->name, ent->len))
+			continue;
+
+		hit |= grep_file(opt, ent->name);
 		if (hit && opt->status_only)
 			break;
 	}
@@ -1157,9 +1163,14 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	if (!use_index && (untracked || cached))
 		die(_("--cached or --untracked cannot be used with --no-index"));

-	if (!use_index || untracked) {
+	if (cached && untracked) {
+		hit = grep_cache(&opt, &pathspec, 1);
+		hit |= grep_directory(&opt, &pathspec, !!opt_exclude, 1, 1);
+
+	} else if (!use_index || untracked) {
 		int use_exclude = (opt_exclude < 0) ? use_index : !!opt_exclude;
-		hit = grep_directory(&opt, &pathspec, use_exclude, use_index);
+		hit |= grep_directory(&opt, &pathspec, use_exclude, use_index, 0);
+
 	} else if (0 <= opt_exclude) {
 		die(_("--[no-]exclude-standard cannot be used for tracked contents"));
 	} else if (!list.nr) {

With this, the `git grep --cached --untracked .` search from the
previous example would produce the following output:

A:cached A
B:untracked

In this case, should we also add an 'untracked:' / 'cached:' prefix to
the filenames, like we do for revision searches (e.g. 'HEAD:A:cached A') ?

