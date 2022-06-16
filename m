Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CB2DC43334
	for <git@archiver.kernel.org>; Thu, 16 Jun 2022 19:21:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378172AbiFPTVA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jun 2022 15:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378097AbiFPTUr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jun 2022 15:20:47 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F60856B26
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 12:20:09 -0700 (PDT)
Received: (qmail 15140 invoked by uid 109); 16 Jun 2022 19:20:09 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.0.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 16 Jun 2022 19:20:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Date:   Thu, 16 Jun 2022 15:20:08 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 11/11] bug_fl(): add missing `va_end()` call
Message-ID: <YquCaE+Vw9P/fybU@coredump.intra.peff.net>
References: <pull.1264.git.1655336146.gitgitgadget@gmail.com>
 <d674aefa78bdb6d255e40af2f308abf8a87a593a.1655336146.git.gitgitgadget@gmail.com>
 <Yqq3O5hykBecoVKQ@coredump.intra.peff.net>
 <xmqq8rpxw6ch.fsf@gitster.g>
 <220616.86o7yswyek.gmgdl@evledraar.gmail.com>
 <xmqqk09gtriq.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqk09gtriq.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 16, 2022 at 11:03:25AM -0700, Junio C Hamano wrote:

> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
> 
> > But obviously that's a bad use of the varargs API, I just don't know how
> > we've been getting away with it in practice, sorry about that.
> 
> Exactly.  We three all expressed our surprises on why it "works".
> Nobody offered an explanation, though, which leaves us in suspense
> ;-)

Being the curious sort, I ran it in a debugger. And indeed, "cp" is
filled with uninitialized garbage. The reason it works is that the test
calls bug() with a format string that does not contain any placeholders.
And thus our eventual call to vsnprintf() does not ever look at "cp" at
all!

> > The fix Peff's got here LGTM. I can (re)submit it with
> > format-patch+send-email after giving it a commit message describing the
> > issue if you'd like, but the change would be the same.
> 
> Yup, I think the code change there looks the most sensible.

I'll wrap it up with a commit message and modify the test to be more
thorough.

-Peff
