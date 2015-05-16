From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH v3 1/9] t5520: fixup file contents comparisons
Date: Sat, 16 May 2015 21:49:52 +0800
Message-ID: <CACRoPnSP9xfyW47ZqU7QO5o4tyzROh4hGRPqG9g9OB5cquS+uw@mail.gmail.com>
References: <1431508136-15313-1-git-send-email-pyokagan@gmail.com>
	<1431508136-15313-2-git-send-email-pyokagan@gmail.com>
	<xmqqk2wcbmq5.fsf@gitster.dls.corp.google.com>
	<xmqqa8x8bkuc.fsf@gitster.dls.corp.google.com>
	<CAO2U3QgD0-tAwGnMeeMR5aqbUuqDsdWy0Sw8dQBPUpUNwJZpHg@mail.gmail.com>
	<xmqq4mnf8358.fsf@gitster.dls.corp.google.com>
	<CACRoPnSbekLANNiGOyxN70TCUd1c=wcrU_6Gfew5pp5EBpSEsA@mail.gmail.com>
	<xmqq7fs9hekc.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Blume <blume.mike@gmail.com>,
	Git List <git@vger.kernel.org>,
	Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 16 15:50:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YtcTX-0000ik-Vw
	for gcvg-git-2@plane.gmane.org; Sat, 16 May 2015 15:50:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752140AbbEPNtz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 May 2015 09:49:55 -0400
Received: from mail-la0-f50.google.com ([209.85.215.50]:35198 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750972AbbEPNty (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 May 2015 09:49:54 -0400
Received: by labbd9 with SMTP id bd9so160872494lab.2
        for <git@vger.kernel.org>; Sat, 16 May 2015 06:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=HkfxuoEzkMpq4qKoe68VPGm7N1Nl3DpS7e3FA10aVwY=;
        b=z/KWZoo+9CZvLMFGUgTEjcsDkgoPvSHdpdYm+YMMjvlID5bNPusZSWqHE3hqTva1Si
         hoXcXcC7R/ODs/p9ZsaCGHh71cPFg/5DjPfbc1YMpM1XTnuc30rLTp8Qm3MnBvNFDD9F
         L8dgqQUllhJcjLSwgBpzE+cuqn+Kfn5p7n91Q/K6UvmW54iOkPjbv2Hqzi0ZIgjBRt7l
         0neP/g8xykhdAj3sYQhi2Azx3eaZRNNJZT45e9zlXlb26yWF38IYt4h/ztYWk+50wN71
         Xg0BNwTmwZsqMyFrZiHWwtsszPo7nGkZB8Z2Wp29tK/yawDqSR8gStttMdIb0tqROPQu
         Hkqg==
X-Received: by 10.152.6.105 with SMTP id z9mr10545450laz.98.1431784192814;
 Sat, 16 May 2015 06:49:52 -0700 (PDT)
Received: by 10.112.74.133 with HTTP; Sat, 16 May 2015 06:49:52 -0700 (PDT)
In-Reply-To: <xmqq7fs9hekc.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269196>

Hi Junio,

On Sat, May 16, 2015 at 2:37 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Just to avoid misunderstanding, please do not remove 'verbose '
> blindly without thinking while doing so, as you already did 1/3 of
> the necessary job to make things better.

Eh? I thought we established that using "verbose" does not provide
anything more than what "set -x" already provides. So at the very
least, its use should be removed completely.

Here is my understanding of the current situation, please correct me
if I am wrong:

When a test fails, it would be useful to know the exact, unexpanded,
unsubstituted command which failed (additionally with a nice stack
trace and line numbers). However, the output of -v and -x (and by
extension, the "verbose" function) is not very helpful, as it still
requires the debugger to understand the test script.

-v will print out the stdout and stderr of the executed commands, but
it requires the debugger to match up the output of the commands with
the test script to understand where the test failed. It is also not
very helpful in the case of "test", which does not print anything when
it fails.

-x will trace the commands being executed, but the tracing output is
so verbose it still requires the debugger to understand the test
script. e.g:

     test "$(cat file)" "expected"

If the above test fails (e.g. the content of the file is
"unexpected"), the tracing output will be:

     + cat file
     + test unexpected = expected
     error: last command exited with $?=1

Furthermore, the format of the tracing output is not specified by
POSIX, so we can't count on it being consistent among all shells (e.g.
for users who submit bug reports with the test output)

> You might have noticed, while adding them, there were something
> common that we currently do with a bare 'test' only because we
> haven't identified common needs.  As I already said, it may be that
> we often try to see a file has a known single line content (I didn't
> check if that were the case; I am just giving you an example) and
> only because there is no ready-made test_file_contents helper to be
> used, the current tests say
>
>         test expected_string = "$(cat file)"
>
> And if that were the case, it is a good thing to have a new helper
> like this
>
>         test_file_contents () {
>                 if test "$(cat "$1")" != "$2"
>                 then
>                         echo "Contents of file '$1' is not '$2'"
>                         false
>                 fi
>         }
>
> in t/test-lib-functions.sh and convert them to say
>
>         test_file_contents file expected_string
>
> That would be an improvement (and that is the remaining 2/3 ;-).

Yeah, this kind of comparison with file contents is something that is
done often in t5520, so I agree with adding it.

However, what about these kind of tests:

     test new = "$(git show HEAD:file2)"

or these:

     test $(git rev-parse HEAD^2) = $(git rev-parse keep-merge)

So, perhaps we could introduce a generic function like:

    # Compares that the output of $1 eval'ed is identical to $2.
    test_output () {
        output=$(eval $1)
        if "$output" != "$2"
        then
             echo >&2 "Output of '$1' ('$output') != '$2'"
             false
        fi
    }

So the first example would be:

    test_output "git show HEAD:file2" new

And the error output will thus be:

     Output of 'git show HEAD:file2' ('some unexpected output') != 'new'

So we know the exact comparison that failed, and we know how the
expected and actual output differs.

What do you think?

Thanks,
Paul
