From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 7/7] sequencer: Remove sequencer state after final commit
Date: Thu, 18 Aug 2011 15:05:20 -0500
Message-ID: <20110818200520.GI30436@elie.gateway.2wire.net>
References: <1313310789-10216-1-git-send-email-artagnon@gmail.com>
 <1313310789-10216-8-git-send-email-artagnon@gmail.com>
 <20110814160440.GK18466@elie.gateway.2wire.net>
 <7vei0nn1cn.fsf@alter.siamese.dyndns.org>
 <20110814213200.GA6555@elie.gateway.2wire.net>
 <7vippzlj7a.fsf@alter.siamese.dyndns.org>
 <7v7h6eld2c.fsf@alter.siamese.dyndns.org>
 <CALkWK0noHBnW-7zZLw=jJdDVFxXmsm2vHHYnUJc9miLLuDRnAg@mail.gmail.com>
 <20110818191812.GG30436@elie.gateway.2wire.net>
 <CALkWK0=jRAq6s1zQ5gwB4feBgC1eo=VYLWx8bsjs+exqmz0f1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 18 22:05:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qu8qd-0008Dx-Sx
	for gcvg-git-2@lo.gmane.org; Thu, 18 Aug 2011 22:05:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751919Ab1HRUFZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Aug 2011 16:05:25 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:38744 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751592Ab1HRUFY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Aug 2011 16:05:24 -0400
Received: by yxj19 with SMTP id 19so1754599yxj.19
        for <git@vger.kernel.org>; Thu, 18 Aug 2011 13:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=r1lhv63k1OzORM4C0SDynAKf7tAz15sZrs6mAvDlkkE=;
        b=Qan5vTvCa1Vsyo37V5FfhPABOTuvmsLRMN/x5qCGT7N3fRCzIaoL2pVxamZnwUBNG1
         LWUAm/wTSOMKRycr3gUGIpBzvjAkPeYtMg6aKDq74WKWCxyqwbE95GR78LKgn9PphCMC
         UW5snWDnY5nOjln7pL2qcoNX+6eBXwiizicr4=
Received: by 10.236.173.131 with SMTP id v3mr704365yhl.112.1313697923705;
        Thu, 18 Aug 2011 13:05:23 -0700 (PDT)
Received: from elie.gateway.2wire.net (adsl-69-209-48-207.dsl.chcgil.ameritech.net [69.209.48.207])
        by mx.google.com with ESMTPS id o2sm1500713yhl.1.2011.08.18.13.05.21
        (version=SSLv3 cipher=OTHER);
        Thu, 18 Aug 2011 13:05:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALkWK0=jRAq6s1zQ5gwB4feBgC1eo=VYLWx8bsjs+exqmz0f1A@mail.gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179622>

Ramkumar Ramachandra wrote:

> In the future, we might want a 'merge' instruction in the sequencer -=
-
> I want to make it clear that we're going for a significant UI change
> so that everyone (including tests, scripts) become comfortable with
> the new UI.

I don't follow.  I meant "Why modify tests, rather than adding new
ones?"  Tests document what is supposed to continue working.

[...]
> Okay, here's my problem with the idea: it'll essentially require the
> sequencer to differentiate between one-commit operations and
> many-commit operations.  In the case of one-commit operations, *every=
*
> new command that calls into the sequencer will will need to persist
> information in its own way using hacks like CHERRY_PICK_HEAD and
> MERGE_HEAD.

Why wouldn't such a backward-compatibility feature apply to
cherry-pick/revert only?

> I'm not talking about some hypothetical case: I'm already planning
> to make 'git am' call into the sequencer, so we'll need an AM_HEAD.

Yuck.  How does the UI distinguish between

	git sequencer --continue; # apply the rest of the patches from mbox

and

	git sequencer --continue; # finish up "am" insn and continue

?  Does the sequencer need an argument to indicate the level of
nesting?  I would find it more straightforward for "git am mbox" to
create a todo list saying something like

	apply patch 1 from mbox
	apply patch 2 from mbox
	apply patch 3 from mbox
	apply patch 4 from mbox

so there would still be only one pending sequence of basic
instructions to think about.

> One final resort: Move some code back into cherry-pick, and call into
> a later-function in the sequencer only if it's a many-commit
> operation.  The new commands can enjoy the comfort of calling into an
> earlier-function in the sequencer that'll do all the revision walk
> setup and call the later-function.  I think this is reasonable.

I'm having trouble parsing this; sorry.  What is the effect on the
user-visible behavior of the program of what you propose?

> Jonathan Nieder writes:

>> One part I'm handwaving is what to do about commands like "git
>> cherry-pick foo^..foo" which use a commit range that only happens to
>> contain one commit. =C2=A0Either behavior seems fine for such comman=
ds.
>
> I don't think I follow.  This will be determined as a single-commit
> operation after setting up the revisions.  I don't think it should be
> treated as a multi-commit operation because the literal tree'ish
> contains "..".

I said "Either behavior seems fine", didn't I?

Hope that clarifies a little.
Jonathan
