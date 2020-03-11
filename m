Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by archive.lwn.net (Postfix) with ESMTP id 8F8877D910
	for <lwn-git@archive.lwn.net>; Wed, 11 Mar 2020 16:28:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729962AbgCKQ22 (ORCPT <rfc822;lwn-git@archive.lwn.net>);
        Wed, 11 Mar 2020 12:28:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:36408 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729511AbgCKQ22 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Mar 2020 12:28:28 -0400
Received: (qmail 2139 invoked by uid 109); 11 Mar 2020 16:28:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 11 Mar 2020 16:28:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20335 invoked by uid 111); 11 Mar 2020 16:37:49 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 11 Mar 2020 12:37:49 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 11 Mar 2020 12:28:27 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren <newren@gmail.com>, git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.26.0-rc1
Message-ID: <20200311162827.GB27893@coredump.intra.peff.net>
References: <xmqqo8t4z29k.fsf@gitster-ct.c.googlers.com>
 <20200310174017.GA549010@coredump.intra.peff.net>
 <xmqqa74ohqqj.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa74ohqqj.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://archive.lwn.net:8080/git/20200311162827.GB27893@coredump.intra.peff.net/>
List-Archive: <http://archive.lwn.net:8080/git/>
List-Post: <mailto:git@vger.kernel.org>

On Tue, Mar 10, 2020 at 01:58:12PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > The first change is that we'll now open an editor when continuing a
> > conflicted rebase. You can see it by running this:
> > ...
> > We won't run the editor the "apply" backend, but do for "merge".  I'm
> > not sure how big a deal this is.
> 
> Back when "git am" was written, it was not considered a bug that the
> "git am --resolved" option did not offer the user a chance to update
> the log message to match the adjustment of the code the user made,
> but honestly, I'd have to say that it is a bug in "git am" in that
> over time it wasn't adjusted to the new world order where we
> encourage users to describe what they did when the automation
> hiccuped by opening an editor.  These days, even when automation
> worked well (e.g. a clean auto-merge with "git merge"), we open an
> editor.  The world has changed, and so should the expectations.

Thanks for writing this out. I had a general feeling that this wasn't a
bug per se, but I agree with your argument that the behavior we want to
end up with is the new one. It's unfortunate that it may cause some
minor troubles for people upgrading, but that may be acceptable. We had
a similar thing when "git merge" started opening an editor, I think.

> If it were that we used to let the users edit and the new behaviour
> is to auto-continue, it would be a quite drastic behaviour change
> that may annoy the users, but fortunately this is the other way
> around, so it may not be too bad.  Having said all that, I do not
> mind some workaround, e.g. "git rebase --continue --no-edit".
> 
> "GIT_EDITOR=: git rebase --continue" would be a usable workaround
> that does not require any code change, hopefully.

Yeah, GIT_EDITOR=: works for me, but I agree that having a "--no-edit"
option would be a little nicer.

-Peff
