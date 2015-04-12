From: =?UTF-8?Q?erik_elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
Subject: Re: [PATCH v2 2/3] p7300: add performance tests for clean
Date: Sun, 12 Apr 2015 17:31:49 +0200
Message-ID: <CAMpP7NZyHBMZ5omT+fPGfkRR56HQPNP3n6cXD7S8voVvqrG6eg@mail.gmail.com>
References: <1428770587-9674-1-git-send-email-erik.elfstrom@gmail.com>
	<1428770587-9674-4-git-send-email-erik.elfstrom@gmail.com>
	<20150411175941.GA32735@hank>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 12 17:32:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YhJrZ-0008JV-S9
	for gcvg-git-2@plane.gmane.org; Sun, 12 Apr 2015 17:31:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751354AbbDLPbv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 12 Apr 2015 11:31:51 -0400
Received: from mail-qk0-f172.google.com ([209.85.220.172]:36117 "EHLO
	mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751314AbbDLPbu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Apr 2015 11:31:50 -0400
Received: by qku63 with SMTP id 63so130947566qku.3
        for <git@vger.kernel.org>; Sun, 12 Apr 2015 08:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=CAWX0EAwoAc8b049bIyZ9Md6SMeJik4xuM5AE9qtiko=;
        b=YOwgdK/Mp8cvP6kcVCsanR12VEd/ubqf0qjgPMkXy0+QjbsVL6i5RB5p6BANbM0ZTs
         8eqs7I6pRDKE/sX8UiURYxCZuDXcnvFhcC26m6pF6NXPQSR7plO6j6FTqohn81FxlF+y
         7k+XZC1ELunTMI/qM2zgjLEEO8fhOZVhX/0bBzckbo6Ua0cEUst6vprWh7z8YEK4zjpV
         wB4mZHF7K/4UN42TpS72kII+mENjynF4LdDCNowbnApDFRzeTMoiGCjOjePu9FDB2OGZ
         a9jsDUbbgoe5BmnaVS4+QuWV/2gjt6nKkASqR7KT1S7uEvsZfrD8juI+qp1v+/6AURhd
         6VLw==
X-Received: by 10.182.72.225 with SMTP id g1mr9314309obv.80.1428852709762;
 Sun, 12 Apr 2015 08:31:49 -0700 (PDT)
Received: by 10.182.154.72 with HTTP; Sun, 12 Apr 2015 08:31:49 -0700 (PDT)
In-Reply-To: <20150411175941.GA32735@hank>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267051>

On Sat, Apr 11, 2015 at 7:59 PM, Thomas Gummerer <t.gummerer@gmail.com>=
 wrote:
> On 04/11, Erik Elfstr=C3=B6m wrote:
>> Signed-off-by: Erik Elfstr=C3=B6m <erik.elfstrom@gmail.com>
>> ---
>>  t/perf/p7300-clean.sh | 37 +++++++++++++++++++++++++++++++++++++
>>  1 file changed, 37 insertions(+)
>>  create mode 100755 t/perf/p7300-clean.sh
>>
>> diff --git a/t/perf/p7300-clean.sh b/t/perf/p7300-clean.sh
>> new file mode 100755
>> index 0000000..af50d5d
>> --- /dev/null
>> +++ b/t/perf/p7300-clean.sh
>> @@ -0,0 +1,37 @@
>> +#!/bin/sh
>> +
>> +test_description=3D"Test git-clean performance"
>> +
>> +. ./perf-lib.sh
>> +
>> +test_perf_large_repo
>> +test_checkout_worktree
>> +
>> +test_expect_success 'setup untracked directory with many sub dirs' =
'
>> +     rm -rf 500_sub_dirs 50000_sub_dirs clean_test_dir &&
>> +     mkdir 500_sub_dirs 50000_sub_dirs clean_test_dir &&
>> +     for i in $(test_seq 1 500)
>> +     do
>> +             mkdir 500_sub_dirs/dir$i || return $?
>> +     done &&
>> +     for i in $(test_seq 1 100)
>> +     do
>> +             cp -r 500_sub_dirs 50000_sub_dirs/dir$i || return $?
>> +     done
>> +'
>> +
>> +test_perf 'clean many untracked sub dirs, check for nested git' '
>> +     rm -rf clean_test_dir/50000_sub_dirs_cpy &&
>> +     cp -r 50000_sub_dirs clean_test_dir/50000_sub_dirs_cpy &&
>
> Maybe this would be a good place to use test_perf_cleanup, which I
> introduced a while ago and you can find in the
> tg/perf-lib-test-perf-cleanup branch?  It probably won't influence th=
e
> performance a lot, but still better separate the code that actually
> needs to be tested from the cleanup/preparation code.  Ditto in the
> other test.
>

Yes, that would be a clear improvement. I was looking for something lik=
e
this, the copy takes more time than the clean currently.

The cleanup hook is maybe not exactly the right fit here though. I woul=
d
need to do one initial copy in the setup test and then a copy in the
cleanup, something like this:

test_expect_success 'setup untracked directory with many sub dirs' '
    ...
    cp -r 50000_sub_dirs clean_test_dir/50000_sub_dirs_cpy
'

test_perf_cleanup 'clean many untracked sub dirs, check for nested git'=
 '
    git clean -q -f -d  clean_test_dir/
' '
    test_dir_is_empty clean_test_dir &&
    rm -rf clean_test_dir/50000_sub_dirs_cpy &&
    cp -r 50000_sub_dirs clean_test_dir/50000_sub_dirs_cpy
'

This works better than my original code but maybe we can do even better
with something like:

test_setup_perf_cleanup 'clean many untracked sub dirs, check for neste=
d git' '
    rm -rf clean_test_dir/50000_sub_dirs_cpy &&
    cp -r 50000_sub_dirs clean_test_dir/50000_sub_dirs_cpy
' '
    git clean -q -f -d  clean_test_dir/
' '
    test_dir_is_empty clean_test_dir
'

Having a setup phase avoids the initial copy in the setup test making
things a little easier to follow. I'm not sure its worth the extra comp=
lexity
in perf-lib though (and I'm not sure I would be able to implement it ei=
ther).

Also, what would the implications be if I were to use your new cleanup
function that is not yet on master? Should I rebase on top of your topi=
c
or make a follow up patch to switch over?

>> +     git clean -q -f -d  clean_test_dir/ &&
>> +     test_dir_is_empty clean_test_dir
>> +'
>> +
>> +test_perf 'clean many untracked sub dirs, ignore nested git' '
>> +     rm -rf clean_test_dir/50000_sub_dirs_cpy &&
>> +     cp -r 50000_sub_dirs clean_test_dir/50000_sub_dirs_cpy &&
>> +     git clean -q -f -f -d  clean_test_dir/ &&
>> +     test_dir_is_empty clean_test_dir
>> +'
>> +
>> +test_done
>> --
>> 2.4.0.rc0.37.ga3b75b3
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
