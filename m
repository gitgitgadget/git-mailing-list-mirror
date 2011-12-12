From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] test-terminal: give the child an empty stdin TTY
Date: Mon, 12 Dec 2011 12:06:20 -0800
Message-ID: <7vfwgp3683.fsf@alter.siamese.dyndns.org>
References: <b97d14da67bd6097e5b04f6ae3057c0f1d536a0b.1323713230.git.trast@student.ethz.ch> <20111212181915.GD31793@elie.hsd1.il.comcast.net> <201112121934.40953.trast@student.ethz.ch> <20111212190553.GJ31793@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 12 21:06:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaC8q-0001rl-31
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 21:06:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753960Ab1LLUGX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 15:06:23 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45643 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753739Ab1LLUGX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 15:06:23 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 984036396;
	Mon, 12 Dec 2011 15:06:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Hg7ktO2zcIr+d3V9KZ32kUfhnoM=; b=f/dcqD
	7gp3GWeA6X+GwQqIdI0kSbIWknNM8dBF3I5SG5tfntkUtJbOm9lGwdrczQ7702CV
	KFFSnC0dG2zkBRaCBI77VahYOy4UTmwlqmDegpMfLDNTScfy8uASN9+wqPU6PnJ+
	xgcHfYnc39n6NyabbxbV2ZU8f5UcyEukrekoQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=b7hj+ByOKI0cnrpmj/9y7it4BEqZfuuP
	zhf8aC7u8cLXu8f/hakeu02RTV0Vbc9eAfjDhj4DIRWJ7f4d/mvRFkuTk8+Dt65U
	XkwdweV5ZbX8ErFzoYDsSBVAFpRf9+gvm16CXvWK3DQziXNKRzQb7rvw6yXqiJZt
	e3IIpuUCzDA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8DD566395;
	Mon, 12 Dec 2011 15:06:22 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E7C126394; Mon, 12 Dec 2011
 15:06:21 -0500 (EST)
In-Reply-To: <20111212190553.GJ31793@elie.hsd1.il.comcast.net> (Jonathan
 Nieder's message of "Mon, 12 Dec 2011 13:05:53 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C2FDED2A-24FC-11E1-8722-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186944>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Sorry, I was thinking narrowly about the "git log" tests in
> t7006-pager.sh.  I was saying that there, the fact that
> lib-terminal.sh creates an environment in which stdin is not
> guaranteed to be a terminal is a feature, not a bug, since it improves
> the test coverage (and I tend to find the "stdin not a tty" case more
> interesting).

I agree with Thomas's objective of giving ttys to all the streams of
process being tested by default to emulate the usage better, but I also
think being able to test some of the streams redirected to non-tty a good
feature to have in test-terminal driver. And I do not think these two have
to be either-or proposition.

I do not think "Run 'git log' as if the user is on an interactive
terminal, but has plugged /dev/null to its standard input" can be spelled
like this:

    test-terminal git log </dev/null

but test-terminal could learn an equivalent feature perhaps from the
command line, no?  Perhaps like

    test-terminal --stdin=/dev/null git log
    test-terminal --stdout=actual --stderr=error git shortlog

or somesuch?
