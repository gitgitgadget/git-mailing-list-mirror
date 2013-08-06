From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH revised] git_mkstemps: add test suite test
Date: Tue, 06 Aug 2013 11:17:42 -0700
Message-ID: <7vsiymfzuh.fsf@alter.siamese.dyndns.org>
References: <201308061805.r76I51If026086@freeze.ariadne.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: worley@alum.mit.edu (Dale R. Worley)
X-From: git-owner@vger.kernel.org Tue Aug 06 20:18:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6lpe-0003u4-Ic
	for gcvg-git-2@plane.gmane.org; Tue, 06 Aug 2013 20:18:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756745Ab3HFSRv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Aug 2013 14:17:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45756 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756139Ab3HFSRr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Aug 2013 14:17:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 274E836756;
	Tue,  6 Aug 2013 18:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=I8gqvlSAtWMoFNqgGNMCqEDEAWs=; b=gggk8U
	gju4yOgQZc7B/kJrws6CTtz0AfBy5/jDSLageAfZde5qkgT5Q33Ci+oUNdUP8s72
	e/HAVrxUKTAjrzWpZ6oAI3Etm7TZkid0oECZWkf42w5WlsK8QfSUHRloLKl5K27u
	NI00sbkuKNJo95Cvsw7hJbkoS5l3AtkmekE7w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WQYaFaEJlp8/CGp31v4+iIJzsW0zs/qN
	mqZ7XWuB8xqL0GB+m+18Q3uvaQUEDsc4Xev/Xpt6dJyF8RNYmF2dL0OTlhoiThZq
	I+z8sgM3JqLd+dmQ5kTOqlWvPYPFe8UDHix6ciI2zsm2LC8NSAg/YQDsHWVj3RFu
	y4CfH6gIZZI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 17D5436755;
	Tue,  6 Aug 2013 18:17:47 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 317B63674D;
	Tue,  6 Aug 2013 18:17:44 +0000 (UTC)
In-Reply-To: <201308061805.r76I51If026086@freeze.ariadne.com> (Dale
	R. Worley's message of "Tue, 6 Aug 2013 14:05:01 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7DB61B72-FEC4-11E2-85C9-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231771>

worley@alum.mit.edu (Dale R. Worley) writes:

> Commit a2cb86 ("git_mkstemps: correctly test return value of open()",
> 12 Jul 2013) fixes a bug regarding testing the return of an open()
> call for success/failure.  Add a testsuite test for that fix.  The
> test exercises a situation where that open() is known to return 0.
>
> Signed-off-by: Dale Worley <worley@ariadne.com>
> ---
> This version of the patch cleans up a number of errors in my previous
> version (which were ultimately due to my faulty updating of my master
> branch).  The commit that added the open() test is now correctly
> described.  Since the test was not present in the test suite at all,
> the patch is described as adding the test rather than improving it.
>
> a2cb86 is on branch tr/fd-gotcha-fixes, but that has been merged into
> master now.

Thanks. I thought I've already queued 

Message-ID: <7vfvuokpr0.fsf@alter.siamese.dyndns.org>
aka 
http://article.gmane.org/gmane.comp.version-control.git/231680

which tests

    git commit --allow-empty -m message <&-

> +test_expect_success 'git_mkstemps_mode does not fail if fd 0 is not open' '
> +	git init &&

This does not do anything useful; you are in the test playpen aka
"trash" which is an already initialized git repository.

> +	echo Test. >test-file &&
> +	git add test-file &&

You do not have to have extra contents...

> +	git commit -m Message. <&-

...you can do with just "--allow-empty" instead.
