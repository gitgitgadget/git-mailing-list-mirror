From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH 1/2] bisect--helper: `is_expected_rev` shell function in C
Date: Sat, 11 Jun 2016 17:48:06 +0530
Message-ID: <CAFZEwPMqwtw061O0QVRGf+dqpxKjp1jRvFE5CUEayEiUhxWveQ@mail.gmail.com>
References: <20160608152415.7770-1-pranit.bauva@gmail.com> <CAPig+cRC_y9MBSsrLEs0OxL4=FMfU-=ACwhESUiECrWrDNvaCw@mail.gmail.com>
 <CAFZEwPOhssmTt6TLPhxjzru+B3sWgXWh71yRt9BOvLqc0imq-g@mail.gmail.com> <CAPig+cTECf6JT6+1SWo-eEwKPOAN3eYL20tvFS90Q28gu5vrZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Lars Schneider <larsxschneider@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sat Jun 11 14:18:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBhri-0005oE-EO
	for gcvg-git-2@plane.gmane.org; Sat, 11 Jun 2016 14:18:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751395AbcFKMSK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Jun 2016 08:18:10 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:33508 "EHLO
	mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751173AbcFKMSI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Jun 2016 08:18:08 -0400
Received: by mail-yw0-f195.google.com with SMTP id y6so11352122ywe.0
        for <git@vger.kernel.org>; Sat, 11 Jun 2016 05:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=nK4Ig/QysJGFJf8kZR5yKjtKlW4UVxvrx/2gsyWDmSs=;
        b=JV6uItrPPjqjFCfZrFBA4mEZxJ4KcugK3jaZRoU+Tsh/7/yrZpPObfYgwIGv2cEV7E
         Ft6iPMQNF1QQgMoIz4+jCHQv8wyYQTuMMhaTlt7YaUvtLLoJBhhLCcVZoEF5dJWd2yYl
         Bb7Q19zsOt5EGSPvef3GMAz4AOcO9q2qxdBgvfrzsmVl3jtsmfiOFtqjy/vIqZ+yk79A
         HEMZNxfyMYAtio2yGSks1vqKYWQq5oLFIqnE/X9PbBcgCh2F+b5cEzJxQXyoFE6lW++K
         GWzzc6J2O8LGFAh4vuUaHYGVmAduI+rnRJXaRYDD1sPnZwfeHsNZr2PBs3HnJcTqNBTO
         /D0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=nK4Ig/QysJGFJf8kZR5yKjtKlW4UVxvrx/2gsyWDmSs=;
        b=FBpRn4vRfUjzgzT86ujNJb7eJbyDyFfFHZ4lq6vV+0g+3EGCLydLzd83BWl5Lx6BtH
         NSay6zoAvfS3/mkk+oXCnQ4joLQ6JiCsYphv/5XLhm7uQggoUNfRme8/pVyWEnFF7zPJ
         DQfbO4zrOG2uYzcsZmDyaJbBhzG+mtxKzP/lJ6y7Xz/7Comfd7fzzwYkEjhzloNE0iwq
         /uzDjJ2zwf2yHX/evxPTKTjNsIomuOzGlOvyNsYdtZT9PZRCSnvaDYJ7yndN7TsuvrH6
         232LIFiBHvWWRM6M00Ett2bG4qfICoMw7vSIWZQ0/+NMmuubOVJ8oNw3jcxKwZx9U1gd
         7Rgg==
X-Gm-Message-State: ALyK8tL1vbYUFKXyOVGfqxdii6PVedd4Z8OtXhNp13cZvCf1BKj0eRVCjmnbwCuTTv56zuUZrBmeZd4frr5AKQ==
X-Received: by 10.129.81.144 with SMTP id f138mr3384006ywb.154.1465647487072;
 Sat, 11 Jun 2016 05:18:07 -0700 (PDT)
Received: by 10.129.124.132 with HTTP; Sat, 11 Jun 2016 05:18:06 -0700 (PDT)
In-Reply-To: <CAPig+cTECf6JT6+1SWo-eEwKPOAN3eYL20tvFS90Q28gu5vrZw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297096>

Hey Eric,

On Sat, Jun 11, 2016 at 12:44 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Fri, Jun 10, 2016 at 9:39 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>> On Fri, Jun 10, 2016 at 3:03 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>> On Wed, Jun 8, 2016 at 11:24 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>>>> Reimplement `is_expected_rev` shell function in C. This will further be
>>>> called from `check_expected_revs` function. This is a quite small
>>>> function thus subcommand facility is redundant.
>>>
>>> This patch should be squashed into patch 2/2, as it is otherwise
>>> pointless without that patch, and merely adds dead code.
>>
>> Sure I will squash and will explain it in the commit message.
>
> Explain what in the commit message? If anything, I'd expect the commit
> message to shrink since you won't need to explain anymore that this
> function is split out.

Yes I would remove the part where it is explained that this function
is split out. I will just explain that 2 functions are converted in 1
commit.

>>>> +       if (!file_exists(git_path_bisect_expected_rev()))
>>>> +               return 0;
>>>
>>> Invoking file_exists() seems unnecessarily redundant when you can
>>> discern effectively the same by checking the return value of
>>> strbuf_read_file() below. I'd drop the file_exists() check altogether.
>>
>> I wanted to imitate the code. But I guess it would actually be better
>> if I drop this file_exists().
>
> There is a bit of a lesson to be learned by this example. While it's
> true that the C conversion should retain the behavior of the original
> shell code, that does not mean blindly mirroring the implementation
> line for line is a good idea. A couple things to take into
> consideration:
>
> There are idiomatic ways of doing things in each language. What is
> idiomatic in shell is not necessarily so in C. The C conversion should
> employ C idioms and flow in a way which is natural for C code.
>
> Consider what the original shell code is doing at a higher level than
> merely by reading it line-by-line. In the case in question, the code
> is:
>
>     test -f "$GIT_DIR/BISECT_EXPECTED_REV" &&
>     test "$1" = $(cat "$GIT_DIR/BISECT_EXPECTED_REV")
>
> While it's true that it's asking "does the file exist and is its value
> the same as $1", the 'test -f' avoids a "file not found" error from
> the $(cat ...) invocation. Since the return value of
> strbuf_read_file() effectively encapsulates the "does the file exist"
> check, a separate check isn't really needed.

True. I will keep this in mind.

>>>> +       if (!strbuf_read_file(&actual_hex, git_path_bisect_expected_rev(), 0))
>>>> +               return 0;
>>>
>>> What exactly is this trying to do? Considering that strbuf_read_file()
>>> returns -1 upon error, otherwise the number of bytes read, if I'm
>>> reading this correctly, is_expected_rev() returns false if
>>> strbuf_read_file() encounters an error (which is fine) but also when
>>> it successfully reads the file and its content length is non-zero
>>> (which is very odd).
>>>
>>>> +       strbuf_trim(&actual_hex);
>>>> +       return !strcmp(actual_hex.buf, expected_hex);
>>>
>>> Thus, it only ever gets to this point if the file exists but is empty,
>>> which is very unlikely to match 'expected_hex'. I could understand it
>>> if you checked the result of strbuf_read_file() with <0 or even <=0,
>>> but the current code doesn't make sense to me.
>>>
>>> Am I misunderstanding?
>>
>> Definitely not. Thanks for pointing it out. :) It went off my head
>> that strbuf_read_file returns the bytes it reads. Also the code
>> comment regarding strbuf_read_file does not mention it which probably
>> misguided me. I should also send a fixing patch so that someone else
>> does not fall into this like I did.
>
> Out of curiosity, did the test suite pass with this patch applied?
> This is such an egregious bug that it's hard to imagine the tests
> passing, but if they did, then that may be a good indication that
> coverage is too sparse and ought to be improved.

Yes the test suite passed perfectly. I have inculcated the habit of
running the whole test suite before sending patches. Yes some parts of
a test suite seem to be missing. How about I do it in the end? By this
I won't have to setup yet another coverage tool for shell script. I
can use the coverage tool by GNU to test the coverage after bisect is
a C code. Till that time the patches can reside in the pu branch.

Regards,
Pranit Bauva
