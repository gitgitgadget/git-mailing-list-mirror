From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 2/2] format-patch: introduce format.defaultTo
Date: Tue, 7 Jan 2014 03:40:56 +0530
Message-ID: <CALkWK0k21W4gz9Rm8CyLMwjXq2A9wvm=XCVDsqs06oeW3VUg6w@mail.gmail.com>
References: <1389028732-27760-1-git-send-email-artagnon@gmail.com>
 <1389028732-27760-3-git-send-email-artagnon@gmail.com> <xmqqlhythrzq.fsf@gitster.dls.corp.google.com>
 <CALkWK0kZn44x98td9YXNT5VfhVs=ueeSty9M7Vh08bdoGjGQYg@mail.gmail.com>
 <xmqqa9f8j2n8.fsf@gitster.dls.corp.google.com> <20140106201854.GA28162@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jan 06 23:11:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0IOc-0001Er-Tq
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jan 2014 23:11:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756366AbaAFWLi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jan 2014 17:11:38 -0500
Received: from mail-ig0-f179.google.com ([209.85.213.179]:65184 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754752AbaAFWLh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jan 2014 17:11:37 -0500
Received: by mail-ig0-f179.google.com with SMTP id hk11so8471269igb.0
        for <git@vger.kernel.org>; Mon, 06 Jan 2014 14:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=kQGM1K1ZPhrEu6/nLfV+j/71dXaAwC6zXgVdm+pUNRM=;
        b=F5v7oBbQSaY7Ncu4SpBwIZX+nfBf/9cd+X9gMAqsL4Rfr3Kb2Y+ReBqSPSxNnNLq9N
         u9qs2cocEaKROdrbxUrsAMKo6jdLvRg5/alaTWIsIa/EPqXwcxVIoPrn+RB0zGu2Q8bw
         GTkVRMm9+dFjrhdSCABRi6wG0errOok9audU024MnB5eiagX4CyTWJ+gSDchlvI34VDb
         7SJ0VDiZCoUVnp5OHMPuZon5rIRSoo4ZGgOTXSz4RAaR8y5W9CY60EHwpEr8iDYxVMYa
         CW57TVr20DtJCCaL4lLFK1evitU8YsrHIzxTrB5jH3DiclBb4g1NPUd3xc9sOgmeA5iN
         L2Tg==
X-Received: by 10.50.128.137 with SMTP id no9mr22447869igb.36.1389046296984;
 Mon, 06 Jan 2014 14:11:36 -0800 (PST)
Received: by 10.64.195.9 with HTTP; Mon, 6 Jan 2014 14:10:56 -0800 (PST)
In-Reply-To: <20140106201854.GA28162@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240073>

Jeff King wrote:
> Yeah, I had similar thoughts. I personally use "branch.*.merge" as
> "forkedFrom", and it seems like we are going that way anyway with things
> like "git rebase" and "git merge" defaulting to upstream.

My issue with that is that I no idea where my branch is with respect
to my forked upstream; I find that extremely useful when doing
re-spins.

> But then there
> is "git push -u" and "push.default = upstream", which treats the
> upstream config as something else entirely.

push.default = upstream is a bit of a disaster, in my opinion. I've
advocated push.default = current on multiple occasions, and wrote the
initial remote.pushDefault series with that configuration in mind.

> I wonder if it is too late to try to clarify this dual usage. It kind of
> seems like the push config is "this is the place I publish to". Which,
> in many workflows, just so happens to be the exact same as the place you
> forked from. Could we introduce a new branch.*.pushupstream variable
> that falls back to branch.*.merge? Or is that just throwing more fuel on
> the fire (more sand in the pit in my analogy, I guess).

We already have a branch.*.pushremote, and I don't see the value of
branch.*.pushbranch (what you're referring to as pushupstream, I
assume) except for Gerrit users. Frankly, I don't use full triangular
workflows myself mainly because my prompt is compromised: when I have
a branch.*.remote different from branch.*.pushremote, I'd like to see
where my branch is with respect to @{u} and @{publish} (not yet
invented); that's probably too much information to digest anyway, so I
use central workflow (pointing to my fork) for each of my branches,
except master (which points to Junio's repo).

> I admit I haven't thought it through yet, though. And even if it does
> work, it may throw a slight monkey wrench in the proposed push.default
> transition.

We're transitioning to push.default = simple which is even simpler than current.
