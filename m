From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t1402-check-ref-format: skip tests of refs beginning
 with slash on Windows
Date: Thu, 13 Oct 2011 16:00:04 -0700
Message-ID: <7vfwiw33bf.fsf@alter.siamese.dyndns.org>
References: <1318492715-5931-1-git-send-email-mhagger@alum.mit.edu>
 <4E969BFC.50706@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: mhagger@alum.mit.edu, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Oct 14 01:00:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REUGB-00084e-UT
	for gcvg-git-2@lo.gmane.org; Fri, 14 Oct 2011 01:00:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755870Ab1JMXAL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Oct 2011 19:00:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59571 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755481Ab1JMXAK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Oct 2011 19:00:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 938F662AA;
	Thu, 13 Oct 2011 19:00:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=W4cAgC3H5Yx5kqVY5pBw4VmK2XY=; b=gmR6Ni
	tf5r513XsQuFNYBzCSL8pOx/r+ppVmv8QM8di3/82+mwn7gXdiZr7Fay89/40JNU
	1bvE8gORuAF9TWlLCcRHTzDCJebz0QwTOs5ydXVFddsXCzQdiRWl42bupHzIpQmI
	yy+1NmRsYjS0edIIvUchXYP/BPtQvt65MFbxI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jAQakivOVQ3Iqesa9qBUMPR01Pe+BkKC
	NojmnzZ0UnnsFdkmJjf/UKPTcLgIAYch2UN062GWlrJXCaWE719q/WFqBpEgNad7
	7z+DyzrZJlg/7EJi9L9Ne0Qw0Jb07Wqfx/tW/GDcjaSzf335urGmLfsoPiiC7hr9
	X6u+O1ymQX4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 891CA62A7;
	Thu, 13 Oct 2011 19:00:08 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 40D016298; Thu, 13 Oct 2011
 19:00:06 -0400 (EDT)
In-Reply-To: <4E969BFC.50706@viscovery.net> (Johannes Sixt's message of "Thu,
 13 Oct 2011 10:06:20 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 17CE9152-F5EF-11E0-B4FB-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183528>

Johannes Sixt <j.sixt@viscovery.net> writes:

> This patch is needed on top of mh/check-ref-format-3, or it could be
> inserted in front of this batch (which probably amounts to the same
> thing :-)

How about applying directly on 'master' then?

> +invalid_ref NOT_MINGW '/'
> ...
> @@ -155,21 +155,21 @@ test_expect_success 'check-ref-format --branch from subdir' '
>  '
>  
>  valid_ref_normalized() {
> -	test_expect_success "ref name '$1' simplifies to '$2'" "
> +	test_expect_success $3 "ref name '$1' simplifies to '$2'" "
>  		refname=\$(git check-ref-format --normalize '$1') &&
>  		test \"\$refname\" = '$2'"
>  }
>  invalid_ref_normalized() {
> -	test_expect_success "check-ref-format --normalize rejects '$1'" "
> +	test_expect_success $2 "check-ref-format --normalize rejects '$1'" "
>  		test_must_fail git check-ref-format --normalize '$1'"
>  }
> ...
> +valid_ref_normalized '/heads/foo' 'heads/foo' NOT_MINGW

The inconsistencies strikes me a bit.

Perhaps update to something like this?

	valid_ref_normalized () {
		if test $# = 3
                then
			prereq=$1
                        shift
		fi
                test_expect_success $prereq "ref name '$1' simplifies to '$2'"
		...
	}
