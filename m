From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] mergetools: Add tortoisegitmerge helper
Date: Thu, 24 Jan 2013 22:11:45 -0800
Message-ID: <CAJDDKr5O70tTfwuipWcYVJL6gM3bUyQh-22yVO89xn8OFsQOpw@mail.gmail.com>
References: <50FBD4AD.2060208@tu-clausthal.de>
	<7v4nibjrg0.fsf@alter.siamese.dyndns.org>
	<50FCFBBB.2080305@tu-clausthal.de>
	<7vfw1qbbr4.fsf@alter.siamese.dyndns.org>
	<5101B0A5.1020308@tu-clausthal.de>
	<7vpq0u8bxd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Jeff King <peff@peff.net>
To: Sven Strickroth <sven.strickroth@tu-clausthal.de>
X-From: git-owner@vger.kernel.org Fri Jan 25 07:12:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TycWH-0000mL-Ou
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jan 2013 07:12:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751195Ab3AYGLs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2013 01:11:48 -0500
Received: from mail-ea0-f177.google.com ([209.85.215.177]:52368 "EHLO
	mail-ea0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751087Ab3AYGLr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2013 01:11:47 -0500
Received: by mail-ea0-f177.google.com with SMTP id n13so7706eaa.22
        for <git@vger.kernel.org>; Thu, 24 Jan 2013 22:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=jVjjrh6FZIlBtFR9qyEz2PL2BCdEd9muIukQPf5tLro=;
        b=jKP6VotZ7teiFMw/TULLKUY/Gl1xti5Xu2Z941ts4/v9Z/Q5RUvoEyEdUgFPl5jEq7
         QTMBZf5eHr4cuzmB+96dlRLqB3+nM87vQ6fFp1OSOZleBbZRXsyXbymccaw77C/usIpC
         7+IpixaK2oU6wkt0KsUwQM/V+L/5hI7DpZtDR/wG3AgyuQrXrEKC2m9fx7fK/Rw4Fo9v
         1pwPk2xdV7gcZ5KDv4nLXkvEAPEcWYDjT4TMG/frambi4CLiCiG0ROntfeOkApyj8yPb
         pLypATSvSJpD2Nm/4R6D4GvsrvppjdEIzD+kHn6RthPCDbTmvXhKrmH6WeYh40ZVDQ1q
         uHqw==
X-Received: by 10.14.1.70 with SMTP id 46mr14809835eec.0.1359094306054; Thu,
 24 Jan 2013 22:11:46 -0800 (PST)
Received: by 10.14.125.135 with HTTP; Thu, 24 Jan 2013 22:11:45 -0800 (PST)
In-Reply-To: <7vpq0u8bxd.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214504>

On Thu, Jan 24, 2013 at 2:15 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Sven Strickroth <sven.strickroth@tu-clausthal.de> writes:
>
>> Am 24.01.2013 20:51 schrieb Junio C Hamano:
>>> Sven Strickroth <sven.strickroth@tu-clausthal.de> writes:
>>>
>>>> - The TortoiseGit team renamed TortoiseMerge.exe to TortoiseGitMerge.exe
>>>>   (starting with 1.8.0) in order to make clear that this one has special
>>>>   support for git and prevent confusion with the TortoiseSVN TortoiseMerge
>>>>   version.
>>>
>>> Wouldn't it make more sense in such a situation if your users can
>>> keep using the old "tortoisemerge" configured in their configuration
>>> and when the renamed one is found the mergetool automatically used
>>> it, rather than the way your patch is done?
>>
>> That was also my first idea, however, TortoiseMerge uses parameters as
>> follows: '-base:"$BASE"'. TortoiseGitMerge uses values separated by
>> space from keys: '-base "$BASE"'. So both are incompatible (the first
>> approach has problems with spaces in filenames, the TortoiseGitMerge
>> approach fixes this).
>
> OK.  Please unconfuse future readers of "git log" by saying why such
> a unification does not work in the proposed log message.

Even though the old tortoisemerge and the new tortoisegitmerge
have completely different syntax, could we still use the existence
of one when deciding which syntax to use?

pseudo-code at the top of the scriptlet:

if test -z "$tortoisegitmerge"
then
    if type tortoisegitmerge 2>&1 >/dev/null
    then
        tortoisegitmerge=true
    else
        tortoisegitmerge=false
    fi
fi

...and then later merge_cmd and diff_cmd
can delegate to {diff,merge}_cmd_legacy() and
{diff,merge}_cmd_gitmerge() functions to do the work.

It's just a thought.  translate_merge_tool_path()
is too low-level to do it, but it seems like we could
get away with it by having some extra smarts in the
scriptlet.

>>>> diff --git a/Documentation/diff-config.txt b/Documentation/diff-config.txt
>>>> index 4314ad0..13cbe5b 100644
>>>> --- a/Documentation/diff-config.txt
>>>> +++ b/Documentation/diff-config.txt
>>>> @@ -151,7 +151,7 @@ diff.<driver>.cachetextconv::
>>>>  diff.tool::
>>>>     The diff tool to be used by linkgit:git-difftool[1].  This
>>>>     option overrides `merge.tool`, and has the same valid built-in
>>>> -   values as `merge.tool` minus "tortoisemerge" and plus
>>>> -   "kompare".  Any other value is treated as a custom diff tool,
>>>> +   values as `merge.tool` minus "tortoisemerge"/"tortoisegitmerge" and
>>>> +   plus "kompare".  Any other value is treated as a custom diff tool,
>>>>     and there must be a corresponding `difftool.<tool>.cmd`
>>>>     option.
>>>
>>> So in short, two tortoises and kompare are only valid as mergetool
>>> but cannot be used as difftool?  No, I am reading it wrong.
>>> merge.tool can be used for both, kompare can be used as difftool,
>>> and two tortoises can only be used as mergetool.
>>>
>>> This paragraph needs to be rewritten to unconfuse readers.  The
>>> original is barely intelligible, and it becomes unreadable as the
>>> set of tools subtracted by "minus" and added by "plus" grows.
>>
>> But I think this should not be part of this patch.
>
> I agree that it can be done (and it is better to be done) as a
> preparatory step.  The current text is barely readable, but with
> this patch there will be two "minus", and the result becomes
> unreadable at that point.
>
> It also could be done as a follow-up documentation readability fix.

Another thought would be to minimize this section as much
as possible and point users to "git difftool --tool-help".

We can then improve --tool-help (there are already preliminary
patches in-flight to do so) so that we do not have to maintain
this documentation in the future.

Likewise, if we are able to teach the scriptlet to choose
the best one (and not require a new scriptlet) then this
section could be left as-is for this patch.
-- 
David
