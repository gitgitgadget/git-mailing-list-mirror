Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2F661F5A2
	for <e@80x24.org>; Mon, 18 Nov 2019 11:24:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbfKRLYB (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Nov 2019 06:24:01 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44009 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727176AbfKRLYA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Nov 2019 06:24:00 -0500
Received: by mail-pg1-f195.google.com with SMTP id b1so13408pgq.10
        for <git@vger.kernel.org>; Mon, 18 Nov 2019 03:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=veIc3Nml1P7Y/HwzVtT2dxsYkYolGTEeneWmYk+Vrvs=;
        b=s5SpXup/FDGxYtTPAJ2fXvHtLQFuf19rHHsLavVttpDDDQ92JqA5f8tst2mEJR/3tH
         KUkWrS8uYPnUdLcCj8BymQ5SBZDOaSzJvyEv5z1BUtOPHjXhqIi+Vt0XXP85jKmUT00q
         wpMiwEVV+XLMVjuoHsWqv6bt6S3zUaYvR/FDt+cUoC6pUI5638a1wUKAZSjUcC3aqdXs
         CqbClPA8o5s6WxJeGX3IwNCKbDOgm6PfAbZptW2lD+UN/DVxvDnB0sB5Pnlt62chC0ja
         CV9xc+eUQaIPAdYE9uXnCsPHfZzjhTlvRhrtyS+6U6wHZls8qTfeV+rLUvtfJZCXpyUb
         gJJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=veIc3Nml1P7Y/HwzVtT2dxsYkYolGTEeneWmYk+Vrvs=;
        b=hUFproQrKegG/IivB6ZdklQLavjAIyMFzJ9FyH1ZcNYJn1TcyiZyQ1DZgWT7apjUJV
         GoFcYhgSFac5A67SBVecbAYjrgVWYWHwwDcG9ZGRzs65c3oStMQaY1vLR6ESN5nK0cTh
         iMzq0v0TOnAexXYW2U5xSE8DkE+7pNV7Sl3UNabOeYN7hJC82yTQrCU2Qs1R5a1QMT0D
         vFekSAw2FlUGx+k7p6CuW4zAnvNpexhF+qVzy956Vg+nK25VLYsVR0KI2CXdkC7TG7AZ
         TAGScxfqQQP0vi7jZbfnclLmb9RFmSlFisXK1OmIDePI/xa5cJv50Mk+44pwX/feZPY6
         TA0g==
X-Gm-Message-State: APjAAAUKJeaejGh9+3gCFaF8ewJT4sRc793v1aDJJJhO+s8Btbio5siy
        a8PWWimIiekRhiB/VpoZTV8=
X-Google-Smtp-Source: APXvYqz6AUFwKjAGjy40B7xCOXsIGHLkJlQ5+QIexnnzW7OauVbnEWza1q0HUn3canHmHW8uO6kITw==
X-Received: by 2002:a63:792:: with SMTP id 140mr22154684pgh.427.1574076240080;
        Mon, 18 Nov 2019 03:24:00 -0800 (PST)
Received: from localhost ([2402:800:6375:16b7:502d:9b82:436:143a])
        by smtp.gmail.com with ESMTPSA id b7sm19061356pjo.3.2019.11.18.03.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 03:23:59 -0800 (PST)
Date:   Mon, 18 Nov 2019 18:23:57 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Subject: [PATCH] sequencer: handle rebase-merge for "onto" message
Message-ID: <20191118112357.GA29922@danh.dev>
References: <pull.327.git.gitgitgadget@gmail.com>
 <pull.327.v2.git.1574032570.gitgitgadget@gmail.com>
 <xmqq8sod3l5a.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8sod3l5a.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019-11-18 12:42:41+0900, Junio C Hamano <gitster@pobox.com> wrote:
> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
> 
> > Those labels must be valid ref names, and therefore valid file names. The
> > initial patch came in via Git for Windows.
> >
> > Change since v1:
> >
> >  * moved the entire sanitizing logic to label_oid(), as a preparatory step.
> >
> > Johannes Schindelin (1):
> >   rebase-merges: move labels' whitespace mangling into `label_oid()`
> >
> > Matthew Rogers (1):
> >   rebase -r: let `label` generate safer labels
> >
> >  sequencer.c              | 72 +++++++++++++++++++++++++---------------
> >  t/t3430-rebase-merges.sh |  6 ++++
> >  2 files changed, 51 insertions(+), 27 deletions(-)
> 
> I think Dscho meant to Cc you as these two patches are meant to be a
> more complete solution to supersede your [*1*].

I've applied their patches over my branches,
my introduced test_expect_failure was flipped.
That's nice.

Anyway, when reading their patch, I discovered a problem with
git rebase --rebase-merges when its message is onto.

Here is a patch to fix it.

I applied Dscho's patches over my dd/sequencer-utf8 then writing this
patch, in case you have problem applying it.

The context for the diff is coming from Dscho's patches.

-------8<--------------------
From 48205889b404b82baa4b30c2eedd52243c349e3e Mon Sep 17 00:00:00 2001
From: Doan Tran Cong Danh <congdanhqx@gmail.com>
Date: Mon, 18 Nov 2019 18:02:05 +0700
Subject: [PATCH] sequencer: handle rebase-merge for "onto" message

In order to work correctly, git-rebase --rebase-merges needs to make
initial todo list with unique labels.

Those unique labels is being handled by employing a hashmap and
suffixing an unique number if any duplicate is found.

But we forgat that beside of those labels for side branches,
we also make a special label `onto' for our so-called new-base.

In a special case that any of those labels for side branches named
`onto', git will run into trouble.

Correct it.

Signed-off-by: Doan Tran Cong Danh <congdanhqx@gmail.com>
---
 sequencer.c              |  5 +++++
 t/t3430-rebase-merges.sh | 21 +++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index 350045b1b4..fc81e43f0f 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4569,10 +4569,15 @@ static int make_script_with_merges(struct pretty_print_context *pp,
 	strbuf_init(&state.buf, 32);
 
 	if (revs->cmdline.nr && (revs->cmdline.rev[0].flags & BOTTOM)) {
+		struct labels_entry *onto_label_entry;
 		struct object_id *oid = &revs->cmdline.rev[0].item->oid;
 		FLEX_ALLOC_STR(entry, string, "onto");
 		oidcpy(&entry->entry.oid, oid);
 		oidmap_put(&state.commit2label, entry);
+
+		FLEX_ALLOC_STR(onto_label_entry, label, "onto");
+		hashmap_entry_init(&onto_label_entry->entry, strihash("onto"));
+		hashmap_add(&state.labels, &onto_label_entry->entry);
 	}
 
 	/*
diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
index f728aba995..4e2c0ede51 100755
--- a/t/t3430-rebase-merges.sh
+++ b/t/t3430-rebase-merges.sh
@@ -474,4 +474,25 @@ test_expect_success '--rebase-merges with commit that can generate bad character
 	git rebase --rebase-merges --force-rebase E
 '
 
+test_expect_success '--rebase-merges with message matched with onto label' '
+	git checkout -b onto-label E &&
+	git merge -m onto G &&
+	git rebase --rebase-merges --force-rebase E &&
+	test_cmp_graph <<-\EOF
+	*   onto
+	|\
+	| * G
+	| * F
+	* |   E
+	|\ \
+	| * | B
+	* | | D
+	| |/
+	|/|
+	* | C
+	|/
+	* A
+	EOF
+'
+
 test_done
-- 
2.24.0.10.gc61c3b979f.dirty

