Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5294AC433B4
	for <git@archiver.kernel.org>; Mon, 10 May 2021 17:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 204B761042
	for <git@archiver.kernel.org>; Mon, 10 May 2021 17:36:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbhEJRiB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 May 2021 13:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbhEJRhz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 May 2021 13:37:55 -0400
Received: from adoakley.name (adoakley.name [IPv6:2a01:4f8:c17:1310::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F578C061343
        for <git@vger.kernel.org>; Mon, 10 May 2021 10:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=adoakley.name; s=2018; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=TCjcHyh1YRVMVCoKwOt4UQinTVGZFcN16DsUS5sB1TQ=; b=UVggHc40lyNHtrYtmcpuGxw6z0
        +1F7LcV9JLqvFMj5PseqBbIb3NDqHfj9YArBxYL6KTJL0PDJJepBSsjdO41Ks0iApb8yUHYLJN4Sv
        lloY+9Ufkv1T1qzeU9NI9Ebql7dQlXK9OsLhceHXlC/E0ClBhEhheajOAqa46TFIV7YU=;
Received: from [2001:8b0:14bb:e93b:e8df:b9:8698:86f8] (helo=ado-tr)
        by adoakley.name with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.93.0.4)
        (envelope-from <andrew@adoakley.name>)
        id 1lg9pf-0005C2-MN; Mon, 10 May 2021 17:36:39 +0000
Date:   Mon, 10 May 2021 18:36:38 +0100
From:   Andrew Oakley <andrew@adoakley.name>
To:     Evan McLain <git.commit@none-of-yer.biz>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Luke Diamand <luke@diamand.org>,
        Ben Keene <seraphire@gmail.com>
Subject: Re: [PATCH] git-p4: fix "git p4 sync" after ignored changelist
Message-ID: <20210510183638.156a6b1d@ado-tr>
In-Reply-To: <pull.941.git.1620490353758.gitgitgadget@gmail.com>
References: <pull.941.git.1620490353758.gitgitgadget@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 08 May 2021 16:12:33 +0000
"Evan McLain via GitGitGadget" <gitgitgadget@gmail.com> wrote:
>     Rename P4Sync.commit() to maybeCommit() and return True if the
> change is committed, or False if ignored. Clear P4Sync.initialParent
> only if maybeCommit() returns True.

I'm not sure I'd bother doing the rename - it makes the diff more noisy
than it needs to be.

>     There may be some other latent bugs here that I haven't fixed. In
>     particular, there seems to be a similar flow when detecting
> branches with del self.initialParents[branch]. I wasn't sure how to
> set up a repro case to expose that error, so I just fixed the bug I
> understood.

I don't think this issue can happen when using --detect-branches.  The
list of changed files get split up in splitFilesIntoBranches.  Only the
branches with modified files get processed, so the initialParents entry
does not get removed on branches with no files to commit.

This change looks good to me.
