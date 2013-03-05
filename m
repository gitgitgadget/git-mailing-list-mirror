From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] Changing submodule foreach --recursive to be
 depth-first, --parent option to execute command in supermodule as well
Date: Tue, 05 Mar 2013 10:34:57 -0800
Message-ID: <7vboaxu23y.fsf@alter.siamese.dyndns.org>
References: <CA+aSAWuoxZkSnRybhefnFr9ngs3tHmt6hAH4o0ebjYKvjJ-vpw@mail.gmail.com>
 <51351CF5.7010308@web.de> <7vhakqwz1e.fsf@alter.siamese.dyndns.org>
 <20130305075901.GB4677@sandbox-ub> <7vhakpvnex.fsf@alter.siamese.dyndns.org>
 <CA+aSAWvQj2wuJX3ENNn7n_pMJjA6nauve5BLRugiTuhWN25Ctg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Heiko Voigt <hvoigt@hvoigt.net>,
	Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org
To: Eric Cousineau <eacousineau@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 05 19:35:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UCwi0-0002zS-KK
	for gcvg-git-2@plane.gmane.org; Tue, 05 Mar 2013 19:35:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756358Ab3CESfB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Mar 2013 13:35:01 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60750 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755457Ab3CESfA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Mar 2013 13:35:00 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7460BA116;
	Tue,  5 Mar 2013 13:34:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2zC5ZyM83kAOxDR53TdKM6pp+e0=; b=c4aIfz
	CgubdwOsCDpK14dOM0o6tyh0I2a9k4M0TsArUzU5oU4X9QVj6FqBj7XFdKBoiCkJ
	1EuBFnNC6JUjqM4rbL4T9DK0ymrR5Mrq5xg1Wd3QuilKjWpbRBkKFqwmb0BN/MTD
	g17g9Vmzs1PJ9dHXd85IyxT08ADvp4caoW82c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XVTIRwAiONPo+ZuO0CWo4W7giiqYvqN0
	8oNONRX7IgUTfpEXkp5TUII5dECYB2IaPRobdAqNWkETsRiCIUq4gFd2BlVicqjN
	uugDJujo0+CS3YVKW4jc9V/wQaajtZ8XrjeCGpMTjwZFU/0wfr/QMISKP+xsd59Y
	/vZV8/XhoX8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 67ED2A115;
	Tue,  5 Mar 2013 13:34:59 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B931EA113; Tue,  5 Mar 2013
 13:34:58 -0500 (EST)
In-Reply-To: <CA+aSAWvQj2wuJX3ENNn7n_pMJjA6nauve5BLRugiTuhWN25Ctg@mail.gmail.com> (Eric
 Cousineau's message of "Tue, 5 Mar 2013 10:42:05 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 623ACB06-85C3-11E2-8D0C-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217473>

Eric Cousineau <eacousineau@gmail.com> writes:

> Would these be the correct behaviors of Heiko's implementation?

I do not think Heiko already has an implementation, but let's try to
see how each example makes sense.

> git submodule foreach # Empty command, pre-order
> git submodule foreach --pre-order # Same behavior
> git submodule foreach --post-order # Empty command, post-order

OK.  The last one shows "I am here" output differently from the
other two, but otherwise they are all no-op.

> git submodule foreach 'frotz' # Do 'frotz' pre-order in each submodule

OK.  And it would be the same if you said either one of:

	git submodule foreach --pre-order 'frotz'
	git submodule foreach --pre-order='frotz'

> git submodule foreach --post-order 'frotz' # Do 'frotz' post-order in
> each submodule

OK.

> git submodule foreach --pre-order='frotz' --post-order='shimmy' # Do
> 'frotz' pre-order and 'shimmy' post-order in each submodule

OK.

> git submodule foreach --post-order='shimmy' 'frotz' # Invalid usage of
> the command

I would expect this to behave exactly the same as:

	git submodule foreach \
        	--post-order=shimmy \
                --pre-order=frotz

> git submodule foreach --post-order --pre-order #

I expect it to behave exactly the same as:

	git submodule foreach --post-order=: --pre-order=:

> It should not be too hard to have this functionality affect the
> --include-super command as well.

I would assume that

	git submodule foreach --pre-order=A --post-order=B --include-super

would be identical to running

	A &&
        git submodule foreach --pre-order=A --post-order=B &&
        B

I am not entirely convinced we would want --include-super in the
first place, though.  It does not belong to "submodule foreach";
it is doing something _outside_ the submoudules.
