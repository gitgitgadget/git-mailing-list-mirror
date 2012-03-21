From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Demonstrate failure of 'core.ignorecase = true'
Date: Wed, 21 Mar 2012 16:58:13 -0700
Message-ID: <7vmx79zeui.fsf@alter.siamese.dyndns.org>
References: <1332370222-5123-1-git-send-email-pj@irregularexpressions.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Peter J. Weisberg" <pj@irregularexpressions.net>
X-From: git-owner@vger.kernel.org Thu Mar 22 00:58:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAVQ9-0004Gq-Fh
	for gcvg-git-2@plane.gmane.org; Thu, 22 Mar 2012 00:58:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753266Ab2CUX6R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Mar 2012 19:58:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47256 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752465Ab2CUX6Q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Mar 2012 19:58:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 59AE463EB;
	Wed, 21 Mar 2012 19:58:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wbkhBGsJ+Yl89Yywow8mpR9qtO4=; b=Ju1SBo
	ao8pkVEL2ht6Fbtm/4+N4iyLWr3rxHsICkCRN0KriPylQsnAP/vQOm4vL57eb94M
	P+LffhhuQcDu7Enx53Jt4N3klmpbe2DvnxoLM3xclSkJ+4Hf7wLUaNsjPAHgUANy
	xHr8Y8GEGEwBGQoQPl2xsPN3WwMPnsCFp/RjI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WP++DdUaTsn65T28uiKw0H5/CmfPa4o4
	Upr94nXE92iByUIQUaX1ZIwvbs5T1+RhMXwM0U8bbv+HQWYPOqua9D9iUUaJ21/3
	3Q61KSohSqFpA81obpnwObE/HNshR0YZBZKigVRauEE0wYeHG2fxlc3PMYiC6bFW
	tsl7Qu88Lc0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5062563EA;
	Wed, 21 Mar 2012 19:58:15 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BF4A863E9; Wed, 21 Mar 2012
 19:58:14 -0400 (EDT)
In-Reply-To: <1332370222-5123-1-git-send-email-pj@irregularexpressions.net>
 (Peter J. Weisberg's message of "Wed, 21 Mar 2012 15:50:22 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B8FEE15E-73B1-11E1-8334-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193627>

"Peter J. Weisberg" <pj@irregularexpressions.net> writes:

> From: "Peter J. Weisberg" <pj@irregularexpressions.net>
>
> On a filesystem that *is* case-sensitive, renaming a file to a name
> that would be equivalent on a case-insensitive filesystem makes Git
> think the original file was deleted.  Add a test that demonstrates
> this as a known error.
> ---

Thanks, Needs sign-off.

> I have a repository that contains files that I sync from a place where
> names are case-insensitive.  When I sync a file that has a change in
> the case of the file name, I want Git to ignore that non-change.  I
> would think core.ignorecase would accomplish this, but it does not.
> ---

No need for the second "---"

>  t/t2000-ignorecase-config.sh |   21 +++++++++++++++++++++

We'd rather not waste a new test number for a single test like this.

>  1 files changed, 21 insertions(+), 0 deletions(-)
>  create mode 100755 t/t2000-ignorecase-config.sh
>
> diff --git a/t/t2000-ignorecase-config.sh b/t/t2000-ignorecase-config.sh
> new file mode 100755
> index 0000000..9d05cee
> --- /dev/null
> +++ b/t/t2000-ignorecase-config.sh
> @@ -0,0 +1,21 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2012 Peter J Weisberg
> +#
> +
> +test_description='core.ignorecase'
> +
> +. ./test-lib.sh
> +
> +test_expect_failure "diff-files doesn't show case change when ignorecase=true" '

This needs to be protected by test prerequisite to make sure that the test
is run on a case insensitive filesystem.  Even if you declare that the
filesystem is case insensitive by setting core.ignorecase to true, the
underlying system calls like open("foo") will *not* magically start
returning a file descriptor opened for "FOO" if your filesystem is not
case insensitive.

Perhaps something as simple as the following would do:

	# on case insensitive filesystems, "mv" would fail
        if >testfile && ! mv testfile TESTFILE >/dev/null 2>/dev/null
        then
                test_set_prereq CASE_INSENSITIVE_FS
        fi
        rm -f testfile TESTFILE

	test_expect_failure CASE_INSENSITIVE_FS "diff-files doesn't..." '
        	... test body comes here ...


> +	git config core.ignorecase true &&
> +
> +	touch foo &&
> +	git add foo &&
> +	git commit -m "foo" &&
> +	mv foo FOO &&
> +
> +	test -z "$(git diff-files)"
> +'
> +
> +test_done
