From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v14 01/16] test: add test cases for relative_path
Date: Mon, 24 Jun 2013 21:57:53 -0700
Message-ID: <7v38s66b3i.fsf@alter.siamese.dyndns.org>
References: <cover.1372087065.git.worldhello.net@gmail.com>
	<85c9aa4d05dba4320a7cc85eae7570e0f450e58e.1372087065.git.worldhello.net@gmail.com>
	<7vli5z8ha0.fsf@alter.siamese.dyndns.org>
	<CANYiYbEK-vc2h64rfNDL5k5yhRsxQR=8xtNJJQwUXmyVHH4Cng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Git List <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 25 06:58:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrLKL-0002UL-Gc
	for gcvg-git-2@plane.gmane.org; Tue, 25 Jun 2013 06:58:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751256Ab3FYE55 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Jun 2013 00:57:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34363 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750971Ab3FYE54 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Jun 2013 00:57:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1D13F2634C;
	Tue, 25 Jun 2013 04:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=owz85AN9agGdlWKJ2vjonKz49Aw=; b=S6GMXJ
	ShBYOMZr8Ng7DWZN/p6cEKPcitNKp/hqH2wRvGVn9tbtba7zm7u0Fg6q6AvTiZ46
	m3UIgJTy9+8opKVFzaUjrNfDqDWtbYr0vx47GtDJtkPC9gLNo05rHfYmlfrBes2w
	UPfF8tcNoHjKJe6nPelIOu1AxJOwOqyf+ZTRM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kpCWv7m+dbJQ63S4snbhvKVW/BVqmBx0
	+zXQ3qAuNLxOh3Au1GU9qKfC9JU+CjpoTZaPRTzDhQYG3P51x6iq4VjVpE4ElVdy
	kC06Veabs1asDzWd+wmjlJPe9EQaPsYLDYE4pkwhJafcvvqsgIBESZBrMwI/USc1
	vqbNo7VOExA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 127DC2634B;
	Tue, 25 Jun 2013 04:57:56 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 63A2526348;
	Tue, 25 Jun 2013 04:57:55 +0000 (UTC)
In-Reply-To: <CANYiYbEK-vc2h64rfNDL5k5yhRsxQR=8xtNJJQwUXmyVHH4Cng@mail.gmail.com>
	(Jiang Xin's message of "Tue, 25 Jun 2013 09:06:51 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CC4D440A-DD53-11E2-B069-9B86C9BC06FA-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228942>

Jiang Xin <worldhello.net@gmail.com> writes:

> In order to test NULL pointer in t/t0060, I have to write normalize_argv_string
> to convert "<null>" to NULL....

Yes, null and empty I already understand.

> Add prefix _ to workaround the absolute path rewritten issue in
> msysGit is interesting, but these test cases have already been
> tested in Linux, right?

The most important thing is what we want to test in these tests.
The special test program is to try running the underlying
relative_path() by driving it directly, but the only real caller is
in setup_work_tree(), where two return values from real_path() is
compared.  On POSIX systems, we know we are feeding paths that both
begin with /.  Now, on Windows systems, what do we get back from
real_path()?  C:\git\Documentation?  /git/Documentation?  If the
former, then writing /a/b/c in the test input and letting Windows
bash convert it to C:\a\b\c before it calls the test-path-utils
would feed what we expect to see in the real caller, which would be
a more meaningful test than what I suggested (i.e. to feed _/a/b/c
to test-path-utils (unmolested by Windows bash), strip _ to feed
/a/b/c to underlying relative_path()).

Unlike relative_path() used in setup.c:setup_work_tree(), for
path_relative() from quote.c, IIRC, the expected inputs are both
full pathnames within the working tree.  A typical question the
callers to this function asks is like "The current directory
obtained from prefix is the Documentation/ directory and we need to
show that compat/mkdir.c is modified, relative to the current
directory.  ../compat/mkdir.c is what I want to show."  So in that
sense, it does not matter if /a/b/c is given as /a/b/c or C:\a\b\c
as we do not care the leading common part (either / or C:\) very
much.  On the other hand, the test vector you preoared in the first
test that all begin with / may not be very useful to make sure that
the function behaves the same way before and after your rewrite.
