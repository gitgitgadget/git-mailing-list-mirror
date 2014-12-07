From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH] introduce git root
Date: Sun, 7 Dec 2014 06:23:54 +0100
Message-ID: <CAP8UFD3mXJEHOfSoW6-B8uAR0gv2ZKWUhAs1SpNr17wVsRpM6g@mail.gmail.com>
References: <CAJFMrCEciWXhBb36MVeFPi7Y7D=9zQ2xGPpiyUz9y4_hOh_taw@mail.gmail.com>
	<vpqoaro99xd.fsf@anie.imag.fr>
	<xmqqd284rryz.fsf@gitster.dls.corp.google.com>
	<CAP8UFD2jES1i+6zOt1gXqTWFy1UHu2GBwAisQktd_Ymbj9Db2g@mail.gmail.com>
	<20141202070415.GC1948@peff.net>
	<xmqqd282m09j.fsf@gitster.dls.corp.google.com>
	<20141204092251.GC27455@peff.net>
	<xmqqlhmntf02.fsf@gitster.dls.corp.google.com>
	<20141204211232.GC19953@peff.net>
	<CAP8UFD2P9P9zL=irZ-7uPD6+bEhxaiABowh0O3RT01Ov3VqT6w@mail.gmail.com>
	<20141205092752.GC32112@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Arjun Sreedharan <arjun024@gmail.com>,
	Philip Oakley <philipoakley@iee.org>, Git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Dec 07 06:24:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XxUKT-0005kL-Fb
	for gcvg-git-2@plane.gmane.org; Sun, 07 Dec 2014 06:24:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752242AbaLGFXz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Dec 2014 00:23:55 -0500
Received: from mail-ie0-f170.google.com ([209.85.223.170]:52617 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752156AbaLGFXz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Dec 2014 00:23:55 -0500
Received: by mail-ie0-f170.google.com with SMTP id rd18so2976889iec.1
        for <git@vger.kernel.org>; Sat, 06 Dec 2014 21:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=j2urVYNZD93dbxzuRcXXLhH9keD0h1relkbQpRonZOM=;
        b=CH2LkRnAnN08Kowq2jVFGEl0qfdsvbB2lZSXvX6nJdFtBfgBGX0U/y4s6QTeoDuk25
         JGCSFG5Iu8qtV1UbXR5t2O94CzQ6KOZakatuSWzHZNCxPFTDqZ5Gzt9n1O4bdEEZVpPs
         aX7E2mbMxPKa9t0FapvpQ8soku0opXSrYWbbVhl0WNe6qOAinaglp6+A0yUGL1YWCZm7
         HBIyxG6QMzCYTqKbnGVDNMW4coHDE1vguDFeiPAq7Tm+APSaMTo2HdrI0/4jwbjwWBWx
         0FhjKKB4IhcyAQW57cPLeEOiu00NPu7tASX9XE3IGhbe0OI7UvIg2GbbhRTWQHYGHtdz
         w5Dg==
X-Received: by 10.50.45.100 with SMTP id l4mr363696igm.40.1417929834395; Sat,
 06 Dec 2014 21:23:54 -0800 (PST)
Received: by 10.50.30.40 with HTTP; Sat, 6 Dec 2014 21:23:54 -0800 (PST)
In-Reply-To: <20141205092752.GC32112@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260969>

On Fri, Dec 5, 2014 at 10:27 AM, Jeff King <peff@peff.net> wrote:
> On Fri, Dec 05, 2014 at 03:27:17AM +0100, Christian Couder wrote:
>
>> > I do not think "git var --exec-path" is a good idea, nor GIT_EXEC_PATH
>> > for the environment-variable confusion you mentioned. I was thinking of
>> > just creating a new namespace, like:
>> >
>> >   git var exec-path
>> >   git var author-ident
>>
>> I agree that this is nice, but I wonder what we would do for the
>> sequence editor and the default editor.
>> Maybe:
>>
>> git var sequence-editor
>> git var editor
>
> Again, I think we're mostly agreeing. Context and hierarchy and falling
> back are good things. Whatever we call the variables, "editor" and
> "sequence-editor" and "foo-editor" should have a predictable and
> consistent form. I like the idea of "foo-editor" automatically falling
> back to "editor" even if we don't know what "foo" is.

Yeah but that means that we have to use something other than "-" to
separate the context from the name, because we already have names like
exec-path, html-path and man-path.

> But the one place I do not agree is:
>
>> I think "sequence.editor" and "core.editor" are better because:
>>
>> - they use the same syntax as the config variables, so they are easier
>> to remember and to discover, and
>
> I really don't like using "core.editor" here, because it has the same
> name as a config variable, but it is _not_ the config variable. It
> happens to use the config variable as one of the inputs to its
> computation, but in many cases:
>
>   git config core.editor
>
> and
>
>   git var core.editor
>
> will produce different values.

Yeah, but I don't think it is a problem. They are different commands,
so it can be expected that they do different things.

For example, if you use "git log origin/master" you get a different
ouput than if you use "git show origin/master", though you still use
the same "origin/master" notation.

When you use "git show" you consider only the commit pointed to by
origin/master and when you use "git log" you consider the same commit
but also all its ancestors.

In the same way, when you use "git config core.editor" you consider
only the value of the core.editor logical variable in the config
files, while when you would use "git var core.editor" you would
consider the value of the core.editor logical variable in both the
config files and the environment variables.

> They are entirely different namespaces.
> Using the same syntax and name seems unnecessarily confusing to me. Even
> still using dotted hierarchies, but giving them different names (e.g.,
> "editor", "editor.sequence", "editor.foo") would make it more obvious
> that they are not the same thing.

Using yet another namespace or syntax when we could reuse an existing
one is what would seem unnecessarily confusing to me.
The value of the "editor" logical variable in the "sequence" context
is related to the "sequence.editor" logical value in the config file,
because the later can directly influence the former. So there is a
reason to use the same notation.

Best,
Christian.
