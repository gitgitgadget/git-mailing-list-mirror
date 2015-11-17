From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v3 1/2] sendemail: teach git-send-email to dump alias names
Date: Tue, 17 Nov 2015 00:32:04 -0800
Message-ID: <CA+P7+xq0itd4Symm7Y_1qS3cmZkc5cMUbfjyhjKrytq=Q28TTA@mail.gmail.com>
References: <1447720166-9941-1-git-send-email-jacob.e.keller@intel.com> <CAPig+cSfk0Xj8Wft6VbnOXtkc43eLZBv7g99AYFdgdGfFQ2nzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	"Shawn O . Pearce" <spearce@spearce.org>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Lee Marlow <lee.marlow@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Nov 17 09:32:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zybgk-0003iz-3h
	for gcvg-git-2@plane.gmane.org; Tue, 17 Nov 2015 09:32:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752077AbbKQIcZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Nov 2015 03:32:25 -0500
Received: from mail-ig0-f177.google.com ([209.85.213.177]:34341 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751452AbbKQIcY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Nov 2015 03:32:24 -0500
Received: by igvg19 with SMTP id g19so91543552igv.1
        for <git@vger.kernel.org>; Tue, 17 Nov 2015 00:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=EcYBkGHvDmQqdbstQ6bs9ayHIzOi+ofi57GB8ZMkLXE=;
        b=vUMz/ALCyJCeJQh0xOZzIOWkbq9NUq6eKC0n5Qvu7WrhOID+FQnONAcldM1khPBH1R
         nM+jUcNwAlAtKS7LJaKPKznFNtYgkFVygQmUq6+nJe36XXFFdUS5c6/tNR1g7eeHWTj+
         RUZuJr7mE2G8QurzvQmh1tGRJg9L2Ow3jEnRB4lyoLc+WUGsgVbMD30QL6pP8lWCVuCL
         Y7P1my2rHjwVrxTXdG0MBCUaPr0qXkC5s62gsMLd5gWBNyXujy/BFuSLMYLuY8Ll1zuQ
         VHxgbm1zkPSyvC/CVPW+AyWDZHdhAfIIkp6yzbedjAAJJ8YZ5BqSDg8O11lOr+vEw5WJ
         MuNw==
X-Received: by 10.50.87.71 with SMTP id v7mr737655igz.92.1447749144050; Tue,
 17 Nov 2015 00:32:24 -0800 (PST)
Received: by 10.107.19.227 with HTTP; Tue, 17 Nov 2015 00:32:04 -0800 (PST)
In-Reply-To: <CAPig+cSfk0Xj8Wft6VbnOXtkc43eLZBv7g99AYFdgdGfFQ2nzQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281390>

On Tue, Nov 17, 2015 at 12:07 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Mon, Nov 16, 2015 at 7:29 PM, Jacob Keller <jacob.e.keller@intel.com> wrote:
>> Add an option "dump-aliases" which changes the default behavior of
>
> It would be easier to understand that this is a new command-line
> option (as opposed to a configuration or other option) if you spelled
> it --dump-aliases (with the leading dashes) rather than
> "dump-aliases".
>
>> git-send-email. This mode will simply read the alias files configured by
>> sendemail.aliasesfile and sendemail.aliasfiletype and dump a list of all
>> configured aliases, one per line. The intended use case for this option
>> is the bash-completion script which will use it to autocomplete aliases
>> on the options which take addresses.
>>
>> Add some tests for the new option.
>
> I think this patch adds only a single test (not "tests").
>
>> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
>> ---
>> diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
>> @@ -10,6 +10,7 @@ SYNOPSIS
>>  --------
>>  [verse]
>>  'git send-email' [options] <file|directory|rev-list options>...
>> +'git send-email' --list-aliases
>
> s/list/dump/
>
>>  DESCRIPTION
>> @@ -387,6 +388,15 @@ default to '--validate'.
>>         Send emails even if safety checks would prevent it.
>>
>>
>> +Information
>> +~~~~~~~~~~~
>> +
>> +--dump-aliases::
>> +       Instead of the standard operation, dump all aliases found in the
>> +       configured alias file(s), followed by its expansion. See
>> +       'sendemail.aliasesfile' for more information about aliases.
>
> This doesn't describe the actual format of the output. "followed by"
> could mean the same line or it could mean that all expansions are
> jumbled together on the next line, or that each expansion has a line
> of its own. A more detailed explanation would be helpful.
>
> However, see my other email where I discuss possibly punting on the
> alias expansions (or perhaps dumping them in an unambiguous format).
>

I agree, I think I will punt this part and remove the extra output.
I'd rather not handle it now as we don't need it and I don't really
know how useful it would be. I think a future could add either verbose
or an option to dump both since I think these are quite separate.

>> diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
>> @@ -1579,6 +1579,24 @@ test_sendmail_aliases () {
>> +test_sendmail_dump_aliases () {
>> +       msg="$1" && shift &&
>> +       expect="$@" &&
>> +       cat >.tmp-email-aliases &&
>> +
>> +       test_expect_success $PREREQ "$msg" '
>> +               clean_fake_sendmail && rm -fr outdir &&
>> +               git config --replace-all sendemail.aliasesfile \
>> +                       "$(pwd)/.tmp-email-aliases" &&
>> +               git config sendemail.aliasfiletype sendmail &&
>> +               git send-email --dump-aliases 2>errors >out &&
>> +               for i in $expect
>> +               do
>> +                       grep "$i" out || return 1
>> +               done
>> +       '
>> +}
>
> I suppose your inspiration for this new function was
> test_sendmail_aliases() which was added by 514554c (t9001: refactor
> sendmail aliases test infrastructure, 2015-05-31). While it made sense
> to introduce test_sendmail_aliases() since it is needed by several
> tests, this new function, test_sendmail_dump_aliases(), is used by
> only one test. Unfortunately, this sort of function is uglier and more
> difficult to understand than the equivalent code embedded directly in
> the test itself. Therefore, if you don't expect to add more tests of
> --dump-aliases, then I recommend just incorporating this code directly
> into the test so as to avoid burdening reviewers and future readers of
> the code with unnecessary complexity.

I think I'll rework the function a bit and add more tests one for each
file type.

>
> Also, this isn't really testing that the output of --dump-aliases has
> the expected format; it's only testing if some name appears *anywhere*
> in the output, which is likely way too loose (especially since alias
> expansions are included in the output).
>

Yea, the problem is I can't guarantee the order of the aliases, since
perl doesn't guarantee order of a hash, I guess I could sort them
first though...

>>  test_sendmail_aliases 'sendemail.aliasfiletype=sendmail' \
>>         'awol@example\.com' \
>>         'bob@example\.com' \
>> @@ -1593,6 +1611,21 @@ test_sendmail_aliases 'sendemail.aliasfiletype=sendmail' \
>>         bcgrp: bob, chloe, Other <o@example.com>
>>         EOF
>>
>> +test_sendmail_dump_aliases '--dump-alias-names sendemail.aliasfiletype=sendmail' \
>
> s/dump-alias-names/dump-aliases/
>
> Also, what's "sendemail.aliasfiletype=sendmail" doing in the title of
> this test? (I presume you copy/pasted it from the preceding test.)
> Since --dump-alises is independent of the aliases file type, it's
> actively misleading to mention 'aliasefiletype' and 'sendmail' in the
> test title, thus it should be removed.
>

Actually currently that function only tests sendmail type, it should
be expanded to not do that, and I can add a test for each format. The
current function actually only tests sendmail file, so it's pretty
accurate, and in this case the test is the sendmail file type of
aliases. I'll add more filetypes in a future rework.

>> +       'alice' \
>> +       'bob' \
>> +       'chloe' \
>> +       'abgroup' \
>> +       'bcgrp' <<-\EOF
>> +       alice: Alice W Land <awol@example.com>
>> +       bob: Robert Bobbyton <bob@example.com>
>> +       # this is a comment
>> +          # this is also a comment
>
> I realize that you copied this from the preceding test, however,
> having these comment lines here is distracting and a bit misleading
> since they are superfluous to this test. Keep the test lean and
> meaningful (to readers) by including only content relevant to what is
> being tested.

They actually are relevant. This is a sendmail format, and having the
comments actually ensures that we test the bits of sendmail format
that don't get them end up including as alias names, right? I can
remove them if you feel strong about it.

>
>> +       chloe: chloe@example.com
>> +       abgroup: alice, bob
>> +       bcgrp: bob, chloe, Other <o@example.com>
>> +       EOF
>
> I'm a bit unhappy about how this new test got plopped right in the
> middle of the four tests which employ test_sendmail_aliases(),
> breaking the flow of those tests for anyone reading the code. Please
> move this test outside of that block of tests.

Yes I will do so.

Regards,
Jake

>
>>  test_sendmail_aliases 'sendmail aliases line folding' \
>>         alice1 \
>>         bob1 bob2 \
>> --
>> 2.6.3.491.g3e3f6ce
