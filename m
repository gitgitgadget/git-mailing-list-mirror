Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8015020229
	for <e@80x24.org>; Wed,  9 Nov 2016 11:12:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933789AbcKILMR (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Nov 2016 06:12:17 -0500
Received: from chiark.greenend.org.uk ([212.13.197.229]:51709 "EHLO
        chiark.greenend.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932295AbcKILMN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2016 06:12:13 -0500
Received: by chiark.greenend.org.uk (Debian Exim 4.84_2 #1) with local
        (return-path ijackson@chiark.greenend.org.uk)
        id 1c4QTd-0007FX-US; Wed, 09 Nov 2016 10:51:34 +0000
From:   Ian Jackson <ijackson@chiark.greenend.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <22562.65461.845411.29907@chiark.greenend.org.uk>
Date:   Wed, 9 Nov 2016 10:51:33 +0000
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Jacob Keller <jacob.keller@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 5/6] config docs: Provide for config to specify tags not to abbreviate
In-Reply-To: <xmqqa8d9b3jh.fsf@gitster.mtv.corp.google.com>
References: <20161108005241.19888-1-ijackson@chiark.greenend.org.uk>
        <20161108005241.19888-6-ijackson@chiark.greenend.org.uk>
        <CA+P7+xoQFsN1tPvKCA6+aRMChFwpMs73D=2kwvVRcxALWK0mZQ@mail.gmail.com>
        <22561.44597.59852.574831@chiark.greenend.org.uk>
        <20161108215709.rvmsnz4fvhizbocl@sigill.intra.peff.net>
        <22562.32428.287354.214659@chiark.greenend.org.uk>
        <xmqqa8d9b3jh.fsf@gitster.mtv.corp.google.com>
X-Mailer: VM 8.2.0b under 24.4.1 (i586-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano writes ("Re: [PATCH 5/6] config docs: Provide for config to specify tags not to abbreviate"):
> And I do not think we would want "log" or any core side Porcelain
> command to have too many "information losing" options like this
> "truncate refnames down to a point where it is no longer unique and
> meaningful".  GUI tools can get away with doing sos because they can
> arrange these truncated labels to react to end-user input (e.g. the
> truncated Tag in the history display of gitk could be made to react
> to mouse-over and pop-up to show a full name, for example), but the
> output from the core side is pretty much fixed once it is emitted.
> 
> So my first preference would be to teach gitk such a "please
> clarify" UI-reaction, if it does not know how to do so yet.  There
> is no need for a configuration variable anywhere with this approach.

gitk already has a way for the user to find out what the elided tag
names are.  The underlying difficulty is that the situation that the
gitk behaviour is designed for (long tag names, perhaps several to a
commit, not particularly interesting), is not applicable to these
particular tags.

Whether the tag is `particularly interesting' depends, as I say, on
both what tree it is in, and on its name.  It might be appropriate for
terminal-based tools to highlight these tags too, or show them when
tags are not normally displayed.

`core.interestingTags' ?

> If you do want to add a configuration to show fuller name in the
> tag, which would make it unnecessary for the user to do "please
> clarify, as I am hovering over what I want to get details of"
> action, that may also be a good way to go.

I think in my use case, which I hope to become common within Debian,
this is going to be essential.

>  But I think the right
> place to do so would be Edit -> Preferences menu in Gitk, and the
> settings will be stored in ~/.gitk or ~/.config/git/gitk or whatever
> gitk-specific place.

This is not correct, because as I have explained, this should be a
per-tree configuration:

If it can't be a `git config' option, even `git config gui.something',
then I guess I will have to teach gitk to read a config file in
GIT_DIR too.  But I think that is silly given that git already has a
config file reading system which handles per-tree configs.

If we can't get agreement from the git-core developers on a config to
be used, and documented, for any tool which has similar behaviour, I
think the right answer is `git config gitk.<something>', which would
be documented in gitk.

Thanks,
Ian.

-- 
Ian Jackson <ijackson@chiark.greenend.org.uk>   These opinions are my own.

If I emailed you from an address @fyvzl.net or @evade.org.uk, that is
a private address which bypasses my fierce spamfilter.
