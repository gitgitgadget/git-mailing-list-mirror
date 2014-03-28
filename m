From: Ilya Bobyr <ilya.bobyr@gmail.com>
Subject: Re: [PATCH 3/3] test-lib: '--run' to run only specific tests
Date: Fri, 28 Mar 2014 00:05:10 -0700
Message-ID: <53351F26.9070007@gmail.com>
References: <1395650987-5960-1-git-send-email-ilya.bobyr@gmail.com>	<1395916370-1404-1-git-send-email-ilya.bobyr@gmail.com>	<1395916370-1404-4-git-send-email-ilya.bobyr@gmail.com> <CAPig+cQeS6PAZN0nN_0LBfnFF_bGxC000cPSQFdSTVaHQD_haw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Mar 28 08:05:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTQrL-0007Kg-2v
	for gcvg-git-2@plane.gmane.org; Fri, 28 Mar 2014 08:05:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751179AbaC1HFZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Mar 2014 03:05:25 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:41402 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751099AbaC1HFX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Mar 2014 03:05:23 -0400
Received: by mail-pa0-f54.google.com with SMTP id lf10so4638885pab.27
        for <git@vger.kernel.org>; Fri, 28 Mar 2014 00:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=605tI3AFagVU4H+jFinkfPOfgqDBsflwGjuc+xCr2JU=;
        b=knRTIK4OjGYma+I+kDR2VY+TrmQ29ytOnv4rErA+28VUSU6KzQVlWCNU1St+KljL/V
         3tjx9KlVAjunsbuSt05KFdQ0IjLrTLLb3GyrmJc9xNNvCFOmTd63gLr19SzKujMnNNII
         oNiNoV5aBXWxsSw9v0F2AhjqVJlRJcqrrshj4QCfaMfcfVcFvbTgFDlc1UeKVQYQe3iA
         QDpZcE3xqaAkdeZBODcXTrTwi+P+b158aRlbQQquNy126L8YUIXpVXdALLHXXZgRN7Cr
         rB9rcPQB3QsJZO7D2qhXZtnQ62+FAl5F1SjYLOG3Utdb2n+gc0XVUhFu88X7Q1UBaR2u
         5nbw==
X-Received: by 10.68.201.97 with SMTP id jz1mr6759680pbc.26.1395990322802;
        Fri, 28 Mar 2014 00:05:22 -0700 (PDT)
Received: from [192.168.1.2] (c-50-136-172-14.hsd1.ca.comcast.net. [50.136.172.14])
        by mx.google.com with ESMTPSA id pv4sm18763710pbb.55.2014.03.28.00.05.21
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Mar 2014 00:05:22 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:28.0) Gecko/20100101 Thunderbird/28.0
In-Reply-To: <CAPig+cQeS6PAZN0nN_0LBfnFF_bGxC000cPSQFdSTVaHQD_haw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245366>

On 3/27/2014 8:36 PM, Eric Sunshine wrote:
> On Thu, Mar 27, 2014 at 6:32 AM, Ilya Bobyr <ilya.bobyr@gmail.com> wrote:
>> Allow better control of the set of tests that will be executed for a
>> single test suite.  Mostly useful while debugging or developing as it
>> allows to focus on a specific test.
>>
>> Signed-off-by: Ilya Bobyr <ilya.bobyr@gmail.com>
>> ---
>>  No changes from the previous version.
>>
>>  t/README         |   65 ++++++++++++++-
>>  t/t0000-basic.sh |  233 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  t/test-lib.sh    |   85 ++++++++++++++++++++
>>  3 files changed, 379 insertions(+), 4 deletions(-)
>>
>> diff --git a/t/README b/t/README
>> index 6b93aca..c911f89 100644
>> --- a/t/README
>> +++ b/t/README
>> @@ -100,6 +100,10 @@ appropriately before running "make".
>>         This causes additional long-running tests to be run (where
>>         available), for more exhaustive testing.
>>
>> +-r,--run=<test numbers>::
> Perhaps <test-selection> or something similar would be closer to the truth.

I think your naming is better.  I will include it in the next version.

>> +       This causes only specific tests to be included or excluded.  See
> This is phrased somewhat oddly, as if you had already been talking
> about tests being included or excluded, and that this option merely
> changes that selection. Perhaps something like:
>
>     Run only the subset of tests indicated by <test-selection>.

Will use that sentence as well :)

>> +       section "Skipping Tests" below for "<test numbers>" syntax.
>> +
>>  --valgrind=<tool>::
>>         Execute all Git binaries under valgrind tool <tool> and exit
>>         with status 126 on errors (just like regular tests, this will
>> @@ -187,10 +191,63 @@ and either can match the "t[0-9]{4}" part to skip the whole
>>  test, or t[0-9]{4} followed by ".$number" to say which
>>  particular test to skip.
>>
>> -Note that some tests in the existing test suite rely on previous
>> -test item, so you cannot arbitrarily disable one and expect the
>> -remainder of test to check what the test originally was intended
>> -to check.
>> +For an individual test suite --run could be used to specify that
>> +only some tests should be run or that some tests should be
>> +excluded from a run.
>> +
>> +--run argument is a list of patterns with optional prefixes that
> "The argument for --run is a list...

I think it could be either.  But I am not a native speaker.
So, I will use your version :)

>> +are matched against test numbers within the current test suite.
>> +Supported pattern:
>> +
>> + - A number matches a test with that number.
>> +
>> + - sh metacharacters such as '*', '?' and '[]' match as usual in
>> +   shell.
>> +
>> + - A number prefixed with '<', '<=', '>', or '>=' matches all
>> +   tests 'before', 'before or including', 'after', or 'after or
>> +   including' the specified one.
> I think you want "and" rather than "or": "before and including",
> "after and including".

I was thinking about an analogy to the corresponding mathematical
operations here.  In mathematics, '<=' is called "less than or
equal to"[1].

If you are thinking about test numbers you can say that you
include a test if it has a number before or equal to the given
one.  The sentence is "A number prefixed with <= matches all
tests [with numbers] before or including the specified [number]."

Maybe if I change "one" to "number" it would be a bit less
ambiguous.  Or even include all the omitted words.

I would not mind a completely different way to say it, but I am
not yet sure that if I replace "or" with "and" it would make it
a lot better.

[1] https://en.wikipedia.org/wiki/Inequality_%28mathematics%29

>> +Optional prefixes are:
>> +
>> + - '+' or no prefix: test(s) matching the pattern are included in
>> +   the run.
>> +
>> + - '-' or '!': test(s) matching the pattern are exluded from the
>> +   run.
> I've been playing with --run, and I find that test selection is not
> especially intuitive. For instance, ">=16 !>24 !20" is easier to
> reason about when written instead with ranges, such as "16-19 21-24",
> or perhaps "16-24 !20". Open-ended ranges make sense too: "5-" means
> tests 5 through the last, and "-5" means tests 1 through 5. (Yes, this
> conflicts with your use of '-' to mean negation, but you already have
> the perfectly serviceable '!' as an alias for negation.)

I completely agree that ranges allow one to express certain
"obvious" things much easier than just inequalities.  I was even
thinking on a possible syntax.  But then I realized that I do not
have a real use case for it.

The only use case that I had is described in the cover letter: to
run several setup tests and then the target test.  For that even
simple lists were enough and I was using that original version
with an environment variable.  After a conversation on the list I
thought that it would be nice to be able to say '<', as it would
save typing several extra characters for cases like '1 2 3 4 25'.
While test suits that I've seen so far actually have no more than
two tests that do the setup.

The next use case that I could come up with was running up to a
specific test.  I was in a situation were that would have been a
nice option.  And inequalities allow that.

Once again, I do not have a use case where I would need to run
tests from 1 to 10, then 14 to 19 and then 100 and up to the end.

Do you have something on your mind where that would be useful?

As for the syntax, ! is replaced in bash by the last executed
command.  That happens inside double quotes as well and the
original command line is not preserved (at lest for me).  So if
it would be the only option that seemed like a limitation.  It is
possible to escape it or use single quotes, of course.  I was
thinking about a comma as a separator for ranges.

As for the open ended ranges - they are the same as inequalities.

>> +If --run starts with '+' or unprefixed pattern the initial set of
>> +tests to run is empty. If the first pattern starts with '-' or
>> +'!' all the tests are added to the initial set.  After initial
>> +set is determined every pattern, test number or range is added or
>> +excluded from the set one by one, from left to right.
>> +
>> +For example, common case is to run several setup tests and then a
>> +specific test that relies on that setup:
> Perhaps be a bit more specific:
>
>     ...run several setup tests (1, 2, 3) and then a
>     specific test (21) that relies...

Good idea, though it clutters the sentence a bit.
Will use it.

>> +    $ sh ./t9200-git-cvsexport-commit.sh --run='1 2 3 21'
>> +
>> +or:
>> +
>> +    $ sh ./t9200-git-cvsexport-commit.sh --run='<4 21'
> It might be clearer to say "<=3" rather than "<4".

I thought that < is less typing, so it should be the first one to show.
Non-strict inequalities were next.
I will change this example and show '<' and '>' in the next two.

>> +To run only tests up to a specific test one could do this:
> s/specific test/specific test,/
>
> Also perhaps:
>
>     ...up to a specific test (21), one...

Fixed.

>> +    $ sh ./t9200-git-cvsexport-commit.sh --run='!>=21'
>> +
>> +As noted above test set is build going though patterns left to
> s/above/above,/
> s/test set/the test set/
> s/build/built/
>
>     As noted above, the test set is built...

Thanks :)

>> +right, so this:
>> +
>> +    $ sh ./t9200-git-cvsexport-commit.sh --run='<5 !3'
>> +
>> +will run tests 1, 2, and 4.
>> +
>> +Some tests in the existing test suite rely on previous test item,
>> +so you cannot arbitrarily disable one and expect the remainder of
>> +test to check what the test originally was intended to check.
>> +--run is mostly useful when you want to focus on a specific test
>> +and know what you are doing.  Or when you want to run up to a
>> +certain test.
>>
>>
>>  Naming Tests
>> diff --git a/t/test-lib.sh b/t/test-lib.sh
>> index e035f36..63e481a 100644
>> --- a/t/test-lib.sh
>> +++ b/t/test-lib.sh
>> @@ -191,6 +191,14 @@ do
>>                 immediate=t; shift ;;
>>         -l|--l|--lo|--lon|--long|--long-|--long-t|--long-te|--long-tes|--long-test|--long-tests)
>>                 GIT_TEST_LONG=t; export GIT_TEST_LONG; shift ;;
>> +       -r)
>> +               shift; test "$#" -ne 0 || {
>> +                       echo 'error: -r requires an argument' >&2;
>> +                       exit 1;
>> +               }
>> +               run_list=$1; shift ;;
>> +       --run=*)
>> +               run_list=$(expr "z$1" : 'z[^=]*=\(.*\)'); shift ;;
>>         -h|--h|--he|--hel|--help)
>>                 help=t; shift ;;
>>         -v|--v|--ve|--ver|--verb|--verbo|--verbos|--verbose)
>> @@ -366,6 +374,76 @@ match_pattern_list () {
>>         return 1
>>  }
>>
>> +match_run_pattern_list () {
>> +       arg="$1"
>> +       shift
>> +       test -z "$*" && return 0
>> +
>> +       # If the first patern is negative we include by default.
> s/patern/pattern/

Fixed.

>> +       include=
>> +       case "$1" in
>> +               [-!]*) include=t ;;
>> +       esac
>> +
>> +       for pattern_
>> +       do
>> +               orig_pattern=$pattern_
>> +
>> +               positive=t
>> +               case "$pattern_" in
>> +                       [-!]*)
>> +                               positive=
>> +                               pattern_=${pattern_##?}
>> +                               ;;
>> +               esac
>> +
>> +               # Short cut for "obvious" cases
>> +               [ "x$include" = "x" -a "x$positive" = "x" ] && continue
> Although there are a few exceptions in this script, 'test' is
> generally preferred over '['. Also, -a doesn't have great portability,
> so && may be better.
>
>     test -z "$include" && test -z "$positive" && continue

Did not know that.  Changed.

>> +               [ "x$include" = "xt" -a "x$positive" = "xt" ] && continue
> Since you're inside double quotes, you can drop the 'x' prefix:
>
>     test "$include" = t && test "$positive" = t && continue

Did not know that either %)
Fixed.
I saw it was used like that in the part that does argument parsing.  So
I just used style from there =)

>> +               pattern_op=
>> +               case "$pattern_" in
>> +                       \<=*)
>> +                               pattern_op='-le'
>> +                               pattern_=${pattern_##??}
>> +                               ;;
>> +                       \<*)
>> +                               pattern_op='-lt'
>> +                               pattern_=${pattern_##?}
>> +                               ;;
>> +                       \>=*)
>> +                               pattern_op='-ge'
>> +                               pattern_=${pattern_##??}
>> +                               ;;
>> +                       \>*)
>> +                               pattern_op='-gt'
>> +                               pattern_=${pattern_##?}
>> +                               ;;
>> +               esac
>> +
>> +               if test -n "$pattern_op"
>> +               then
>> +                       if expr "z$pattern_" : "z[0-9]*[^0-9]" >/dev/null
> Inside double quotes: you can drop the 'z' prefix.

Thanks.

>> +                       then
>> +                               echo "error: --run: test number contains" \
>> +                                       "non-digits: '$orig_pattern'" >&2
>> +                               exit 1
>> +                       fi
>> +                       if test $arg $pattern_op $pattern_
>> +                       then
>> +                               include=$positive
>> +                       fi
>> +               else
>> +                       case "$arg" in
>> +                               $pattern_)
>> +                                       include=$positive
>> +                       esac
>> +               fi
>> +       done
>> +
>> +       test -n "$include"
>> +}
>> +
>>  maybe_teardown_verbose () {
>>         test -z "$verbose_only" && return
>>         exec 4>/dev/null 3>/dev/null
>> @@ -470,6 +548,13 @@ test_skip () {
>>                 fi
>>                 skipped_reason="missing $missing_prereq${of_prereq}"
>>         fi
>> +       if test -z "$to_skip" && test -n "$run_list" &&
>> +               ! match_run_pattern_list $test_count $run_list
>> +       then
>> +               to_skip=t
>> +               skipped_reason="--run"
> A few pure bike-shedding comments (to be ignore if desired):
>
> I still don't understand the need to distinguish between a test
> skipped due to --run and and one skipped due to GIT_SKIP_TESTS.
>
> The skip-reason "GIT_SKIP_TESTS" (in patch 2/3) still seems
> unnecessarily verbose and loud.
>
> The skip-reason "excluded" (suggested in an earlier review) is short
> and sweet, and equally applicable to a test skipped either via --run
> or GIT_SKIP_TESTS.

Well, technically, it already says that the test is skipped.  So
adding "excluded" is actually a bit redundant.  Part that is in
the parenthesis explains the reason, at least for the case when
a test is skipped because a prerequisite is missing.

When you are just starting, I think, it is nice when the tool
tells you exactly why it was skipped - so that you do not have to
know everything to search in the right direction, if it does not
work the way you want it to.  When you already know what are you
doing, you probably ignore the exact text any way.  At least this
is how it is for me.

I am not sure I understand why "GIT_SKIP_TESTS" is verbose and
loud while "excluded" is sweet :)  Maybe I do not spend enough
time in the mail lists to have that association of all caps with
loud.  But in the land of Unix command line tools all caps means
"environment variable".  This is what I think when I see
"GIT_SKIP_TESTS".

P.S. Thanks for reviewing it :)
