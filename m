From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 3/9] tests: new test for orderfile options
Date: Thu, 24 Apr 2014 11:45:35 -0700
Message-ID: <xmqqoazqva5s.fsf@gitster.dls.corp.google.com>
References: <1398331809-11309-1-git-send-email-mst@redhat.com>
	<1398331809-11309-3-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, sunshine@sunshineco.com, jrnieder@gmail.com,
	peff@peff.net
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Thu Apr 24 20:45:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdOef-0002nd-KI
	for gcvg-git-2@plane.gmane.org; Thu, 24 Apr 2014 20:45:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758127AbaDXSpt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Apr 2014 14:45:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65218 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753229AbaDXSpr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Apr 2014 14:45:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 39882807C1;
	Thu, 24 Apr 2014 14:45:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=a4+Kt/5daqslsklRcwi1HTCRI+o=; b=PrzinW
	8c3FIxv6yk9CKHiH5F5S5/eqoZAgo9ta1dZGglJW1T/31AJkNntALXX18z3Lj2K+
	4PV6yHHilci/sm7EvVdEDjJTBOab7vHODxQbdQUJ1zL4+0s59rdYfy9Db5OLzs6V
	JhIYx31G3BEVT59xfOFKAbNRmdpI5S9sb7Rnc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lc9Qn2QPjGt75kM5sBmWcW42Ofh3tYe6
	ScXSs+YlB/X8uzMHVtmeLTYo2aG8UiieCPTAic7cizJN/wjZ/x+qYX/rl01vPo4C
	WXcKA0svuPO8yvKBJVHZhjtIgftuf6IQupe8DyihccRLnKW/k5DY8w1jDUIAcVx1
	EllybKj5l48=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 24DC6807C0;
	Thu, 24 Apr 2014 14:45:47 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 146DC807BF;
	Thu, 24 Apr 2014 14:45:44 -0400 (EDT)
In-Reply-To: <1398331809-11309-3-git-send-email-mst@redhat.com> (Michael
	S. Tsirkin's message of "Thu, 24 Apr 2014 12:30:57 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A4EE1598-CBE0-11E3-A12A-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246995>

"Michael S. Tsirkin" <mst@redhat.com> writes:

> The test is very basic and can be extended.
> Couldn't find a good existing place to put it,
> so created a new file.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  t/t4056-diff-order.sh | 63 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 63 insertions(+)
>  create mode 100755 t/t4056-diff-order.sh
>
> diff --git a/t/t4056-diff-order.sh b/t/t4056-diff-order.sh
> new file mode 100755
> index 0000000..0404f50

Huh?  What codebase is this based on?

I think we had t4056 since b5277730 (t4056: add new tests for "git
diff -O", 2013-12-18).

Puzzled...

> --- /dev/null
> +++ b/t/t4056-diff-order.sh
> @@ -0,0 +1,63 @@
> +#!/bin/sh
> +
> +test_description='diff orderfile'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'setup' '
> +	as="a a a a a a a a" && # eight a
> +	test_write_lines $as >foo &&
> +	test_write_lines $as >bar &&
> +	git add foo bar &&
> +	git commit -a -m initial &&
> +	test_write_lines $as b >foo &&
> +	test_write_lines $as b >bar &&
> +	git commit -a -m first &&
> +	test_write_lines bar foo >bar-then-foo &&
> +	test_write_lines foo bar >foo-then-bar &&
> +	git diff -Ofoo-then-bar HEAD~1..HEAD >diff-foo-then-bar &&
> +	git diff -Obar-then-foo HEAD~1..HEAD >diff-bar-then-foo
> +'
> +
> +test_diff_well_formed () {
> +	grep ^+b "$1" >added
> +	grep ^-b "$1" >removed
> +	grep ^+++ "$1" >oldfiles
> +	grep ^--- "$1" >newfiles
> +	test_line_count = 2 added &&
> +	test_line_count = 0 removed &&
> +	test_line_count = 2 oldfiles &&
> +	test_line_count = 2 newfiles
> +}
> +
> +test_expect_success 'diff output with -O is well-formed' '
> +	test_diff_well_formed diff-foo-then-bar &&
> +	test_diff_well_formed diff-bar-then-foo
> +'
> +
> +test_expect_success 'flag -O affects diff output' '
> +	! test_cmp diff-foo-then-bar diff-bar-then-foo
> +'
> +
> +test_expect_success 'orderfile is same as -O' '
> +	test_config diff.orderfile foo-then-bar &&
> +	git diff HEAD~1..HEAD >diff-foo-then-bar-config &&
> +	test_config diff.orderfile bar-then-foo &&
> +	git diff HEAD~1..HEAD >diff-bar-then-foo-config &&
> +	test_cmp diff-foo-then-bar diff-foo-then-bar-config &&
> +	test_cmp diff-bar-then-foo diff-bar-then-foo-config
> +'
> +
> +test_expect_success '-O overrides orderfile' '
> +	test_config diff.orderfile foo-then-bar &&
> +	git diff -Obar-then-foo HEAD~1..HEAD >diff-bar-then-foo-flag &&
> +	test_cmp diff-bar-then-foo diff-bar-then-foo-flag
> +'
> +
> +test_expect_success '/dev/null is same as no orderfile' '
> +	git diff -O/dev/null HEAD~1..HEAD>diff-null-orderfile &&
> +	git diff HEAD~1..HEAD >diff-default &&
> +	test_cmp diff-null-orderfile diff-default
> +'
> +
> +test_done
