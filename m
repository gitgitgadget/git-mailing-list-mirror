From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC PATCH] git log: support "auto" decorations
Date: Thu, 29 May 2014 21:54:10 -0700
Message-ID: <CA+55aFzwy09-i=hpBy-5bYS6eowGzkdcF65cFJpL2qnJvYq85w@mail.gmail.com>
References: <alpine.LFD.2.11.1405291523520.8270@i7.linux-foundation.org>
	<20140530015855.GG28683@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 30 06:54:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WqEpb-0005Th-V8
	for gcvg-git-2@plane.gmane.org; Fri, 30 May 2014 06:54:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751892AbaE3EyM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2014 00:54:12 -0400
Received: from mail-vc0-f171.google.com ([209.85.220.171]:63422 "EHLO
	mail-vc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751115AbaE3EyL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2014 00:54:11 -0400
Received: by mail-vc0-f171.google.com with SMTP id lc6so1507797vcb.16
        for <git@vger.kernel.org>; Thu, 29 May 2014 21:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=0Rs20XUTTQpWX4pWxPwfSWcFA6R7wgnn83/aCHZaF1E=;
        b=PnUB/PTI9HEWCIfWDJLCr4QjX/G57VRI9jEV74mOmbKJ9dzZtIAurt14JxhOQJji30
         dNjmlSPYqCyNEONhZgH44Fqcg4WhOrbCX++CFQxrLS7kxcPhpzocSWAmlrXAvYEQ+UAd
         WpKMSVUoDJq1wbW3l2hTQfb7olQyXUX7Jd8fciL1NVau45DhPiuPPeyf01qVgRO6z9FJ
         D++LybRNefHOB3q4cky21F/sh2go3F3N0x1wFURf0DQ/QsWR7WfYS3ZoeWzyDQewFm5d
         SXkKn4hGCvHFW0jjg15GykO5wjn5jI372D4o6GybtpaA/ccWr/GNEepCMen49EUxJXJg
         TYpQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=0Rs20XUTTQpWX4pWxPwfSWcFA6R7wgnn83/aCHZaF1E=;
        b=IuHEBiYG3rLujACJeSyvCcvFhpgiQWbNcmkCwmfwKgdb93gbGUYSDo9tQTUagVyAZp
         zVBt0+XyDjZycVpbBw+Zo5IJLpsF9tqXVAywIonbsiCTPwxrQr1CQ0VgVFRSRKQ921V/
         DaKiSb5m8iwSP8hjEkfYFFHmLFTnosqHPXpcY=
X-Received: by 10.52.175.69 with SMTP id by5mr9737133vdc.16.1401425650385;
 Thu, 29 May 2014 21:54:10 -0700 (PDT)
Received: by 10.220.2.205 with HTTP; Thu, 29 May 2014 21:54:10 -0700 (PDT)
In-Reply-To: <20140530015855.GG28683@sigill.intra.peff.net>
X-Google-Sender-Auth: GhHZ6eoZ2rSz6IrXVBBb7KHk1jI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250432>

On Thu, May 29, 2014 at 6:58 PM, Jeff King <peff@peff.net> wrote:
>
> I will spare you the usual lecture on having these lines in the message
> body. ;)

We do it for the kernel because they often get lost otherwise.
Particularly the date/author.

git doesn't tend to have the same kind of deep email forwarding
models, and nobody uses quilt to develop git (I hope!) but it's a
habit I like to encourage for the kernel, so I use it in general..

> Yeah, I think this makes a lot of sense. I do use log.decorate=true, and
> it is usually not a big deal. However, I think I have run into
> annoyances once or twice when piping it. I'd probably use
> log.decorate=auto if we had it.

I have various scripts to generate releases etc, using "git log" and
piping it to random other stuff. I don't _think_ they care, but quite
frankly, I'd rather not even have to think about it.

Also, I actually find the un-colorized version of the decorations to
be distracting. With color (not that I really like the default color
scheme, but I'm too lazy to set it up to anything else), the
colorization ends up making the decorations much easier to visually
separate, so I like them there.

>> It's marked with RFC because
>>
>>  (a) that "isatty(1) || pager_in_use()" test is kind of hacky, maybe we
>>      would be better off sharing something with the auto-coloration?
>
> The magic for this is in color.c, want_color() and check_auto_color().

Oh, I know. That's where I stole it from. But the colorization
actually has very different rules, and looks at TERM etc. So I only
stole the actual non-color-specific parts of it, but I was wondering
whether it might make sense to unify them.

>>  (b) I also think it would be nice to have the equivalent for
>>      "--show-signature", but there we don't have any preexisting config
>>      file option.
>
> Potentially yes, though there is a real performance impact for "log
> --show-signature" if you actually have a lot of signatures. Even on
> linux.git, a full "git log" is 15s with --show-signature, and 5s
> without. Maybe that is acceptable for interactive use (and certainly it
> is not a reason to make it an _option_, if somebody wants to turn it
> on).

Yes. This is an example of where the whole "tty is fundamentally
different from scripting" happens. It really is about the whole "user
is looking at it" vs "scripting". There is no way in hell that
"--show-signature" should be on by default for anybody sane.

That said, part of it is just that show-signature is so suboptimal
performance-wise, re-parsing the commit buffer for each commit when
"show_signature" is set. That's just crazy, we've already parsed the
commit text, we already *could* know if it has a signature or not, and
skip it if it doesn't. That would require one of the flag bits in the
object, though, or something, so it's probably not worth doing.

Sure, performance might matter if you end up searching for something
in the pager after you've done "git log", but personally I think I'd
never even notice..

          Linus
