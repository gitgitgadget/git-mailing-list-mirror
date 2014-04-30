From: Ilya Bobyr <ilya.bobyr@gmail.com>
Subject: Re: [PATCH 3/3] test-lib: '--run' to run only specific tests
Date: Wed, 30 Apr 2014 02:41:19 -0700
Message-ID: <5360C53F.5080909@gmail.com>
References: <1398154767-1276-1-git-send-email-ilya.bobyr@gmail.com>	<1398154767-1276-4-git-send-email-ilya.bobyr@gmail.com> <CAPig+cTK8i6rGYmum0m-wCmTUE4oqMVEdryiAt29vJXYdgSuYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Apr 30 11:41:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfR1F-0007yU-N5
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 11:41:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758481AbaD3Jld (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2014 05:41:33 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:46674 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751691AbaD3Jlc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2014 05:41:32 -0400
Received: by mail-ie0-f182.google.com with SMTP id tp5so1646559ieb.41
        for <git@vger.kernel.org>; Wed, 30 Apr 2014 02:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=Tugp0c8zRvkwxalWSe5aiAERSprux0MsJqMakDLcMWM=;
        b=JXin98ENHcGDsfRj8wdKJfxfS1H72Jd0WAnxfzjherJBzi148J1HfFUa8HiJA7Xhvx
         xeBnHrFv4XumvXRPItpKndbeJJX+GWCWaOxY8NAm7DUyEtuQEb1Esw31w0iADQh1AmRT
         /IMoghK1Uw1NuXYXIiW+ZkpRSnx8EKMVwovGDnQ3x8CiPXHzBeVhEyZkVEW9Czdrech/
         A8GdB4BxAAnZgoS/B7kbKsbzXyZBzcSMVzGicOlykN0tN+m2RRsAOEYfioqJXenGzkTK
         Jo8ffU7EpNyfg9YHbMSbNqjP3TZGSRAKPkQIUL5YbpiU89kKxx/0qqYVhi5fAwzzNVVr
         4PcA==
X-Received: by 10.50.33.74 with SMTP id p10mr36632540igi.5.1398850886948;
        Wed, 30 Apr 2014 02:41:26 -0700 (PDT)
Received: from [192.168.1.2] (c-50-136-172-14.hsd1.ca.comcast.net. [50.136.172.14])
        by mx.google.com with ESMTPSA id ie20sm4321823igb.10.2014.04.30.02.41.25
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Apr 2014 02:41:26 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:29.0) Gecko/20100101 Thunderbird/29.0
In-Reply-To: <CAPig+cTK8i6rGYmum0m-wCmTUE4oqMVEdryiAt29vJXYdgSuYQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247690>

On 4/23/2014 12:51 PM, Eric Sunshine wrote:
> On Tue, Apr 22, 2014 at 4:19 AM, Ilya Bobyr <ilya.bobyr@gmail.com> wrote:
>> Allow better control of the set of tests that will be executed for a
>> single test suite.  Mostly useful while debugging or developing as it
>> allows to focus on a specific test.
>>
>> Signed-off-by: Ilya Bobyr <ilya.bobyr@gmail.com>
>> ---
>> diff --git a/t/README b/t/README
>> index 6b93aca..2dac619 100644
>> --- a/t/README
>> +++ b/t/README
>> +As noted above, the test set is built going though items left to
>> +right, so this:
>> +
>> +    $ sh ./t9200-git-cvsexport-commit.sh --run='1-4 !3'
>> +
>> +will run tests 1, 2, and 4.
>> +
>> +You may use negation with ranges.  The following will run all
>> +test as a test suite except from 7 upto 11:
> s/upto/up to/
> ...or...
> s/upto/through/

Fixed.  Thanks.

>> +    $ sh ./t9200-git-cvsexport-commit.sh --run='!7-11'
>> +
>> +Some tests in a test suite rely on the previous tests performing
>> +certain actions, specifically some tests are designated as
>> +"setup" test, so you cannot _arbitrarily_ disable one test and
>> +expect the rest to function correctly.
>> +--run is mostly useful when you want to focus on a specific test
>> +and know what you are doing.  Or when you want to run up to a
>> +certain test.
>>
>>
>>  Naming Tests
>> diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
>> index ae8874e..e2589cc 100755
>> --- a/t/t0000-basic.sh
>> +++ b/t/t0000-basic.sh
>> @@ -84,6 +97,18 @@ check_sub_test_lib_test () {
>>         )
>>  }
>>
>> +check_sub_test_lib_test_err () {
>> +       name="$1" # stdin is the expected output output from the test
>> +       # expecte error output is in descriptor 3
> s/expecte/expected/

Fixed.

>> +       (
>> +               cd "$name" &&
>> +               sed -e 's/^> //' -e 's/Z$//' >expect.out &&
>> +               test_cmp expect.out out &&
>> +               sed -e 's/^> //' -e 's/Z$//' <&3 >expect.err &&
>> +               test_cmp expect.err err
>> +       )
>> +}
>> +
>>  test_expect_success 'pretend we have a fully passing test suite' "
>>         run_sub_test_lib_test full-pass '3 passing tests' <<-\\EOF &&
>>         for i in 1 2 3
>> @@ -333,6 +358,329 @@ test_expect_success 'GIT_SKIP_TESTS sh pattern' "
>> +test_expect_success '--run invalid range start' "
>> +       run_sub_test_lib_test_err run-inv-range-start \
>> +               '--run invalid range start' \
>> +               --run='a-5' <<-\\EOF &&
>> +       test_expect_success \"passing test #1\" 'true'
>> +       test_done
>> +       EOF
>> +       check_sub_test_lib_test_err run-inv-range-start \
>> +               <<-\\EOF_OUT 3<<-\\EOF_ERR
>> +       > FATAL: Unexpected exit with code 1
>> +       EOF_OUT
>> +       > error: --run: range start should contain only digits: 'a-5'
> This reads rather strangely, as if it's attempting to give an example
> (after the colon) of a valid digit range, but then shows something
> that is not valid. Rewording it slightly can eliminate the ambiguity:
>
>     error: --run: invalid non-numeric range start: 'a-5'

Changed.

>> +       EOF_ERR
>> +"
>> +
>> +test_expect_success '--run invalid range end' "
>> +       run_sub_test_lib_test_err run-inv-range-end \
>> +               '--run invalid range end' \
>> +               --run='1-z' <<-\\EOF &&
>> +       test_expect_success \"passing test #1\" 'true'
>> +       test_done
>> +       EOF
>> +       check_sub_test_lib_test_err run-inv-range-end \
>> +               <<-\\EOF_OUT 3<<-\\EOF_ERR
>> +       > FATAL: Unexpected exit with code 1
>> +       EOF_OUT
>> +       > error: --run: range end should contain only digits: '1-z'
> Ditto.

Fixed.

>> +       EOF_ERR
>> +"
>> +
>> +test_expect_success '--run invalid selector' "
>> +       run_sub_test_lib_test_err run-inv-selector \
>> +               '--run invalid selector' \
>> +               --run='1?' <<-\\EOF &&
>> +       test_expect_success \"passing test #1\" 'true'
>> +       test_done
>> +       EOF
>> +       check_sub_test_lib_test_err run-inv-selector \
>> +               <<-\\EOF_OUT 3<<-\\EOF_ERR
>> +       > FATAL: Unexpected exit with code 1
>> +       EOF_OUT
>> +       > error: --run: test selector should contain only digits: '1?'
> And here:
>
>     error: --run: invalid non-digit in range selector: '1?'
>
> or something.

Changed to "invalid non-digit in test selector".  This one is only shown
if it does not have a "-", so it is probably not a range.

>> +       EOF_ERR
>> +"
>> +
>> +
>>  test_set_prereq HAVEIT
>>  haveit=no
>>  test_expect_success HAVEIT 'test runs if prerequisite is satisfied' '
>> diff --git a/t/test-lib.sh b/t/test-lib.sh
>> index e7d9c51..46ba513 100644
>> --- a/t/test-lib.sh
>> +++ b/t/test-lib.sh
>> @@ -366,6 +374,100 @@ match_pattern_list () {
>>         return 1
>>  }
>>
>> +match_test_selector_list () {
>> +       title="$1"
>> +       shift
>> +       arg="$1"
>> +       shift
>> +       test -z "$1" && return 0
>> +
>> +       # Both commas and spaces are accepted as separators
>> +       OLDIFS=$IFS
>> +       IFS='   ,'
> The comment mentions only space and comma, but the actual assigned IFS
> value also treats tabs as separators. Perhaps update the comment to
> say "commas and whitespace".

I thought that tab is a space character =)  Changed it.

>> +       set -- $1
>> +       IFS=$OLDIFS
>> +
>> +       # If the first selector is negative we include by default.
>> +       include=
>> +       case "$1" in
>> +               !*) include=t ;;
>> +       esac
>> +
>> +       for selector
>> +       do
>> +               orig_selector=$selector
>> +
>> +
> Unnecessary extra blank line.

Thanks.

> [...]
>> +                               ;;
>> +                       *)
>> +                               if expr "z$selector" : "z[0-9]*[^0-9]" >/dev/null
>> +                               then
>> +                                       echo "error: $title: test selector should contain" \
>> +                                               "only digits: '$orig_selector'" >&2
>> +                                       exit 1
>> +                               fi
>> +               esac
>> +
>> +               # Short cut for "obvious" cases
>> +               test -z "$include" && test -z "$positive" && continue
>> +               test -n "$include" && test -n "$positive" && continue
>> +
>> +               case "$selector" in
>> +                       -*)
>> +                               if test $arg -le ${selector#-}
>> +                               then
>> +                                       include=$positive
>> +                               fi
>> +                               ;;
>> +                       *-)
>> +                               if test $arg -ge ${selector%-}
>> +                               then
>> +                                       include=$positive
>> +                               fi
>> +                               ;;
>> +                       *-*)
>> +                               if test ${selector%%-*} -le $arg \
>> +                                       -a $arg -le ${selector#*-}
> The -a option to 'test' is not portable [1] and is considered obsolete
> by POSIX [2]. Use "test foo && test bar" instead.
>
> [1]: http://www.gnu.org/software/autoconf/manual/autoconf.html#index-g_t_0040command_007btest_007d-1793
> [2]: http://pubs.opengroup.org/onlinepubs/9699919799/utilities/test.html

Did not know that.  Thanks.  Changed it.

It is used a number of times thought:

$ git grep '\<test\>.*-a\>' | wc -l
72

About 10 matches are accidental, but the rest are '-a' uses in 'test'.

>> [...]

Thanks a lot for looking into it :)
