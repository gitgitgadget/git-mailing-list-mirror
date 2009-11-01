From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] commit -c/-C/--amend: acquire authorship and restamp
 time with --claim
Date: Sun, 01 Nov 2009 12:02:02 -0800
Message-ID: <7vr5sixbd1.fsf@alter.siamese.dyndns.org>
References: <1257099580-7365-1-git-send-email-erick.mattos@gmail.com>
 <1257101127-8196-1-git-send-email-erick.mattos@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Erick Mattos <erick.mattos@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 01 21:02:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N4gd2-0000mQ-2q
	for gcvg-git-2@lo.gmane.org; Sun, 01 Nov 2009 21:02:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753230AbZKAUCJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Nov 2009 15:02:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752917AbZKAUCI
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Nov 2009 15:02:08 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:42032 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752264AbZKAUCH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Nov 2009 15:02:07 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 180AB8EA1A;
	Sun,  1 Nov 2009 15:02:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3krsYU8U3qCKmbkPiMmXQYhtPWA=; b=GC4A0n
	3AO6jqKXofH478ANh0vniZiTbjq1pcKUH92H6rDyoo0+kQu/5OvveqN2foCBkdRi
	P+bsVgpnQB+w4VgGy2GwFmTs8cc645YeNRERx25Pw2nxHCTBQyrieslbY9VjGq2X
	tdGtcYEpPHn4GTi+4WlfNoUYXby35AxOJ/ei8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Y4KP2RfrpRShiG3KAxVmBcTBEJCSIppl
	+raNrfhqWQUmbJ1PyI2bgpdQLlzUu2T4nR+JEF6c+iMavNGYzbuW7i/uVq220JHn
	PaM1x/gwCghsr+SbF7QwQUQTZrFrH++fRubCkFvfol2uxJwMx/dUNuoPWu3ZorL1
	MViJ4lcJqCY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EE6218EA19;
	Sun,  1 Nov 2009 15:02:07 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 96E3B8EA18; Sun,  1 Nov 2009
 15:02:04 -0500 (EST)
In-Reply-To: <1257101127-8196-1-git-send-email-erick.mattos@gmail.com> (Erick
 Mattos's message of "Sun\,  1 Nov 2009 16\:45\:27 -0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6F176154-C721-11DE-9471-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131875>

Erick Mattos <erick.mattos@gmail.com> writes:

> The new --claim option is meant to solve this need by regenerating the
> timestamp and setting as new author the committer or the one specified
> on --author option.

Thanks.

I don't think "claim" is a good name for this option.  It makes me go
"huh, I do not get it.  What are you claiming?  Claiming that this is the
correct fix?"

Renaming it to "claim-authorship" may avoid that confusion, but it is too
long.

How about naming this option "mine"?

> @@ -61,14 +61,19 @@ OPTIONS
>  -C <commit>::
>  --reuse-message=<commit>::
>  	Take an existing commit object, and reuse the log message
> -	and the authorship information (including the timestamp)
> -	when creating the commit.
> +	and the authorship information when creating the commit.

I don't think this is a good change.

When you use the new option, the author name, email and timestamp are
ignored, and when you don't, they are all used.

To new users who are taught to first set user.name and user.email via
configuration variables, the phrase "authorship information" would mean
<name, email> pair, and the explanation in the parentheses helps to avoid
a misunderstanding that these two are the only things that are copied.

I would suggest you keep the original text.

> +--claim::
> +	When used with -C/-c/--amend options, declare that the
> +	authorship of the resulting commit now belongs of the committer.
> +	This also renews the author timestamp.  Therefore this option
> +	sets the use of only the message from the original commit.

I don't understand/parse the last sentence; I don't think it is necessary,
either.

> diff --git a/builtin-commit.c b/builtin-commit.c
> index c395cbf..919e3fe 100644
> --- a/builtin-commit.c
> +++ b/builtin-commit.c
> @@ -51,7 +51,7 @@ static const char *template_file;
>  static char *edit_message, *use_message;
>  static char *author_name, *author_email, *author_date;
>  static int all, edit_flag, also, interactive, only, amend, signoff;
> -static int quiet, verbose, no_verify, allow_empty, dry_run;
> +static int quiet, verbose, no_verify, allow_empty, dry_run, claim;

Even if you name the command option "claim" in order to keep it short, I
think it is a bad idea to name the variable "claim", because it doesn't
say _what_ you are claiming and is confusing.  Naming it claim_authorship
would be better.

> +	OPT_BOOLEAN(0, "claim", &claim, "acquire authorship and restamp time of resulting commit"),

It is unclear from where it is "acquire"-ing, nor what "restamp" means.

Here are my attempts to come up with better wording:

    "ignore author and timestamp of the original commit (used with -C/-c/--amend)"
    "the commit is authored by me now (used with -C/-c/--amend)"

The latter will work well if the option is renamed to "--mine".

What should happen when the user uses --claim without -C/-c/--amend?

    % git commit --claim

Should you detect an error?  Does your code do so?  Do you have a test
that catches this error?

What should happen when the user uses --author and --claim at the same time?

    % git commit --claim --author='Erick Mattos <eric@mattos>' -C HEAD

Should you detect an error?  Does your code do so?  Do you have a test
that catches this error?

> diff --git a/t/t7509-commit.sh b/t/t7509-commit.sh
> new file mode 100755
> index 0000000..62fb00f
> --- /dev/null
> +++ b/t/t7509-commit.sh
> @@ -0,0 +1,87 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2009 Erick Mattos
> +#
> +
> +test_description='git commit
> +
> +Tests for --claim option on a commit.'
> +
> +. ./test-lib.sh
> +
> +TEST_FILE="$PWD"/foo

Why does this have to be given as a full path, not just "foo"?

> +test_expect_success '-C option should be working' '

Every test is about "should be working", so you are wasting 16 letters or
so without giving any useful information.

Say something like "-C without --claim uses the author from the old commit" here.

> +	echo "Initial" > "$TEST_FILE" && 
> +	git add "$TEST_FILE" && 
> +	git commit -m "Initial Commit" --author Frigate\ \<flying@over.world\> && 
> +	sleep 1 && 

If you use "test_tick", you don't have to slow the test down. You use
"test_tick" before you commit to increment the time. Look at t6036 for an
example.

> +	echo "Test 1" >> "$TEST_FILE" && 
> +	git add "$TEST_FILE" && 
> +	git commit -C HEAD && 
> +	git cat-file -p HEAD^ | sed -e '/^parent/d' -e '/^tree/d' -e '/^committer/d' > commit_1 && 
> +	git cat-file -p HEAD | sed -e '/^parent/d' -e '/^tree/d' -e '/^committer/d' > commit_2 && 
> +	cmp commit_1 commit_2
> +'

Use "test_cmp" instead, so that errors can be seen easily when somebody
breaks this new feature.

> +test_expect_success '-C option with --claim is working properly' '

Again, "working properly" is a meaningless thing to say because that is
what all tests check. "-C with --claim makes me the author" would be
better.

> +	sleep 1 &&
> +	echo "Test 2" >> "$TEST_FILE" &&
> +	git add "$TEST_FILE" &&
> +	git commit -C HEAD^ --claim &&
> +	git cat-file -p HEAD^ | grep '^author' > commit_1 &&
> +	git cat-file -p HEAD | grep '^author' > commit_2 &&
> +	test_must_fail cmp commit_1 commit_2

This test shouldn't be happy with any random author information that
happens to be different from the original. The purpose of --claim option
is to take the authorship, make it mine (or whoever is specified with
GIT_AUTHOR_NAME or user.name or uid-to-gecos), so the last cmp (again, it
should use test_cmp) should make sure that the author is 'A U Thor', not
just being different from "Frigate" or whatever.  It should check email
and timestamp as well, of course.

> +'
> +
> +test_expect_success '-c option should be working' '
> +	echo "Initial" > "$TEST_FILE" && 
> +	git add "$TEST_FILE" && 
> +	git commit -m "Initial Commit" --author Frigate\ \<flying@over.world\> && 
> +	sleep 1 && 
> +	echo "Test 3" >> "$TEST_FILE" && 
> +	git add "$TEST_FILE" && 
> +	git commit -c HEAD <<EOF
> +	"Changed" 
> +	EOF && 

What editor is reading this "Changed"?
