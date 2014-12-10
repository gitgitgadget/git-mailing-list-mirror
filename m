From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH] introduce git root
Date: Wed, 10 Dec 2014 10:16:38 +0100
Message-ID: <CAP8UFD3U4BjAoebuL3dPGCqWM4T5y8GKUzhwgW=cx700hJd3zg@mail.gmail.com>
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
	<xmqqoarcn0wm.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Arjun Sreedharan <arjun024@gmail.com>,
	Philip Oakley <philipoakley@iee.org>, Git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 10 10:16:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XydOA-0003Y0-OK
	for gcvg-git-2@plane.gmane.org; Wed, 10 Dec 2014 10:16:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751199AbaLJJQt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2014 04:16:49 -0500
Received: from mail-ie0-f173.google.com ([209.85.223.173]:61748 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750716AbaLJJQp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2014 04:16:45 -0500
Received: by mail-ie0-f173.google.com with SMTP id y20so2293642ier.18
        for <git@vger.kernel.org>; Wed, 10 Dec 2014 01:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=HUMrxN5bRA9N+BNfbvhp16+9eP4lKH6e9IRWT4xOEC8=;
        b=itBldStjVOx0Ro+wLC5PHBi/K+Y3YnT0uAl+CrfJ7h/rCrXQ0hyVT42yx4wYZQ8S8/
         JzA6GD6dxqNDTm1U8z7xh1JWauLPT0hi7mw8u6nNE8OJ37iuYpYbJz9mSXsTIXwFKXgp
         gM/Y2rwkuLBGD9c2AML78v/ovCvYFV7Rvx39dwRinz0JuF2cRY+7vdFiqx7gSrW4/tUf
         lRkqM2KJWfQfQ3/JHX7NgIF2AzNCT2qrnN6919bQeNyd+kOAw5LTuYImdVJ9HmIAevgZ
         4vktIfbYBIpYTbrgjCu36hrasoUVE+j4JgeENM3tCia9RjfHlTMgEN8SqcdfomgYIEMe
         7WCw==
X-Received: by 10.42.153.131 with SMTP id m3mr5775679icw.28.1418202998376;
 Wed, 10 Dec 2014 01:16:38 -0800 (PST)
Received: by 10.50.30.40 with HTTP; Wed, 10 Dec 2014 01:16:38 -0800 (PST)
In-Reply-To: <xmqqoarcn0wm.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261197>

On Tue, Dec 9, 2014 at 7:17 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>
>> But the one place I do not agree is:
>>
>>> I think "sequence.editor" and "core.editor" are better because:
>>>
>>> - they use the same syntax as the config variables, so they are easier
>>> to remember and to discover, and
>>
>> I really don't like using "core.editor" here, because it has the same
>> name as a config variable, but it is _not_ the config variable. It
>> happens to use the config variable as one of the inputs to its
>> computation, but in many cases:
>>
>>   git config core.editor
>>
>> and
>>
>>   git var core.editor
>>
>> will produce different values. They are entirely different namespaces.
>> Using the same syntax and name seems unnecessarily confusing to me.
>
> I think this is a valid concern.
>
> It is a tangent, the current definition of "git_editor" helper reads
> like this:
>
>         git_editor() {
>                 if test -z "${GIT_EDITOR:+set}"
>                 then
>                         GIT_EDITOR="$(git var GIT_EDITOR)" || return $?
>                 fi
>
>                 eval "$GIT_EDITOR" '"$@"'
>         }
>
> If "git var editor" were to compute a reasonable value from the
> various user settings, and because GIT_EDITOR is among the sources
> of user settings, I wonder if the surrounding "if test -z then...fi"
> should be there.
>
> The pager side seems to do (halfway) "the right thing":
>
>         git_pager() {
>                 if test -t 1
>                 then
>                         GIT_PAGER=$(git var GIT_PAGER)
>                 else
>                         GIT_PAGER=cat
>                 fi
>                 : ${LESS=-FRX}
>                 : ${LV=-c}
>                 export LESS LV
>
>                 eval "$GIT_PAGER" '"$@"'
>         }
>
> The initial "test -t 1" is "we do not page to non-terminal", but we
> ask "git var" to take care of PAGER/GIT_PAGER fallback/precedence.
>
> It is tempting to argue that "we do not page to non-terminal" should
> also be part of "various user settings" for "git var" to take into
> account and fold this "if test -t 1...then...else...fi" also into
> "git var", but because a typical command line "git var" will be used
> on would look like this:
>
>         GIT_PAGER=$(git var pager)
>         eval "$GIT_PAGER" ...
>
> with the standard output stream of "git var" not connected to
> terminal, that would not fly very well, and I am not sure what
> should be done about it.
>
> This is another tangent that comes back to the original "how to name
> them?" question, but I wonder if a convention like this would work.
>
>  * When asking for a feature (e.g. "what editor to use"), if there
>    is a git-specific environment variable that can be set to
>    override all other settings (e.g. "$GIT_EDITOR" trumps "$EDITOR"
>    environment or "core.editor" configuration), "git var" can be
>    queried with the name of that "strong" environment variable.
>
>  * All other features without such a strong environment variables
>    should not be spelled as if there is such an environment variable
>    the user can set in order to avoid confusion.

Does that mean that we would also have the following:

- git var GIT_DIR
- git var GIT_EXEC_PATH
- git var GIT_HTML_PATH
- git var GIT_WORK_TREE
- git var GIT_PREFIX
...

but not:

- git var GIT_SHARED_INDEX_PATH
- git var GIT_TOP_LEVEL
- git var GIT_CDUP

?

For the above 3 variables we would have:

- git var shared-index-path
- git var top-level
- git var cdup

And then what if we add the GIT_SHARED_INDEX_PATH env variable for example?
Would we need to deprecate "git var shared-index-path"?

We also would have:

- git var GIT_EDITOR

but:

- git var web-browser (or "git var web.browser" like the config option?)

And when we add a GIT_WEB_BROWSER or GIT_BROWSER env variable, we
deprecate "git var web-browser" (or "git var web.browser"?)

I doesn't look like user and future friendly to me, but maybe I
misunderstood something.

Thanks,
Christian.
