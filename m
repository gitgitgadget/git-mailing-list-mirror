Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F243C48BDF
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 17:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F5DB61181
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 17:46:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbhFJRsM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 13:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbhFJRsL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jun 2021 13:48:11 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA9FC061574
        for <git@vger.kernel.org>; Thu, 10 Jun 2021 10:45:59 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id a15so452908qtx.13
        for <git@vger.kernel.org>; Thu, 10 Jun 2021 10:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qw9Ilkt9IDvJ34PV6P2xK8mbqAtK/YuVZm2OWMOq9q4=;
        b=vDswgnezbkNXE/rkbuusYcTmTXtwIIK9DnHKCoyM4ozQqlfyzH5iB42XCHnNlnzyvE
         Io1M6RAA8gacegqDMGFv2QAno/bc3azfqmWGHQS6eHThSWEWdIPcvwUXSUh0ncSoqYbW
         cpePALHIPMlAXtYHemNIf8kXTmRDQ1Pzxm54HeXBckI9U+84O9yhRjvFap2rPeTCAd72
         i0tghWOcLYThNB1JoBsrzr96MNSxqnr8wjlZ77AbUvPIoynJg3Bh31KOK4+AfIKkMyLL
         300vkF8R45lflY7xf8yXq6bR5FFR7trP156yRDX4lM9Pb+JNJ+yQnL/xQSZOv7Cg8pzi
         U2Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qw9Ilkt9IDvJ34PV6P2xK8mbqAtK/YuVZm2OWMOq9q4=;
        b=UXvTCsv5vammB4Yne+zVr8CjwjCA7lLMUAa7FSRJmM+PI94OqlsPkODpZTiuGzU8oV
         wen9+R6byNeEDslLZOrcaG++9nK0ejgrJFNG9wKJ7+keChh+Swdq7r6X7CBDFSCquBSq
         +bRR318xcooRIz+0yLd5PL7G1TY2XFGv5Zrzh8F4syqU3xGSGpVOuJrKxmMdXJfHFKJg
         ZNjiS8uwloaRf4UnbUl3TV7e1ul6M09mZGxxrymO3JBpWYvDKfROadqbW1BHkIe5yLZ9
         6K5L/HBswcTNlB7UIxEFZ3unmiwbU/NRSIJ47bFEbMkoyxXbNPyyWHr8osURi8GZpGm0
         okUA==
X-Gm-Message-State: AOAM532HdgmDK2xp38IsQ2jQ5GG8BBNaYVApYET1RDKgF3r9rdnlEOi0
        dC0CI+JoS14kXabzxyqSxA8=
X-Google-Smtp-Source: ABdhPJwGh171dybyUyU72u/zW+TgvXK0xZKHzjU6lY9BUkETC3P/jzx1Welyl1DeVKOKSQKUqFi4/w==
X-Received: by 2002:ac8:5394:: with SMTP id x20mr813747qtp.192.1623347158832;
        Thu, 10 Jun 2021 10:45:58 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:8dd3:e726:fe78:a0d9? ([2600:1700:e72:80a0:8dd3:e726:fe78:a0d9])
        by smtp.gmail.com with ESMTPSA id g24sm2607205qts.60.2021.06.10.10.45.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jun 2021 10:45:58 -0700 (PDT)
Subject: Re: [PATCH v5 10/14] diff-lib: handle index diffs with sparse dirs
From:   Derrick Stolee <stolee@gmail.com>
To:     Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.932.v4.git.1621598382.gitgitgadget@gmail.com>
 <pull.932.v5.git.1623069252.gitgitgadget@gmail.com>
 <b9b97e0112939d1787ff1d2a13c48e5b406408db.1623069252.git.gitgitgadget@gmail.com>
 <CABPp-BEp0NzUqW_pWpTGoUvrB1JMp9fVHr28Sp8RZqV6w0-hEw@mail.gmail.com>
 <xmqqfsxrk0oc.fsf@gitster.g>
 <CABPp-BHEp6mH3jx6BeRk+u8C-9Q+go0=hHiaxenN_5KQKsR5iw@mail.gmail.com>
 <60844f4b-33d4-b6d7-3611-a93cf012d3ff@gmail.com>
Message-ID: <38d0900b-c677-a32d-cc63-e615828e9a5d@gmail.com>
Date:   Thu, 10 Jun 2021 13:45:57 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <60844f4b-33d4-b6d7-3611-a93cf012d3ff@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/9/2021 4:33 PM, Derrick Stolee wrote:
> On 6/9/2021 4:11 AM, Elijah Newren wrote:
>> On Tue, Jun 8, 2021 at 11:32 PM Junio C Hamano <gitster@pobox.com> wrote:
>>>
>>> Elijah Newren <newren@gmail.com> writes:
>>>
>>> The tree-diff machinery takes two trees, walks them in parallel and
>>> repeatedly calls either diff_addremove() or diff_change(), which
>>> appends diff_filepair() to the diff_queue[] structure.  If you see
>>> an unexpanded tree on the index side, you should be able to pass
>>> that tree with the subtree you are comparing against to the tree-diff
>>> machinery to come up with a series of filepairs, and then tweak the
>>> pathnames of these filepairs (as such a two-tree comparison would be
>>> comparing two trees representing a single subdirectory of two different
>>> vintages) before adding them to the diff_queue[] you are collecting
>>> the index-vs-tree diff, for example.
>>
>> Good to know it seems my idea might be reasonable.
> 
> I agree that this is reasonable. I just didn't look hard enough
> to find existing code for this, since I found traverse_trees and
> thought that _was_ the library for this.

This was surprisingly simple, since most of the complicated stuff
is built into diff_tree_oid() and its use of revs->diffopt. The
new patch works as shown below the cut-line.

I was incredibly suspicious of how quickly this came together,
but it passes all the tests I have for it (including Scalar
functional tests with the commit, checkout, and add integrations).

I'll send a new version with this patch tomorrow, as well as the
other recommended edits.

Thanks,
-Stolee

--- >8 ---


diff --git a/diff-lib.c b/diff-lib.c
index c2ac9250fe9..b631df89343 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -316,6 +316,13 @@ static int get_stat_data(const struct index_state *istate,
 	return 0;
 }
 
+static void show_directory(struct rev_info *revs,
+			   const struct cache_entry *new_dir,
+			   int added)
+{
+	diff_tree_oid(NULL, &new_dir->oid, new_dir->name, &revs->diffopt);
+}
+
 static void show_new_file(struct rev_info *revs,
 			  const struct cache_entry *new_file,
 			  int cached, int match_missing)
@@ -325,6 +332,11 @@ static void show_new_file(struct rev_info *revs,
 	unsigned dirty_submodule = 0;
 	struct index_state *istate = revs->diffopt.repo->index;
 
+	if (new_file && S_ISSPARSEDIR(new_file->ce_mode)) {
+		show_directory(revs, new_file, /*added */ 1);
+		return;
+	}
+
 	/*
 	 * New file in the index: it might actually be different in
 	 * the working tree.
@@ -336,6 +348,15 @@ static void show_new_file(struct rev_info *revs,
 	diff_index_show_file(revs, "+", new_file, oid, !is_null_oid(oid), mode, dirty_submodule);
 }
 
+static void show_modified_sparse_directory(struct rev_info *revs,
+			 const struct cache_entry *old_entry,
+			 const struct cache_entry *new_entry,
+			 int report_missing,
+			 int cached, int match_missing)
+{
+	diff_tree_oid(&old_entry->oid, &new_entry->oid, new_entry->name, &revs->diffopt);
+}
+
 static int show_modified(struct rev_info *revs,
 			 const struct cache_entry *old_entry,
 			 const struct cache_entry *new_entry,
@@ -347,6 +368,17 @@ static int show_modified(struct rev_info *revs,
 	unsigned dirty_submodule = 0;
 	struct index_state *istate = revs->diffopt.repo->index;
 
+	/*
+	 * If both are sparse directory entries, then expand the
+	 * modifications to the file level.
+	 */
+	if (old_entry && new_entry &&
+	    S_ISSPARSEDIR(old_entry->ce_mode) &&
+	    S_ISSPARSEDIR(new_entry->ce_mode)) {
+		show_modified_sparse_directory(revs, old_entry, new_entry, report_missing, cached, match_missing);
+		return 0;
+	}
+
 	if (get_stat_data(istate, new_entry, &oid, &mode, cached, match_missing,
 			  &dirty_submodule, &revs->diffopt) < 0) {
 		if (report_missing)
