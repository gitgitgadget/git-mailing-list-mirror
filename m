From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] clone: add `--shallow-submodules` flag
Date: Mon, 25 Apr 2016 14:25:32 -0700
Message-ID: <CAGZ79kbPcefodLd4Jt4tvJJmHZXJGe-AMEgzREWZiUvNeciFSQ@mail.gmail.com>
References: <1461609054-17118-1-git-send-email-sbeller@google.com>
	<xmqqd1pdjt7m.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jacob Keller <jacob.keller@gmail.com>,
	Lars Schneider <larsxschneider@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 25 23:25:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auo0j-00029F-Oh
	for gcvg-git-2@plane.gmane.org; Mon, 25 Apr 2016 23:25:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965015AbcDYVZf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2016 17:25:35 -0400
Received: from mail-io0-f181.google.com ([209.85.223.181]:36830 "EHLO
	mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964906AbcDYVZe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2016 17:25:34 -0400
Received: by mail-io0-f181.google.com with SMTP id u185so198167559iod.3
        for <git@vger.kernel.org>; Mon, 25 Apr 2016 14:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=0y2uxPuwpXsMRmbWjaTrsW0/tbzdAoWHD5+BBAXiVuE=;
        b=Oln+lE389hD5WEtecu7SMvNV2boPhr+u0UaUD/az0Lm35ViEbNcpP4TGr8QJFgS+W6
         4Lfxr4hC3GRhYwUcJq0hRIM1MWoy3VjH1DN6YckQcAsCt2tRfetCf3MyW5LO71wiqxeD
         evGMMcqvRqFPP9S+JCJiIbHAQWRcneYfRhMKy4NEe8wemJtJyr0zetaANVmmeIU4z5sZ
         GQKklyrInP3Nt2W6TLgXFI5d7q+YMo2gqSDdrlb2yz8uuJo2hf2isl+dxMp22GZykjAg
         tJMIUi7ZvOg5mCkauycjG7TN6zVoO4gAD5El8WxcVxNiRgXNpc4cF3Bh2tSd/UnY3Tlj
         uJFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=0y2uxPuwpXsMRmbWjaTrsW0/tbzdAoWHD5+BBAXiVuE=;
        b=PLb7ELWr2xz0JXBHROV9rZhkam5BAwPeqm0tOTx+T5a5ksRYy0lzL2Lro7jR7zc7Qc
         pMTnA7FDO2jNTGG/7NIRpmvLMF1Ndwn/AlgZxBzzjlQpzlziDFA6cARbTs4J6csVb4im
         fxweA4kBDHR1utYvPNlziHFNxwcyWg0qM1mlOmMyYDRsr+n9kWVYnKzJ4J9MyLFZvAU+
         vgcPRqsjsQdNpyO7U/MTMTF62Kp9MpK3dh9pl0wMoLwY/wbhLdAhVse7e8cPoxpGKfag
         eFsKWSY1UKuTX8V9jtmrrwEJSFT5DThP8B7zAYh8z+hhx3e4/PF0Ro8lRM4TcIfio76X
         StgA==
X-Gm-Message-State: AOPr4FXE/gyCa4gXUr2QlNO5Dffrz+8IUxl7oFs/1BJ8pDnRJrf4nyNJABH3k3/+9jFYiMbA58kYdI/RtligaPGl
X-Received: by 10.107.174.205 with SMTP id n74mr14022664ioo.96.1461619532741;
 Mon, 25 Apr 2016 14:25:32 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Mon, 25 Apr 2016 14:25:32 -0700 (PDT)
In-Reply-To: <xmqqd1pdjt7m.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292564>

On Mon, Apr 25, 2016 at 2:04 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>>   This replaces origin/sb/clone-shallow-passthru.
>> @@ -190,7 +190,11 @@ objects from the source repository into a pack in the cloned repository.
>>
>>  --depth <depth>::
>>       Create a 'shallow' clone with a history truncated to the
>> -     specified number of revisions.
>> +     specified number of revisions. Implies `--single-branch` unless
>> +     `--no-single-branch` is given to fetch the histories near the
>> +     tips of all branches. This implies `--shallow-submodules`. If
>> +     you want to have a shallow superproject clone, but full submodules,
>> +     also pass `--no-shallow-submodules`.
>
> This is not wrong per-se but the early half of the new text seems to
> come from 28a1b569 (docs: clarify that passing --depth to git-clone
> implies --single-branch, 2016-01-06), which was merged to 'master'
> some time ago.
>
> I've resolved the conflicts coming from the duplicates, so no need
> to resend, but the resulting history would become misleading.  I am
> undecided if I should rebasing this on top of 85705cfb (Merge branch
> 'ss/clone-depth-single-doc', 2016-01-20) or later.

I could reroll with another variable name on top of 85705cfb?

>
>> diff --git a/t/t5614-clone-submodules.sh b/t/t5614-clone-submodules.sh
>> new file mode 100755
>> index 0000000..825f511
>> --- /dev/null
>> +++ b/t/t5614-clone-submodules.sh
>> @@ -0,0 +1,85 @@
>> +#!/bin/sh
>> +
>> +test_description='Test shallow cloning of repos with submodules'
>> +
>> +. ./test-lib.sh
>> +
>> +p=$(pwd)
>
> A single-letter lower-case global that needs to stay constant for
> the entire file looks like a ticking time bomb screaming to be
> broken by future updates.

I agree. How about `currentdir`, `testdir` or `testtop` instead?
That is slightly longer than `D`, `here` or `top`, but is slightly more
informative. $TRASH would also work for me.

Talking about time bombs: I see there are many tests in single files
(e.g. 7412 has ~80 tests IIRC and adding a test in there I often spend
more time figuring out the current state of the testing directory rather than
writing the test.

So I'd rather see more testing files with fewer tests rather than a few
files with all the tests for one topic. (e.g. these tests could have gone
into the clone tests, or the basic submodule tests, but instead I chose
a new file to test this.)


> I see $D used for this purpose in many
> scripts, $here and $top in some, and $TRASH in yet some others.
> Perhaps $D may be more appropriate if we wanted to keep this
> ultra-short-and-cryptic while mimicking existing ones.

I was not keen on being ultrashort, rather I was toying around
to drop the patch introducing the --no-local option.

>
>> +test_expect_success 'setup' '
>> +     git checkout -b master &&
>> +     test_commit commit1 &&
>> +     test_commit commit2 &&
>> +     mkdir sub &&
>> +     (
>> +             cd sub &&
>> +             git init &&
>> +             test_commit subcommit1 &&
>> +             test_commit subcommit2 &&
>> +             test_commit subcommit3
>> +     ) &&
>> +     git submodule add "file://$p/sub" sub &&
>> +     git commit -m "add submodule"
>> +'
>> +
>> +test_expect_success 'nonshallow clone implies nonshallow submodule' '
>> +     test_when_finished "rm -rf super_clone" &&
>> +     git clone --recurse-submodules "file://$p/." super_clone &&
>> +     (
>> +             cd super_clone &&
>> +             git log --oneline >lines &&
>> +             test_line_count = 3 lines
>> +     ) &&
>> +     (
>> +             cd super_clone/sub &&
>> +             git log --oneline >lines &&
>> +             test_line_count = 3 lines
>> +     )
>> +'
>> +
>> +test_expect_success 'shallow clone implies shallow submodule' '
>> +     test_when_finished "rm -rf super_clone" &&
>> +     git clone --recurse-submodules --depth 2 "file://$p/." super_clone &&
>> +     (
>> +             cd super_clone &&
>> +             git log --oneline >lines &&
>> +             test_line_count = 2 lines
>> +     ) &&
>> +     (
>> +             cd super_clone/sub &&
>> +             git log --oneline >lines &&
>> +             test_line_count = 1 lines
>> +     )
>> +'
>> +
>> +test_expect_success 'shallow clone with non shallow submodule' '
>> +     test_when_finished "rm -rf super_clone" &&
>> +     git clone --recurse-submodules --depth 2 --no-shallow-submodules "file://$p/." super_clone &&
>> +     (
>> +             cd super_clone &&
>> +             git log --oneline >lines &&
>> +             test_line_count = 2 lines
>> +     ) &&
>> +     (
>> +             cd super_clone/sub &&
>> +             git log --oneline >lines &&
>> +             test_line_count = 3 lines
>> +     )
>> +'
>> +
>> +test_expect_success 'non shallow clone with shallow submodule' '
>> +     test_when_finished "rm -rf super_clone" &&
>> +     git clone --recurse-submodules --no-local --shallow-submodules "file://$p/." super_clone &&
>> +     (
>> +             cd super_clone &&
>> +             git log --oneline >lines &&
>> +             test_line_count = 3 lines
>> +     ) &&
>> +     (
>> +             cd super_clone/sub &&
>> +             git log --oneline >lines &&
>> +             test_line_count = 1 lines
>> +     )
>> +'
>> +
>> +test_done
