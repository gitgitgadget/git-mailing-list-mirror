From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] diff: Add diff.orderfile configuration variable
Date: Fri, 06 Dec 2013 10:11:46 -0800
Message-ID: <xmqqhaal3l3x.fsf@gitster.dls.corp.google.com>
References: <CADsOX3DBmNituJsiYEBRENQeosASXtV_hd0zUW13cBoDZWHRhg@mail.gmail.com>
	<1386312508-7421-1-git-send-email-naesten@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Anders Waldenborg <anders@0x63.nu>
To: Samuel Bronson <naesten@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 06 19:11:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vozsb-0007Ob-1x
	for gcvg-git-2@plane.gmane.org; Fri, 06 Dec 2013 19:11:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758336Ab3LFSLx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Dec 2013 13:11:53 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56310 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753924Ab3LFSLv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Dec 2013 13:11:51 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AF09A56407;
	Fri,  6 Dec 2013 13:11:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gDRwW3i3vk6MNgJaei2fEQ5a5jw=; b=kI9fht
	qWG/VKTAgZAHh53rr0WcyaIAh0P2MgBqx+32NYyX2nO1483B/uMl7tNETrJgyRwI
	0oYRrJo6IG6Y1jmD3BYd1R1aca9JILQ835cF2Rw5xM1HhQ6WYBEJS8jmZC0dfskr
	+2HWxwPSBH7k2NPybsY7Ui/EjNvJwFdSX02mU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=c8MtUeF2SiVdVbJHDHC9coKDi4KEVzZf
	ifM3eVYI+Ct3UOzElIV5SpQJQop2O8MK0wR3Zix5AsbeTGirP74GSw5u3mxnVIlJ
	EuG1pQOCPrgu2KlLZ731BI5Yr6jLAJ7Ubg6QfN6zfIaRy1GAm0Mo8Wi8Uknnz4tS
	cxQ0A6crODQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9BCA556406;
	Fri,  6 Dec 2013 13:11:49 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C855F56404;
	Fri,  6 Dec 2013 13:11:48 -0500 (EST)
In-Reply-To: <1386312508-7421-1-git-send-email-naesten@gmail.com> (Samuel
	Bronson's message of "Fri, 6 Dec 2013 01:48:28 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: DFC674DC-5EA1-11E3-9FF6-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238941>

Samuel Bronson <naesten@gmail.com> writes:

> From: Anders Waldenborg <anders@0x63.nu>
>
> diff.orderfile acts as a default for the -O command line option.
>
> [sb: fixed testcases & revised docs based on Jonathan Nieder's suggestions]
>
> Signed-off-by: Anders Waldenborg <anders@0x63.nu>
> Thanks-to: Jonathan Nieder <jrnieder@gmail.com>
> Signed-off-by: Samuel Bronson <naesten@gmail.com>

Thanks for reviving a stalled topic.

> ---
> *I* even verified that the tests do fail properly when the feature is
> sabotaged.

Sabotaged in what way?

>  Documentation/diff-config.txt  |  5 +++
>  Documentation/diff-options.txt |  2 ++
>  diff.c                         |  5 +++
>  t/t4056-diff-order.sh          | 79 ++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 91 insertions(+)
>  create mode 100755 t/t4056-diff-order.sh
>
> diff --git a/Documentation/diff-config.txt b/Documentation/diff-config.txt
> index 223b931..f07b451 100644
> --- a/Documentation/diff-config.txt
> +++ b/Documentation/diff-config.txt
> @@ -98,6 +98,11 @@ diff.mnemonicprefix::
>  diff.noprefix::
>  	If set, 'git diff' does not show any source or destination prefix.
>  
> +diff.orderfile::
> +	File indicating how to order files within a diff, using
> +	one shell glob pattern per line.
> +	Can be overridden by the '-O' option to linkgit:git-diff[1].
> +
>  diff.renameLimit::
>  	The number of files to consider when performing the copy/rename
>  	detection; equivalent to the 'git diff' option '-l'.
> diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
> index bbed2cd..1af5a5e 100644
> --- a/Documentation/diff-options.txt
> +++ b/Documentation/diff-options.txt
> @@ -432,6 +432,8 @@ endif::git-format-patch[]
>  -O<orderfile>::
>  	Output the patch in the order specified in the
>  	<orderfile>, which has one shell glob pattern per line.
> +	This overrides the `diff.orderfile' configuration variable
> +	((see linkgit:git-config[1]).

Double opening parenthesis?

If somebody has diff.orderfile configuration that points at a custom
ordering, and wants to send out a patch (or show a diff) with the
standard order, how would the "overriding" command line look like?
Would it be "git diff -O/dev/null"?

> diff --git a/t/t4056-diff-order.sh b/t/t4056-diff-order.sh
> new file mode 100755
> index 0000000..a756b34
> --- /dev/null
> +++ b/t/t4056-diff-order.sh
> @@ -0,0 +1,79 @@
> +#!/bin/sh
> +
> +test_description='diff order'
> +
> +. ./test-lib.sh
> +
> +create_files () {
> +	echo "$1" >a.h &&
> +	echo "$1" >b.c &&
> +	echo "$1" >c/Makefile &&
> +	echo "$1" >d.txt &&
> +	git add a.h b.c c/Makefile d.txt &&
> +	git commit -m"$1"
> +	return $?
> +}

That return looks somewhat strange.  Does it even need to be there?

> +test_expect_success "setup" '

Makes readers wonder why dq is used here, I think.

> +	mkdir c &&
> +	create_files 1 &&
> +	create_files 2
> +'
> +
> +cat >order_file_1 <<EOF
> +*Makefile
> +*.txt
> +*.h
> +*
> +EOF
> +cat >order_file_2 <<EOF
> +*Makefile
> +*.h
> +*.c
> +*
> +EOF
> +
> +cat >expect_diff_headers_none <<EOF
> +diff --git a/a.h b/a.h
> +diff --git a/b.c b/b.c
> +diff --git a/c/Makefile b/c/Makefile
> +diff --git a/d.txt b/d.txt
> +EOF
> +
> +cat >expect_diff_headers_1 <<EOF
> +diff --git a/c/Makefile b/c/Makefile
> +diff --git a/d.txt b/d.txt
> +diff --git a/a.h b/a.h
> +diff --git a/b.c b/b.c
> +EOF
> +
> +cat >expect_diff_headers_2 <<EOF
> +diff --git a/c/Makefile b/c/Makefile
> +diff --git a/a.h b/a.h
> +diff --git a/b.c b/b.c
> +diff --git a/d.txt b/d.txt
> +EOF

All of these "cat" outside the test_expect_* are better be inside
the 'setup' section, I think.  I.e.

	test_expect_success setup '
        	mkdir c &&
                create_files 1 &&
                create_files 2 &&
                cat >order_file_1 <<-\EOF &&
                *Makefile
                *.txt
                *.h
                *
                EOF
                cat >order_file_2 <<-\EOF &&
		...
		cat >expect_diff_headers_2 <<EOF
                ...
                EOF
	'

Quoting the EOF like the above will help the readers by signaling
them that they do not have to wonder if there is some substitution
going on in the here text.

> +test_expect_success "no order (=tree object order)" '
> +	git diff HEAD^..HEAD >patch &&
> +	grep ^diff patch >actual_diff_headers &&
> +	test_cmp expect_diff_headers_none actual_diff_headers
> +'

Instead of grepping, "git diff --name-only" would be far easier to
check, no?

> +for i in 1 2; do
> +	test_expect_success "orderfile using option ($i)" "
> +	git diff -Oorder_file_$i HEAD^..HEAD >patch &&
> +	grep ^diff patch >actual_diff_headers &&
> +	test_cmp expect_diff_headers_$i actual_diff_headers
> +"
> +done
> +for i in 1 2; do
> +	test_expect_success "orderfile using config ($i)" "
> +	git -c diff.orderfile=order_file_$i diff HEAD^..HEAD >patch &&
> +	grep ^diff patch >actual_diff_headers &&
> +	test_cmp expect_diff_headers_$i actual_diff_headers
> +"
> +done

I'd probably write the above like so:

	for i in 1 2
        do
		test_expect_success "orderfile using option ($i)" '
                	git diff -Oorder_file_$i --name-only HEAD^ >actual &&
			test_cmp expect_$i actual
		'
		test_expect_success "orderfile using config ($i)" '
			test_config diff.orderfile order_file_$i &&
                	git diff --name-only HEAD^ >actual &&
			test_cmp expect_$i actual
		'
	done

Points to note:

 * We eval the scriptlets inside test framework, so using $i as a
   variable inside the single quotes will have the expected result.
   You do not have to worry about extra quoting inside dq pair.

 * We do _not_ substitute variables in the test title (perhaps we
   should have designed the test framework to do so, in hindsight),
   so unfortunately the title need to be in dq.

 * Use line-breaks instead of semicolons when writing compound
   syntax structures such as "for/do/done", "if/then/elif/else/fi",
   etc.
