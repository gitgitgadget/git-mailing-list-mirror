Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B68E9271C
	for <git@archiver.kernel.org>; Thu,  5 Oct 2023 17:31:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbjJERbv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Oct 2023 13:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbjJERbW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2023 13:31:22 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95EBB3A8D
        for <git@vger.kernel.org>; Thu,  5 Oct 2023 10:07:05 -0700 (PDT)
Received: (qmail 23738 invoked by uid 109); 5 Oct 2023 17:07:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 05 Oct 2023 17:07:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25548 invoked by uid 111); 5 Oct 2023 17:07:05 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 05 Oct 2023 13:07:05 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 5 Oct 2023 13:07:03 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v2 1/2] attr: add attr.tree for setting the treeish to
 read attributes from
Message-ID: <20231005170703.GA975921@coredump.intra.peff.net>
References: <pull.1577.git.git.1695218431033.gitgitgadget@gmail.com>
 <pull.1577.v2.git.git.1696443502.gitgitgadget@gmail.com>
 <446bce03a96836f35f94e9ef8548cf4a2b041ba8.1696443502.git.gitgitgadget@gmail.com>
 <xmqqfs2qp3bg.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqfs2qp3bg.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 04, 2023 at 12:58:43PM -0700, Junio C Hamano wrote:

> "John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
> > From: John Cai <johncai86@gmail.com>
> >
> > 44451a2e5e (attr: teach "--attr-source=<tree>" global option to "git",
> > 2023-05-06) provided the ability to pass in a treeish as the attr
> > source. In the context of serving Git repositories as bare repos like we
> > do at GitLab however, it would be easier to point --attr-source to HEAD
> > for all commands by setting it once.
> >
> > Add a new config attr.tree that allows this.
> 
> Hmph, I wonder if we want to go all the way to emulate how the
> mailmap.blob was done, including
> 
>  - Default the value of attr.tree to HEAD in a bare repository;
> 
>  - Notice but ignore errors if the attr.tree does not point at a
>    tree object, and pretend as if attr.tree specified an empty tree;
> 
> which does not seem to be in this patch.  With such a change,
> probably we do not even need [2/2] of the series, perhaps?

Oh good, this was exactly what I was going to write in a review, so now
I don't have to. :)

Even though it creates behavior differences between attr.tree and
--attr-source, I think that is justifiable. Config options apply across
a wider set of contexts, so loosening the error handling may make sense
where it would not for a command-line option. But we should document
both that, and also how the two interact (I assume "git --attr-source"
would override attr.tree completely).

-Peff
