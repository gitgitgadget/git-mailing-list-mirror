Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E64FC0E
	for <git@vger.kernel.org>; Fri, 28 Jun 2024 19:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719603051; cv=none; b=RglatRZqIym685ko7bZXq6R7LFA2pvcmkKT3z/zQTbqgi6+pXYY8W4f5S51P4YJBWUgGD6GhWrK89pakctc57GhmIMyZVFG57ysQAOe5ZCK7bXuIPQLWTYSAO5X3Kt5vlFeefngHLqjPpBcN3eQaJWrfd8uGmAyQmtaxU9yr/54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719603051; c=relaxed/simple;
	bh=wTpVi2uvUG51574VteB15DuTYYBh97Y5+ptcaAver88=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Zs8EsipKiEFU1qmEmVcQeN7ESY0e5D+qhOlibLNbdC/3JWA2Gk6MZ5cPWhLMc8k/U/+7j6MFLQflf8XZFUMJHCqyEIcWzy5M5cSc9x2xzwVTsNsjKgKk6oqJSZPBQ6DuEHd2opO3g8QVX6av4tu2tabWQvHDkmakp2E1xmy5kJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=iWHsifuY; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="iWHsifuY"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 1D48032F90;
	Fri, 28 Jun 2024 15:30:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=wTpVi2uvUG51
	574VteB15DuTYYBh97Y5+ptcaAver88=; b=iWHsifuYWC7eqspI/RmlaksdVA3s
	ftJ7FpLG5fbEr8w0llKEkPchRwA07xW+0JEP+aPOz3p45gNaKOZQAjwHTbWbjIN2
	fiwMnPJhMEwx1CYJADRTV/L8C/yZehKcUfXQo2ROZIdYpZMzSGqKa6ON4ws9hg1K
	MLm6NOTB+ezbJVM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 157BB32F8F;
	Fri, 28 Jun 2024 15:30:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A225732F8E;
	Fri, 28 Jun 2024 15:30:39 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Cs=C3=B3k=C3=A1s=2C_Bence?= <csokas.bence@prolan.hu>
Cc: <git@vger.kernel.org>
Subject: Re: [PATCH v3] git-send-email: Use sanitized address when reading
 mbox body
In-Reply-To: <20240628085018.65076-2-csokas.bence@prolan.hu>
 (=?utf-8?B?IkNzw7Nrw6FzLA==?=
	Bence"'s message of "Fri, 28 Jun 2024 10:50:19 +0200")
References: <20240628085018.65076-2-csokas.bence@prolan.hu>
Date: Fri, 28 Jun 2024 12:30:38 -0700
Message-ID: <xmqq1q4g3lwh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 E6DA0368-3584-11EF-98B8-DFF1FEA446E2-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

"Cs=C3=B3k=C3=A1s, Bence" <csokas.bence@prolan.hu> writes:

> Commas and other punctuation marks in 'Cc: ', 'Signed-off-by: '
> etc. lines mess with git-send-email.

Calling these "trailers" would make it more obvious that you are
talking about parts of the log message ("S-o-b" would not be
mistaken as an e-mail header, but you cannot complain if a reader
mistook the mention of "Cc" as a reference to an e-mail header).

More importantly, "mess with" is true when potentially
address-looking strings from the trailer lines are added to @cc
list.  So perhaps

    Addresses that are mentioned on the trailers in the commit log
    messages (e.g., "Reviewed-by") are added to the "Cc:" list
    (unless suppressed) by "git send-email".  These hand-written
    addresses may be malformed (e.g., having unquoted "." and other
    punctutation marks in the display-name part).

> This is handled by calling
> `sanitize_address()` before adding addresses to @cc. This function
> was already being called, but was only used for comparing it to
> $author for suppression purposes.

So this is not telling the truth.  This is *NOT* handled by calling
the helper function, as the result is *NOT* added to @cc.  I would
suggest striking this paragraph (and the rest of the log message)
out and rewrite, perhaps like so:

    The code does use sanitize_address on these address-looking
    strings to make them into valid addresses, but the result was
    used only to see if the address should be suppressed.  The
    original string taken from the message was added to the @cc list.

    Because the addresses on trailer lines are hand-written and more
    likely to contain malformed addresses, when adding to the @cc
    list, use the result from sanitize_address, not the original.

    Note that we do not modify the behaviour for addresses taken
    from the e-mail headers, as they are more likely to be machine
    generated and well-formed.

or something.

> diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
> index 58699f8e4e..8bbbf20855 100755
> --- a/t/t9001-send-email.sh
> +++ b/t/t9001-send-email.sh
> @@ -1299,6 +1299,57 @@ test_expect_success $PREREQ 'utf8 sender is not =
duplicated' '
>  	test_line_count =3D 1 msgfrom
>  '
> =20
> +test_expect_success $PREREQ 'setup expect for cc list' "
> +cat >expected-cc <<\EOF
> +!recipient@example.com!
> +!author@example.com!
> +!one@example.com!
> +!odd_?=3Dmail@example.com!
> +!doug@example.com!
> +!thor.au@example.com!
> +EOF
  > +"
> +
> +test_expect_success $PREREQ 'cc list is sanitized' '
> +	clean_fake_sendmail &&
> +	test_commit weird_cc_body &&
> +	test_when_finished "git reset --hard HEAD^" &&
> +	git commit --amend -F - <<-EOF &&
> +	Test Cc: sanitization.
> +
> +	Cc: Person, One <one@example.com>
> +	Reviewed-by: F=C3=BC=C3=B1n=C3=BD N=C3=A2m=C3=A9 <odd_?=3Dmail@exampl=
e.com>
> +	Reported-by: bugger on Jira
> +	Reported-by: Douglas Reporter <doug@example.com> [from Jira profile]
> +	BugID: 12345
> +	Signed-off-by: A. U. Thor <thor.au@example.com>
> +	EOF
> +	git send-email -1 --to=3Drecipient@example.com \
> +		--smtp-server=3D"$(pwd)/fake.sendmail" >actual-show-all-headers &&
> +	test_cmp expected-cc commandline1 &&
> +	test_grep "^(body) Adding cc: \"Person, One\" <one@example.com>" actu=
al-show-all-headers &&
> +	test_grep "^(body) Adding cc: =3D?UTF-8?q?F=3DC3=3DBC=3DC3=3DB1n=3DC3=
=3DBD=3D20N=3DC3=3DA2m=3DC3=3DA9?=3D"\
> +" <odd_?=3Dmail@example.com>" actual-show-all-headers &&
> +	test_grep "^(body) Adding cc: Douglas Reporter <doug@example.com>" ac=
tual-show-all-headers &&
> +	test_grep "^(body) Adding cc: \"A. U. Thor\" <thor.au@example.com>" a=
ctual-show-all-headers
> +'

The test does not check that "bugger on Jira" and "12345" are not
used as recipients, but it should.  Otherwise your effort to add the
extra trailers to the test goes wasted.

It is a good choice to use Reported-by and BugID as two extra ones,
by the way.  The mechanisms that causes them omitted from the
resulting message are different.

> +
> +test_expect_success $PREREQ 'quotes are sanitized in cc list' "
> +	clean_fake_sendmail &&
> +	test_commit quote_in_cc_body &&
> +	test_when_finished \"git reset --hard HEAD^\" &&
> +	git commit --amend -F - <<-EOF &&
> +	Quotation marks sanitization in Cc:.
> +
> +	Cc: P'erson, One <one@example.com>
> +	Reported-by: \"Douglas 'Bug' Reporter\" <doug@example.com>
> +	EOF

Quoting the test body in a pair of double quotes is error prone.  Do
not do it (and you do have a bug here that was caused by it).

Rather, write ${SQ} where you would write a single quote in your
test body, and enclose the test body in a pair of single quotes,
like everybody else does.

> +	git send-email -1 --to=3Drecipient@example.com \
> +		--smtp-server=3D\"$(pwd)/fake.sendmail\" >actual-show-all-headers &&

Here is the bug.  This $(pwd) command substition is done *before*
the test runs---it is expanded while the shell computes the command
line to run test_expect_success (as part of the test body string
that is quoted in a pair of double-quotes).  So if your cwd has a
character that needs to be quoted inside double-quotes to be a valid
value for the "--smtp-server" option, you end up breaking the shell
quoting rules.  In other words: what happens if your $(pwd) has a
double-quote in it?

> +	test_grep \"^(body) Adding cc: \\\"P'erson, One\\\" <one@example.com>=
\" actual-show-all-headers &&
> +	test_grep \"^(body) Adding cc: \\\"Douglas 'Bug' Reporter\\\" <doug@e=
xample.com>\" actual-show-all-headers
> +"
> +

So, I do not see a strong reason why we want to have this as a
separate test.  We can write and test addresses with single quotes
in it as part of the previous test.

A squashable change on top of your version is attached at the end.

 * Added a name with apostrophe in it on the Cc: line, and check
   that the address appears on the recipient list and also in the
   log.

 * Added checks for "Reported-by: bugger on Jira" that explicitly
   gets ignored in the log, and "BugId:" that is not even considered
   for Cc: (in other words, not appearing in the log at all).

Thanks.

 t/t9001-send-email.sh | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git c/t/t9001-send-email.sh w/t/t9001-send-email.sh
index 658f3a72ae..64c56677cd 100755
--- c/t/t9001-send-email.sh
+++ w/t/t9001-send-email.sh
@@ -1304,6 +1304,7 @@ cat >expected-cc <<\EOF
 !recipient@example.com!
 !author@example.com!
 !one@example.com!
+!os@example.com!
 !odd_?=3Dmail@example.com!
 !doug@example.com!
 !thor.au@example.com!
@@ -1318,6 +1319,7 @@ test_expect_success $PREREQ 'cc list is sanitized' =
'
 	Test Cc: sanitization.
=20
 	Cc: Person, One <one@example.com>
+	Cc: Ronnie O${SQ}Sullivan <os@example.com>
 	Reviewed-by: F=C3=BC=C3=B1n=C3=BD N=C3=A2m=C3=A9 <odd_?=3Dmail@example.=
com>
 	Reported-by: bugger on Jira
 	Reported-by: Douglas Reporter <doug@example.com> [from Jira profile]
@@ -1328,28 +1330,15 @@ test_expect_success $PREREQ 'cc list is sanitized=
' '
 		--smtp-server=3D"$(pwd)/fake.sendmail" >actual-show-all-headers &&
 	test_cmp expected-cc commandline1 &&
 	test_grep "^(body) Adding cc: \"Person, One\" <one@example.com>" actual=
-show-all-headers &&
+	test_grep "^(body) Adding cc: Ronnie O${SQ}Sullivan <os@example.com>" a=
ctual-show-all-headers &&
 	test_grep "^(body) Adding cc: =3D?UTF-8?q?F=3DC3=3DBC=3DC3=3DB1n=3DC3=3D=
BD=3D20N=3DC3=3DA2m=3DC3=3DA9?=3D"\
 " <odd_?=3Dmail@example.com>" actual-show-all-headers &&
+	test_grep "^(body) Ignoring Reported-by .* bugger on Jira" actual-show-=
all-headers &&
 	test_grep "^(body) Adding cc: Douglas Reporter <doug@example.com>" actu=
al-show-all-headers &&
+	test_grep ! "12345" actual-show-all-headers &&
 	test_grep "^(body) Adding cc: \"A. U. Thor\" <thor.au@example.com>" act=
ual-show-all-headers
 '
=20
-test_expect_success $PREREQ 'quotes are sanitized in cc list' "
-	clean_fake_sendmail &&
-	test_commit quote_in_cc_body &&
-	test_when_finished \"git reset --hard HEAD^\" &&
-	git commit --amend -F - <<-EOF &&
-	Quotation marks sanitization in Cc:.
-
-	Cc: P'erson, One <one@example.com>
-	Reported-by: \"Douglas 'Bug' Reporter\" <doug@example.com>
-	EOF
-	git send-email -1 --to=3Drecipient@example.com \
-		--smtp-server=3D\"$(pwd)/fake.sendmail\" >actual-show-all-headers &&
-	test_grep \"^(body) Adding cc: \\\"P'erson, One\\\" <one@example.com>\"=
 actual-show-all-headers &&
-	test_grep \"^(body) Adding cc: \\\"Douglas 'Bug' Reporter\\\" <doug@exa=
mple.com>\" actual-show-all-headers
-"
-
 test_expect_success $PREREQ 'sendemail.composeencoding works' '
 	clean_fake_sendmail &&
 	git config sendemail.composeencoding iso-8859-1 &&
