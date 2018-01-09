Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 339371FADF
	for <e@80x24.org>; Tue,  9 Jan 2018 02:30:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754123AbeAICay (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jan 2018 21:30:54 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:51883 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751770AbeAICax (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 8 Jan 2018 21:30:53 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 884A320BF7;
        Mon,  8 Jan 2018 21:30:52 -0500 (EST)
Received: from web6 ([10.202.2.216])
  by compute3.internal (MEProxy); Mon, 08 Jan 2018 21:30:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=1GNvl4
        mMnwbbHrHCjJK1yi+gz042lRCD1xRJrgBh1pA=; b=g1BFaqYwHzjobe4iWDLeaH
        O+T0gRKkxf9/1kgPCyQ/iPC+JCpa9JRK/wteqLrwQUlAP5btKJ8UKQRcKCiYrWwF
        QwnYBhPj4inalDpXPzbFa+5gNXoSe43wgq4esn5YB3qVMY84zz1nswkvIaJzaPwf
        SyXNFbYMd5RypeRGemSfBCB4FMH0RI5kMVQEIpmk7cbG2sX0VCn6Rtc0N9CHvhit
        NL7egTttJj0DqxT/S99oQliX6dLBIN7EfRTuHkhzSYJHxOHZ5bqNVEm+pOUnA74F
        XYiQ4tJxOkOsP1i5cWKc3MY0y6yPS5HHqSpQQS4dPjwhE6+CfpTqcdf+Z2Lk7XJQ
        ==
X-ME-Sender: <xms:XClUWhFW5W79Ux-LZytw_bfaK_09zgmDs4o8f_QJauKsirjp-187jg>
Received: by mailuser.nyi.internal (Postfix, from userid 99)
        id F41784252; Mon,  8 Jan 2018 21:30:51 -0500 (EST)
Message-Id: <1515465051.2895186.1228754952.0036D645@webmail.messagingengine.com>
From:   Colin Walters <walters@verbum.org>
To:     Stefan Beller <sbeller@google.com>,
        Santiago Torres <santiago@nyu.edu>
Cc:     git <git@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Mailer: MessagingEngine.com Webmail Interface - ajax-6368b27c
Date:   Mon, 08 Jan 2018 21:30:51 -0500
Subject: Re: upstreaming https://github.com/cgwalters/git-evtag ?
References: <1515442320.3241451.1228399576.66D7DA96@webmail.messagingengine.com>
 <20180108204029.m42qyezojak4kohh@LykOS.localdomain>
 <CAGZ79kZ8AXezcX1_5WJsUJMHiHCzj2B=Uj8+4K3VF+cC6mTCqA@mail.gmail.com>
In-Reply-To: <CAGZ79kZ8AXezcX1_5WJsUJMHiHCzj2B=Uj8+4K3VF+cC6mTCqA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On Mon, Jan 8, 2018, at 3:49 PM, Stefan Beller wrote:
> On Mon, Jan 8, 2018 at 12:40 PM, Santiago Torres <santiago@nyu.edu> wrote:
> > Hi,
> >
> > I personally like the idea of git-evtags, but I feel that they could be
> > made so that push certificates (and being hash-algorithm agnostic)
> > should provide the same functionality with less code.
> >
> > To me, a git evtag is basically a signed tag + a data structure similar
> > to a push certificate embedded in it. I wonder if, with the current
> > tooling in git, this could be done as a custom command...
> 
> In that case, why not migrate Git to a new hash function instead
> of adding a very niche fixup?

Every day, for many years I find it maddening and really ridiculous
that the Fedora package build process insists I provide it a tarball
instead of being able to just fetch a signed git tag.

Now while I haven't fought the battle to teach Fedora to actually use
this, I think I have a pretty strong argument that git-evtag very clearly
fulfills the same role that a signed tarball does.

In particular, how a single checksum covers the entire source - no
hash tree involved.  The way that the evtag is "horizontal" across
the source while the git tree is "vertical" around history means
they're complementary.
 
> See Documentation/technical/hash-function-transition.txt
> for how to do it.

evtag took me a day or two to write initially and doesn't
impose any requirements on users except a small additional
bit of software.

In contrast, working on hash-function-transition.txt?  That
seems like it'd easily consume many person-months of work.
And that plan only exists post-shatter.io, whereas git-evtag
long predates both.

> Personally I'd dislike to include ev-tags as it might send a signal
> of "papering over sha1 issues instead of fixing it".

I don't agree.  I think it's pretty clear that a hash function transition
would be a huge amount of work - not least because of course
there are now at least two widely used implementations of git in C,
plus https://www.eclipse.org/jgit/ plus...

> push certificates are somewhat underdocumented, see the

Why not call them "git signed pushes"?  Junio's post
even says "the signed push".

And I just looked at this a little bit more but I'm not sure I
see how this covers the same goal as evtags; it seems
more about stopping someone from MITM my push
to github.com, and not about ensuring integrity from
someone pulling from github.com (and not wanting
to fully trust github).
