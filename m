Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32ACA1FAF4
	for <e@80x24.org>; Wed,  8 Feb 2017 22:14:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751373AbdBHWOC (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Feb 2017 17:14:02 -0500
Received: from sub3.mail.dreamhost.com ([69.163.253.7]:54818 "EHLO
        homiemail-a12.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751011AbdBHWOB (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 8 Feb 2017 17:14:01 -0500
Received: from homiemail-a12.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a12.g.dreamhost.com (Postfix) with ESMTP id 71D26262065;
        Wed,  8 Feb 2017 14:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=novalis.org; h=message-id
        :subject:from:to:cc:date:in-reply-to:references:content-type
        :mime-version:content-transfer-encoding; s=novalis.org; bh=edHro
        8IypmJ0EG1oWm98hRcR1S0=; b=pLNlB+u6Iq3iNSSbppYtOqJMSz8YIGvHkuVHg
        TPMICioea9famg71HAMe7896Mouo1X1X3QrVowOnDfpHYeqOOlkaFHfZX6/3BqUq
        pyMf4Ct1PN56Hwjm9NFgyT33bgdUImtx+aZ1eFhS/A0l65x1IPSUOp3OtwJALR1j
        4LrYEQ=
Received: from [172.31.11.72] (gzac12-mdf2-1.aoa.twosigma.com [208.77.215.155])
        (using TLSv1 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: novalis@novalis.org)
        by homiemail-a12.g.dreamhost.com (Postfix) with ESMTPSA id E842A262062;
        Wed,  8 Feb 2017 14:13:59 -0800 (PST)
Message-ID: <1486592043.1938.82.camel@novalis.org>
Subject: Re: "disabling bitmap writing, as some objects are not being
 packed"?
From:   David Turner <novalis@novalis.org>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Date:   Wed, 08 Feb 2017 17:14:03 -0500
In-Reply-To: <20170208190858.rjoqehbhyizlwg5q@sigill.intra.peff.net>
References: <1481922331.28176.11.camel@frank>
         <xmqqpokrr2cf.fsf@gitster.mtv.corp.google.com>
         <CACsJy8ACy+Hv1Z3FgG-WFBozwWqmMuN-JnMWF-+rdpF0knFjqg@mail.gmail.com>
         <1486515795.1938.45.camel@novalis.org>
         <CACsJy8C81+D=UG4pZ4e+URQqKRCPG=5bLiCHbGCQamvE-2y2MQ@mail.gmail.com>
         <1486542299.1938.47.camel@novalis.org>
         <CACsJy8C4DO-GYREUhED3YU_WetoTZaB3MUq1kGfRjA3e-FOLYQ@mail.gmail.com>
         <xmqqtw84wpag.fsf@gitster.mtv.corp.google.com>
         <1486580742.1938.52.camel@novalis.org>
         <20170208190858.rjoqehbhyizlwg5q@sigill.intra.peff.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.12.9-1+b1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 2017-02-08 at 14:08 -0500, Jeff King wrote:
> On Wed, Feb 08, 2017 at 02:05:42PM -0500, David Turner wrote:
> 
> > On Wed, 2017-02-08 at 09:44 -0800, Junio C Hamano wrote:
> > > Duy Nguyen <pclouds@gmail.com> writes:
> > > 
> > > > On second thought, perhaps gc.autoDetach should default to false if
> > > > there's no tty, since its main point it to stop breaking interactive
> > > > usage. That would make the server side happy (no tty there).
> > > 
> > > Sounds like an idea, but wouldn't that keep the end-user coming over
> > > the network waiting after accepting a push until the GC completes, I
> > > wonder.  If an impatient user disconnects, would that end up killing
> > > an ongoing GC?  etc.
> > 
> > Regardless, it's impolite to keep the user waiting. So, I think we
> > should just not write the "too many unreachable loose objects" message
> > if auto-gc is on.  Does that sound OK?
> 
> I thought the point of that message was to prevent auto-gc from kicking
> in over and over again due to objects that won't actually get pruned.
> 
> I wonder if you'd want to either bump the auto-gc object limit, or
> possibly reduce the gc.pruneExpire limit to keep this situation from
> coming up in the first place (or at least mitigating the amount of time
> it's the case).

Auto-gc might not succeed in pruning objects, but it will at least
reduce the number of packs, which is super-important for performance.

I think the intent of automatic gc is to have a git repository be
relatively low-maintenance from a server-operator perspective.  (Side
note: it's fairly trivial for a user with push access to mess with the
check simply by pushing a bunch of objects whose shas start with 17).
It seems odd that git gets itself into a state where it refuses to do
any maintenance just because at some point some piece of the maintenance
didn't make progress.

Sure, I could change my configuration, but that doesn't help the other
folks (e.g. https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=813084 )
who run into this.

I have three thoughts on this:

Idea 1: when gc --auto would issue this message, instead it could create
a file named gc.too-much-garbage (instead of gc.log), with this message.
If that file exists, and it is less than one day (?) old, then we don't
attempt to do a full gc; instead we just run git repack -A -d.  (If it's
more than one day old, we just delete it and continue anyway).

Idea 2 : Like idea 1, but instead of repacking, just smash the existing
packs together into one big pack.  In other words, don't consider
dangling objects, or recompute deltas.  Twitter has a tool called "git
combine-pack" that does this:
https://github.com/dturner-tw/git/blob/dturner/journal/builtin/combine-pack.c

That's less space-efficient than a true repack, but it's no worse than
having the packs separate, and it's a win for read performance because
there's no need to do a linear search over N packs to find an object.

Idea 3: As I suggested last time, separate fatal and non-fatal errors.
If gc fails because of EIO or something, we probably don't want to touch
the disk anymore. But here, the worst consequence is that we waste some
processing power. And it's better to occasionally waste processing power
in a non-interactive setting than it is to do so when a user will be
blocked on it.  So non-fatal warnings should go to gc.log, and fatal
errors should go to gc.fatal.  gc.log won't block gc from running. I
think this is my preferred option.

