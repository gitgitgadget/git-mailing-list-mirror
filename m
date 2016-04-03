From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v12 3/5] parse-options.c: make OPTION_COUNTUP respect
 "unspecified" values
Date: Sun, 3 Apr 2016 19:10:01 -0400
Message-ID: <CAPig+cS23i9XFTntLTHRbNf21DxhLAcw+9ent_ZtWj=1aO7JwQ@mail.gmail.com>
References: <01020153d952bd99-d3812bd6-d189-4780-ab48-f015696e9cf0-000000@eu-west-1.amazonses.com>
	<01020153d952be68-ee055619-664d-4502-92e9-6aa524e2354b-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 04 01:10:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1amr9n-0007IB-BU
	for gcvg-git-2@plane.gmane.org; Mon, 04 Apr 2016 01:10:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752750AbcDCXKE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Apr 2016 19:10:04 -0400
Received: from mail-ig0-f196.google.com ([209.85.213.196]:34790 "EHLO
	mail-ig0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752266AbcDCXKC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2016 19:10:02 -0400
Received: by mail-ig0-f196.google.com with SMTP id qu10so3532120igc.1
        for <git@vger.kernel.org>; Sun, 03 Apr 2016 16:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=06tnwXZG3KBdp6JGzZb/Ol26Yp+F6HbbrhUhaRCOe7E=;
        b=MOLCS8314zQTp/VwIAJeYXKC+8FNhA5kjFZLF967Qz/DwxgPvYfDmzynEasYUrY6M2
         vq1+HNHLgGLc6QA2mOX2EudZzFk6rUfWDX0cjjbD3ojIBrIA7h2rusmB3NhFqXHlFc7f
         vjPXh1fH423TN5+1AwGm5eR6ryDY6J5P8AvjXOOBdkoalKsAgouXTbtIozdtbrYPh7Z9
         3m8FI54GfQnu1Iq7P5eGXxsajQM1WfpNyDK5QBlHtzOShvoxww+e5dJzWHfg/fGi8xuk
         O1c/s+Gdy97JDWj91z03dcQz5N7Ql5R9eTeyBa+VZo6gnGNVyrjP0ik94jx3HIQldazS
         DyFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=06tnwXZG3KBdp6JGzZb/Ol26Yp+F6HbbrhUhaRCOe7E=;
        b=em0LgVuKFWTroAJHOp8T5V9rQHjVpB7NaJca4nYDp+uosZkh/8hKEHe1VtjmrFIX+B
         hCYO0wCx4RbQPxSXqiTgG0z2FaUTrViXUVdr4oWHFnFHHvOxKenT4yy7M0G3HRcadBR7
         3ygRx1btHewctJoX+6ds4/yhCTB/QMSUWIhAulaE1wLk0ti06BTw7nU9/kARVpQPe2l3
         9W/418skGqiXTLXByvc6xzeTKr84MOeSWVjtLHWqP9cphI1VjeHW3GZFghqdE9lpVjLg
         qPFn0GliabDccGuKEq2vNNu3hdqtkc5HG/xUXbIht9jdykrZvbtZ2LS0DsENgMTrDSM4
         vybw==
X-Gm-Message-State: AD7BkJLY9P9mj9G4iSwK6iF2XMvAE2bCxSgPvJslPgwbvCmCyp14Flg1toMhBkVNoR6fgSspe3RaYBJJAvc8CQ==
X-Received: by 10.107.130.138 with SMTP id m10mr7264193ioi.34.1459725001166;
 Sun, 03 Apr 2016 16:10:01 -0700 (PDT)
Received: by 10.79.12.139 with HTTP; Sun, 3 Apr 2016 16:10:01 -0700 (PDT)
In-Reply-To: <01020153d952be68-ee055619-664d-4502-92e9-6aa524e2354b-000000@eu-west-1.amazonses.com>
X-Google-Sender-Auth: 6llo9a35-MK_5nstkAYvbxji96Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290662>

On Sat, Apr 2, 2016 at 7:33 PM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
> The reason to make it respect "unspecified" values is to give the
> ability to differentiate whether `--option` or `--no-option` was
> specified at all. "unspecified" values should be in the form of negative
> values. If initial value is set to negative and `--option` specified
> then it will reflect the number of occurrences (counting done from 0),
> if `--no-option` is specified then it will reflect 0 and if nothing at
> all is given then it will retain its negative value.

Thanks, this rewrite does a better job of explaining the aim of the
change and how a client can take advantage of it. However, with my
"first-time reader" hat on, I still have some trouble digesting it as
a coherent whole. I wonder if a rewrite like this would help?

    OPT_COUNTUP() merely increments the counter upon --option, and
    resets it to 0 upon --no-option, which means that there is no
    "unspecified" value with which a client can initialize the
    counter to determine whether or not --[no-]option was seen at
    all.

    Make OPT_COUNTUP() treat any negative number as an "unspecified"
    value to address this shortcoming. In particular, if a client
    initializes the counter to -1, then if it is still -1 after
    parse_options(), then neither --option nor --no-option was seen;
    if it is 0, then --no-option was seen last, and if it is 1 or
    greater, than --option was seen last.

> This change will not affect existing users of COUNTUP, because they all
> use the initial value of 0 (or more).

    "This change does not affect behavior of existing clients of..."

> Note that builtin/clean.c initializes the variable used with
> OPT__FORCE (which uses OPT_COUNTUP()) to a negative value, but it is set
> to either 0 or 1 by reading the configuration before the code calls
> parse_options(), i.e. as far as parse_options() is concerned, the
> initial value of the variable is not negative.
>
> To test this behavior "verbose" is set to "unspecified" while quiet is
> set to 0 which will test the new behavior with all sets of values.

I think you need to mention here that you're talking about test-parse-options.c
(and indirectly t0040) since it's otherwise too easy for the reader to
think that this paragraph is a continuation of the discussion about
OPT_COUNTUP()'s new behavior and how it won't impact existing tests,
rather than a new topic of its own (testing the behavior). Maybe say
something like this:

    To test the new behavior, augment the initial "verbose" setting
    of test-parse-options.c to be unspecified...

and then go on to say that, because "quiet" is still initialized to 0,
you have complete coverage. An alternative would be to split off the
new testing into its own patch, which would make this patch (which is
the real meat of the change) less noisy.

I actually expected you to add new functionality to
test-parse-options.c specifically to test OPT_COUNTUP() directly
rather than indirectly through --verbose and --quiet, however, I think
I can be sold on the approach you took for a couple reasons. First,
you have a genuine use-case for an "unspecified" --verbose value, so
changing test-parse-options.c's --verbose to start at -1 tests what
you ultimately care about. Second, since you retained 0-initialization
of --quiet, that case of OPT_COUNTUP() is still being tested.

What I find a bit disturbing about this approach is that you are
getting "full coverage" only because of current *implementation*, not
because you are explicitly testing for *expected* behavior. That is,
you get that coverage only while both OPT__VERBOSE() and OPT__QUIET()
are built atop OPT_COUNTUP(); if OPT__QUIET() is ever rewritten so it
no longer uses OPT_COUNTUP(), then the tests silently lose full
coverage. However, I may be over-worrying about the situation...

> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
> ---
> diff --git a/Documentation/technical/api-parse-options.txt b/Documentation/technical/api-parse-options.txt
> @@ -144,8 +144,12 @@ There are some macros to easily define options:
>  `OPT_COUNTUP(short, long, &int_var, description)`::
>         Introduce a count-up option.
> -       `int_var` is incremented on each use of `--option`, and
> -       reset to zero with `--no-option`.
> +       Each use of `--option` increments `int_var`, starting from zero
> +       (even if initially negative), and `--no-option` resets it to
> +       zero. To determine if `--option` or `--no-option` was set at

s/was set/was encountered/

> +       all, set `int_var` to a negative value, and if it is still

s/set `int_var`/initialize `int_var`/

> +       negative after parse_options(), then neither `--option` nor
> +       `--no-option` was seen.
> diff --git a/parse-options.c b/parse-options.c
> @@ -110,6 +110,8 @@ static int get_value(struct parse_opt_ctx_t *p,
>         case OPTION_COUNTUP:
> +               if (*(int *)opt->value < 0)
> +                       *(int *)opt->value = 0;
>                 *(int *)opt->value = unset ? 0 : *(int *)opt->value + 1;

This is nicer.

>                 return 0;
> diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
> @@ -454,6 +454,25 @@ dry run: no
> +test_expect_success 'OPT_COUNTUP() resets to 0 with --no- flag' '
> +       test-parse-options --no-verbose >output 2>output.err &&
> +       test_must_be_empty output.err &&
> +       test_cmp expect output
> +'

If you take the advice of my 2/5 review and add new tests (in a new
patch) which test --no-verbose and --no-quiet, then I think this new
test here can just go away since the case it cares about will already
be covered.
