From: Erick Mattos <erick.mattos@gmail.com>
Subject: Re: [PATCH] commit -c/-C/--amend: acquire authorship and restamp time 
	with --claim
Date: Sun, 1 Nov 2009 18:57:37 -0200
Message-ID: <55bacdd30911011257m22ee85f2wc5d51865f7f2aadd@mail.gmail.com>
References: <1257099580-7365-1-git-send-email-erick.mattos@gmail.com> 
	<1257101127-8196-1-git-send-email-erick.mattos@gmail.com> 
	<7vr5sixbd1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 01 21:58:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N4hV1-0007Rd-3w
	for gcvg-git-2@lo.gmane.org; Sun, 01 Nov 2009 21:58:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753434AbZKAU5z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 Nov 2009 15:57:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753401AbZKAU5y
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Nov 2009 15:57:54 -0500
Received: from mail-yw0-f202.google.com ([209.85.211.202]:56719 "EHLO
	mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753362AbZKAU5x convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 Nov 2009 15:57:53 -0500
Received: by ywh40 with SMTP id 40so3989486ywh.33
        for <git@vger.kernel.org>; Sun, 01 Nov 2009 12:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=8xjjTfW1skfqeuLaaN84vBVypikshNKXKdAhoAkkHJU=;
        b=nuAXnD49zUgtLn02mqSg/yr3bPocujlJP4b8SvkNVVjqJIixgdaXGkwJd87WsZziLm
         makPY3ZZjPP4WeTy43uA4L73UL44jmLVe4zdIgCsQmiDSgZk7D2xHk8jEqJL0ZtnyL5t
         GIF+9f3YSKpTiGTH1retdU6WD8/hcqy91fVA0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=qnGH1Rx3QPkX7mZ9uaBQsWLp8z9/ypPnKKWAk5VNqW9k6+i/yXaC3lsTMrWoLBAySM
         Z1tLF06LHy9FP2CzHgF58lxRaI248cO3zXnW69QM8N51MiQnrQyoVQ/x/l1pK1RXTy5k
         I8pkCEGDHEtnQwbzxVveqOIb5OzX+GNeK7wA0=
Received: by 10.150.46.15 with SMTP id t15mr6994750ybt.253.1257109077172; Sun, 
	01 Nov 2009 12:57:57 -0800 (PST)
In-Reply-To: <7vr5sixbd1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131879>

2009/11/1 Junio C Hamano <gitster@pobox.com>:
> Erick Mattos <erick.mattos@gmail.com> writes:
>
>> The new --claim option is meant to solve this need by regenerating t=
he
>> timestamp and setting as new author the committer or the one specifi=
ed
>> on --author option.
>
> Thanks.
>
> I don't think "claim" is a good name for this option. =C2=A0It makes =
me go
> "huh, I do not get it. =C2=A0What are you claiming? =C2=A0Claiming th=
at this is the
> correct fix?"
>
> Renaming it to "claim-authorship" may avoid that confusion, but it is=
 too
> long.
>
> How about naming this option "mine"?

Makes sense: "mine" then.  I felt you haven't like the name.

>> @@ -61,14 +61,19 @@ OPTIONS
>> =C2=A0-C <commit>::
>> =C2=A0--reuse-message=3D<commit>::
>> =C2=A0 =C2=A0 =C2=A0 Take an existing commit object, and reuse the l=
og message
>> - =C2=A0 =C2=A0 and the authorship information (including the timest=
amp)
>> - =C2=A0 =C2=A0 when creating the commit.
>> + =C2=A0 =C2=A0 and the authorship information when creating the com=
mit.
>
> I don't think this is a good change.
>
> When you use the new option, the author name, email and timestamp are
> ignored, and when you don't, they are all used.
>
> To new users who are taught to first set user.name and user.email via
> configuration variables, the phrase "authorship information" would me=
an
> <name, email> pair, and the explanation in the parentheses helps to a=
void
> a misunderstanding that these two are the only things that are copied=
=2E
>
> I would suggest you keep the original text.

I think it is pointless but if you say so.

>> +--claim::
>> + =C2=A0 =C2=A0 When used with -C/-c/--amend options, declare that t=
he
>> + =C2=A0 =C2=A0 authorship of the resulting commit now belongs of th=
e committer.
>> + =C2=A0 =C2=A0 This also renews the author timestamp. =C2=A0Therefo=
re this option
>> + =C2=A0 =C2=A0 sets the use of only the message from the original c=
ommit.
>
> I don't understand/parse the last sentence; I don't think it is neces=
sary,
> either.

Just trying to clarify.  I think people that would be searching for
renewing timestamp as I was would find it easier to identify the
correct option.

>> diff --git a/builtin-commit.c b/builtin-commit.c
>> index c395cbf..919e3fe 100644
>> --- a/builtin-commit.c
>> +++ b/builtin-commit.c
>> @@ -51,7 +51,7 @@ static const char *template_file;
>> =C2=A0static char *edit_message, *use_message;
>> =C2=A0static char *author_name, *author_email, *author_date;
>> =C2=A0static int all, edit_flag, also, interactive, only, amend, sig=
noff;
>> -static int quiet, verbose, no_verify, allow_empty, dry_run;
>> +static int quiet, verbose, no_verify, allow_empty, dry_run, claim;
>
> Even if you name the command option "claim" in order to keep it short=
, I
> think it is a bad idea to name the variable "claim", because it doesn=
't
> say _what_ you are claiming and is confusing. =C2=A0Naming it claim_a=
uthorship
> would be better.

Changed to mine.

>> + =C2=A0 =C2=A0 OPT_BOOLEAN(0, "claim", &claim, "acquire authorship =
and restamp time of resulting commit"),
>
> It is unclear from where it is "acquire"-ing, nor what "restamp" mean=
s.
>
> Here are my attempts to come up with better wording:
>
> =C2=A0 =C2=A0"ignore author and timestamp of the original commit (use=
d with -C/-c/--amend)"
> =C2=A0 =C2=A0"the commit is authored by me now (used with -C/-c/--ame=
nd)"

What about "take new timestamp and make me new author (with -C/-c/--ame=
nd)"?

> The latter will work well if the option is renamed to "--mine".
>
> What should happen when the user uses --claim without -C/-c/--amend?
>
> =C2=A0 =C2=A0% git commit --claim
>
> Should you detect an error? =C2=A0Does your code do so? =C2=A0Do you =
have a test
> that catches this error?

You say it.  In the first patch of mine I was testing for
--(new|old)-timestamp.  Now I thought it was unnecessary because the
normal behavior is documented and by comparison with other options
which does not test combinations extensively.  But it is just code to
add if you want...

> What should happen when the user uses --author and --claim at the sam=
e time?
>
> =C2=A0 =C2=A0% git commit --claim --author=3D'Erick Mattos <eric@matt=
os>' -C HEAD
>
> Should you detect an error? =C2=A0Does your code do so? =C2=A0Do you =
have a test
> that catches this error?

It works as intended.  Both together.

>> diff --git a/t/t7509-commit.sh b/t/t7509-commit.sh
>> new file mode 100755
>> index 0000000..62fb00f
>> --- /dev/null
>> +++ b/t/t7509-commit.sh
>> @@ -0,0 +1,87 @@
>> +#!/bin/sh
>> +#
>> +# Copyright (c) 2009 Erick Mattos
>> +#
>> +
>> +test_description=3D'git commit
>> +
>> +Tests for --claim option on a commit.'
>> +
>> +. ./test-lib.sh
>> +
>> +TEST_FILE=3D"$PWD"/foo
>
> Why does this have to be given as a full path, not just "foo"?

Templating from other scripts.  Ask them...   :-)

>> +test_expect_success '-C option should be working' '
>
> Every test is about "should be working", so you are wasting 16 letter=
s or
> so without giving any useful information.
>
> Say something like "-C without --claim uses the author from the old c=
ommit" here.
>
>> + =C2=A0 =C2=A0 echo "Initial" > "$TEST_FILE" &&
>> + =C2=A0 =C2=A0 git add "$TEST_FILE" &&
>> + =C2=A0 =C2=A0 git commit -m "Initial Commit" --author Frigate\ \<f=
lying@over.world\> &&
>> + =C2=A0 =C2=A0 sleep 1 &&
>
> If you use "test_tick", you don't have to slow the test down. You use
> "test_tick" before you commit to increment the time. Look at t6036 fo=
r an
> example.

Easy change.

>> + =C2=A0 =C2=A0 echo "Test 1" >> "$TEST_FILE" &&
>> + =C2=A0 =C2=A0 git add "$TEST_FILE" &&
>> + =C2=A0 =C2=A0 git commit -C HEAD &&
>> + =C2=A0 =C2=A0 git cat-file -p HEAD^ | sed -e '/^parent/d' -e '/^tr=
ee/d' -e '/^committer/d' > commit_1 &&
>> + =C2=A0 =C2=A0 git cat-file -p HEAD | sed -e '/^parent/d' -e '/^tre=
e/d' -e '/^committer/d' > commit_2 &&
>> + =C2=A0 =C2=A0 cmp commit_1 commit_2
>> +'
>
> Use "test_cmp" instead, so that errors can be seen easily when somebo=
dy
> breaks this new feature.

Easy change.

>> +test_expect_success '-C option with --claim is working properly' '
>
> Again, "working properly" is a meaningless thing to say because that =
is
> what all tests check. "-C with --claim makes me the author" would be
> better.
>
>> + =C2=A0 =C2=A0 sleep 1 &&
>> + =C2=A0 =C2=A0 echo "Test 2" >> "$TEST_FILE" &&
>> + =C2=A0 =C2=A0 git add "$TEST_FILE" &&
>> + =C2=A0 =C2=A0 git commit -C HEAD^ --claim &&
>> + =C2=A0 =C2=A0 git cat-file -p HEAD^ | grep '^author' > commit_1 &&
>> + =C2=A0 =C2=A0 git cat-file -p HEAD | grep '^author' > commit_2 &&
>> + =C2=A0 =C2=A0 test_must_fail cmp commit_1 commit_2
>
> This test shouldn't be happy with any random author information that
> happens to be different from the original. The purpose of --claim opt=
ion
> is to take the authorship, make it mine (or whoever is specified with
> GIT_AUTHOR_NAME or user.name or uid-to-gecos), so the last cmp (again=
, it
> should use test_cmp) should make sure that the author is 'A U Thor', =
not
> just being different from "Frigate" or whatever. =C2=A0It should chec=
k email
> and timestamp as well, of course.

Good point but the text imho is a little unnecessary because the
change could only be to user.name, user.email, ...
But if want that it will be an easy change too.

>> +'
>> +
>> +test_expect_success '-c option should be working' '
>> + =C2=A0 =C2=A0 echo "Initial" > "$TEST_FILE" &&
>> + =C2=A0 =C2=A0 git add "$TEST_FILE" &&
>> + =C2=A0 =C2=A0 git commit -m "Initial Commit" --author Frigate\ \<f=
lying@over.world\> &&
>> + =C2=A0 =C2=A0 sleep 1 &&
>> + =C2=A0 =C2=A0 echo "Test 3" >> "$TEST_FILE" &&
>> + =C2=A0 =C2=A0 git add "$TEST_FILE" &&
>> + =C2=A0 =C2=A0 git commit -c HEAD <<EOF
>> + =C2=A0 =C2=A0 "Changed"
>> + =C2=A0 =C2=A0 EOF &&
>
> What editor is reading this "Changed"?
>

Nobody cares...  Just a text to change the file.
