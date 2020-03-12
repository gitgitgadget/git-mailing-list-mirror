Return-Path: <SRS0=YYoh=45=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B674AC10DCE
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 04:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9439D206F7
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 04:11:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=jramsay.com.au header.i=@jramsay.com.au header.b="qwP3/0wX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GLW5qgfA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731644AbgCLELk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Mar 2020 00:11:40 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:60519 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726023AbgCLELk (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 12 Mar 2020 00:11:40 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 4B75F220CA
        for <git@vger.kernel.org>; Thu, 12 Mar 2020 00:11:39 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Thu, 12 Mar 2020 00:11:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jramsay.com.au;
         h=from:to:subject:date:message-id:in-reply-to:references
        :mime-version:content-type:content-transfer-encoding; s=mesmtp;
         bh=atETnhpz6BGlKskEM5mfp0yr2fBBQ6O9u7w8DkrQyIk=; b=qwP3/0wXxIrN
        eZdPI3ZDDLzV6mTx+je1t1n08SixPD0pDRDFIjCyBHpdHngS7Wv2QPV5mhDOXReW
        6euOGj8+UoHtFw6uRE9JfNVeauvv6g9yKQeTaOe0hLmnCkPdw1IuG60NNQ48LHDC
        Ah7JUOxoJYysFi6BgVXi6X63Y3MRFM0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=atETnhpz6BGlKskEM5mfp0yr2fBBQ6O9u7w8DkrQy
        Ik=; b=GLW5qgfA0jpH43rmS+tm7e10Y66/SECjgrEprYfD3G1bnlgTbLi4d0tLQ
        owvjgcNkyJZv7Nq+8t5kO8NhILayfgaHm/r353IaGbLB1j265ppD6TezLWwh8rgV
        8hKezDX93DuJx3yI+SNTOS3IOx5tUHCpOlukbhYLicao0Y6fWsLZoyfFOYjHUGa6
        MqQ9WgBFn/6S1/6iG1HP4of3wFb9lSb3rNcQr1ACTjpVOaQuPBSjT107anpM6hL3
        E0SZpwGCoaKiS0VAjSD5kHTOfcw/TTVYSYoNyfnrFk0po2wgkY9uvtb7HCcOJxa7
        KVTv2zvOL/FT0ehu9miWBQvim6IyA==
X-ME-Sender: <xms:e7ZpXncCqCnPmF5FwzBd6n5Y_ed6jv3IuIvIo3GpW6VQ9HocbpX6ew>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedruddvgedgjeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffokfgjfhggtgfgsehtke
    hmtdertdejnecuhfhrohhmpedflfgrmhgvshcutfgrmhhsrgihfdcuoehjrghmvghssehj
    rhgrmhhsrgihrdgtohhmrdgruheqnecukfhppeduvddurddvtddtrdeirdduuddtnecuve
    hluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrghilhhfrhhomhepjhgrmhgvshes
    jhhrrghmshgrhidrtghomhdrrghu
X-ME-Proxy: <xmx:e7ZpXixWJ9pUbt04yUW-mvdz-AO_SF-0EDH43IV1_u_TAhK5km446g>
    <xmx:e7ZpXqHADOdYI6qUnLg1BSN9rDWxjM7QpnuUXxy0-x8XZgA3qStbXg>
    <xmx:e7ZpXp3ocOetWGP-toyHl9c5H17kRzmZuw6Kv-TtAFa7b5KXAY2Lug>
    <xmx:e7ZpXh9PQK7QxxIsa5fNNlBsrOwYO1T5nWzahyi_V1gAdHcL7nLDUQ>
Received: from [192.168.1.38] (121-200-6-110.79c806.syd.nbn.aussiebb.net [121.200.6.110])
        by mail.messagingengine.com (Postfix) with ESMTPA id 463EE328005E
        for <git@vger.kernel.org>; Thu, 12 Mar 2020 00:11:38 -0400 (EDT)
From:   "James Ramsay" <james@jramsay.com.au>
To:     git@vger.kernel.org
Subject: [TOPIC 14/17] Aspects of merge-ort: cool, or crimes against humanity?
Date:   Thu, 12 Mar 2020 15:11:35 +1100
X-Mailer: MailMate (1.13.1r5671)
Message-ID: <84A85206-F4A7-4F36-A302-C3986D6AFF91@jramsay.com.au>
In-Reply-To: <AC2EB721-2979-43FD-922D-C5076A57F24B@jramsay.com.au>
References: <AC2EB721-2979-43FD-922D-C5076A57F24B@jramsay.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

1. Elijah: ORT stands for Ostensibly Recursive’s Twin. As a merge 
strategy, just like you can call ‘git merge -s recursive’ you can 
call ‘git merge -s ort’.  Git’s option parsing doesn’t require 
the space after the ‘-s’.

2. Major question is about performance & possible layering violations. 
Merge recursive calls unpacks trees to walks trees, then needs to get 
all file and directory names and so walks the trees on the right again, 
and then the trees on the left again. Then diff needs to walk sets of 
trees twice, and then insert_stage_data() does a bunch more narrow tree 
walks for rename detection. Lots of tree walking. Replaced that with two 
tree walks.

3. Using traverse_trees() instead of unpack_trees(), and avoid the index 
entirely (not even touching or creating cache_entry’s), and building 
up information as I need. I’m not calling diffcore_std(), but instead 
directly calling diffcore_rename(). Is this horrifying? Or is it 
justified by the performance gains?

4. Peff: both, some of it sounds like an improvement, but maybe there 
were hidden benefits previously.

5. Elijah: I write to a tree before I do anything.

6. Peff: I like that. Seems like a clean up to me. We have written 
libgit2-like code for merging server-side

7. Elijah: I’ve been adding tests for the past few years, more to add, 
feel good about it.

8. Jonathan N: If you are using a lower-layer thing, I would not say 
you’re not doing anything you shouldn’t. But if you docs say you 
should not to use diffcore_rename(), you can update the docs to say that 
it’s fine to use it.

9. Elijah: three places directly write tree objects. All have different 
data structures they are writing from. Should I pull them out? But then 
my data structure was also different, so I’d have a fourth.

10. Peff: not worried because trees are simple. Worried about policy 
logic. Can’t write a tree entry with a double slash. Want this to be 
enforced everywhere, but no idea how hard that would be to implement. 
Not about lines of code, but consistency of policy. Fearful that only 
one place does it.

11. Elijah: I know merge-ort checks this, but it’s not nearby, so it 
could change.

12. Peff: as bad as it is to round trip through the index, it may bypass 
quality checks, which you will need to manually implement.

13. Elijah: usability side, with the tree I’ve created, I could have 
.git/AUTOMERGE. I have an old tree, a new tree, and a checkout can get 
me there. Fixed a whole bunch of bugs for sparsity and submodules.

14. Elijah: If we use this to on-the-fly remerge as part of git-log in 
order to compare the merge commit to what the automatic merging would 
have done, where/how should we write objects as we go?

15. Jonathan N: can end up with proliferation of packs, would be nice to 
have similar to fast import and have in memory store. Dream not to have 
loose files written ever.

16. Peff: I like your dream. But fast import packs are bad. We assume 
that packs are good, and thus need to use GC aggressively. This 
increases pollution of that problem. I know about objects, but not 
written to disc, risk that you can write objects that are broken, but 
git doesn’t know because git thinks it has the object but it’s only 
in memory. Log is conceptually a read operation, but this would create 
the need for writes.

17. Elijah: you could write into a temporary directory. Worried about 
`gc --auto` in the middle of my operation. If I write to a temp pack I 
could potentially avoid it.

18. Elijah: large files. Rename detection might not work efficiently OR 
correctly for sufficiently large files (binary or not). Limited bucket 
size means that completely different files treated as renames when both 
are over 8MB. Should big files just not be compared?

19. Peff: maybe we should fix the hash…

20. Elijah: present situation is broken, maybe we can cheat in the short 
term, and avoid fixing?

21. Peff: seems more correct for now, but we’d need to document

22. Elijah: checkout --overwrite-ignore flag. Should merge have the same 
flag.

23. Jonathan N: gitignore original use case was build outputs which can 
be regenerate. But then some people want to ignore `.hg` which is much 
more precious.

24. Peff: we can plumb it through later to other commands

25. Brian: CI doesn’t really care. Moving between branches it would 
complain. For checkout and merge it makes sense to support just 
destroying.
