From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] format_commit_message: honor `color=auto` for `%C(auto)`
Date: Tue, 31 May 2016 19:23:32 +0700
Message-ID: <CACsJy8BF6woZy8WUsJzVFqaMDCOMEYK-3xFNNeOQ6B+OMyqJLw@mail.gmail.com>
References: <20160525015649.GA13258@zoidberg> <20160525223904.GD13776@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 31 14:24:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7iiS-0005fg-7r
	for gcvg-git-2@plane.gmane.org; Tue, 31 May 2016 14:24:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752400AbcEaMYE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2016 08:24:04 -0400
Received: from mail-io0-f181.google.com ([209.85.223.181]:32864 "EHLO
	mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751023AbcEaMYD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2016 08:24:03 -0400
Received: by mail-io0-f181.google.com with SMTP id t40so131732081ioi.0
        for <git@vger.kernel.org>; Tue, 31 May 2016 05:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4uquSfANx3sUgKFUDcR5aVUeDmDOQEgEKrbXxcKIMic=;
        b=IG9DV677HyOLAce96h/YKi2l8G74gCX8r9DIAWiHUfHsFYgMLM1nAZgI8qhNVhRAdJ
         Wfzc+vB4Q0n/k7epZSu9+YCb5GoedR3DKUnvjXLhSj9A/ct+lwMQxcRkO+0uqBnghpuX
         BlUO3EeOUS5ySe2z8H4jBfhe7ae9QW9hGkObRKyZEHtvZGmqaAL8zKNRiYVh8m06Pxiz
         qmqfcr0zIp9RpFPlZ7vYlWvRr/NbYYkRmaFlq+0lwTBsYZ6+aIoKJKZtzdRFU3xjFTpU
         uN5OqjgqU0u7B82gP39BKsQx9A+SnXGg9PzebG1ZXSCqr7PCkBveoSBh9w7NgWLGO4by
         m3VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4uquSfANx3sUgKFUDcR5aVUeDmDOQEgEKrbXxcKIMic=;
        b=ftCZNJxxVy4wdW15gVBX0yTKv9WxBpshmAgZSKdPNvfKqmDnqEdzeWJmxrgtc2Y6Gy
         CVV9nT32kRKbpaXhq8LsawHl9vcCrZf/HSnriyoegaQiLUrJiRVtafUet1pGWA/8gAB1
         elVWFTKDm9OymgYOVkLr6deQ/5KhjzIPD0qu3QSPZyAsV69eqH3tpUoNHQb+PedkNVEX
         ZPSBje1O67AZ+OQoNQylOowmgbW7acay8QAg5nh1eEyek3lMhgpvotO9MXQJz+Xg0T+o
         tRTbHjgQthhB+Y4jpx0SNCx9mo7UXhWoRL8f/3FsmBGYMQShxrPDAfyAtP4M+81UBfzF
         CpMw==
X-Gm-Message-State: ALyK8tIik5/De3VOGm361k+1+QHKP5L7UUruNd1bcQf64gQnqlqMQGH1MIPYg6aUoW++Wcz1MCXb1A1N6hk9Nw==
X-Received: by 10.107.8.142 with SMTP id h14mr27530054ioi.95.1464697441774;
 Tue, 31 May 2016 05:24:01 -0700 (PDT)
Received: by 10.64.173.167 with HTTP; Tue, 31 May 2016 05:23:32 -0700 (PDT)
In-Reply-To: <20160525223904.GD13776@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295972>

On Thu, May 26, 2016 at 5:39 AM, Jeff King <peff@peff.net> wrote:
> On Tue, May 24, 2016 at 08:56:49PM -0500, Edward Thomson wrote:
>
>> Check that we are configured to display colors in the given context when
>> the user specifies a format string of `%C(auto)`.  This brings that
>> behavior in line with the behavior of `%C(auto,<colorname>)`, which will
>> display the given color only when the configuration specifies to do so.
>>
>> This allows the user the ability to specify that color should be
>> displayed only when the output is a tty, and to use the default color
>> for the given context (instead of a hardcoded color value).
>>
>> Signed-off-by: Edward Thomson <ethomson@edwardthomson.com>
>
> I somehow had trouble figuring out the problem from this description and
> the patch. It seems to be about much more than just color=auto or a
> given context, and more like:
>
>   When %C(auto) is used, we unconditionally turn on color for any
>   subsequent placeholders, even if the user said "--no-color", or color
>   config is turned off, or it is set to "auto" and we are not going to a
>   tty.

I think the (old) "auto" here means "automatically select the
color" and what you do would be equivalent to %(auto,auto) where the
first (and new) "auto" is about on/off switch, and the second is about
selecting the actual color.

> It's possible somebody is relying on the ability to unconditionally turn
> on color for "auto-colored" placeholders like "%H" or "%d", but I'm
> inclined to call this a strict bug-fix, for two reasons:
>
>   1. It says "%C(auto)", not "%C(on)".
>
>   2. This is documented as behaving like "%C(auto,...)", which as you
>      note works in a more sane way.
>
> I think it's worth mentioning this explicitly in the commit message. We
> could also add "%C(on)", I guess, but it's unclear to me whether anybody
> would want it (they would probably just use "--color" in that case,
> unless they really want unconditional coloring for just _some_
> elements).

If I could redo, I would go with %C(default) instead of %C(auto) then
we could have %C(auto,default). Perhaps we can make %C(auto) an
equivalent of %C(auto,default) now (i.e. exactly what this patch does)
and at some point in future add %C(default) which is what %C(auto) is
now if people really need to force it on?
-- 
Duy
