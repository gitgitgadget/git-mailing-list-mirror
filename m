From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 2/7] reset: add a few tests for "git reset --merge"
Date: Sat, 12 Dec 2009 15:30:33 -0800
Message-ID: <7v638blqhy.fsf@alter.siamese.dyndns.org>
References: <20091212042042.3930.54783.chriscool@tuxfamily.org>
 <20091212043259.3930.19134.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Paolo Bonzini <bonzini@gnu.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Stephen Boyd <bebarino@gmail.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sun Dec 13 02:14:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NJd28-0000sh-9m
	for gcvg-git-2@lo.gmane.org; Sun, 13 Dec 2009 02:14:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756057AbZLMBNo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Dec 2009 20:13:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755891AbZLMBNo
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Dec 2009 20:13:44 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:44197 "HELO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1757778AbZLMBNm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Dec 2009 20:13:42 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9A49CA693F;
	Sat, 12 Dec 2009 18:31:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lf2bYzmzF4g5zXqptVr1Ri/SX0A=; b=V0UAZ4
	gIvJYb2RqDaFsvvL3vROeXBLXyZreJ74FUMS2KeLVksWjk4Rk5d7kgiYPkIw9oK9
	FQjydbBvr6TkgwZWTJ9/aozVTdhsujPChUBHhiWrvIg/gDvN8r/VDb8cQt7MGgMK
	btVJUfoC5iugdGMMoP4qkGD7MEnVRaJdCp72w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=M4ll8jEdUwXW3YsONKOr0avVeyfmnj+g
	j0xjH5/njunoKoLoz9f1WdIv6Mev8lHXvhV8aRUwbet4+XmxRb9+r235zweN1GZs
	3Awuhgw4gE1k2eB0fad+XCoKuGmYiM5MlsMSmveA1cqL2zl3xLzm/3UKuZ6PWjsh
	yrmvPCEFu5U=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0351FA693E;
	Sat, 12 Dec 2009 18:30:49 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 74CB4A693D; Sat, 12 Dec 2009
 18:30:35 -0500 (EST)
In-Reply-To: <20091212043259.3930.19134.chriscool@tuxfamily.org> (Christian
 Couder's message of "Sat\, 12 Dec 2009 05\:32\:53 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 61BE3350-E776-11DE-BFF8-B34DBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135136>

Christian Couder <chriscool@tuxfamily.org> writes:

> +test_description='Tests for "git reset --merge"'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'creating initial files' '
> +     echo "line 1" >> file1 &&
> +     echo "line 2" >> file1 &&
> +     echo "line 3" >> file1 &&
> +     cp file1 file2 &&
> +     git add file1 file2 &&
> +     test_tick &&
> +     git commit -m "Initial commit"
> +'

5-char indent is somewhat unusual; please fix it.  Also you may want to
tag the initial one and other key commits for later use.

> +test_expect_success 'reset --merge is ok with changes in file it does not touch' '
> +     echo "line 4" >> file1 &&
> +     echo "line 4" >> file2 &&
> +     test_tick &&
> +     git commit -m "add line 4" file1 &&

IOW, move the above four lines to the end of the first "setup", and tag as
necessary like this:

    test_expect_success setup '
        for i in 1 2 3; do echo line $i; done >file1 &&
        cat file1 >file2 &&
        git add file1 file2 &&
        test_tick &&
        git commit -m "Initial commit" &&
        git tag initial &&
        echo line 4 >>file1 &&
        cat file1 >file2 &&
        test_tick &&
        git commit -m "add line 4 to file1" file1 &&
        git tag second
    '

And the rest should become its own test, starting from a known state.

> +     git reset --merge HEAD^ &&
> +     ! grep 4 file1 &&
> +     grep 4 file2 &&

Switching from the second commit to the initial one should succeed because
the only local change is in file2 that is unrelated.  This should also check
if HEAD points at the "initial" commit after "reset", and the index
matches the HEAD commit.

> +     git reset --merge HEAD@{1} &&
> +     grep 4 file1 &&
> +     grep 4 file2
> +'

And switching back to the second commit should recover.  This should be a
separate test, and should make sure it begins in a known state even if the
"reset --merge HEAD^" in the previous test failed.  This should also
check:

	test $(git rev-parse HEAD) = $(git rev-parse second) &&
	test -z "$(git diff --cached)"

If any of these two "reset --merge" is broken, the next test will start at
an unknown commit, hence you should add

	git reset --hard second &&

at the beginning of the next test.  You may also need to copy file1 to
file2 to recreate the local change as well.

The idea is not to assume that tests will succeed and 'recovery' step at
the end will run; instead, make sure each test starts itself in a known
state.  The way you wrote "reset --hard" at the end of some tests for
recovery is fragile.  There is no guarantee that each test run to the end,
executing these recovery parts.  Instead, have a corresponding set-up at
the beginning of each test as necessary.

> +test_expect_success 'reset --merge discards changes added to index (1)' '
> +     echo "line 5" >> file1 &&
> +     git add file1 &&

So at this point, file2 has an extra "line 4", and file1 has a change to
be committed.  And we reset to the initial commit.

> +     git reset --merge HEAD^ &&
> +     ! grep 4 file1 &&
> +     ! grep 5 file1 &&
> +     grep 4 file2 &&

And that will make file1 match that of initial, while keeping the change
to file2 intact.  The same comment about missing checks applies.  The
remainder of this test should be a separate test.

> +     echo "line 5" >> file2 &&
> +     git add file2 &&
> +     git reset --merge HEAD@{1} &&
> +     ! grep 4 file2 &&
> +     ! grep 5 file1 &&
> +     grep 4 file1
> +'

Starting at 'initial' but with two lines added to file2 and the index
updated to it, we reset to 'second' (spell these out with tags, instead of
relying on reflog, so that you do not assume all the previous tests have
passed).  Both files should match those of 'second'.  The same comment
about missing checks applies.

> +test_expect_success 'reset --merge discards changes added to index (2)' '
> +     echo "line 4" >> file2 &&
> +     git add file2 &&
> +     git reset --merge HEAD^ &&
> +     ! grep 4 file2 &&
> +     git reset --merge HEAD@{1} &&
> +     ! grep 4 file2 &&
> +     grep 4 file1
> +'

The same comment about the missing 'make sure it begins in a known state'
applies, but I don't see the point of this (2).  Is there any fundamental
difference of the set-up this one tests, compared to the earlier test?

> +test_expect_success 'reset --merge fails with changes in file it touches' '
> +     echo "line 5" >> file1 &&
> +     test_tick &&
> +     git commit -m "add line 5" file1 &&
> +     sed -e "s/line 1/changed line 1/" <file1 >file3 &&
> +     mv file3 file1 &&
> +     test_must_fail git reset --merge HEAD^ 2>err.log &&
> +     grep file1 err.log | grep "not uptodate" &&

Hmm, this is something we had a patch for to give different messages from
plumbing and Porcelain.

> +     git reset --hard HEAD^

Lose this 'recover at the end'.  There is no guarantee the each test run
to the end.   Instead, have a corresponding set-up at the beginning of the
next one.

I'd re-review the rest after this is rerolled.
