Return-Path: <SRS0=p0jH=64=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 467ECC433DF
	for <git@archiver.kernel.org>; Thu, 14 May 2020 21:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D7EE20727
	for <git@archiver.kernel.org>; Thu, 14 May 2020 21:05:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728227AbgENVFI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 May 2020 17:05:08 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:33446 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727122AbgENVFI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 May 2020 17:05:08 -0400
Received: from callcc.thunk.org (pool-100-0-195-244.bstnma.fios.verizon.net [100.0.195.244])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 04EL516Q014418
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 May 2020 17:05:03 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id BE479420304; Thu, 14 May 2020 17:05:01 -0400 (EDT)
Date:   Thu, 14 May 2020 17:05:01 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Caleb Gray <hey@calebgray.com>, git@vger.kernel.org
Subject: Re: Add a "Flattened Cache" to `git --clone`?
Message-ID: <20200514210501.GY1596452@mit.edu>
References: <CAGjfG9a-MSg7v6+wynR1gL0zoe+Kv8HZfR8oxe+a3r59cGhEeg@mail.gmail.com>
 <20200514203326.2aqxolq5u75jx64q@chatter.i7.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200514203326.2aqxolq5u75jx64q@chatter.i7.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 14, 2020 at 04:33:26PM -0400, Konstantin Ryabitsev wrote:
> > Assuming my idea doesn't contradict other best practices or standards
> > already in place,  I'd like to transform the typical `git clone` flow
> > from:
> > 
> >  Cloning into 'linux'...
> >  remote: Enumerating objects: 4154, done.
> >  remote: Counting objects: 100% (4154/4154), done.
> >  remote: Compressing objects: 100% (2535/2535), done.
> >  remote: Total 7344127 (delta 2564), reused 2167 (delta 1612),
> > pack-reused 7339973
> >  Receiving objects: 100% (7344127/7344127), 1.22 GiB | 8.51 MiB/s, done.
> >  Resolving deltas: 100% (6180880/6180880), done.
> > 
> > To subsequent clones (until cache invalidated) using the "flattened
> > cache" version (presumably built while fulfilling the first clone
> > request above):
> > 
> >  Cloning into 'linux'...
> >  Receiving cache: 100% (7344127/7344127), 1.22 GiB | 8.51 MiB/s, done.
> 
> I don't think it's a common workflow for someone to repeatedly clone 
> linux.git. Automated processes like CI would be doing it, but they tend 
> to blow away the local disk between jobs, so they are unlikely to 
> benefit from any native git local cache for something like this (in 
> fact, we recommend that people use clone.bundle files for their CI 
> needs, as described here: 
> https://www.kernel.org/best-way-to-do-linux-clones-for-your-ci.html).

If the goal is a git local cache, we have this today.  I'm not sure
this is what Caleb was asking for, though:

git clone --bare https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git base
git clone --reference base https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git ext4

							- Ted
