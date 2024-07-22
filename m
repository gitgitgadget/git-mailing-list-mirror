Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FF916DEC9
	for <git@vger.kernel.org>; Mon, 22 Jul 2024 17:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721668984; cv=none; b=Y1M64khcJW9OAsGdoD5zIWLrZfUWURarw3KP2G9Gv+LxlicR+0dUDptdKQS5sdCsZ5avoxYe3ySyItsDObxdiqQTECwzl0fx/uGKbSBzAPrrdWqDTUrplV6hmlJdT1Cn8rExyE/lAmIZ3H4dekhl04tjC5RUBr02NYVGS6YSatE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721668984; c=relaxed/simple;
	bh=mEeqPTBuKDJHplvDEJMExd1sG8Nq5s0wUVQy8zdWnlM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=t5ZJ3HmrhWike11phC63wWeg0AA43gy69VJ++6l8am/VGhe3OiFUuAQBFpzMjPCE358Viuti1Ip9XtNNFuG+46CnnkxeLMCEnx9JiBqI+NelxIVcHhv/QGAtRALcDvlOg+JO+i8DqfYNNL6s08/M2D6/Q4ZeIk3x2oIwkr9Fmkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=hqgGDyKu; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hqgGDyKu"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3859520442;
	Mon, 22 Jul 2024 13:23:01 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=mEeqPTBuKDJH
	plvDEJMExd1sG8Nq5s0wUVQy8zdWnlM=; b=hqgGDyKuCkeNQmEgftYKUVOCxJMf
	dMBxejgCJ6IPkeC89TLo/i9fhByLf8oAcaxOdQtxR48DyQqwZiJaZ6XNq6ovGfLm
	yFD1Mc2+nLNRS2Zx4OnBymjOSCv2OAPlRyl00+GQMR0hR/rwNA2W8Cgw2CJm1cL/
	nA28NtiOX4zcTFA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2621520441;
	Mon, 22 Jul 2024 13:23:01 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 36D8120440;
	Mon, 22 Jul 2024 13:23:00 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: phillip.wood@dunelm.org.uk,  Git List <git@vger.kernel.org>,  Dragan
 Simic <dsimic@manjaro.org>,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 4/4] add-patch: render hunks through the pager
In-Reply-To: <a2ea00e2-08e4-4e6b-b81c-ef3ba02b4b1f@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
	message of "Sun, 21 Jul 2024 00:29:44 +0200")
References: <2653fb37-c8a8-49b1-a804-4be6654a2cad@gmail.com>
	<ebcba08f-3fbb-4130-93eb-d0e62bfe0a8a@gmail.com>
	<efa98aec-f117-4cfe-a7c2-e8c0adbdb399@gmail.com>
	<1dc9ebad-768b-4c1a-8a58-8a7a5d24d49e@gmail.com>
	<xmqqttgqyzwa.fsf@gitster.g>
	<2b57479c-29c8-4a6e-b7b0-1309395cfbd9@gmail.com>
	<88f9256e-04ba-4799-8048-406863054106@gmail.com>
	<a2ea00e2-08e4-4e6b-b81c-ef3ba02b4b1f@gmail.com>
Date: Mon, 22 Jul 2024 10:22:58 -0700
Message-ID: <xmqqv80xcpe5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 0B635036-484F-11EF-942F-34EEED2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

>> > +	test_write_lines P q |
>> > +	(
>> > +		GIT_PAGER=3D"head -n 1" &&
>> > +		export GIT_PAGER &&
>> > +		test_terminal git add -p >actual
>> > +	)
>>=20
>> That's surprising, why does running git in a sub-shell stop it from
>> segfaulting?
>
> The fix isn't the sub-shell;  it's "export GIT_PAGER".
> ...
> Because GIT_PAGER is not being set correctly in the test, "git add -p"
> can use the values defined in the environment where the test is running=
.
> Usually PAGER is empty or contains "less", but in the environment where
> the fault occurs, it happens to be: "PAGER=3Dcat".=20
>
> Since we have an optimization to avoid forking if the pager is "cat",
> courtesy of caef71a535 (Do not fork PAGER=3Dcat, 2006-04-16), then we f=
ail
> in `wait_for_pager()` because we are calling `finish_command()` with an
> uninitialized `pager_process`.

Attached at the end is a test tweak patch, taking inspirations from
Phillip's comments, to see what value GIT_PAGER has in the shell
function.  I shortened the huge_file a bit so that I do not have to
have an infinite scrollback buffer,but otherwise, the test_quirk
intermediate shell function should work just like the test_terminal
helper in the original position would.

And I see in the output from "sh t3701-add-interactive.sh -i -v":

    expecting success of 3701.51 'P handles SIGPIPE when writing to pager=
':=20
            test_when_finished "rm -f huge_file; git reset" &&
            printf "\n%250s" Y >huge_file &&
            git add -N huge_file &&
            echo "in env: GIT_PAGER=3D$(env | grep GIT_PAGER=3D)" &&
            test_write_lines P q | GIT_PAGER=3D"head -n 1" test_quirk &&
            echo "after test_quirk returns: GIT_PAGER=3D$GIT_PAGER"

    in env: GIT_PAGER=3D
    in test_quirk: GIT_PAGER=3Dhead -n 1
    in env: GIT_PAGER=3DGIT_PAGER=3Dhead -n 1
    In test_terminal: GIT_PAGER=3DGIT_PAGER=3Dhead -n 1
    test-terminal: GIT_PAGER=3Dhead -n 1
    diff --git a/huge_file b/huge_file
    new file mode 100644
    index 0000000..d06820d
    --- /dev/null
    +++ b/huge_file
    @@ -0,0 +1,2 @@
    +
    +                                                                    =
                                                                         =
                                                                         =
                                   Y
    \ No newline at end of file
    (1/1) Stage addition [y,n,q,a,d,e,p,?]? @@ -0,0 +1,2 @@
    (1/1) Stage addition [y,n,q,a,d,e,p,?]?=20
    after test_quirk returns: GIT_PAGER=3D
    Unstaged changes after reset:
    M       test
    ok 51 - P handles SIGPIPE when writing to pager

So:

 - before the one-shot thing, in the envrionment GIT_PAGER is empty.
 - in the helper function,
   - shell variable GIT_PAGER is set to the expected value.
   - GIT_PAGER env is exported.
   - test-terminal.perl sees $ENV{GIT_PAGER} set to the expected value.
 - after the helper returns GIT_PAGER is empty

It's a very convincing theory but it does not seem to match my
observation.  Is there a difference in shells used, or something?

 t/lib-terminal.sh          |  3 +++
 t/t3701-add-interactive.sh | 15 +++++++++++++--
 t/test-terminal.perl       |  2 ++
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git c/t/lib-terminal.sh w/t/lib-terminal.sh
index e3809dcead..558db9aa33 100644
--- c/t/lib-terminal.sh
+++ w/t/lib-terminal.sh
@@ -9,6 +9,9 @@ test_terminal () {
 		echo >&4 "test_terminal: need to declare TTY prerequisite"
 		return 127
 	fi
+
+	echo >&4 "In test_terminal: GIT_PAGER=3D$(env | grep GIT_PAGER=3D)"
+
 	perl "$TEST_DIRECTORY"/test-terminal.perl "$@" 2>&7
 } 7>&2 2>&4
=20
diff --git c/t/t3701-add-interactive.sh w/t/t3701-add-interactive.sh
index c60589cb94..f7037cbed4 100755
--- c/t/t3701-add-interactive.sh
+++ w/t/t3701-add-interactive.sh
@@ -612,13 +612,24 @@ test_expect_success TTY 'print again the hunk (PAGE=
R)' '
 	test_cmp expect actual.trimmed
 '
=20
+test_quirk () {
+	echo "in test_quirk: GIT_PAGER=3D$GIT_PAGER"
+	echo "in env: GIT_PAGER=3D$(env | grep GIT_PAGER=3D)"
+	test_terminal git add -p
+	true
+}
+
 test_expect_success TTY 'P handles SIGPIPE when writing to pager' '
 	test_when_finished "rm -f huge_file; git reset" &&
-	printf "\n%2500000s" Y >huge_file &&
+	printf "\n%250s" Y >huge_file &&
 	git add -N huge_file &&
-	test_write_lines P q | GIT_PAGER=3D"head -n 1" test_terminal git add -p
+	echo "in env: GIT_PAGER=3D$(env | grep GIT_PAGER=3D)" &&
+	test_write_lines P q | GIT_PAGER=3D"head -n 1" test_quirk &&
+	echo "after test_quirk returns: GIT_PAGER=3D$GIT_PAGER"
 '
=20
+exit
+
 test_expect_success 'split hunk "add -p (edit)"' '
 	# Split, say Edit and do nothing.  Then:
 	#
diff --git c/t/test-terminal.perl w/t/test-terminal.perl
index b8fd6a4f13..92b1c13675 100755
--- c/t/test-terminal.perl
+++ w/t/test-terminal.perl
@@ -67,6 +67,8 @@ sub copy_stdio {
 if ($#ARGV < 1) {
 	die "usage: test-terminal program args";
 }
+print STDERR "test-terminal: GIT_PAGER=3D$ENV{GIT_PAGER}\n";
+
 $ENV{TERM} =3D 'vt100';
 my $parent_out =3D new IO::Pty;
 my $parent_err =3D new IO::Pty;
