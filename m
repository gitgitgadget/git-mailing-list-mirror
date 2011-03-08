From: Will Palmer <wmpalmer@gmail.com>
Subject: Re: Fwd: [PATCH 2/2] pretty.c: allow date formats in user format
 strings
Date: Tue, 08 Mar 2011 08:29:45 +0000
Message-ID: <1299572985.4071.30.camel@walleee>
References: <20110305195020.GA3089@sigill.intra.peff.net>
	 <20110305200010.GB32095@sigill.intra.peff.net>
	 <AANLkTinH8zwX2sbd5bpk=x4R3zOAg3Dc92Fbspfdv03T@mail.gmail.com>
	 <AANLkTikaN=wsg6RLFaFxh=L3RCYjKkVGFR4VTrQ=KRZk@mail.gmail.com>
	 <20110307161758.GB11934@sigill.intra.peff.net>
	 <1299518898.3024.10.camel@wpalmer.simply-domain>
	 <1299523834.1835.17.camel@walleee>
	 <20110307192640.GB20930@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 08 09:29:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PwsIo-0000Dd-3J
	for gcvg-git-2@lo.gmane.org; Tue, 08 Mar 2011 09:29:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755906Ab1CHI3w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Mar 2011 03:29:52 -0500
Received: from mail-ww0-f42.google.com ([74.125.82.42]:37763 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754492Ab1CHI3v (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Mar 2011 03:29:51 -0500
Received: by wwi17 with SMTP id 17so617337wwi.1
        for <git@vger.kernel.org>; Tue, 08 Mar 2011 00:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:subject:from:to:cc:in-reply-to:references
         :content-type:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=J4QeZ14JbtkFJX1MpNcLazuTSsEubiJ+rp0oiJNPNDE=;
        b=td78qFfIkuEmVCH5qvmEDUt6KCMn01lVP7if4s2rA/QNEVUza9qyMBwhklItBE5ZC4
         TsHblPgJQacFbHVaqxvrpoff5c0KEdal7Ti4bF8WS5S6TD5i4bhQBHTOaVNFly8qWv5j
         0XFWBl3lp6Q4Zk6SCTBt3yeMwUVJvwgx2l7Sc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=v6A4gX7BpHRojifz8f7a75U/JHPjX/zwMk/PKA8XznJkL07ClOTn024et47AkIAgFT
         wUhE3mkbXTVhZzkt9jV2iaygKnz/sgT3k0ZjxA3ZkUjD38xnoNV+qcwaLTROUBUIjxFL
         xi3QaYxa1hCyhosYdgJs26OEjPJo6QS2Kly+k=
Received: by 10.216.171.133 with SMTP id r5mr3067272wel.91.1299572990430;
        Tue, 08 Mar 2011 00:29:50 -0800 (PST)
Received: from [192.168.0.2] (5acc3aad.bb.sky.com [90.204.58.173])
        by mx.google.com with ESMTPS id f52sm187600wes.35.2011.03.08.00.29.47
        (version=SSLv3 cipher=OTHER);
        Tue, 08 Mar 2011 00:29:48 -0800 (PST)
In-Reply-To: <20110307192640.GB20930@sigill.intra.peff.net>
X-Mailer: Evolution 2.28.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168640>

On Mon, 2011-03-07 at 14:26 -0500, Jeff King wrote:
> On Mon, Mar 07, 2011 at 06:50:34PM +0000, Will Palmer wrote:
> 
> > I'm home now, and apparently that should have been:
> > https://github.com/wpalmer/git/tree/pretty/parse-format
> > 
> > I assume the code is very hard to follow, as it was pretty much written
> > with the mindset of "get it done now, fix it later". Looking into it
> > again, I see that part of the reason I abandoned it was not being able
> > to determine a good way to split things into logical commits. It's
> > almost entirely an "everything works or nothing works" change.
> 
> I haven't looked at your code yet, but the breakdown of patches I would
> expect / hope for is something like:
> 
>   1. introduce infrastructure for creating parse-tree from strbuf_expand
>      format, with some tests
> 
>   2. port format_commit_* over to new system; I would expect that the
>      caller code will have to be part of both the parsing and the
>      expansion, since the generic code can't know that "%ad" is
>      meaningful (and we want to keep it for backwards compatibility).
>      Leave format_commit_message as a parse + expand wrapper for simple
>      callers who don't care about speed.
> 
>   3. Add generic "%(key:option)" support to the new infrastructure,
>      forward-porting format_commit_* as necessary (and hopefully the
>      change are minimal...).
> 
> So those are all big commits, obviously,

Yeah, looks about right. It's mostly the "those commits will still be
pretty big" that I was concerned with. There's also the question of:
as my end-goal is conditional formatting, should these "smaller, but
still big" commits try to make sense independently, or, for example,
should I lay out a basic structure in the earlier commits, filled-out
with a relatively simple loop, and only later expand that into the
recursive function / parse-tree structure; or, should I start with the
"fancy" structures, even before they have a justification?

 - the "simple first" way sounds tempting, but it has the result of
   pretty much "inventing" in-between code which is never intended to
   actually be used. (even if it is intended to compile and work just 
   fine)
 - the "write it as it will be", however, is going to result in commits
   which may not make any sense one after another, and really only make
   sense in the end. I don't know if that's okay.

Neither of these options sound fun for bisecting, and yet it's such a
big change (in terms of "everyone uses log, so every user is effected")
that ease of bisectability seems like a very important consideration.

What I don't want to do is start the patch over from scratch, with only
the "long formats"/"unification with for-each-ref" in mind, only to
submit another patch following up later on that needs to completely
change the structures again to fit with the "parse tree" idea. Given
that the basic %(opt-color?...) test works, I expect that the current
state of the tree-structure is at least fairly close to what it should
be, though I also expect that someone with more experience writing
parsers may want to slap me for the way that structure is built.
Criticism is anticipated and appreciated.

>
> ...................................... but hopefully it lets us review
> in three stages: does the new infrastructure look good, does porting an
> existing caller (and probably the most complex caller) clean up the
> caller code, and then finally, does the new syntax look good?
> 
> But of course the devil is in the details, so probably that breakdown
> has some flaw in it. :) I'll see when I look at your code how close to
> reality I came.
> 
> -Peff

Er, good luck :)
As a side-note: It turns out that rebasing to the current "next" was not
too difficult. The result hasn't been pushed yet (I need to do a little
be of forensic work to make sure a behaviour I'm seeing isn't a
rebase-induced regression), but it does imply that at least pretty.c
should still make a fair amount of sense, even though it's about a year
old. Most of the problems I expected of the rebase, it turns out would
have been in sections which I hadn't actually done yet.
