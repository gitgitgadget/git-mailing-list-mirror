From: Per Cederqvist <cederp@opera.com>
Subject: Re: [GUILT 07/28] Added test cases for "guilt fold".
Date: Wed, 7 May 2014 22:59:56 +0200
Message-ID: <CAP=KgsQ2fvVWZG7OwwWac+tMeWaPTEdSrgFqE5gVfSAqNn-VCQ@mail.gmail.com>
References: <1395387126-13681-1-git-send-email-cederp@opera.com>
	<1395387126-13681-8-git-send-email-cederp@opera.com>
	<20140506194026.GK1655@meili.valhalla.31bits.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Wed May 07 23:00:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wi8we-0003B3-M3
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 23:00:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751458AbaEGU77 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2014 16:59:59 -0400
Received: from mail-ie0-f173.google.com ([209.85.223.173]:62991 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751054AbaEGU76 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2014 16:59:58 -0400
Received: by mail-ie0-f173.google.com with SMTP id rp18so1652607iec.4
        for <git@vger.kernel.org>; Wed, 07 May 2014 13:59:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=QrQ/Az+n1SJDfPpO6d/c22XCuuNyycRq9k4GOy4Sc5M=;
        b=c2YvV/IgNWVYH4COoHnwmpKC0+YR271GZAknckwoPcyq7E8WnAX/M/yoDF2TbeaQaB
         muqwfgwL+uL+2sZQybr/JLvzEN/tyG/n+PQ7EgnF0OOfO25cSXCuhnpSZws8O9iUbrDb
         gLeG1R0TO84Al58ASeOeBv8nVRrzobj8cVuZSbQWToDBrncXEXzGWpgfex7K5SuGeCQh
         5gxzCTf3KWD+CfMtoL+8X+wFx9TQUSK5dLJCluPtZe8+um0qQ2m/g4GZHbz3YZDjksNz
         H3leK1v3psawG+Nej4dlx8UpIDl+keNoBEr7XUi6RHSPZ3bDQcmptC/fzL8KGrl9q9Fn
         S+4A==
X-Gm-Message-State: ALoCoQkGf0pUa4AhYsjIx85obG0x4xVUmvYQbw+3DIEeX0MY+MXNXQKBe8jS7BAVEiKKOZT8ylNH
X-Received: by 10.50.78.164 with SMTP id c4mr348831igx.41.1399496396962; Wed,
 07 May 2014 13:59:56 -0700 (PDT)
Received: by 10.43.89.66 with HTTP; Wed, 7 May 2014 13:59:56 -0700 (PDT)
In-Reply-To: <20140506194026.GK1655@meili.valhalla.31bits.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248376>

On Tue, May 6, 2014 at 9:40 PM, Jeff Sipek <jeffpc@josefsipek.net> wrote:
> On Fri, Mar 21, 2014 at 08:31:45AM +0100, Per Cederqvist wrote:
>> Test that we can combine any combination of patches with empty and
>> non-empty messages, both with and without guilt.diffstat.  (All
>> patches are empty.)
>
> I feel like we should have *some* content there - most of the time, I care
> more about the diffs getting folded than the commit message :)

I added these tests for a reason: the reproduce a bug in guilt that I found.

I'm afraid that having some content might hide the bug I found. (I'm also
equally afraid that it might uncover other bugs in guilt, which would delay
integration of this patch series. So adding more test cases with content
is a good thing to do, but maybe not in this patch series.)

>> Signed-off-by: Per Cederqvist <cederp@opera.com>
>> ---
>>  regression/t-035.out | 659 +++++++++++++++++++++++++++++++++++++++++++++++++++
>>  regression/t-035.sh  |  88 +++++++
>>  2 files changed, 747 insertions(+)
>>  create mode 100644 regression/t-035.out
>>  create mode 100755 regression/t-035.sh
>>
>> diff --git a/regression/t-035.out b/regression/t-035.out
>> new file mode 100644
>> index 0000000..04af146
>> --- /dev/null
>> +++ b/regression/t-035.out
>> @@ -0,0 +1,659 @@
>> +% setup_repo
>> +% git config guilt.diffstat true
>> +%% empty + empty (diffstat=true)
>> +% guilt new empty-1
>> +% guilt pop
>> +All patches popped.
>> +% guilt push
>> +Applying patch..empty-1
>> +Patch applied.
>> +% guilt new empty-2
>> +% guilt pop
>> +Now at empty-1.
>> +% guilt push
>> +Applying patch..empty-2
>> +Patch applied.
>> +% guilt pop
>> +Now at empty-1.
>> +% guilt fold empty-2
>> +% guilt pop
>> +All patches popped.
>> +% guilt push
>> +Applying patch..empty-1
>> +Patch applied.
>> +% list_files
>> +d .git/patches
>> +d .git/patches/master
>> +d .git/refs/patches
>> +d .git/refs/patches/master
>> +f 22930c6d1f1938f298a4fca51c57e4b47171db21  .git/patches/master/mode
>> +f 413390f3906f16f30b054a4fb86c1e014b964504  .git/patches/master/remove
>> +f 4ea806e306f0228a8ef41f186035e7b04097f1f2  .git/patches/master/status
>> +f 7d261b8caad0f161c21daf5de65eeb521ff8c067  .git/patches/master/empty-1
>> +f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/patches/master/add
>> +f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
>> +f d28d87b88c1e24d637e390dc3603cfa7c1715711  .git/patches/master/series
>> +f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/empty-1~
>> +f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/empty-2~
>> +r bde3d337af70f36836ad606c800d194006f883b3  .git/refs/patches/master/empty-1
>> +% git log -p
>
> Strictly speaking, git log isn't necessary since list_files prints the
> hashes of each of the files as well as the refs for all the applied patches.
> If anything mismatches, the hashes will catch it.  I'm ok with keeping the
> git log here as long as people can't mess up the formatting with git
> config/etc.

Having the patches included was very helpful while I developed the
test case, but your concern about messing up the formatting is valid.
I'll remove them.

> ...
>> diff --git a/regression/t-035.sh b/regression/t-035.sh
>> new file mode 100755
>> index 0000000..aed3ef2
>> --- /dev/null
>> +++ b/regression/t-035.sh
>> @@ -0,0 +1,88 @@
>> +#!/bin/bash
>> +#
>> +# Test the fold code
>> +#
>> +
>> +source "$REG_DIR/scaffold"
>> +
>> +cmd setup_repo
>> +
>> +function fixup_time_info
>> +{
>> +     cmd guilt pop
>> +     touch -a -m -t "$TOUCH_DATE" ".git/patches/master/$1"
>> +     cmd guilt push
>> +}
>> +
>> +function test_fold
>> +{
>> +    using_diffstat=$1
>> +
>> +    cmd git config guilt.diffstat $using_diffstat
>> +
>> +    # Empty message + empty message = empty message.
>> +    echo "%% empty + empty (diffstat=$using_diffstat)"
>> +    cmd guilt new empty-1
>> +    fixup_time_info empty-1
>> +    cmd guilt new empty-2
>> +    fixup_time_info empty-2
>> +    cmd guilt pop
>> +    cmd guilt fold empty-2
>> +    fixup_time_info empty-1
>> +    cmd list_files
>> +    cmd git log -p
>> +    cmd guilt pop
>> +    cmd guilt delete -f empty-1
>> +    cmd list_files
>> +
>> +    # Empty message + non-empty message
>> +    echo "%% empty + non-empty (diffstat=$using_diffstat)"
>> +    cmd guilt new empty
>> +    fixup_time_info empty
>> +    cmd echo test > a
>
> I see these redirected echos... what are they for?

The intent was to create files with some content. I was under
the impression that the "guilt new" on the next line would
include the file, since I use the -f option. Now I see that
that is not the case, and I will remove these lines.

>> +    cmd guilt new -f -s -m "A commit message." non-empty
>> +    fixup_time_info non-empty
>> +    cmd guilt pop
>> +    cmd guilt fold non-empty
>> +    fixup_time_info empty
>> +    cmd list_files
>> +    cmd git log -p
>> +    cmd guilt pop
>> +    cmd guilt delete -f empty
>> +    cmd list_files
>
> Maybe make two helper functions.. one to make a patch with an empty message
> and one to make a patch with a non-empty message.  Then each of these blocks
> would look a bit cleaner.
>
>         echo "%% empty + non-empty (diffstat=$using_diffstat)"
>         empty_patch empty
>         nonempty_patch non-empty
>         cmd guilt pop non-empty
>         cmd guilt fold non-empty
>         fixup_time_info empty
>         cmd list_files
>         cleanup empty
>         cmd list_files
>
> cleanup()
> {
>         guilt pop $1
>         guilt delete -f $1
> }
>
> Eh, it's not as clean as I thought it would be, but I think it's still a
> bit better.  Ok, how about:
>
> for using_diffstat in true false ; do
>         for patcha in empty nonempty ; do
>                 for patchb in empty nonempty ; do
>                         echo "%% $patcha + $patchb (diffstat=$using_diffstat)"
>                         ${patcha}_patch $patcha
>                         ${patchb}_patch $patchb
>                         cmd guilt pop $patchb
>                         cmd guilt fold $patchb
>                         fixup_time_info $patcha
>                         cmd list_files
>                         cleanup $patcha
>                         cmd list_files
>                 done
>         done
> done
>
> Aha!  That's better, IMO.

I'll try that and post a version 2 of the series. It might take a few
days, though.

> Adding the non-empty diff is a matter of another loop, but I'm ok with just
> testing the headers (for now) :)
>
> Jeff.
>
    /ceder
