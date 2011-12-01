From: Samuel Bronson <naesten@gmail.com>
Subject: Re: [PATCH/RFC 1/2] pull: pass the --no-ff-only flag through to
 merge, not fetch
Date: Thu, 1 Dec 2011 13:59:36 -0500
Message-ID: <CAJYzjmcePWriGLr5a0oe_=6qUkfKp5OyFGGEabj6S8vy+hb4+g@mail.gmail.com>
References: <1322703537-3914-1-git-send-email-naesten@gmail.com>
	<7vborsq45x.fsf@alter.siamese.dyndns.org>
	<CAJYzjmep7sKxiSNhMzAX2DRYJhANDQkPL5pX4HOZ9CssJxcWbw@mail.gmail.com>
	<7vvcq0np35.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 01 19:59:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RWBrC-0002TG-Cy
	for gcvg-git-2@lo.gmane.org; Thu, 01 Dec 2011 19:59:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755985Ab1LAS7i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Dec 2011 13:59:38 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:48541 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755789Ab1LAS7h (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Dec 2011 13:59:37 -0500
Received: by eaak14 with SMTP id k14so2502110eaa.19
        for <git@vger.kernel.org>; Thu, 01 Dec 2011 10:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=9cZnOeHirch3EkMt2GmPOtRjXgLWjzlmBH0w+XOSNv8=;
        b=AR6wriaQveYzJ1NBSRXP4bwHeA/yz/H3iWbEHtmfj2BUu0pt/hFxBWOl81aXg/Nxq1
         bmqQiVzocWHsc6ulf9c27bd8PFdUnykCbooCWddwHWm0s4W0wD+oiLzFsGIwQVP7wHpk
         5QMMhblIw3uxzM9DTL+NNCSkv0wA8Y6pJxjX0=
Received: by 10.227.206.144 with SMTP id fu16mr3431853wbb.23.1322765976094;
 Thu, 01 Dec 2011 10:59:36 -0800 (PST)
Received: by 10.180.103.228 with HTTP; Thu, 1 Dec 2011 10:59:36 -0800 (PST)
In-Reply-To: <7vvcq0np35.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186186>

On Thu, Dec 1, 2011 at 1:06 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Samuel Bronson <naesten@gmail.com> writes:
>
>> Hmm, yes, I had noticed that it was a tristate (merge.ff clearly is),
>> and I guess --no-ff-only is a pretty ugly flag. I do have to ask,
>> though: why give --ff these new values? Wouldn't it make more sense to
>> reuse the values accepted by merge.ff; namely, 'true' (the implied
>> default), 'false', and 'only'?
>
> The 'true' and 'false' values to merge.ff are carry-over from the days
> when it was a boolean, _not_ a tristate. If we were to make the UI more
> rational by making it clear that this is not a boolean, it is a good time
> for us to aim a bit higher than merely repeating the mistakes we made in
> the past due to historical accident. In other words, we could add a
> synonym for the "default" mode in addition to "--ff=true" (and for the
> "always merge" mode in addition to "--ff=false") that makes it clear that
> the value is _not_ a boolean [*1*]. If we were to go the "--ff=<value>"
> route, we have to add support for other ways to spell boolean 'true'
> (e.g. 'yes', '1', and 'on') anyway, so it is not that much extra work to
> do so, I would think.

Sure, that makes sense. I was just a little worried that you might be
(accidentally) proposing that --ff use a different set of names than
merge.ff for a moment there...

>> Otherwise, this looks like a very nice way to implement what I want: I
>> guess it is probably a mistake that the existing (documented) flags do
>> not behave in this way?
>
> Yeah, right now if you say "merge --ff-only --no-ff", we say these are
> mutually exclusive (which is true), but if you think about the tristate
> nature of the 'ff' option and spell it differently in your head, i.e.
> "merge --ff=only --ff=never", it is reasonable to argue that we should
> apply the usual "last one overrides" rule and behave as if "merge --no-ff"
> were given (for the purpose of "last one overrides", the configured
> defaults can be treated as if they come very early on the command line).
> After all "merge --no-ff --ff" does seem to use the "last one overrides"
> rule.

Yes, I totally agree that it would make more sense that way; I
certainly tried that before I even began to look at any of the code.

> [Footnote]
>
> *1* Perhaps 'allowed' instead of 'normal' (which I wrote out of thin-air;
> I do not have any strong preference on the actual values) may be a better
> choice for such a "this is not a boolean" spelling for the default mode.
