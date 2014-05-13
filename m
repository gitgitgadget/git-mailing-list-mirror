From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] t: git-show: adapt tests to fixed 'git show'
Date: Tue, 13 May 2014 12:26:42 -0700
Message-ID: <xmqqiop9o4y5.fsf@gitster.dls.corp.google.com>
References: <20140512230943.GC32316@wheezy.local>
	<20140512231107.GE32316@wheezy.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Max Kirillov <max@max630.net>
X-From: git-owner@vger.kernel.org Tue May 13 21:27:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkIM2-0001tg-Go
	for gcvg-git-2@plane.gmane.org; Tue, 13 May 2014 21:27:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753566AbaEMT1H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2014 15:27:07 -0400
Received: from smtp.pobox.com ([208.72.237.35]:61789 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752464AbaEMT1D (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2014 15:27:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5729118A26;
	Tue, 13 May 2014 15:27:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xVlLWmh+YrzKemj6UEoxrCOWa9E=; b=lnOOVb
	70NaN5NC4NHUEr6oKK/1gRbmmvuLa+xtmE9tC6zcPTi+f7VOA1JhFeDUxDPDV2t6
	m5oIMkEYu4rGKSnqaVaFhUx5c+kX1h9sNi8AZRq+6KPCk/pLHCvKrREfyg/8SYyO
	P4dnzhka3ChYD9LDohfRCc3A2xkpMBr5Sa718=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hWQig5m/g2M24i74AtAKjj1AtNc4V6S2
	Xu66tf2wP8Ve/QCtiEUEFWMGUGfI0577gcLmKXPnVYW1KZjxehURmcsTP7CbfqgQ
	DOW2xbh1LyvnEDiADgMxpGwcfCYpO7PWpZHwovWAg2gB9qA7ngscYhCkaQfwyToK
	Uzr5T5IZNf0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4C75D18A25;
	Tue, 13 May 2014 15:27:03 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A934B189E9;
	Tue, 13 May 2014 15:26:44 -0400 (EDT)
In-Reply-To: <20140512231107.GE32316@wheezy.local> (Max Kirillov's message of
	"Tue, 13 May 2014 02:11:07 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 84CAC678-DAD4-11E3-BDB8-9CEB01674E00-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248808>

Max Kirillov <max@max630.net> writes:

> 'git show' used to print extra newline after merge commit, and it was
> recorded so into the test reference data. Now when the behavior is
> fixed, the tests should be updated.
>
> Signed-off-by: Max Kirillov <max@max630.net>
> ---

Hmph.  Having these as two separate commits would mean that 1/2
alone will break the test, hurting bisectability a little bit.  The
necessary adjustments in this patch is small enough that we may be
better off squashing them into one.

>  t/t1507-rev-parse-upstream.sh |  2 +-
>  t/t7600-merge.sh              | 11 +++++------
>  2 files changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/t/t1507-rev-parse-upstream.sh b/t/t1507-rev-parse-upstream.sh
> index 2a19e79..672280b 100755
> --- a/t/t1507-rev-parse-upstream.sh
> +++ b/t/t1507-rev-parse-upstream.sh
> @@ -100,7 +100,7 @@ test_expect_success 'merge my-side@{u} records the correct name' '
>  	git branch -D new ;# can fail but is ok
>  	git branch -t new my-side@{u} &&
>  	git merge -s ours new@{u} &&
> -	git show -s --pretty=format:%s >actual &&
> +	git show -s --pretty=tformat:%s >actual &&
>  	echo "Merge remote-tracking branch ${sq}origin/side${sq}" >expect &&
>  	test_cmp expect actual
>  )

This seems to me that it is updating how the output is produced, not
updating the expected outputs from commands with arguments we have
been testing.  I have been expecting to see changes to the pieces of
the code that prepare the expected output, so that we can compare
old expectations, which would have been expecting something strange,
with new expectations from the updated code, which would show that
the new behaviour is a welcome change because it would produce more
sensible output.

Having said all that, for this particular test piece, I agree with
the patch that using --pretty=tformat:%s is a lot more sensible and
using --pretty=format:%s and expecting its output to be terminated
with the newline was an unrealistic test.  After all, "tformat" is
the version with "line terminator" semantics, as opposed to "item
separator" semantics offered by "--pretty=format:", and the test
merely was depending on the bug to expect a complete line output
(i.e. "echo" without "-n"), which you fixed.  The new test makes a
lot more sense and is relevant to the real world use, and I would
have preferred to see it explained as such in the log message.

> diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
> index 10aa028..b164621 100755
> --- a/t/t7600-merge.sh
> +++ b/t/t7600-merge.sh
> @@ -57,11 +57,10 @@ create_merge_msgs () {
>  		git log --no-merges ^HEAD c2 c3
>  	} >squash.1-5-9 &&
>  	: >msg.nologff &&
> -	echo >msg.nolognoff &&
> +	: >msg.nolognoff &&
>  	{
>  		echo "* tag 'c3':" &&
> -		echo "  commit 3" &&
> -		echo
> +		echo "  commit 3"
>  	} >msg.log
>  }

These are updating the expectation.  We used to expect an
unnecessary trailing blank line, and now we do not, which clearly
shows that the previous fix is a welcome change.

> @@ -71,7 +70,7 @@ verify_merge () {
>  	git diff --exit-code &&
>  	if test -n "$3"
>  	then
> -		git show -s --pretty=format:%s HEAD >msg.act &&
> +		git show -s --pretty=tformat:%s HEAD >msg.act &&
>  		test_cmp "$3" msg.act
>  	fi
>  }

It is hard to judge what is fed as "$3" here without context, but
this is in line with the "--pretty=tformat aka --format is the
normal thing to use" we saw in 1507.  The same for the other hunk.

> @@ -620,10 +619,10 @@ test_expect_success 'merge early part of c2' '
>  	git tag c6 &&
>  	git branch -f c5-branch c5 &&
>  	git merge c5-branch~1 &&
> -	git show -s --pretty=format:%s HEAD >actual.branch &&
> +	git show -s --pretty=tformat:%s HEAD >actual.branch &&
>  	git reset --keep HEAD^ &&
>  	git merge c5~1 &&
> -	git show -s --pretty=format:%s HEAD >actual.tag &&
> +	git show -s --pretty=tformat:%s HEAD >actual.tag &&
>  	test_cmp expected.branch actual.branch &&
>  	test_cmp expected.tag actual.tag
>  '

How about squashing these two into a single patch, and at the end of
the log message for 1/2, add this to explain the changes to the
test:

    Also existing tests are updated to demonstrate the new
    behaviour.  Earlier, the tests that used "git show -s
    --pretty=format:%s", even though "--pretty=format:%s" calls for
    item separator semantics and does not ask for the terminating
    newline after the last item, expected the output to end with
    such a newline.  They were relying on the buggy behaviour.  Use
    of "--format=%s", which is equivalent to "--pretty=tformat:%s"
    that asks for a terminating newline after each item, is a more
    realistic way to use the command.

    The update to verify_merge in t7600 adjusts the the merge
    message that used to expect an extra blank line in the output,
    which has been eliminated with this fix.

or something like that?
