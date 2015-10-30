From: Edmundo Carmona Antoranz <eantoranz@gmail.com>
Subject: Re: [PATCH 0/2] checkout: added two options to control progress output
Date: Thu, 29 Oct 2015 18:09:06 -0600
Message-ID: <CAOc6etakOy_zZ3fH_vS5UGGqouXTd7SJFtD6UC9bZRJaYWsRQw@mail.gmail.com>
References: <1445698768-22614-1-git-send-email-eantoranz@gmail.com>
	<20151029220519.GA466@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 30 01:09:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrxFo-0001ch-RR
	for gcvg-git-2@plane.gmane.org; Fri, 30 Oct 2015 01:09:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757820AbbJ3AJI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2015 20:09:08 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:33800 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752336AbbJ3AJH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2015 20:09:07 -0400
Received: by padhk11 with SMTP id hk11so55081116pad.1
        for <git@vger.kernel.org>; Thu, 29 Oct 2015 17:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=zWgnbAKqp67JaSQ/7b65yNuXksqAcphlpmsHqCT88G8=;
        b=IazSbYR+tBQR1Qjf5Rrpltw2BCENd+/bf0dT4wu4o45iu3zXJmwOFfI87T8WrVyJ6m
         rrP7uWW3i0pjkcXRyIhQgbOn+XX4frVqD2ARoSOrjcMq+fM/GE1TLMnFpcTzEMKyjqsA
         vJ6Om0uMHD8OwZhxoTaTzk7uapouaxErYjYTkxS8YLfvftqazpPSDDKTt7D5B/ibxdMw
         BrtaCaKp6I4eHrGUuMyeGfDOZ/4G6udCgUNF8S/UICm7JOWa0fpxCJTDfTuPEfv4LaI2
         l8ASAd8DHZM+qspV4EI0SZiVOv2bAREV+19EmwDbt5zDMUdJT0pLfoRGjVqZWDzYxKDg
         XQrQ==
X-Received: by 10.66.124.165 with SMTP id mj5mr5045188pab.58.1446163746273;
 Thu, 29 Oct 2015 17:09:06 -0700 (PDT)
Received: by 10.66.149.4 with HTTP; Thu, 29 Oct 2015 17:09:06 -0700 (PDT)
In-Reply-To: <20151029220519.GA466@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280463>

On Thu, Oct 29, 2015 at 4:05 PM, Jeff King <peff@peff.net> wrote:
> On Sat, Oct 24, 2015 at 08:59:28AM -0600, Edmundo Carmona wrote:
>
>> From: Edmundo Carmona Antoranz <eantoranz@gmail.com>
>>
>> checkout will refuse to print progress information if it's not connected
>> to a TTY. These patches will add two options:
>
> Not just checkout, but all of git's progress code. The usual rules are:
>
>   - if the user told us --progress, show progress
>
>   - if the user told us --no-progress, don't show progress
>
>   - if neither is set, guess based on isatty(2)
>
> So with that in mind...
>
>> --progress-no-tty: enable printing progress info even if not using a TTY
>
> This should just be "--progress", shouldn't it?

It sure does!

A comment there: I think more builtins support --progress than the ones that
support --no-progress, right?

>
> It looks like checkout does not understand --progress and --no-progress.
> It does have "--quiet", but elsewhere we usually use that to mean "no
> progress, but also no other informational messages". We should probably
> make this consistent with other commands. See how builtin/clone.c does
> this, for example. Note also that clone's "quiet" option is part of
> OPT__VERBOSITY(), which provides both "-q" and "-v" to turn the
> verbosity level up/down. We could switch checkout to use that, too, but
> I do not think it buys us anything, as we have no "-v" output for
> checkout yet.
>
>> --progress-lf: print progress information using LFs instead of CRs
>
> I notice this is part of your patch 1, but it really seems orthogonal to
> checkout's --progress option. It should probably be a separate patch,
> and it probably needs some justification in the commit message (i.e.,
> explain not just _what_ you are doing in the patch, but _why_ it is
> useful).
>
> It also seems like this has nothing to do with checkout in particular.
> Should it be triggered by an environment variable or by an option to the
> main git binary? E.g.:
>
>   git --progress-lf checkout ...
>
> to affect the progress meter for all commands?

I think it would be worth it but, given that this is a more "global"
adjustment (
as in, for the whole progress and not just checkout), I think it's better I
separate it from the "--progress for checkout" patch cause right now checkout
is missing the --progress option that many other builtins already support....
say, for standardization's sake.

>
>> Edmundo Carmona Antoranz (2):
>>   checkout: progress on non-tty. progress with lf
>>   checkout: adjust documentation to the two new options
>
> I mentioned above that the two orthogonal features should each get their
> own patches. I think you should also do the reverse with the
> documentation: include it along with the implementation of the feature.
> Sometimes we do documentation as a separate patch (especially if it is
> large, or if the feature itself took many patches to complete). But for
> a small feature, as a reviewer (and when looking back through history) I
> usually find it simpler if the documentation is included in the same
> commit.
>
>>  Documentation/git-checkout.txt | 10 ++++++++++
>>  builtin/checkout.c             | 12 ++++++++++--
>>  progress.c                     |  8 +++++++-
>>  progress.h                     |  1 +
>>  unpack-trees.c                 |  3 +++
>>  unpack-trees.h                 |  2 ++
>>  6 files changed, 33 insertions(+), 3 deletions(-)
>
> I didn't look too carefully at the patches themselves, as they would
> need to be reworked substantially to follow the suggestions above. But I
> didn't notice any style or patch-formatting problems, and you seem to
> generally be touching the right areas for what you want to do.
>
> -Peff

It's ok. I knew I would have to rework them based on feedback from the list.

Thank you very much!
