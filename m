From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH RFC] completion: add support for completing email aliases
Date: Sat, 14 Nov 2015 00:36:48 -0800
Message-ID: <CA+P7+xpxpkCJxesU4Tif46pYeQHG-NdvMuD0bj1Kr_kGz4djTg@mail.gmail.com>
References: <20151114015504.Horde.4mcBf20X0mnolD3xNrtymin@webmail.informatik.kit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jacob Keller <jacob.e.keller@intel.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O . Pearce" <spearce@spearce.org>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Lee Marlow <lee.marlow@gmail.com>
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Sat Nov 14 09:38:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZxWLD-0002Ph-Tl
	for gcvg-git-2@plane.gmane.org; Sat, 14 Nov 2015 09:37:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751075AbbKNIhJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Nov 2015 03:37:09 -0500
Received: from mail-io0-f177.google.com ([209.85.223.177]:33187 "EHLO
	mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751037AbbKNIhI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Nov 2015 03:37:08 -0500
Received: by iouu10 with SMTP id u10so112080128iou.0
        for <git@vger.kernel.org>; Sat, 14 Nov 2015 00:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=QwRlQrxOZOLrnJGM4OF7iGi06Dl/kH3+AecROrocC0k=;
        b=t/nfxdaXE0cmYRNR7ub7jm1g3n3rA7f7Yh9EjBksHZie0GV7Vd7CUb+8ixai8zLKME
         3vkdwQ5HbtoJa07hTfXlncDUcVzi3t0jdRhSwXAluC4ex/0RXBIF2BuEU2toZL+XpCdp
         Sx0Ur93n5hDvzLKHRLx/FDA3agARCY+Q6R/WSDE6bkVedREsno9A4/GtAIyLgDBebD54
         9eApgJK50uHGRh2qvNCIg/QoiaR2PWaIIhmZ4VG3Ef2HmHE/ZBfBjqCRR/YPIIpQ5I13
         iOFPX4/E+4mfJNtJdFEusNN9qKzqMxtHosWTXjl/DuuIPyWZCZlk9UzrKn/36sAa7/nW
         UKEA==
X-Received: by 10.107.136.39 with SMTP id k39mr29379000iod.0.1447490227735;
 Sat, 14 Nov 2015 00:37:07 -0800 (PST)
Received: by 10.107.19.227 with HTTP; Sat, 14 Nov 2015 00:36:48 -0800 (PST)
In-Reply-To: <20151114015504.Horde.4mcBf20X0mnolD3xNrtymin@webmail.informatik.kit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281302>

On Fri, Nov 13, 2015 at 4:55 PM, SZEDER G=C3=A1bor <szeder@ira.uka.de> =
wrote:
>
> Hi,
>
> Quoting Jacob Keller <jacob.e.keller@intel.com>:
>
>> From: Jacob Keller <jacob.keller@gmail.com>
>>
>> Extract email aliases from the sendemail.aliasesfile according to th=
e
>> known types. Implementation only extracts the alias name and does no=
t
>> attempt to complete email addresses.
>>
>> Add a few tests for simple layouts of the currently supported alias
>> filetypes.
>>
>> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
>> ---
>>
>> Labeled this RFC because I have only been able to test the mutt form=
at
>> as this is what I use locally. I have a few (probably brittle) test
>> cases for the files, but they are not "real" configuration files as =
per
>> the upstream tools, so they are essentially made to work with the si=
mple
>> extractors that I have now. I'd like some review on this to see if i=
t's
>> valuable, but it definitely helps me type out aliases and see what i=
s
>> available by just using TAB.
>
>
> I think it's definitely valuable, but I'm unsure about parsing the
> different alias file formats in shell (well, in awk...), though some
> of the parses are much simpler than I expected.
> However, 'git send-email' already knows how to parse these files, so
> how about letting it do all the work, i.e. teach it a new 'git
> send-email --list-aliases' option that would only read the config,
> parse the alias file, print all the aliases, i.e. the keys from the
> 'aliases' associative array and exit.  That way we wouldn't have to
> duplicate parts of an already working and tested parsing into a
> different language, the completion script would be simpler, because w=
e
> wouldn't need __git_email_aliases() helper function, it would
> immediately benefit from future bug fixes to 'send-email', and new
> alias file formats would Just Work.
>

Agreed. I hadn't thought about it this way. We could also add email
addresses to the complete list, if that was a reasonable addition?
Maybe not worth it though.

I'll respin a version like this in the next few days.

>
>> contrib/completion/git-completion.bash | 69 ++++++++++++++++++++++++=
++
>> t/t9902-completion.sh                  | 90
>> ++++++++++++++++++++++++++++++++++
>> 2 files changed, 159 insertions(+)
>>
>> diff --git a/contrib/completion/git-completion.bash
>> b/contrib/completion/git-completion.bash
>> index 482ca84b451b..9b786bb390ba 100644
>> --- a/contrib/completion/git-completion.bash
>> +++ b/contrib/completion/git-completion.bash
>> @@ -10,6 +10,7 @@
>> #    *) local and remote tag names
>> #    *) .git/remotes file names
>> #    *) git 'subcommands'
>> +#    *) git email aliases for git-send-email
>> #    *) tree paths within 'ref:path/to/file' expressions
>> #    *) file paths within current working directory and index
>> #    *) common --long-options
>> @@ -785,6 +786,56 @@ __git_aliased_command ()
>>         done
>> }
>>
>> +# Print aliases for email addresses from sendemail.aliasesfile
>> +__git_email_aliases ()
>> +{
>> +       local file=3D"$(git --git-dir=3D"$(__gitdir)" config --path
>> sendemail.aliasesfile)"
>> +       local filetype=3D"$(git --git-dir=3D"$(__gitdir)" config
>> sendemail.aliasfiletype)"
>
>
> Using $(__gitdir) is good.  Running it twice not so much.  fork()ing =
a
> subshell and fork()+exec()ing a git command is expensive on some
> platforms, most importantly Windows.
> Please run it only once, store the returned path in a variable, and
> pass that to the 'git config' commands.
>

Yep. We won't even need this once we just exec git send-email once, anw=
yays.

> Sidenote, just wondering: why are these config keys named
> 'aliasfiletype' and 'alias*es*file'?!
>

No idea, but we can't really fix it now.

>> +       # Only run awk if we find an actual file
>> +       if ! [ -f $file ]; then
>> +               return
>> +       fi
>
>
> According to the docs multiple alias files can be configured, but thi=
s
> would only work with one.
> That 'git send-email --list-aliases' would take care of this, too.
>

Agreed, yep. The --list-aliases sounds like a much stronger approach.

>
>> +
>> +       case "$filetype" in
>> +               # Each file type needs to be parsed differently.
>> +               mutt|mailrc)
>> +                       # Mutt and mailrc are simple and just put th=
e
>> alias in
>> +                       # the 2nd field of the file.
>> +                       awk '{print $2}' $file
>> +                       return
>> +                       ;;
>> +               sendmail)
>> +                       # Skip new lines, lines without fields, and =
lines
>> +                       # ending in '\' then print the name minus th=
e
>> final :
>> +                       awk 'NF && $1!~/^#/ && !/\\$/ {sub(/:$/, "",=
 $1);
>> print $1 }' $file
>> +                       return
>> +                       ;;
>> +               pine)
>> +                       # According to spec, line continuations are =
any
>> line
>> +                       # which starts with whitespace, otherwise we=
 can
>> just
>> +                       # use the normal separator and print the fir=
st
>> field.
>> +                       awk '/^\S/ {print $1}' "$file"
>> +                       return
>> +                       ;;
>> +               elm)
>> +                       # Elm doesn't appear to allow newlines, and
>> +                       # git-send-email only accepts one alias per =
line,
>> so
>> +                       # just print the first field.
>> +                       awk '{print $1}' "$file"
>> +                       return
>> +                       ;;
>> +               gnus)
>> +                       # The gnus format has the alias quoted, so w=
e just
>> use
>> +                       # gsub to extract the alias from the quotes
>> +                       awk '/define-mail-alias/ {gsub(/"/, "", $2);=
 print
>> $2}' $file
>> +                       return
>> +                       ;;
>> +               *)
>> +                       return;;
>> +       esac
>> +}
>
>
> Since there is nothing after the case statement in this function, the
> return statements in each branch are unnecessary, as is the last
> catch-all branch.
>

Sure, though we'd drop this anyways. I'm sensing a wonderful pattern he=
re.

>> +
>> # __git_find_on_cmdline requires 1 argument
>> __git_find_on_cmdline ()
>> {
>> @@ -1735,6 +1786,24 @@ _git_send_email ()
>>                         " "" "${cur##--thread=3D}"
>>                 return
>>                 ;;
>> +       --to=3D*)
>> +               __gitcomp "
>> +               $(__git_email_aliases)
>> +               " "" "${cur##--to=3D}"
>> +               return
>> +               ;;
>> +       --cc=3D*)
>> +               __gitcomp "
>> +               $(__git_email_aliases)
>> +               " "" "${cur##--cc=3D}"
>> +               return
>> +               ;;
>> +       --bcc=3D*)
>> +               __gitcomp "
>> +               $(__git_email_aliases)
>> +               " "" "${cur##--bcc=3D}"
>> +               return
>> +               ;;
>
>
> These case branches look essentially the same except what has to be
> removed from the word being completed.  And what gets removed is
> essentially everything before and including the first '=3D'.
> So how about squashing these three cases into a single (untested) one
> like this:

I tried this, but I wasn't sure if it was reasonable or not inccase
there was an equals later in the section? since glob will match the
longest one?

>
>      --to=3D*|--cc=3D*|--bcc=3D*)
>        __gitcomp "$(__git_email_aliases)" "" "${cur#*=3D}"
>        return
>
>        ;;
>
>>         --*)
>>                 __gitcomp "--annotate --bcc --cc --cc-cmd --chain-re=
ply-to
>>                         --compose --confirm=3D --dry-run --envelope-=
sender
>> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
>> index 2ba62fbc178e..0549f75e6e7c 100755
>> --- a/t/t9902-completion.sh
>> +++ b/t/t9902-completion.sh
>> @@ -404,6 +404,96 @@ test_expect_success '__git_aliases' '
>>         test_cmp expect actual
>> '
>>
>> +test_expect_success '__git_email_aliases (mutt)' '
>> +       cat >aliases <<-EOF &&
>> +       alias user1 Some User <user1@example.org>
>> +       alias user2 random-user-foo@foo.garbage
>> +       EOF
>> +       cat >expect <<-EOF &&
>> +       user1
>> +       user2
>> +       EOF
>> +       test_config sendemail.aliasesfile aliases &&
>> +       test_config sendemail.aliasfiletype mutt &&
>> +       __git_email_aliases >actual &&
>> +       test_cmp expect actual
>> +'
>> +
>> +test_expect_success '__git_email_aliases (mailrc)' '
>> +       cat >aliases <<-EOF &&
>> +       alias user1 Some User <user1@example.org>
>> +       alias user2 random-user-foo@foo.garbage
>> +       EOF
>> +       cat >expect <<-EOF &&
>> +       user1
>> +       user2
>> +       EOF
>> +       test_config sendemail.aliasesfile aliases &&
>> +       test_config sendemail.aliasfiletype mailrc &&
>> +       __git_email_aliases >actual &&
>> +       test_cmp expect actual
>> +'
>> +
>> +test_expect_success '__git_email_aliases (sendmail)' '
>> +       cat >aliases <<-EOF &&
>> +       user1: Some User <user1@example.org>
>> +       user2: random-user-foo@foo.garbage
>> +       EOF
>> +       cat >expect <<-EOF &&
>> +       user1
>> +       user2
>> +       EOF
>> +       test_config sendemail.aliasesfile aliases &&
>> +       test_config sendemail.aliasfiletype sendmail &&
>> +       __git_email_aliases >actual &&
>> +       test_cmp expect actual
>> +'
>> +
>> +test_expect_success '__git_email_aliases (pine)' '
>> +       cat >aliases <<-EOF &&
>> +       user1   Some User       user1@example.org>
>> +       user2   random-user-foo@foo.garbage
>> +       EOF
>> +       cat >expect <<-EOF &&
>> +       user1
>> +       user2
>> +       EOF
>> +       test_config sendemail.aliasesfile aliases &&
>> +       test_config sendemail.aliasfiletype pine &&
>> +       __git_email_aliases >actual &&
>> +       test_cmp expect actual
>> +'
>> +
>> +test_expect_success '__git_email_aliases (elm)' '
>> +       cat >aliases <<-EOF &&
>> +       user1 =3D User; Someone =3D user1@example.org
>> +       user2 =3D =3D user2@garbage.foo
>> +       EOF
>> +       cat >expect <<-EOF &&
>> +       user1
>> +       user2
>> +       EOF
>> +       test_config sendemail.aliasesfile aliases &&
>> +       test_config sendemail.aliasfiletype elm &&
>> +       __git_email_aliases >actual &&
>> +       test_cmp expect actual
>> +'
>> +
>> +test_expect_success '__git_email_aliases (gnus)' '
>> +       cat >aliases <<-EOF &&
>> +       define-mail-alias "user1" "user1@example.org"
>> +       define-mail-alias "user2" "user2@arbitrary.foo"
>> +       EOF
>> +       cat >expect <<-EOF &&
>> +       user1
>> +       user2
>> +       EOF
>> +       test_config sendemail.aliasesfile aliases &&
>> +       test_config sendemail.aliasfiletype gnus &&
>> +       __git_email_aliases >actual &&
>> +       test_cmp expect actual
>> +'
>
>
> I didn't check how the contents of these aliases files conform to eac=
h
> format, but other than that these tests look good.
> But then again, with a 'git send-email --list-aliases' option we
> wouldn't these tests at all.
>

Agreed, we can extend tests for list-aliases but that is even easier.
I really like that approach a lot more.

Regards,
Jake

>
> Thanks,
> G=C3=A1bor
>
>
>> +
>> test_expect_success 'basic' '
>>         run_completion "git " &&
>>         # built-in
>> --
>> 2.6.1.264.gbab76a9
>
>
