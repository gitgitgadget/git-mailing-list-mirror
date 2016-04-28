From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 49/83] builtin/apply: move 'lock_file' global into 'struct apply_state'
Date: Thu, 28 Apr 2016 18:30:53 +0200
Message-ID: <CAP8UFD1=w2D-5q9bWrYqzL3v1q7fYi9imy1UhG2OaW2vB=2ECA@mail.gmail.com>
References: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
	<1461504863-15946-50-git-send-email-chriscool@tuxfamily.org>
	<CAPig+cRSe8oOjo2h6SuJQyD+he_Q7zHfF4TivZ0amhAu4HLQ+g@mail.gmail.com>
	<xmqqzishlgj1.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 28 18:31:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avoqB-0006bf-Ce
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 18:30:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752830AbcD1Qaz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2016 12:30:55 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:36470 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752067AbcD1Qay (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2016 12:30:54 -0400
Received: by mail-wm0-f54.google.com with SMTP id n129so72154248wmn.1
        for <git@vger.kernel.org>; Thu, 28 Apr 2016 09:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=keRDoRejtuxZA0z1b98rcNmdg9mtb+LsesLHB2gQ/F0=;
        b=xQ8TMwigOwMuWNhbOTlRtq+gSR0T3VztFqekDgPL1e8xBpJfF03846+psrJF4wpk95
         n2mLcj6VRy3a0Zb0On61wnqx39SGfsAfPjKgYqWqnuUvSoruPScf+GHN0G4/L6xyGZrw
         dwcwMi7LbI8RS111bZmRCn1jwyHYKOExnmP7Rst+HSTWJzvdMk3cPEUZe5yCkotiIXCj
         EMBqtJM6tN9R6ctiCNqRBOposQCdEXB6snahot9nG52kUDHppf44ItXqsia0q750kXdB
         4oqatM2FU86yLaFBQQJgYpnQ4xyLPWr4w4MaGbjG9AcNnq5U9zOUfIHAR3tQiS9norLz
         FPeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=keRDoRejtuxZA0z1b98rcNmdg9mtb+LsesLHB2gQ/F0=;
        b=cjrm8OMOQaojCKCbICLLv1LuNzfsQ/yb4QVafMGWl1zbQcwXRl6P4X0TSloxSqcBIv
         hilv0d7+Uj4nyKRoIAZKwHSY2SKj0UhF+bEyf0kCSS3BmfLwCEy2k9w5pFtSRqDxP1Xz
         iX1pb/UyGKd5pD2fI3NL3gP37GSiSZV7N4Rud+oRSQS3jOdU6sZA7kO2UURomZ3nf/2o
         aGn9Crq6jS19VW7br67VAD235W1cvXH8y2vMcIs+W5WAhUbvjlo0nF6SdsK870xDGr6R
         /QTQV3EDP/1DMgU0ddcW7JHti787LuaUq58veKEj1NP18mvdlgwJEFn3gIXWBtzAGChQ
         9LBA==
X-Gm-Message-State: AOPr4FU75EaSAP0Z2ghs5ch+HtdDDCrFEvvjxUHVXPog7pAUD6bwKT9t3H0V6/bp+8OOY+SViPigMcrwL9JM+w==
X-Received: by 10.195.17.166 with SMTP id gf6mr16585275wjd.124.1461861053165;
 Thu, 28 Apr 2016 09:30:53 -0700 (PDT)
Received: by 10.194.95.129 with HTTP; Thu, 28 Apr 2016 09:30:53 -0700 (PDT)
In-Reply-To: <xmqqzishlgj1.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292915>

On Mon, Apr 25, 2016 at 7:55 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>>> +       /*
>>> +        * Since lockfile.c keeps a linked list of all created
>>> +        * lock_file structures, it isn't safe to free(lock_file).
>>> +        */
>>> +       struct lock_file *lock_file;
>>
>> Is there ever a time when lock_file is removed from the list (such as
>> upon successful write of the index), in which case it would be safe to
>> free() this?
>
> I do not think you need to think about "free"ing.

Yeah, lockfile.h says:

 * * Automatic cruft removal. If the program exits after we lock a
 *   file but before the changes have been committed, we want to make
 *   sure that we remove the lockfile. This is done by remembering the
 *   lockfiles we have created in a linked list and setting up an
 *   `atexit(3)` handler and a signal handler that clean up the
 *   lockfiles. This mechanism ensures that outstanding lockfiles are
 *   cleaned up if the program exits (including when `die()` is
 *   called) or if the program is terminated by a signal.

and:

 * The caller:
 *
 * * Allocates a `struct lock_file` either as a static variable or on
 *   the heap, initialized to zeros. Once you use the structure to
 *   call the `hold_lock_file_for_*()` family of functions, it belongs
 *   to the lockfile subsystem and its storage must remain valid
 *   throughout the life of the program (i.e. you cannot use an
 *   on-stack variable to hold this structure).

> Even if the libified version of the apply internal can be called
> multiple times to process multiple patch inputs, there is no need to
> run multiple instances of it yet.  And a lockfile, after the caller
> finishes interacting with one file using it by calling commit or
> rollback, can be reused to interact with another file.
>
> So the cleanest would be to:
>
>  * make the caller of apply API responsible for preparing a static
>    or (allocating and leaking) lockfile instance,

Ok.

>  * make it pass a pointer to the lockfile to the apply API so that
>    it can store it in apply_state, and

Ok, I will add a new "struct lock_file *" parameter to
init_apply_state(), for the caller of the apply API to do that.
Though I think it should be ok for the caller to pass a NULL pointer
and in this case have init_apply_state() allocate the lockfile file
instance.

>  * have the caller use apply API feeding one patch at a time in a
>    loop, allowing the same lockfile instance used for each
>    "invocation".

Ok, the same lockfile instance will be used for each invocation.

> I sounded as if I were advocating non-reentrant implementation in
> the introductory paragraph, but that is not the intention.  If you
> want to do N threads, you would prepare N lockfile instances, give
> them to N apply API instances to be stored in N apply_state
> instances, and you would have N parallel applications, if you wanted
> to.

Thanks,
Christian.
