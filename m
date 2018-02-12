Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 210F21F404
	for <e@80x24.org>; Mon, 12 Feb 2018 21:36:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932368AbeBLVgZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Feb 2018 16:36:25 -0500
Received: from osg.samsung.com ([64.30.133.232]:57089 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932204AbeBLVgY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Feb 2018 16:36:24 -0500
Received: from localhost (localhost [127.0.0.1])
        by osg.samsung.com (Postfix) with ESMTP id ABB1328533;
        Mon, 12 Feb 2018 13:36:23 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at dev.s-opensource.com
Received: from osg.samsung.com ([127.0.0.1])
        by localhost (localhost [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id DrIP-iQiRTR4; Mon, 12 Feb 2018 13:36:22 -0800 (PST)
Received: from vento.lan (unknown [177.159.244.41])
        by osg.samsung.com (Postfix) with ESMTPSA id 882662852B;
        Mon, 12 Feb 2018 13:36:20 -0800 (PST)
Date:   Mon, 12 Feb 2018 19:36:17 -0200
From:   Mauro Carvalho Chehab <mchehab@osg.samsung.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Junio C Hamano <gitster@pobox.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: linux-next: unnecessary merge in the v4l-dvb tree
Message-ID: <20180212193617.4993398a@vento.lan>
In-Reply-To: <CA+55aFwM0vy+pw-Xv=gA19ULMwAXNPhdO3qR5A3hkMrZKJFNSQ@mail.gmail.com>
References: <20180213080036.3bf3a908@canb.auug.org.au>
        <CA+55aFwM0vy+pw-Xv=gA19ULMwAXNPhdO3qR5A3hkMrZKJFNSQ@mail.gmail.com>
Organization: Samsung
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Em Mon, 12 Feb 2018 13:15:04 -0800
Linus Torvalds <torvalds@linux-foundation.org> escreveu:

> On Mon, Feb 12, 2018 at 1:00 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > Linus, this happens a bit after the merge window, so I am wondering
> > about the rational of not doing a fast forward merge when merging a
> > signed tag (I forget the reasoning).  
> 
> The reasoning is to avoid losing the signature from the tag (when
> merging a signed tag, the signature gets inserted into the merge
> commit itself - use "git log --show-signature" to see them).
> 
> So when I merge a signed tag, I do *not* want to fast-forward to the
> top commit, because then I'd lose the signature from the tag. Thus the
> "merging signed tags are non-fast-forward by default" reasoning.
> 
> But, yes, that reasoning is really only valid for proper merges of new
> features, not for back-merges.
> 
> The problem, of course, is that since git is distributed, git doesn't
> know who is "upstream" and who is "downstream", so there's no
> _technical_ difference between merging a development tree, and a
> development tree doing a back-merge of the upstream tree.
> 
> Maybe it was a mistake to make signed tag merges non-fast-forward,
> since they cause these kinds of issues with people who use "pull" to
> update their otherwise unmodified trees.
> 
> I can always teach myself to just use --no-ff, since I end up doing
> things like verifying at the signatures anyway.

Hmm... at least at git version 2.14.3, git documentation doesn't
mention that signed pull requests won't do fast forward. Instead,
it says that --ff is the default behavior:


       --ff
           When the merge resolves as a fast-forward, only update the branch pointer, without creating a merge commit. This is the
           default behavior.

Btw, even doing:

	$ git merge -ff v4.16-rc1

it will still produce a git commit for the merge.


-- 
Thanks,
Mauro
