From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH] introduce git root
Date: Fri, 5 Dec 2014 03:27:17 +0100
Message-ID: <CAP8UFD2P9P9zL=irZ-7uPD6+bEhxaiABowh0O3RT01Ov3VqT6w@mail.gmail.com>
References: <1417291211-32268-1-git-send-email-arjun024@gmail.com>
	<2AC7B765F56B4AA8A0DB76E8C670A889@PhilipOakley>
	<CAJFMrCEciWXhBb36MVeFPi7Y7D=9zQ2xGPpiyUz9y4_hOh_taw@mail.gmail.com>
	<vpqoaro99xd.fsf@anie.imag.fr>
	<xmqqd284rryz.fsf@gitster.dls.corp.google.com>
	<CAP8UFD2jES1i+6zOt1gXqTWFy1UHu2GBwAisQktd_Ymbj9Db2g@mail.gmail.com>
	<20141202070415.GC1948@peff.net>
	<xmqqd282m09j.fsf@gitster.dls.corp.google.com>
	<20141204092251.GC27455@peff.net>
	<xmqqlhmntf02.fsf@gitster.dls.corp.google.com>
	<20141204211232.GC19953@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Arjun Sreedharan <arjun024@gmail.com>,
	Philip Oakley <philipoakley@iee.org>, Git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Dec 05 03:27:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xwic8-0006qc-Ca
	for gcvg-git-2@plane.gmane.org; Fri, 05 Dec 2014 03:27:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933565AbaLEC1U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2014 21:27:20 -0500
Received: from mail-ig0-f173.google.com ([209.85.213.173]:55376 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933474AbaLEC1S (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2014 21:27:18 -0500
Received: by mail-ig0-f173.google.com with SMTP id r2so95265igi.6
        for <git@vger.kernel.org>; Thu, 04 Dec 2014 18:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=cwZFYb7uUfL89Hi9C3XuhpMU8o/wpDRJzkkgTU1fpEE=;
        b=sOoYuCJl+pS/EEoKJ7IWUbBkWnlyZL1VaRk3PU8QK+v+rmetA5oHkafCnUxXkS6tnQ
         2KP+A+YOusgOCKBFQIxIcECzkrkQ4eLkBciC8GqTHqGTwzZhcQ5NCPNbfO39RkMzalW9
         C//d6tJiDWi8ZU6xt3roAqbYaT3PwHOR7YlC15eB1+obatJylcBWDEVhGQj04P2yznbC
         wBgrrDJNTAP4w2Ru78Y5iqLmJFmhnIO9DhhNA8FzVqDx0yaL697rPBNphBYFwvKnO75A
         9ZBx2csJ82ay+zRtN5YFdKR6a/J4HWWx6NBEdmj/wHrgsT8iced89CZkM7Ep+TIWImO4
         HiMw==
X-Received: by 10.107.134.212 with SMTP id q81mr12440335ioi.62.1417746437715;
 Thu, 04 Dec 2014 18:27:17 -0800 (PST)
Received: by 10.50.30.40 with HTTP; Thu, 4 Dec 2014 18:27:17 -0800 (PST)
In-Reply-To: <20141204211232.GC19953@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260854>

Jeff King <peff@peff.net> wrote:

> Some of the discussion has involved mixing config options into this
> kitchen sink, but that does not make any sense to me (and is why I
> find "git var -l" so odd). Config options are fundamentally different, in
> that they are set and retrieved, not computed (from other config
> variables, or from hard-coded values). And we already have a nice
> tool for working with them (well...nice-ish, let's say).

Yeah, but "git config" cannot say which config option applies in some
context and why.
For example, to chose the editor all the following could apply:

GIT_SEQUENCE_EDITOR env variable
sequence.editor config variable
GIT_EDITOR env variable
core.editor config variable
VISUAL env variable
EDITOR env variable
editor configured at compile time

and the user or our own scripts right now cannot easily know which
editor should be used when editing the sequence list.

The best they can do is:

- first check if GIT_SEQUENCE_EDITOR is set, and if yes, use it
- then check if sequence.editor config variable is set, and if yes, use it
- then use "git var GIT_EDITOR" that will check the other options

I don't think it is very nice.

Jeff King <peff@peff.net> also wrote:

> My issue is only that "git --foo" has other options besides computables.
> So you need to name each option in a way that makes it clear it is
> reporting a computable and not doing something else.
>
> Take "git --pager" for instance. That would be a natural choice to
> replace "git var GIT_PAGER". But shouldn't "--pager" be the opposite of
> the existing "--no-pager"?
>
> So instead we probably need some namespace to indicate that it is a
> "showing" option. Like "--show-pager". And then for consistency, we
> would probably want to move "--exec-path" to "--show-exec-path",
> creating a new "--show-" namespace. Or we could call that namespace
> "git var". :)

I agree with that, but I think it could be better if there was also a
notion of context,

> I do not think "git var --exec-path" is a good idea, nor GIT_EXEC_PATH
> for the environment-variable confusion you mentioned. I was thinking of
> just creating a new namespace, like:
>
>   git var exec-path
>   git var author-ident

I agree that this is nice, but I wonder what we would do for the
sequence editor and the default editor.
Maybe:

git var sequence-editor
git var editor

That would already be nicer than what we have now, but maybe we should
consider the following instead:

git var sequence.editor
git var core.editor

(and maybe also some aliases to core.editor, like:

git var default.editor
git var editor)

I think "sequence.editor" and "core.editor" are better because:

- they use the same syntax as the config variables, so they are easier
to remember and to discover, and
- they provide a notion of context.

The notion of context is interesting because suppose that we later
introduce the "commit.editor" config variable. If we decide now that
"foo.editor" means just "core.editor" if we don't know about any
"editor" variable related to the "foo" context, then the scripts that
might later be written using "git var commit.editor" will not have to
worry about the fact that previous versions of Git didn't know about
"commit.editor".

People could even start using "git var commit.editor" now, because it
would work even if "commit.editor" is unused by git commit.

Of course when the user asks for "git var foo.editor" and we don't
know about any "editor" variable related to the "foo" context, we
first should check if "foo.editor" exists in the config file and we
should use that if it exists, before we default to "git var
core.editor".

Best,
Christian.
