From: Brandon McCaig <bamccaig@gmail.com>
Subject: Re: GSoC idea: allow "git rebase --interactive" todo lines to take options
Date: Thu, 27 Feb 2014 13:10:30 -0500
Message-ID: <CANUGeEY2qE2LPq=-bhaKrKrv+uJUaPRqAeW_X1sFyZH-_PRVeA@mail.gmail.com>
References: <530DA00E.4090402@alum.mit.edu> <20140226105249.GE25711@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	git discussion list <git@vger.kernel.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 27 19:11:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJ5QT-0007Mm-7B
	for gcvg-git-2@plane.gmane.org; Thu, 27 Feb 2014 19:11:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751720AbaB0SKx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Feb 2014 13:10:53 -0500
Received: from mail-wi0-f180.google.com ([209.85.212.180]:33896 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751157AbaB0SKv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Feb 2014 13:10:51 -0500
Received: by mail-wi0-f180.google.com with SMTP id hm4so3846132wib.7
        for <git@vger.kernel.org>; Thu, 27 Feb 2014 10:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=hKnfi6tFsfwlIHYnc6Et0QPOgbDhoPQJouUJFLUsXm0=;
        b=gRACzzR7yIZvUc+PmcO0gaVaRmZb9yFOUq3gnk2Fz98O3m0PKAhWlhXWKBNAz7WXq1
         kaBm7/L4tjLp0DmIPHGShdHMjEAQGoC2kVK2ZM05pYimHWThUJ0Ivs7knLaKsUzaEhoo
         7weCSjjgPIjB85UPgcKCfN8hTj58tFrI4/T+FGD3gHGV+AF8uMYm2B796qvdfOKDKw0G
         Y5ypoVN8qJ7xjZ/EkrmHumS9H3zodXuX31ynnRBa/Y6LHk/wrjW8LzU7wo/K6x6E5OW+
         LvAyPSx7xkzrJWXCIyChw9lwF9YSVU9GrZ1rlvQYMHBSYrd3puzsGnJNFr6jvUtfk6I/
         QjHA==
X-Received: by 10.180.219.44 with SMTP id pl12mr14560198wic.12.1393524650658;
 Thu, 27 Feb 2014 10:10:50 -0800 (PST)
Received: by 10.216.176.65 with HTTP; Thu, 27 Feb 2014 10:10:30 -0800 (PST)
In-Reply-To: <20140226105249.GE25711@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242835>

On Wed, Feb 26, 2014 at 5:52 AM, Jeff King <peff@peff.net> wrote:
> This seems like a reasonable feature to me. All of your examples are
> possible with an "e"dit and another git command, but the convenience may
> be worth it (though personally, most of the examples you gave are
> particularly interesting to me[1]).

This strikes me as over-complicating the rebase --interactive
interface. Particularly all of the ideas expressed later on about
merge commits and resetting authors, etc. It seems like you're trying
to define a whole new command set (i.e., API) for Git, but within the
context of rebase --interactive. I think it would be hard to document
this, and hard to learn it, and harder still to remember it (even
though it would obviously try to mirror the existing Git command API).
I honestly didn't know (or forgot) about the e"x"ec command, but that
to me says that I can automate whatever I want without needing to make
any changes to the rebase --interactive interface. The advantage to
this is that we don't need to reinvent the square wheel that is the
Git command API. We can just exec git ... with the exact same command
set and options that we're already familiar with. No doubts about
syntax or disparities, etc.

I don't think it's my place to resist these changes; particularly
because I don't think they'd necessarily affect me, except for maybe
the proposed automatic merge support, but if that SOMEHOW actually
works reliably and sensibly (i.e., to allow you to rebase over merges
without losing the merges) I'm not sure I'd complain. That said, I do
think that this is probably a bad direction and shouldn't be rushed
into too fast. It seems like it would be a complicated thing to do,
more complicated to do well, and I'm not sure that it would really
improve things any. I'm not sure that users would prefer to use this
over "e"diting and/or e"x"ecing instead. Plus where do you draw the
line as far as which features to reproduce? How do you prevent scope
creep?

> [1] The one feature I would like in this vein is that editing the title
>     in the instruction-sheet would modify the commit message of the
>     relevant commit. For some reason I try to do this every few weeks,
>     but of course the changes are just thrown away.

When I do this I am usually half asleep and it's a good reminder to
pay attention to what I'm doing. I'd probably rather Git *error* when
I change the subject line and tell me why it doesn't make sense and
recommend "r"eword instead.

Regards,


-- 
Brandon McCaig <bamccaig@gmail.com> <bamccaig@castopulence.org>
Castopulence Software <https://www.castopulence.org/>
Blog <http://www.bamccaig.com/>
perl -E '$_=q{V zrna gur orfg jvgu jung V fnl. }.
q{Vg qbrfa'\''g nyjnlf fbhaq gung jnl.};
tr/A-Ma-mN-Zn-z/N-Zn-zA-Ma-m/;say'
