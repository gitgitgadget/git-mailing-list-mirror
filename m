From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 3/6] tests: new test for orderfile options
Date: Wed, 23 Apr 2014 10:38:07 -0700
Message-ID: <xmqq8uqw0ww0.fsf@gitster.dls.corp.google.com>
References: <1398255277-26303-1-git-send-email-mst@redhat.com>
	<1398255277-26303-3-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Wed Apr 23 19:38:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wd18B-00065H-69
	for gcvg-git-2@plane.gmane.org; Wed, 23 Apr 2014 19:38:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161051AbaDWRik (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2014 13:38:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60142 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161044AbaDWRih (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2014 13:38:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4FABC7EE26;
	Wed, 23 Apr 2014 13:38:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XSSE9TkVj/3XDahopyim9EP8exs=; b=ea/KaI
	I2Ot+maXOwqpxzhz37ewVsTX/wb6aRpi0enQRfmnwNo3TK3QA5VrzoBqdWQMb0Us
	U2/zoVFlGSd2/7kv14Kzuf0nL/Moah3Sd+cLcK7jke+/zaMLSuZQV3Hi0KjbQvGo
	ffXLFxpDJJi+0i7CabtVtz7W5QUzL2+gPjoEg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=U5OCWxDchiZi3Q5NlnkHeqzlNbb8c/YR
	p4vUAOFIaAET8lLmOzAaMFpXSd1F53LVdpjrNCgwJy5/GcPnK5xhFBtIpgXZYyVd
	2OrC0i86GYybdQcyiRg4pxe/Zdt6q1DPmJjty36Iu4cWMkudeCi9AgsNRjciVRxE
	isqVgYtrvyU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 397007EE25;
	Wed, 23 Apr 2014 13:38:37 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C91777EDF5;
	Wed, 23 Apr 2014 13:38:08 -0400 (EDT)
In-Reply-To: <1398255277-26303-3-git-send-email-mst@redhat.com> (Michael
	S. Tsirkin's message of "Wed, 23 Apr 2014 15:14:57 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 08C739EC-CB0E-11E3-9131-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246855>

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
> index 0000000..a247b7a
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
> +        as="a a a a a a a a" && # eight a
> +        test_write_lines $as >foo &&
> +        test_write_lines $as >bar &&
> +	git add foo bar &&
> +	git commit -a -m initial &&
> +        test_write_lines $as b >foo &&
> +        test_write_lines $as b >bar &&

These lines are curiously jaggy; are you indenting with spaces?
Please don't.

My running "git am -s3c" may auto-fix these indentation issues, so
please wait before seeing what may be pushed out on 'pu'.  It may
turn out that there is no other need for rerolling this patch in the
series.

Thanks.

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
