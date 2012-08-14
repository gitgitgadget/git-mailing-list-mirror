From: David Aguilar <davvid@gmail.com>
Subject: Re: What should mergetool do with --no-prompt?
Date: Tue, 14 Aug 2012 12:15:28 -0700
Message-ID: <CAJDDKr7C1dNFZZap9duKc7QgvSRjAhHB+B2GpBc1h7spwpNRqg@mail.gmail.com>
References: <CAJDDKr5TK910n603jcmoq6WoaLL9DX9hgwF3Y+MmjngMpAXPQw@mail.gmail.com>
	<20120814071823.GA21031@hashpling.org>
	<7vehn98qcv.fsf@alter.siamese.dyndns.org>
	<20120814170900.GA28978@hashpling.org>
	<7v1uj9bd5d.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Charles Bailey <charles@hashpling.org>,
	Git Mailing List <git@vger.kernel.org>,
	Tim Henigan <tim.henigan@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 14 21:15:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1Mac-0000q1-3e
	for gcvg-git-2@plane.gmane.org; Tue, 14 Aug 2012 21:15:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755784Ab2HNTPf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Aug 2012 15:15:35 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:34217 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755740Ab2HNTP3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2012 15:15:29 -0400
Received: by vcbfk26 with SMTP id fk26so707369vcb.19
        for <git@vger.kernel.org>; Tue, 14 Aug 2012 12:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Gb/0cXTRb/uLaqptO3v2eAMmNVVSiHot14j6JYNQqvU=;
        b=y3vhqqg0fi7EGdOBImJfQ6tTB1iiYhN/2jvOl8eUC7XvF0m/vtaH+ILYht5uyXUi2t
         yATW6N5jKnLF9gLJcCzKUVN8xRNqJpawc6DPHqnbRdr108Sy4sXkoZbB3Kn7m0MrKOZG
         3nsx1CIi4l8kl1Ph22v5RXbva/9iYyRli4PHyCnEgwJX4Mqrsark3wpJG0ghuqbZfBwF
         GO/m4txk0uVZjH1gX8C56OqkxoqSNJxhNVCGWuItDMtSiWRGhZR03xV5RE0ctwoRL2YP
         MAogxyJqUYwi8Twr10FgiGnHPT+Vu1/+tvOhEHZ2UPb8+gnrbDidq6AXPSfPZ6vIr54r
         X5TA==
Received: by 10.52.94.148 with SMTP id dc20mr9813060vdb.12.1344971728833; Tue,
 14 Aug 2012 12:15:28 -0700 (PDT)
Received: by 10.58.173.104 with HTTP; Tue, 14 Aug 2012 12:15:28 -0700 (PDT)
In-Reply-To: <7v1uj9bd5d.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203423>

On Tue, Aug 14, 2012 at 10:23 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Charles Bailey <charles@hashpling.org> writes:
>
>> On Tue, Aug 14, 2012 at 08:06:56AM -0700, Junio C Hamano wrote:
>>>
>>> Could it be that the calling user or script does not even have a
>>> terminal but still can spawn the chosen mergetool backend and
>>> interact with the user via its GUI?  Or it may have a terminal that
>>> is hard for the user to interact with, and the prompt and "read ans"
>>> may get stuck.
>>
>> It could be, although this certainly wasn't considered in the original
>> design. I know that we removed explicit references to /dev/tty and
>> replaced them with exec n>&m juggling which made things generally more
>> robust and allowed some basic shell tests to work more reliably. I
>> don't object to handling non-interactive mode better but it feels
>> unsatisfactory to only be able to resolve some types of conflict and
>> have to skip others.
>
> Exactly.  The mention of "a matching GUI" below you quoted was a
> suggestion to improve that "only resolve some but not others"
> problem.  The usual mergetool backend, e.g. meld, may not be capable
> of resolving symlink conflicts, but "git mergetool" could run a GUI
> dialog that gives the user "ours/theirs/fail" choice (or better yet
> "merge result value" textbox in addition) for such a path.  The same
> for delete/modify conflicts.
>
>>> In such an environment, the ideal behaviour for the "git mergetool"
>>> frontend may be not to interact via the terminal at all and instead
>>> run its interaction to choose the resolution using a matching GUI
>>> interface.

That makes sense.  Perhaps a tcl/tk dialog could be used for these
when a special flag, e.g. "--interactive-gui" or something, is
supplied. I think that would be nice, and I can look into this when
I have some more tcl/tk hacking time.

I did have a real-world example -- a GUI that runs git-mergetool
on the user's behalf that (wrongly) assumed that "git mergetool -y"
would not block waiting for input.  This is not a problem with the
documentation or with the implementation -- it was simply an oversight
on my part.

Due to backwards-compatibility concerns, the only way to do
this (and work across as many git versions as possible) is to
detect these special cases -- submodules, symlinks, and deletions
-- and handle it in the calling app instead of delegating to mergetool.


There is a part of me that thinks that "--no-prompt" should
really not prompt, and that the various choices could be supplied
on the command-line, e.g. "git mergetool --theirs --no-prompt <path>".

Flags like --ours and --theirs would be heavy hammers when run
without pathspecs. Nonetheless, would it would be helpful to have
these? I seems like it would be helpful when resolving these
special-case merge scenarios.

So I think I'll take the advice that the calling app should
special-case these for existing git versions, and then later
allow them to fall through to mergetool once we've had a chance
to add a matching GUI interface.

Thanks for the sanity check,
-- 
David
