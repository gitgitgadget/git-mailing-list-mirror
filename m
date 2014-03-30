From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 3/3] test-lib: '--run' to run only specific tests
Date: Sun, 30 Mar 2014 05:41:45 -0400
Message-ID: <CAPig+cSDCJ=3BC0dDaJMtfsRx_89z-6knNuRbzY+V3uBXY6xsA@mail.gmail.com>
References: <1395650987-5960-1-git-send-email-ilya.bobyr@gmail.com>
	<1395916370-1404-1-git-send-email-ilya.bobyr@gmail.com>
	<1395916370-1404-4-git-send-email-ilya.bobyr@gmail.com>
	<CAPig+cQeS6PAZN0nN_0LBfnFF_bGxC000cPSQFdSTVaHQD_haw@mail.gmail.com>
	<53351F26.9070007@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Ilya Bobyr <ilya.bobyr@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 30 11:42:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUCG0-0008Es-2d
	for gcvg-git-2@plane.gmane.org; Sun, 30 Mar 2014 11:42:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752725AbaC3Jlt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Mar 2014 05:41:49 -0400
Received: from mail-yk0-f172.google.com ([209.85.160.172]:49347 "EHLO
	mail-yk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751570AbaC3Jlq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Mar 2014 05:41:46 -0400
Received: by mail-yk0-f172.google.com with SMTP id 200so5186966ykr.3
        for <git@vger.kernel.org>; Sun, 30 Mar 2014 02:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=/WnQdE0yVrL+76Zeh430bkVKMaMXFF3l7gRKzBPGkVs=;
        b=09sXANHvl1sD+E3txhlT9RcHCOIplQigBXrFumzLqlbQC0+WSBieCLKRbqyaKxQJHi
         f8QlSSRE3LXr4D4aQWZff0wpOiRKily+jbHy2TERH2aJ5YQqEVkriWhW3dSEwGrRPVn2
         q9bsgA9mea426ODIvzQwZW4dBDwzpzw0VBr+Z1ltR284hbuJJ7/YMjLAxF0R2tNTMHe4
         Tt68BeJFN+xoxswsHmIZwNiqP0ilshQCUwj0AXKGsYGLvs4dkvF3EgXXAWFN48u0pgnC
         RnFIq2sIstKdd+gKzV11Okr3Bmj+ddomLkH/4TqdQl5scDkEBqFNoL5oLgRTtIzJerWJ
         s7jQ==
X-Received: by 10.236.123.130 with SMTP id v2mr26437654yhh.85.1396172506065;
 Sun, 30 Mar 2014 02:41:46 -0700 (PDT)
Received: by 10.170.180.134 with HTTP; Sun, 30 Mar 2014 02:41:45 -0700 (PDT)
In-Reply-To: <53351F26.9070007@gmail.com>
X-Google-Sender-Auth: TptHtmJFE32jXcAkFVZi_tH7bhY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245456>

On Fri, Mar 28, 2014 at 3:05 AM, Ilya Bobyr <ilya.bobyr@gmail.com> wrote:
> On 3/27/2014 8:36 PM, Eric Sunshine wrote:
>> On Thu, Mar 27, 2014 at 6:32 AM, Ilya Bobyr <ilya.bobyr@gmail.com> wrote:
>>> Allow better control of the set of tests that will be executed for a
>>> single test suite.  Mostly useful while debugging or developing as it
>>> allows to focus on a specific test.
>>>
>>> Signed-off-by: Ilya Bobyr <ilya.bobyr@gmail.com>
>>> ---
>>>  No changes from the previous version.
>>>
>>>  t/README         |   65 ++++++++++++++-
>>>  t/t0000-basic.sh |  233 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>>  t/test-lib.sh    |   85 ++++++++++++++++++++
>>>  3 files changed, 379 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/t/README b/t/README
>>> index 6b93aca..c911f89 100644
>>> --- a/t/README
>>> +++ b/t/README
>>> @@ -100,6 +100,10 @@ appropriately before running "make".
>>>         This causes additional long-running tests to be run (where
>>>         available), for more exhaustive testing.
>>>
>>> +-r,--run=<test numbers>::
>> Perhaps <test-selection> or something similar would be closer to the truth.
>
> I think your naming is better.  I will include it in the next version.
>
>>> +       This causes only specific tests to be included or excluded.  See
>> This is phrased somewhat oddly, as if you had already been talking
>> about tests being included or excluded, and that this option merely
>> changes that selection. Perhaps something like:
>>
>>     Run only the subset of tests indicated by <test-selection>.
>
> Will use that sentence as well :)
>
>>> +       section "Skipping Tests" below for "<test numbers>" syntax.
>>> +
>>>  --valgrind=<tool>::
>>>         Execute all Git binaries under valgrind tool <tool> and exit
>>>         with status 126 on errors (just like regular tests, this will
>>> @@ -187,10 +191,63 @@ and either can match the "t[0-9]{4}" part to skip the whole
>>>  test, or t[0-9]{4} followed by ".$number" to say which
>>>  particular test to skip.
>>>
>>> -Note that some tests in the existing test suite rely on previous
>>> -test item, so you cannot arbitrarily disable one and expect the
>>> -remainder of test to check what the test originally was intended
>>> -to check.
>>> +For an individual test suite --run could be used to specify that
>>> +only some tests should be run or that some tests should be
>>> +excluded from a run.
>>> +
>>> +--run argument is a list of patterns with optional prefixes that
>> "The argument for --run is a list...
>
> I think it could be either.  But I am not a native speaker.
> So, I will use your version :)
>
>>> +are matched against test numbers within the current test suite.
>>> +Supported pattern:
>>> +
>>> + - A number matches a test with that number.
>>> +
>>> + - sh metacharacters such as '*', '?' and '[]' match as usual in
>>> +   shell.
>>> +
>>> + - A number prefixed with '<', '<=', '>', or '>=' matches all
>>> +   tests 'before', 'before or including', 'after', or 'after or
>>> +   including' the specified one.
>> I think you want "and" rather than "or": "before and including",
>> "after and including".
>
> I was thinking about an analogy to the corresponding mathematical
> operations here.  In mathematics, '<=' is called "less than or
> equal to"[1].
>
> If you are thinking about test numbers you can say that you
> include a test if it has a number before or equal to the given
> one.  The sentence is "A number prefixed with <= matches all
> tests [with numbers] before or including the specified [number]."

In English, it is idiomatic to say "less than or equal" for '<=', and
"greater than or equal" for '>='. "before or including" and "after or
including" are not used and sound odd. They also sound rather odd when
"or" is replaced with "and". Using the idiomatic forms should be fine.

> Maybe if I change "one" to "number" it would be a bit less
> ambiguous.  Or even include all the omitted words.

Changing "all tests" to "all test numbers" and using the idiomatic forms gives:

    A number prefixed with '<', '<=', '>', or '>=' matches,
    respectively, all test numbers less than, less than or equal,
    greater than, or greater than or equal to the specified one.

which isn't bad, though a bit verbose.

> I would not mind a completely different way to say it, but I am
> not yet sure that if I replace "or" with "and" it would make it
> a lot better.

Since the relational operators are fairly self-explanatory, you could
drop the prose explanation, though that might make it too cryptic:

    A number prefixed with '<', '<=', '>', or '>=' matches test
    numbers meeting the specified relation.

> [1] https://en.wikipedia.org/wiki/Inequality_%28mathematics%29
>
>>> +Optional prefixes are:
>>> +
>>> + - '+' or no prefix: test(s) matching the pattern are included in
>>> +   the run.
>>> +
>>> + - '-' or '!': test(s) matching the pattern are exluded from the
>>> +   run.
>> I've been playing with --run, and I find that test selection is not
>> especially intuitive. For instance, ">=16 !>24 !20" is easier to
>> reason about when written instead with ranges, such as "16-19 21-24",
>> or perhaps "16-24 !20". Open-ended ranges make sense too: "5-" means
>> tests 5 through the last, and "-5" means tests 1 through 5. (Yes, this
>> conflicts with your use of '-' to mean negation, but you already have
>> the perfectly serviceable '!' as an alias for negation.)
>
> I completely agree that ranges allow one to express certain
> "obvious" things much easier than just inequalities.  I was even
> thinking on a possible syntax.  But then I realized that I do not
> have a real use case for it.
>
> The only use case that I had is described in the cover letter: to
> run several setup tests and then the target test.  For that even
> simple lists were enough and I was using that original version
> with an environment variable.  After a conversation on the list I
> thought that it would be nice to be able to say '<', as it would
> save typing several extra characters for cases like '1 2 3 4 25'.
> While test suits that I've seen so far actually have no more than
> two tests that do the setup.
>
> The next use case that I could come up with was running up to a
> specific test.  I was in a situation were that would have been a
> nice option.  And inequalities allow that.
>
> Once again, I do not have a use case where I would need to run
> tests from 1 to 10, then 14 to 19 and then 100 and up to the end.
>
> Do you have something on your mind where that would be useful?

I don't have a particular use-case. I was just observing how much
easier it was to reason about ranges than relational operators,
especially when negation is involved. The two modes are not mutually
exclusive, though implementing both seems overkill.

> As for the syntax, ! is replaced in bash by the last executed
> command.  That happens inside double quotes as well and the
> original command line is not preserved (at lest for me).  So if
> it would be the only option that seemed like a limitation.  It is
> possible to escape it or use single quotes, of course.

It's not unprecedented to use '!' in a command argument. 'sed',
'find', 'awk' (to name a few) all accept '!' for some use or another,
and users of those commands are likely already comfortable escaping or
using single-quotes.

Tilde (~) has some mnemonic value as an inversion operator.

> I was thinking about a comma as a separator for ranges.

Are you saying "1,5" would be the range 1-5? That likely would be too
easily misread as just tests 1 and 5.

> As for the open ended ranges - they are the same as inequalities.
>
>>> +If --run starts with '+' or unprefixed pattern the initial set of
>>> +tests to run is empty. If the first pattern starts with '-' or
>>> +'!' all the tests are added to the initial set.  After initial
>>> +set is determined every pattern, test number or range is added or
>>> +excluded from the set one by one, from left to right.
>>> +
>>> +For example, common case is to run several setup tests and then a
>>> +specific test that relies on that setup:
>> Perhaps be a bit more specific:
>>
>>     ...run several setup tests (1, 2, 3) and then a
>>     specific test (21) that relies...
>
> Good idea, though it clutters the sentence a bit.
> Will use it.
>
>>> +    $ sh ./t9200-git-cvsexport-commit.sh --run='1 2 3 21'
>>> +
>>> +or:
>>> +
>>> +    $ sh ./t9200-git-cvsexport-commit.sh --run='<4 21'
>> It might be clearer to say "<=3" rather than "<4".
>
> I thought that < is less typing, so it should be the first one to show.
> Non-strict inequalities were next.
> I will change this example and show '<' and '>' in the next two.

It's not a big deal. It just seemed slightly easer to reason about how
"<=3", rather than "<4", was the same as "1 2 3" (since "4" was not
mentioned anywhere in the preceding example).

>>> +To run only tests up to a specific test one could do this:
>> s/specific test/specific test,/
>>
>> Also perhaps:
>>
>>     ...up to a specific test (21), one...
>
> Fixed.
>
>>> +    $ sh ./t9200-git-cvsexport-commit.sh --run='!>=21'
>>> +
>>> +As noted above test set is build going though patterns left to
>> s/above/above,/
>> s/test set/the test set/
>> s/build/built/
>>
>>     As noted above, the test set is built...
>
> Thanks :)
>
>>> +right, so this:
>>> +
>>> +    $ sh ./t9200-git-cvsexport-commit.sh --run='<5 !3'
>>> +
>>> +will run tests 1, 2, and 4.
>>> +
>>> +Some tests in the existing test suite rely on previous test item,
>>> +so you cannot arbitrarily disable one and expect the remainder of
>>> +test to check what the test originally was intended to check.
>>> +--run is mostly useful when you want to focus on a specific test
>>> +and know what you are doing.  Or when you want to run up to a
>>> +certain test.
>>>
>>>
>>>  Naming Tests
>>> diff --git a/t/test-lib.sh b/t/test-lib.sh
>>> index e035f36..63e481a 100644
>>> --- a/t/test-lib.sh
>>> +++ b/t/test-lib.sh
>>> @@ -191,6 +191,14 @@ do
>>>                 immediate=t; shift ;;
>>>         -l|--l|--lo|--lon|--long|--long-|--long-t|--long-te|--long-tes|--long-test|--long-tests)
>>>                 GIT_TEST_LONG=t; export GIT_TEST_LONG; shift ;;
>>> +       -r)
>>> +               shift; test "$#" -ne 0 || {
>>> +                       echo 'error: -r requires an argument' >&2;
>>> +                       exit 1;
>>> +               }
>>> +               run_list=$1; shift ;;
>>> +       --run=*)
>>> +               run_list=$(expr "z$1" : 'z[^=]*=\(.*\)'); shift ;;
>>>         -h|--h|--he|--hel|--help)
>>>                 help=t; shift ;;
>>>         -v|--v|--ve|--ver|--verb|--verbo|--verbos|--verbose)
>>> @@ -366,6 +374,76 @@ match_pattern_list () {
>>>         return 1
>>>  }
>>>
>>> +match_run_pattern_list () {
>>> +       arg="$1"
>>> +       shift
>>> +       test -z "$*" && return 0
>>> +
>>> +       # If the first patern is negative we include by default.
>> s/patern/pattern/
>
> Fixed.
>
>>> +       include=
>>> +       case "$1" in
>>> +               [-!]*) include=t ;;
>>> +       esac
>>> +
>>> +       for pattern_
>>> +       do
>>> +               orig_pattern=$pattern_
>>> +
>>> +               positive=t
>>> +               case "$pattern_" in
>>> +                       [-!]*)
>>> +                               positive=
>>> +                               pattern_=${pattern_##?}
>>> +                               ;;
>>> +               esac
>>> +
>>> +               # Short cut for "obvious" cases
>>> +               [ "x$include" = "x" -a "x$positive" = "x" ] && continue
>> Although there are a few exceptions in this script, 'test' is
>> generally preferred over '['. Also, -a doesn't have great portability,
>> so && may be better.
>>
>>     test -z "$include" && test -z "$positive" && continue
>
> Did not know that.  Changed.
>
>>> +               [ "x$include" = "xt" -a "x$positive" = "xt" ] && continue
>> Since you're inside double quotes, you can drop the 'x' prefix:
>>
>>     test "$include" = t && test "$positive" = t && continue
>
> Did not know that either %)
> Fixed.
> I saw it was used like that in the part that does argument parsing.  So
> I just used style from there =)

A reason for the "x" trick is to avoid the following problem when $foo
expands to nothing:

% foo=
% test $foo = bar
bash: test: =: unary operator expected
% test x$foo = xbar
%

Quoting "$foo" achieves the same result.

Also, if the value of $foo starts with a hyphen, then 'test' would see
it as a command-line option. Prefixing with 'x' (or any letter) avoids
such misunderstanding.

It's also common to quote the expression to avoid the following
problem when $foo expands to multiple words:

% foo='foo bar'
% test $foo = bar
bash: test: too many arguments
% text "$foo" = bar
%

In your case, the values of $include and $positive are well-controlled
(only empty or 't'), so quoting alone is fine.

>>> +               pattern_op=
>>> +               case "$pattern_" in
>>> +                       \<=*)
>>> +                               pattern_op='-le'
>>> +                               pattern_=${pattern_##??}
>>> +                               ;;
>>> +                       \<*)
>>> +                               pattern_op='-lt'
>>> +                               pattern_=${pattern_##?}
>>> +                               ;;
>>> +                       \>=*)
>>> +                               pattern_op='-ge'
>>> +                               pattern_=${pattern_##??}
>>> +                               ;;
>>> +                       \>*)
>>> +                               pattern_op='-gt'
>>> +                               pattern_=${pattern_##?}
>>> +                               ;;
>>> +               esac
>>> +
>>> +               if test -n "$pattern_op"
>>> +               then
>>> +                       if expr "z$pattern_" : "z[0-9]*[^0-9]" >/dev/null
>> Inside double quotes: you can drop the 'z' prefix.
>
> Thanks.

It might be safer to keep the 'z' (or whatever) prefix on this one
since the pattern is coming from the user, thus not under your
control, and may start with a hyphen.

>>> +                       then
>>> +                               echo "error: --run: test number contains" \
>>> +                                       "non-digits: '$orig_pattern'" >&2
>>> +                               exit 1
>>> +                       fi
>>> +                       if test $arg $pattern_op $pattern_
>>> +                       then
>>> +                               include=$positive
>>> +                       fi
>>> +               else
>>> +                       case "$arg" in
>>> +                               $pattern_)
>>> +                                       include=$positive
>>> +                       esac
>>> +               fi
>>> +       done
>>> +
>>> +       test -n "$include"
>>> +}
>>> +
>>>  maybe_teardown_verbose () {
>>>         test -z "$verbose_only" && return
>>>         exec 4>/dev/null 3>/dev/null
>>> @@ -470,6 +548,13 @@ test_skip () {
>>>                 fi
>>>                 skipped_reason="missing $missing_prereq${of_prereq}"
>>>         fi
>>> +       if test -z "$to_skip" && test -n "$run_list" &&
>>> +               ! match_run_pattern_list $test_count $run_list
>>> +       then
>>> +               to_skip=t
>>> +               skipped_reason="--run"
>> A few pure bike-shedding comments (to be ignore if desired):
>>
>> I still don't understand the need to distinguish between a test
>> skipped due to --run and and one skipped due to GIT_SKIP_TESTS.
>>
>> The skip-reason "GIT_SKIP_TESTS" (in patch 2/3) still seems
>> unnecessarily verbose and loud.
>>
>> The skip-reason "excluded" (suggested in an earlier review) is short
>> and sweet, and equally applicable to a test skipped either via --run
>> or GIT_SKIP_TESTS.
>
> Well, technically, it already says that the test is skipped.  So
> adding "excluded" is actually a bit redundant.  Part that is in
> the parenthesis explains the reason, at least for the case when
> a test is skipped because a prerequisite is missing.
>
> When you are just starting, I think, it is nice when the tool
> tells you exactly why it was skipped - so that you do not have to
> know everything to search in the right direction, if it does not
> work the way you want it to.  When you already know what are you
> doing, you probably ignore the exact text any way.  At least this
> is how it is for me.
>
> I am not sure I understand why "GIT_SKIP_TESTS" is verbose and
> loud while "excluded" is sweet :)  Maybe I do not spend enough
> time in the mail lists to have that association of all caps with
> loud.  But in the land of Unix command line tools all caps means
> "environment variable".  This is what I think when I see
> "GIT_SKIP_TESTS".

It's loud in this sense: You generally want to ignore test output,
with the exception of failures which should loudly draw your
attention. Most of the output from the tests is lowercase, but the
uppercase (GIT_SKIP_TESTS) -- being different -- draws the attention
unnecessarily.

(Having actually just run some tests, I note that skipped tests
already are colored differently and the typical skip reason is
uppercase anyhow, so the above reasoning is likely unsupportable.)

But, as noted, this is pure bike-shedding. I won't bring it up again.

> P.S. Thanks for reviewing it :)
