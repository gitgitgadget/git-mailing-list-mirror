From: Chris Rorvick <chris@rorvick.com>
Subject: Re: [PATCH v6 0/8] push: update remote tags only with force
Date: Mon, 21 Jan 2013 22:59:22 -0600
Message-ID: <CAEUsAPYaK3PP67fc89-J3a83wzYcmu7HRyh7y1Kctg6d166LEQ@mail.gmail.com>
References: <1354239700-3325-1-git-send-email-chris@rorvick.com>
	<DBF53EC2-A669-4B77-B88E-BFCDF43C862E@quendi.de>
	<7vsj61xez2.fsf@alter.siamese.dyndns.org>
	<7vobgpxeel.fsf@alter.siamese.dyndns.org>
	<CAEUsAPb0Zg0x78e+12NqXA4PRBkOUO89KTgxtwxujS1KOx9NYg@mail.gmail.com>
	<7vehhkuwg5.fsf@alter.siamese.dyndns.org>
	<CAEUsAPYAL6TD_nzu-YumRK_b-kFy7mNz1VivmSxGeuFYVxVL4g@mail.gmail.com>
	<20130118010638.GA29453@sigill.intra.peff.net>
	<CAEUsAPZr+bNNA-pqrQbBGvku4T3h58Ub66mK2zLeHqghEKw5Aw@mail.gmail.com>
	<20130121234002.GE17156@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, Max Horn <max@quendi.de>,
	git@vger.kernel.org, Angelo Borsotti <angelo.borsotti@gmail.com>,
	Drew Northup <n1xim.email@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Philip Oakley <philipoakley@iee.org>,
	Johannes Sixt <j6t@kdbg.org>,
	Kacper Kornet <draenog@pld-linux.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 22 05:59:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxVxd-0006SL-TG
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jan 2013 05:59:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752645Ab3AVE70 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2013 23:59:26 -0500
Received: from mail-lb0-f176.google.com ([209.85.217.176]:56957 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750915Ab3AVE7Y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2013 23:59:24 -0500
Received: by mail-lb0-f176.google.com with SMTP id s4so1771926lbc.21
        for <git@vger.kernel.org>; Mon, 21 Jan 2013 20:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=+l1S97i7qNK5F7sLxS7hDSC1pTE6UdX/5ClGlX/WR2o=;
        b=P2+g+iS2y3iVzS/fw0e5qHor8SegrWKcgHYCnoNnC1qNBBaNj8EG+q6sIE62ZWf7Po
         csLmxh1RiBysLE2C76gprdUx7RZR93ZKwHDDLgPv8bOL/J3LNmFIZWkqv0nkGNRkuTad
         OwobEvvA12lCyCbQjdAHMjz+Ro+4Apc0H0DTR3hsKqE86Qxb5+lJsJz7OT6oMUCMr5F9
         x3lR5gm9w8TkspJc8Bn3VuHGbgd8wrOZRzc0ICT/BjDA8kHURRrj2Yousnix/hU9q3am
         Z7vwbvNsUKGcfoYANOaqr71sRyrLrZkPJXRMDOIljRG6U3m0ftpLflShUqGxblAmfCyf
         G2Gg==
X-Received: by 10.152.145.37 with SMTP id sr5mr19939579lab.33.1358830762544;
 Mon, 21 Jan 2013 20:59:22 -0800 (PST)
Received: by 10.114.2.97 with HTTP; Mon, 21 Jan 2013 20:59:22 -0800 (PST)
In-Reply-To: <20130121234002.GE17156@sigill.intra.peff.net>
X-Google-Sender-Auth: IvPavNxWCH-LayUHQ4J3h9F9-SQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214193>

On Mon, Jan 21, 2013 at 5:40 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Jan 17, 2013 at 09:18:50PM -0600, Chris Rorvick wrote:
>
>> On Thu, Jan 17, 2013 at 7:06 PM, Jeff King <peff@peff.net> wrote:
>> > However, if instead of the rule being
>> > "blobs on the remote side cannot be replaced", if it becomes "the old
>> > value on the remote side must be referenced by what we replace it with",
>> > that _is_ something we can calculate reliably on the sending side.
>>
>> Interesting.  I would have thought knowing reachability implied having
>> the old object in the sending repository.
>
> No, because if you do not have it, then you know it is not reachable
> from your refs (or your repository is corrupted). If you do have it, it
> _might_ be reachable. For commits, checking is cheap (merge-base) and we
> already do it. For trees and blobs, it is much more expensive, as you
> have to walk the whole object graph.  While it might be "more correct"
> in some sense to say "it's OK to replace a tree with a commit that
> points to it", in practice I doubt anyone cares, so you can probably
> just punt on those ones and say "no, it's not a fast forward".

Thanks for explaining this further.  I'm not exactly sure what I was
thinking when I wrote the above other than I didn't fully grasp you
point and responded in a confused state.  Clear on all fronts now.

>> > And
>> > that is logically an extension of the fast-forward rule, which is why I
>> > suggested placing it with ref_newer (but the latter should probably be
>> > extended to not suggest merging if we _know_ it is a non-commit object).
>>
>> Sounds great, especially if it is not dependent on the sender actually
>> having the old object.  Until this is implemented, though, I don't
>> understand what was wrong with doing the checks in the
>> is_forwardable() helper function (of course after fixing the
>> regression/bug.)
>
> I don't think it is wrong per se; I just think that the check would go
> more naturally where we are checking whether the object does indeed
> fast-forward. Because is_forwardable in some cases must say "I don't
> know; I don't have the object to check its type, so maybe it is
> forwardable, and maybe it is not". Whereas when we do the actual
> reachability check, we can say definitely "this is not reachable because
> I don't have it, or this is not reachable because it is a commit and I
> checked, or this might be reachable but I don't care to check because it
> has a funny type".
>
> I think looking at it as the latter makes it more obvious how to handle
> the "maybe" situation (e.g., the bug in is_forwardable was hard to see).
>
> Anyway, I do not care that much where it goes. To me, the important
> thing is the error message. I do think the error "already exists" is a
> reasonable one for refs/tags (we do not allow non-force pushes of
> existing tags), but not necessarily for other cases, like trying to push
> a blob over a blob. The problem there is not "already exists" but rather
> "a blob is not something that can fast-forward". Using the existing
> REJECT_NONFASTFORWARD is insufficient (because later code will recommend
> pull-then-push, which is wrong). So I'd be in favor of creating a new
> error status for it.

I agree with everything above.  I just don't understand why reverting
the "already exists" behavior for non-commit-ish objects was a
prerequisite to fixing this.  Despite the flaws (I am not referring to
the buggy behavior) you and Junio have pointed out, this still seems
like an improvement over the previous (and soon-to-be current)
behavior.  Saying the remote reference already exists is true, and it
implies that removing it might solve the problem which is also true.
Adding another error status will allow the error message to be made
clearer in both cases (i.e., I avoided the word "tag" specifically so
that it would apply to other cases, or so I thought.)

Chris
