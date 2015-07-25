From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] log: add log.firstparent option
Date: Sat, 25 Jul 2015 10:41:21 -0700
Message-ID: <xmqqh9osjfsu.fsf@gitster.dls.corp.google.com>
References: <20150723012343.GA21000@peff.net>
	<xmqqpp3io5km.fsf@gitster.dls.corp.google.com>
	<20150724072325.GC2111@peff.net>
	<xmqq8ua5oapm.fsf@gitster.dls.corp.google.com>
	<20150725020526.GA8948@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Josh Bleecher Snyder <josharian@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jul 25 19:42:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZJ3T8-0005P2-Ka
	for gcvg-git-2@plane.gmane.org; Sat, 25 Jul 2015 19:42:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964778AbbGYRlZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Jul 2015 13:41:25 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:34484 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964771AbbGYRlX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jul 2015 13:41:23 -0400
Received: by pacan13 with SMTP id an13so30101771pac.1
        for <git@vger.kernel.org>; Sat, 25 Jul 2015 10:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=FLoOgh916pNBD/6xzZchSt3euvyUt+yA3knpkWN8gGg=;
        b=hBDqRGUCLipAHndeAEHm486lclWLuhYhf3+9NSTr3bTfYVrifpCDv5HQMayPc1DCyT
         izAFsBhHiiOfwcN48SzdkuF5PvsbEOiMaLxozhDg7r2GFZXZI2hUp7Q4+k1yEfAOQRpJ
         RROV+CjdvSPkXFeo0yze//s7m4I+8NyGuyvoew/oy6juQ0p/usANazjFiQlvoFqcBmCM
         PvooGUIRcZgy0h3nrhQ4YjP2u/kGXH4dL21Uxpp9hDEBTnI/30b+XTQB7bUvUITNzKgV
         KSG4h6lGlD+UYUC4q7+/dPykheBUqqwgnuCYs9HllBC06nqozgjwDZdDGp422b1EmExx
         I3QQ==
X-Received: by 10.66.222.161 with SMTP id qn1mr46901252pac.66.1437846083172;
        Sat, 25 Jul 2015 10:41:23 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:f068:7766:ecc2:8f58])
        by smtp.gmail.com with ESMTPSA id bd5sm20928781pdb.41.2015.07.25.10.41.22
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 25 Jul 2015 10:41:22 -0700 (PDT)
In-Reply-To: <20150725020526.GA8948@peff.net> (Jeff King's message of "Fri, 24
	Jul 2015 19:05:27 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274614>

Jeff King <peff@peff.net> writes:

> On Fri, Jul 24, 2015 at 08:07:49AM -0700, Junio C Hamano wrote:
>
>> Yeah, you actually convinced me reasonably well that it would
>> happen.  I'd never use it myself.  If people want to shoot
>> themselves in the foot, be my guest ;-)
>> 
>> Perhaps we should drop this, and give a shorter synonym to the
>> option?
>
> I'm still on the fence to have the config kick in only for HEAD.

Hmm, I cannot tell offhand if the confusion factor is worth it (I
didn't say "I don't think it is worth it").  I'd imagine that one
common thing to want is to get an overview of what has happened
upstream since the topic one is currently working on forked from it,
i.e. "log --first-parent ..master", for an individual contributor,
and nother is to see what has happened since the last stable point,
i.e. "log --first-parent origin.." or "log --first-parent v1.0..",
for an integrator.  Neither is covered by the "fp when implied HEAD".

When I am playing an individual contributor, I often want to see my
progress with "log -9" or something, only because "log origin.." is
longer to type and I know my topic is not that long as nine commits.
I guess implied first-parent would not hurt that much in that case,
simply because I do not expect too many merges on a topic, but it
feels wrong to default to first-parent traversal there.

So...

> It feels somewhat magical, but at least the config option name makes it
> painfully clear exactly when it would kick in. I dunno. I am happy
> enough for myself to just run "--first-parent" when that is what I want
> to see. Giving it a shorter name would not help much, I think.

I admit I may be minority, but two common things I do everyday are
"log --first-parent v2.5.0-rc0.." and "log --first-parent master..pu";
I could certainly use a short-hand there.

I already have alias for it, so this is not to help me personally,
but "log -FO" to trigger first-parent one-line would make the alias
unnecessary.

> It is not
> the number of characters, but the fact that most people do not _know_
> that --first-parent exists in the first place, or that it would be
> useful in this case.

That is a separate "education" problem.  My suggestion was more
about "I know there is a way already, but it is cumbersome to type".

> I hoped with a config option it might become
> something projects could recommend to their users[1] if the project has a
> matching workflow. But maybe we could also rely on those same projects
> to educate their users.

They could educate their users to use "log -F" just like they could
tell them to say "config log.firstparent true", I would think.  The
risk of the latter is that those who blindly follow the config path
without understanding what is going on will not even realize that
the problem is that they told Git to only follow the first-parent
path, when they do want to see commits on the side branch, let alone
discovering how to countermand it from the command line one shot.

An instruction to use an extra option, on the other hand, makes it
clear that there is a non-default thing going on, which is more
discoverable: "perhaps I can run it without -F?"
