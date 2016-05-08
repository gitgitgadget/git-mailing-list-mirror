From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/2] rev-parse tests: add tests executed from a subdirectory
Date: Sun, 08 May 2016 11:46:23 -0700
Message-ID: <xmqq37psz8u8.fsf@gitster.mtv.corp.google.com>
References: <1462541720-79553-1-git-send-email-rappazzo@gmail.com>
	<1462541720-79553-2-git-send-email-rappazzo@gmail.com>
	<xmqqy47m25z4.fsf@gitster.mtv.corp.google.com>
	<CANoM8SVr1_G6KevbGSHifGyQS-ei57q+5D+GE_QmKvf_ysF2Sg@mail.gmail.com>
	<xmqqvb2ozapp.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmc=?= =?utf-8?B?4buNYw==?= 
	<pclouds@gmail.com>,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Mike Rappazzo <rappazzo@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 08 20:46:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azTiv-0008WU-Rn
	for gcvg-git-2@plane.gmane.org; Sun, 08 May 2016 20:46:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751064AbcEHSqc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 May 2016 14:46:32 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53392 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751058AbcEHSqb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2016 14:46:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8664D17EA0;
	Sun,  8 May 2016 14:46:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cvbFJGiL8sq5ID1ssXwOBheL3Lw=; b=DA/wC6
	jNi+ByLnkJeGhIc7VVgjPFkgovMfEDmsKouBxQPsYSOTI3XqzBOnoFzyVkaq2yD5
	LBVA2e6MtGlS9EWwI+nHa4TwFHrQoTe574bH+kAU5ofpiNpq+QnsJ5tTBPxWwrY7
	1xAhRIaqFbG2GpB9vdNJIQwSI3/BkSah0lZMA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nwVMIjVu8J/45gu7h+bjEe9CTXAwy/GH
	vgSISsW/Who/wAVSWZWKPE+/zka3ujRKpvNxwxwuTqWtGpIbAovi5YqMSAORwZ5W
	XP/g1joHlx+tkzR6Hmp6aL+e6E0CSWAgUSw4/0sJFAC+oR4tOsXX2FUNj+HHvkFH
	yLtrEG858u0=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7E1F017E9F;
	Sun,  8 May 2016 14:46:25 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F016E17E9E;
	Sun,  8 May 2016 14:46:24 -0400 (EDT)
In-Reply-To: <xmqqvb2ozapp.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Sun, 08 May 2016 11:05:54 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2A78DA9C-154D-11E6-B0EF-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293975>

Junio C Hamano <gitster@pobox.com> writes:

> What I had in mind was more a long the lines of this change. I only
> did the first several just for illustration (I added an 'exit' to
> mark where I stopped), but I think you get the idea.  The point is
> that by doing things in subprocess inside test_expect_success you
> can avoid disrupting the main test process even when a test fails as
> much as possible, and this illustrates how you would deal with the
> "cd" and "export".  What I didn't handle was the updates to
> .git/config whose effects by earlier tests are relied on later tests
> in this illustration.
>
> As to "table driven" vs "explicitly spelling out scripts, accepting
> some code repetition", I tend to favor the latter slightly, unless
> the table driven approach is done in such a way that each of its
> tests are truly independent from one another, i.e. if a row of the
> table represents one test, the tests would not be disrupted by
> reordering the rows, inserting a new row in the middle, or removing
> an existing row.  From my experience, "table-driven" sets of tests
> whose rows have inter-dependency has been much harder to debug when
> I had to hunt down a bug that manifests itself only in one test in
> the middle.
>
> Hope this helps clarify what I meant.


If you want to go forward in this direction, three are a few
additional things to note.

> +	test_expect_success "$name: is-bare-repository" "
> +	(
> +		$prep &&
> +		test '$1' = \"\$(git rev-parse --is-bare-repository)\"
> +	)"

This is not a new problem, but quoting the test body with dq instead
of sq pair make it ugly to read.  We might want to do something like

	expect=$1
	test_expect_success "$name: is-bare-repository" '
	(
		$prep &&
		test "$outcome" = "$(git rev-parse --is-bare-repository)"
	)'

>  	shift
>  	[ $# -eq 0 ] && return

Also, let's avoid []; i.e.

	test $# = 0 && return

> -# label is-bare is-inside-git is-inside-work prefix git-dir
> +# label prep is-bare is-inside-git is-inside-work prefix git-dir
>  
>  ROOT=$(pwd)
> +mkdir -p sub/dir work

Remember this place in the script, I may refer to it later.

> -git config core.bare true
> -test_rev_parse 'core.bare = true' true false false
> +test_rev_parse subdirectory 'cd sub/dir' \
> +	false false true sub/dir/ "$ROOT/.git"
>  
> -git config --unset core.bare
> -test_rev_parse 'core.bare undefined' false false true
> +test_rev_parse 'core.bare = true' 'git config core.bare true' \
> +	true false false

I didn't use "test_config" and "test_unconfig" here, because you
cannot use them in a subprocess.  If we truly want to make these
tests independent from each other, we'd need to come up with a way
for the tests to revert the configuration state back to where it was
before they started.
>  
> -mkdir work || exit 1
> -cd work || exit 1
> -GIT_DIR=../.git
> -GIT_CONFIG="$(pwd)"/../.git/config
> -export GIT_DIR GIT_CONFIG
>  
> -git config core.bare false
> -test_rev_parse 'GIT_DIR=../.git, core.bare = false' false false true ''
> +test_rev_parse 'GIT_DIR=../.git, core.bare = false' '
> +	cd work && 
> +	GIT_DIR=../.git &&
> +	GIT_CONFIG="$(pwd)"/../.git/config &&
> +	export GIT_DIR GIT_CONFIG &&
> +	git config core.bare false' \
> +	false false true ''

The "prep" step for this test is long and I'd assume that the later
tests would need to do something similar themselves.  To avoid
repetition, create a helper shell function to reduce boilerplate
before the series of these tests start (i.e. the place above) and
call it from the prep parts with different arguments, e.g. making
the above test into

test_rev_parse 'GIT_DIR=../.git, core.bare = false' '
	cd work && 
	set_common_env ../.git false' \
	false false true ''

by having something like

set_dir_and_core_bare () {
	GIT_DIR=$1 &&
	GIT_CONFIG="$(pwd)/$GIT_DIR/config" &&
	export GIT_DIR GIT_CONFIG &&
	git config core.bare "$2"
}

> +exit
>  
>  git config core.bare true
>  test_rev_parse 'GIT_DIR=../.git, core.bare = true' true false false ''
