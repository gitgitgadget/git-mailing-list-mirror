From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] t3300-*.sh: Fix a TAP parse error
Date: Tue, 24 Jul 2012 12:57:37 -0700
Message-ID: <7veho1exu6.fsf@alter.siamese.dyndns.org>
References: <500AEB11.4050006@ramsay1.demon.co.uk>
 <20120721182049.GL19860@burratino> <500EEAAA.8030604@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	GIT Mailing-list <git@vger.kernel.org>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Tue Jul 24 21:57:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StlEo-0002cS-Gt
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jul 2012 21:57:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754219Ab2GXT5l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jul 2012 15:57:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44184 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753819Ab2GXT5k (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2012 15:57:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C7C8D629D;
	Tue, 24 Jul 2012 15:57:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+A22oQzGaCxNC3JWiwM0vW/GmwA=; b=UqiJoN
	YkCo4nAZyDeZ02aisW70siX0BrpodqmQnSUPd98jQRywZwy7xn6zJHldxSAd5w6x
	5ou5CLmALrxtuhyQlC2dzVeDvTvF8rCZEoSZq/bktOGY2i6RSGSQvQ1PM5qLqfCK
	1y8hG8HCxpJ5lA3z0RAiSSRafYwlC4RhYEomU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZvbMh1JBJpUodvs3P5ZVoZIQqUHrHOPL
	/nJT8EUnGIoGvge4nHNr0QDaR/xETxAgyRN+CROs3OXvl0ljNV1RQQ6f0pBqXnX7
	C4vvQ4G5KWCguHbHILjkE3EhQQDEmyW0YTdDkdJGj2K9/IDNPBr/rbU81aIZ405A
	GAMk3PEhlIg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B5766629C;
	Tue, 24 Jul 2012 15:57:39 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 155BD629B; Tue, 24 Jul 2012
 15:57:38 -0400 (EDT)
In-Reply-To: <500EEAAA.8030604@ramsay1.demon.co.uk> (Ramsay Jones's message
 of "Tue, 24 Jul 2012 19:34:18 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D248C4A2-D5C9-11E1-8FC0-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202063>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

> The only problematic platforms I test on are "NTFS/bash" on cygwin and MinGW.
> Since commit 2b843732 ("Suppress some bash redirection error messages",
> 26-08-2008), I have not noticed any complaints regarding this problem.
> What have I missed?
>
> Assuming we are not talking about errors like ENOSPC, EROFS etc., then the
> only command which would issue a complaint to stderr would be the line
> following the above snippet, thus:
>
>     +cat 2>/dev/null >"$p1" "$p0"
>
> (note the stderr redirection).

As I am more worried about longer-term health of the codebase, what
the part you moved outside test_expect_* with this patch happens to
do _right now_ is of secondary importance, at least from my point of
view.  The next patch that updates this scirpt may want to run more
involved commands that can fail in different ways.

Being able to rely on the protection test_expect_* gives us in the
set-up phase of the test has been very valuable (in addition to
making the result more readable) to us.  Can we keep that property
in some way while also keeping the ability to skip the remainder of
the test script?

Observing that all well-written test scripts we have begin with this
boilerplate line:

	test_expect_success setup '

I wouldn't mind introducing a new helper function test_setup that
behaves like test_expect_success but is meant to be used in the
first "set-up" phase of the tests in a test script. Perhaps we can
give its failure a meaning different than failures in other normal
tests (e.g. "even set-up fails, and the remainder of the test is N/A
here, hence abort the whole thing"), and do not count "test_setup"
as part of the test (i.e. do not increment $test_count and friends).
