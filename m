From: Junio C Hamano <gitster@pobox.com>
Subject: Re: debugging git tests, was: Re: [PATCH v4 2/8] t5520: test no merge candidates cases
Date: Mon, 18 May 2015 12:35:37 -0700
Message-ID: <xmqqd21xbrw6.fsf@gitster.dls.corp.google.com>
References: <1431955978-17890-1-git-send-email-pyokagan@gmail.com>
	<1431955978-17890-3-git-send-email-pyokagan@gmail.com>
	<e89b333476cbb1e546371a07b357cd42@www.dscho.org>
	<xmqqoalhdbhx.fsf@gitster.dls.corp.google.com>
	<20150518185554.GB11463@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>, git@vger.kernel.org,
	Stefan Beller <sbeller@google.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 18 21:35:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuQpF-0000Eg-Im
	for gcvg-git-2@plane.gmane.org; Mon, 18 May 2015 21:35:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932618AbbERTfk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2015 15:35:40 -0400
Received: from mail-ie0-f172.google.com ([209.85.223.172]:36304 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932233AbbERTfk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2015 15:35:40 -0400
Received: by iepj10 with SMTP id j10so30914147iep.3
        for <git@vger.kernel.org>; Mon, 18 May 2015 12:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=to9KqQ0nAGk7J21MR09BVBarUtVzPENW1Pes0v+JGEk=;
        b=e17JnJTDvmisIXCt5nFrcPVa0NBB6OJTPpqTHQRcxJVhwwMyftmMNXzi8Y5e/xkW8O
         9pj8UsFR2Au4LzQfg4zizcQPz8YqtqAFIxIH3dqkp3ZNPdXFWjAyC6/Uw8YChTiWo8or
         Fk9o1gJsjO0Sb7zbhlye0sb9nFrAFZA70gcXEpIXXmEuuAxIlzXojfYk2ozoTUwm2Zfy
         o0V6H6QCrRGRYNmmpQNx6G2gVNE0w8wS/9jvnB1CM6wbvjCHakDlru77b0Ut04W47KY/
         GGElmR9aRmTuMRFHskTO/4Zgbg+/+dmgDoXF9ifkUEehXj4nW6lRZz3vmo2JFbaFV8VR
         aAaw==
X-Received: by 10.42.175.198 with SMTP id bb6mr14670941icb.53.1431977739638;
        Mon, 18 May 2015 12:35:39 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:2120:a5f3:f7b6:7da9])
        by mx.google.com with ESMTPSA id o9sm8312414ioe.35.2015.05.18.12.35.38
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 18 May 2015 12:35:38 -0700 (PDT)
In-Reply-To: <20150518185554.GB11463@peff.net> (Jeff King's message of "Mon,
	18 May 2015 14:55:54 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269313>

Jeff King <peff@peff.net> writes:

> On Mon, May 18, 2015 at 10:46:50AM -0700, Junio C Hamano wrote:
>
>> The test framework is aware of the fact that it needs to help the
>> people who are debugging the scripts.  The support is limited to the
>> case in which you run it under the -i option, i.e.
>> 
>> 	$ cd t
>>         $ sh ./t5520-pull.sh -i -v
>> 
>> will refrain from running test_when_finished scripts when the test
>> piece fails.  Even though this is only limited to -i, I found it
>> often sufficient for debugging.
>
> If you don't use "-i", you are pretty much screwed anyway, because the
> subsequent tests will stomp all over the state of the test directory.

Yeah.

> Many a head-scratching session has been caused by looking at the wrong
> state, and these days my go-to options for debugging a test are "-v -i".
> But since we are talking about it in a related thread, I will advertise
> the new "-x" here, too.  :)

Yes, thanks for "-x".  That has been very helpful.

> As a side note, I've also considered better support for running the
> debugger on git commands inside a test (right now, I usually stick a
> "gdb --args" in the pipeline, but you have to remember to run with "-v",
> and to redirect stdin appropriately). Do other people have this
> annoyance, too?

I usually tweak the script and have it stop before the offending
test, and then go through the steps in the test manually X-<.  If it
can be more automated, that would be great.

I haven't been ambitious enough to even attempt it so do not have
anything to add to the implementation ideas at this point.

> I'm vaguely thinking of something like putting debug support into
> bin-wrappers/git, but activating it only for certain tests (so you could
> say "t5520-pull.sh --gdb=10", and git would start under the debugger
> only for test 10). I think we'd also have to use gdbserver for I/O
> sanity, and maybe provide short script to do:
>
>    gdb -ex "target remote localhost:$some_port" "$TEST_DIRECTORY"/../git
>
> That still doesn't cover all cases (when git spawns an external command,
> you probably want to run the debugger on that; likewise, I have a
> git-remote-debug hack for debugging remote-curl). I suspect with clever
> use of gdb options that you could convince the original gdb invocation
> to end up tracing the process you care about, though.
>
> -Peff
