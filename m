Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB80C433EF
	for <git@archiver.kernel.org>; Mon,  2 May 2022 14:06:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236739AbiEBOJk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 May 2022 10:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237107AbiEBOJP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 May 2022 10:09:15 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA9A11C0A
        for <git@vger.kernel.org>; Mon,  2 May 2022 07:05:37 -0700 (PDT)
Received: from host-84-13-159-41.opaltelecom.net ([84.13.159.41] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1nlWgB-00075X-BW;
        Mon, 02 May 2022 15:05:35 +0100
Message-ID: <324301af-4ad3-739c-25bb-1ddbe069eb3e@iee.email>
Date:   Mon, 2 May 2022 15:05:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: Bare repositories in the working tree are a security risk
Content-Language: en-GB
To:     Glen Choo <chooglen@google.com>, Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        justin@justinsteven.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        rsbecker@nexbridge.com
References: <kl6lsfqpygsj.fsf@chooglen-macbookpro.roam.corp.google.com>
 <kl6lwnfp7tbc.fsf@chooglen-macbookpro.roam.corp.google.com>
 <Ylobp7sntKeWTLDX@nand.local>
 <kl6ly1zno328.fsf@chooglen-macbookpro.roam.corp.google.com>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <kl6ly1zno328.fsf@chooglen-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 30/04/2022 00:57, Glen Choo wrote:
> If I were designing Git from scratch, I would probably block embedded bare repos
> from being committed altogether - if an embedded bare repo doesn't behave
> particularly differently from `.git` (which we pretty much agree we should not
> support), then this is just an inherently dangerous way to work.
>
> But yes, we have historically allowed embedded bare repos, and I don't think we
> should stop supporting them altogether. For instance, I don't see a good
> alternative for the test fixture use case:
>
> - Submodules aren't a good fit because they only allow you to include the
>   contents of a submodule's tree, whereas in a test fixture, you really do want
>   the gitdir internals to be source controlled so that you get nice predictable
>   results.
> - Users could store the repos in some other form e.g. CDN, tarball. It's fine
>   when running from a test script, but it's pretty awful to author/review any
>   changes.

Can I check that storing bundles (of other repos) within a repository is
considered reasonably safe?

I have been looking at how Git's documentation could carry with it small
exemplar repositories that cover the commit hierarchies shown in the
various man pages to allow users to see, explore and understand the man
page examples. I'd settled on bundles as a reasonable compromise, with
the exemplar repositories being generated via the test suite
(obviously). With the recent focus on security issues, I thought it
worth asking now.

> - Perhaps the users could munge the bare repo at commit time e.g. instead of
>   storing (refs/, objects/, HEAD), they could store (test_refs/, test_objects/,
>   test_HEAD), which would later get turned into the bare repo in the test
>   script. It's a little silly, but not unreasonable for a test script, I think.
--
Philip
