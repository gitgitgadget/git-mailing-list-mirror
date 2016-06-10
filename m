From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/2] bisect--helper: `is_expected_rev` shell function in C
Date: Fri, 10 Jun 2016 15:14:13 -0400
Message-ID: <CAPig+cTECf6JT6+1SWo-eEwKPOAN3eYL20tvFS90Q28gu5vrZw@mail.gmail.com>
References: <20160608152415.7770-1-pranit.bauva@gmail.com> <CAPig+cRC_y9MBSsrLEs0OxL4=FMfU-=ACwhESUiECrWrDNvaCw@mail.gmail.com>
 <CAFZEwPOhssmTt6TLPhxjzru+B3sWgXWh71yRt9BOvLqc0imq-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Lars Schneider <larsxschneider@gmail.com>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 10 21:14:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBRss-0002vQ-HQ
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 21:14:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752040AbcFJTOP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2016 15:14:15 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:34200 "EHLO
	mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751440AbcFJTOO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2016 15:14:14 -0400
Received: by mail-it0-f65.google.com with SMTP id d71so465071ith.1
        for <git@vger.kernel.org>; Fri, 10 Jun 2016 12:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=W+pvHjI1dW62jQVHLHT/ZwUcL0XUfVj354N6ez7sM6w=;
        b=oYNsUIig+06x/xSomyiAU8Yz0/uQEWeOynOuG6zESSNEneM+Hcr51Suijyv0fnAoLk
         dsS4ZuPkX3Sl7JjVc9ggffHSAt/HfGvHEX18iHw9iCyd+BeuHKc5y3pGg5gX4/zXSOBP
         hiNFwrXO3Pn7v4IU/7aqkZrhnA6pejRpUs40TFIj4lvz5Hd21+lHdeL7uHSNXrYrkoi9
         q9SsOkIQutBc97jyc8a7PWKif/psgsEH7h5csII8/mNSHZg3O5wqpaMefrcT0FLrQp19
         XAhrPcXV82tXTA8elehem+4F91ySu0BRdQ0PALsEB7f5iio9kZRbIrWBrZv3kY7UAchS
         +BgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=W+pvHjI1dW62jQVHLHT/ZwUcL0XUfVj354N6ez7sM6w=;
        b=QBWPqeH35W6qLyrsxIXbbbHBVnADKFeQBzICEQ+usxDx7FiTMPSshcfgF/0qKKzzpB
         RQr3xRxB1Lt83dGg9e19dtjKM22nTdTPKWsoLRIR82TxxudKudJ2DjyOxUySE8QuLTMQ
         duHPCz92Zt9o8rDXivHb6lIvSJPQgLUBXbKkzkZ3LSBGDOSvuzusbaQeHWd06U0JPL08
         lksUDItyhUOnxPwsVlILDMy/Mi3YRNQRc4HS1AKf58D4jo9deJ6oOHLZaKppsf3rSMI6
         lPx9oYh55zkh+9PVBxBkHjaKu0dJF8E60z3iY7RaJa+aSXWzflgeWuEnKMa0bwf0wieF
         IdRQ==
X-Gm-Message-State: ALyK8tL9w7/tT8d2AGONKEtvb/R0MVT2FZAWhSL0qjvbb7cGfbYmggmtADBEDkF6BIjMtA+XQcHaWsCta3BpFw==
X-Received: by 10.36.55.15 with SMTP id r15mr1073440itr.73.1465586053487; Fri,
 10 Jun 2016 12:14:13 -0700 (PDT)
Received: by 10.79.0.30 with HTTP; Fri, 10 Jun 2016 12:14:13 -0700 (PDT)
In-Reply-To: <CAFZEwPOhssmTt6TLPhxjzru+B3sWgXWh71yRt9BOvLqc0imq-g@mail.gmail.com>
X-Google-Sender-Auth: SQ91WvrysC6c1HxbiQ2EiinzQiw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297019>

On Fri, Jun 10, 2016 at 9:39 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
> On Fri, Jun 10, 2016 at 3:03 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Wed, Jun 8, 2016 at 11:24 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>>> Reimplement `is_expected_rev` shell function in C. This will further be
>>> called from `check_expected_revs` function. This is a quite small
>>> function thus subcommand facility is redundant.
>>
>> This patch should be squashed into patch 2/2, as it is otherwise
>> pointless without that patch, and merely adds dead code.
>
> Sure I will squash and will explain it in the commit message.

Explain what in the commit message? If anything, I'd expect the commit
message to shrink since you won't need to explain anymore that this
function is split out.

>>> +       if (!file_exists(git_path_bisect_expected_rev()))
>>> +               return 0;
>>
>> Invoking file_exists() seems unnecessarily redundant when you can
>> discern effectively the same by checking the return value of
>> strbuf_read_file() below. I'd drop the file_exists() check altogether.
>
> I wanted to imitate the code. But I guess it would actually be better
> if I drop this file_exists().

There is a bit of a lesson to be learned by this example. While it's
true that the C conversion should retain the behavior of the original
shell code, that does not mean blindly mirroring the implementation
line for line is a good idea. A couple things to take into
consideration:

There are idiomatic ways of doing things in each language. What is
idiomatic in shell is not necessarily so in C. The C conversion should
employ C idioms and flow in a way which is natural for C code.

Consider what the original shell code is doing at a higher level than
merely by reading it line-by-line. In the case in question, the code
is:

    test -f "$GIT_DIR/BISECT_EXPECTED_REV" &&
    test "$1" = $(cat "$GIT_DIR/BISECT_EXPECTED_REV")

While it's true that it's asking "does the file exist and is its value
the same as $1", the 'test -f' avoids a "file not found" error from
the $(cat ...) invocation. Since the return value of
strbuf_read_file() effectively encapsulates the "does the file exist"
check, a separate check isn't really needed.

>>> +       if (!strbuf_read_file(&actual_hex, git_path_bisect_expected_rev(), 0))
>>> +               return 0;
>>
>> What exactly is this trying to do? Considering that strbuf_read_file()
>> returns -1 upon error, otherwise the number of bytes read, if I'm
>> reading this correctly, is_expected_rev() returns false if
>> strbuf_read_file() encounters an error (which is fine) but also when
>> it successfully reads the file and its content length is non-zero
>> (which is very odd).
>>
>>> +       strbuf_trim(&actual_hex);
>>> +       return !strcmp(actual_hex.buf, expected_hex);
>>
>> Thus, it only ever gets to this point if the file exists but is empty,
>> which is very unlikely to match 'expected_hex'. I could understand it
>> if you checked the result of strbuf_read_file() with <0 or even <=0,
>> but the current code doesn't make sense to me.
>>
>> Am I misunderstanding?
>
> Definitely not. Thanks for pointing it out. :) It went off my head
> that strbuf_read_file returns the bytes it reads. Also the code
> comment regarding strbuf_read_file does not mention it which probably
> misguided me. I should also send a fixing patch so that someone else
> does not fall into this like I did.

Out of curiosity, did the test suite pass with this patch applied?
This is such an egregious bug that it's hard to imagine the tests
passing, but if they did, then that may be a good indication that
coverage is too sparse and ought to be improved.
