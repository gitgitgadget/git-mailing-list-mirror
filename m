From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH v4 4/4] t0302: test credential-store support for XDG_CONFIG_HOME
Date: Sat, 21 Mar 2015 13:46:13 +0800
Message-ID: <CACRoPnTXH+HDD42H2ca7b+OPF15v2TxM+y+NRRi2CS_Xg3tGEw@mail.gmail.com>
References: <1426662276-8728-1-git-send-email-pyokagan@gmail.com>
	<1426662276-8728-4-git-send-email-pyokagan@gmail.com>
	<CAPig+cR-87-dWXUKoKvphrdb_Y=7268G5uerAiPYDsj-UQiuRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sat Mar 21 06:46:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZCEm-0001qJ-Qo
	for gcvg-git-2@plane.gmane.org; Sat, 21 Mar 2015 06:46:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752092AbbCUFqQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Mar 2015 01:46:16 -0400
Received: from mail-we0-f178.google.com ([74.125.82.178]:36549 "EHLO
	mail-we0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751612AbbCUFqP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Mar 2015 01:46:15 -0400
Received: by wetk59 with SMTP id k59so96974181wet.3
        for <git@vger.kernel.org>; Fri, 20 Mar 2015 22:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Fy9AbPsnrVL09R9s+C5V4Zn1AmpCjo5ESvaiB1r6j38=;
        b=y2DqIUbD4ToXNzYTePimjjZz4mcMTVraNyWI+wb8tcZVohFsKZOnt/I+kKVbv4tXfQ
         +C6/JPJxg/7Pw+MMAO7Qz48B7pRtstVQNEf2qRnde00Sf2a5IDlmODGLvrwoQXZnPTXU
         JYK2zA6SSVolxQ5ytXki4Ne8tFvpB7GjjpQajX307shuDJQzMwdIlMM5H6po3Fm9BZIY
         RHR0BnDLL2yEzRgyDzfpNcmFEX6CLlAOoa2rTLlZN0orK2xacZp07ilb/SHFeLryqOz6
         qs+vIhKqpjfcEBY/n9Lj6uuVZklgBkp4QDur5HvfVDDEJ7VQ4X7tw/TAzlLconGoaWvN
         SrcQ==
X-Received: by 10.180.106.225 with SMTP id gx1mr1940777wib.53.1426916773896;
 Fri, 20 Mar 2015 22:46:13 -0700 (PDT)
Received: by 10.194.64.69 with HTTP; Fri, 20 Mar 2015 22:46:13 -0700 (PDT)
In-Reply-To: <CAPig+cR-87-dWXUKoKvphrdb_Y=7268G5uerAiPYDsj-UQiuRw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266010>

Hi,

On Thu, Mar 19, 2015 at 3:26 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Wed, Mar 18, 2015 at 3:04 AM, Paul Tan <pyokagan@gmail.com> wrote:
>> diff --git a/t/t0302-credential-store.sh b/t/t0302-credential-store.sh
>> index f61b40c..5b0a666 100755
>> --- a/t/t0302-credential-store.sh
>> +++ b/t/t0302-credential-store.sh
>> @@ -6,4 +6,115 @@ test_description='credential-store tests'
>>
>>  helper_test store
>>
>> +test_expect_success 'when xdg credentials file does not exist, only write to ~/.git-credentials; do not create xdg file' '
>
> These test descriptions are quite long, often mirroring in prose what
> the test body already says more concisely. I generally try to keep
> descriptions short while still being descriptive enough to give a
> general idea about what is being tested. I've rewritten a few test
> descriptions (below) to be very short, in fact probably too terse; but
> perhaps better descriptions would lie somewhere between the two
> extremes. First example, for this test:
>
>     "!xdg: >.git-credentials !xdg"
>
> Key: Space-separated items. Items before ":" are the pre-conditions,
> and items after are the post-state. "!" file does not exist; ">"
> output goes here.

I will make the test descriptions shorter. However, I don't think the
test descriptions need to be so terse such that a separate key is
required. e.g. I will shorten the above to "when xdg file does not
exist, it's not created.", or even terser: "when xdg file not exists,
it's not created.". I don't think symbols should be used, as many
other test descriptions do not use them.

>> +       test -s "$HOME/.git-credentials" &&
>> +       test_path_is_missing "$HOME/.config/git/credentials"
>> +'
>> +
>> +test_expect_success 'create $XDG_CONFIG_HOME/git/credentials file' '
>
> It's customary to call this "setup" rather than "create".

Will fix.

> Terse version: "setup: -.git-redentials +xdg"
>
> Key: "-" file removed; "+" file created.

How about just "setup xdg file" (the fact that ~/.git-credentials is
not created/deleted is implied in the next test)

>> +       rm -f "$HOME/.git-credentials" &&
>> +       mkdir -p "$HOME/.config/git" &&
>> +       >"$HOME/.config/git/credentials"
>> +'
>> +
>> +helper_test store
>> +
>> +test_expect_success 'when xdg credentials file exists, only write to xdg file; do not create ~/.git-credentials' '
>
> Terse version: "!.git-credentials xdg: !.git-credentials >xdg"

How about "when xdg file exists, home file not created"

>> +       test -s "$HOME/.config/git/credentials" &&
>> +       test_path_is_missing "$HOME/.git-credentials"
>> +'
>> +
>> +test_expect_success 'set up custom XDG_CONFIG_HOME credential file at ~/xdg/git/credentials' '
>
> s/set up/setup/

Will fix. Thanks.

> Terse: "setup custom-xdg"

It's a matter of taste, but I personally don't see the need for
hyphenation. How about: "setup custom xdg file"

>
>> +       mkdir -p "$HOME/xdg/git" &&
>> +       rm -f "$HOME/.config/git/credentials" &&
>> +       >"$HOME/xdg/git/credentials"
>
> It would be easier to read this if you placed the two lines together
> which refer to the custom xdg file.
> Also, for completeness and to be
> self-contained, don't you want to remove ~/.git-credentials?

Ah yes, thanks for the suggestion.

>     rm -f "$HOME/.git-credentials" &&
>     rm -f "$HOME/.config/git/credentials" &&
>     mkdir -p "$HOME/xdg/git" &&
>     >"$HOME/xdg/git/credentials"
>
>> +'
>> +
>> +XDG_CONFIG_HOME="$HOME/xdg" && export XDG_CONFIG_HOME && helper_test store
>> +unset XDG_CONFIG_HOME
>
> It's hard to spot the "helper_test store" at the end of line. I'd
> place it on a line by itself so that it is easy to see that it is
> wrapped by the setting and unsetting of the environment variable.

Thanks, will fix. Although now it looks weird that the "export" is the
only one with a continuation on a single line, so I split all of them
so that they each have their own line.

>> +test_expect_success 'if custom XDG_CONFIG_HOME credentials file ~/xdg/git/credentials exists, it will only be written to; ~/.config/git/credentials and ~/.git-credentials will not be created' '
>
> Terse: "!.git-credentials !xdg custom-xdg: !.git-credentials !xdg >custom-xdg"
>
>> +       test_when_finished "rm -f $HOME/xdg/git/credentials" &&
>> +       test -s "$HOME/xdg/git/credentials" &&
>> +       test_path_is_missing "$HOME/.config/git/credentials"
>
> Matthieu already pointed out the broken &&-chain.

Will fix. Thanks for catching it.

>
>> +       test_path_is_missing "$HOME/.git-credentials"
>> +'
>> +
>> +test_expect_success 'get: return credentials from home file if matches are found in both home and xdg files' '
>
> Terse: ".git-credentials xdg: <.git-credentials"
>
> Key: "<" taken from here.

How about "use home file if both home and xdg files have matches". I
wish to make it explicit that which files are used depends on whether
they have the matching credential, not if they exist.

>
>> +       mkdir -p "$HOME/.config/git" &&
>> +       echo "https://xdg-user:xdg-pass@example.com" >"$HOME/.config/git/credentials" &&
>> +       echo "https://home-user:home-pass@example.com" >"$HOME/.git-credentials" &&
>> +       check fill store <<-\EOF
>> +       protocol=https
>> +       host=example.com
>> +       --
>> +       protocol=https
>> +       host=example.com
>> +       username=home-user
>> +       password=home-pass
>> +       --
>> +       EOF
>> +'
>> +
>> +test_expect_success 'get: return credentials from xdg file if the home files do not have them' '
>
> Terse: "!.git-credentials xdg: <xdg"

How about "use xdg file if home file has no matches".

>
>> +       mkdir -p "$HOME/.config/git" &&
>> +       >"$HOME/.git-credentials" &&
>> +       echo "https://xdg-user:xdg-pass@example.com" >"$HOME/.config/git/credentials" &&
>> +       check fill store <<-\EOF
>> +       protocol=https
>> +       host=example.com
>> +       --
>> +       protocol=https
>> +       host=example.com
>> +       username=xdg-user
>> +       password=xdg-pass
>> +       --
>> +       EOF
>> +'
>> +
>> +test_expect_success 'get: return credentials from home file if xdg files are unreadable' '
>
> An earlier test showed that the home file is preferred if both it and
> the xdg file exist, so is this test actually telling us anything new?
> Did you mean instead to reverse the case and make the home file
> unreadable?

Ah yes, this is embarrassing. Apparently this test was written with
the old precedence ordering. Thank you so much for catching this fatal
error.

>> +       mkdir -p "$HOME/.config/git" &&
>> +       echo "https://xdg-user:xdg-pass@example.com" >"$HOME/.config/git/credentials" &&
>> +       echo "https://home-user:home-pass@example.com" >"$HOME/.git-credentials" &&
>> +       chmod -r "$HOME/.config/git/credentials" &&
>
> It would be a bit easier to see that the 'chmod' applies to the xdg
> file if it directly followed creation of the xdg file.

Will fix (will chmod the home file instead)

>
>> +       check fill store <<-\EOF
>> +       protocol=https
>> +       host=example.com
>> +       --
>> +       protocol=https
>> +       host=example.com
>> +       username=home-user
>> +       password=home-pass
>> +       --
>> +       EOF
>> +'
>> +
>> +test_expect_success 'store: If both xdg and home files exist, only store in home file' '
>
> Inconsistent capitalization: s/If/if/

Will fix.

>
>> +       mkdir -p "$HOME/.config/git" &&
>> +       >"$HOME/.config/git/credentials" &&
>> +       >"$HOME/.git-credentials" &&
>> +       check approve store <<-\EOF &&
>> +       protocol=https
>> +       host=example.com
>> +       username=store-user
>> +       password=store-pass
>> +       EOF
>> +       echo "https://store-user:store-pass@example.com" >expected &&
>> +       test_cmp expected "$HOME/.git-credentials" &&
>> +       test_must_be_empty "$HOME/.config/git/credentials"
>> +'
>> +
>> +
>> +test_expect_success 'erase: erase matching credentials from both xdg and home files' '
>> +       mkdir -p "$HOME/.config/git" &&
>> +       echo "https://xdg-user:xdg-pass@example.com" >"$HOME/.config/git/credentials" &&
>> +       echo "https://home-user:home-pass@example.com" >"$HOME/.git-credentials" &&
>> +       check reject store <<-\EOF &&
>> +       protocol=https
>> +       host=example.com
>> +       EOF
>> +       test_must_be_empty "$HOME/.config/git/credentials" &&
>> +       test_must_be_empty "$HOME/.git-credentials"
>> +'
>> +
>>  test_done

Thanks so much Eric and Matthieu for the review.
