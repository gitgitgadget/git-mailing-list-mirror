From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] perf: compare diff algorithms
Date: Wed, 07 Mar 2012 10:19:31 -0800
Message-ID: <7vzkbsmfyk.fsf@alter.siamese.dyndns.org>
References: <87pqcp6fyh.fsf@thomas.inf.ethz.ch>
 <m31up5tnjw.fsf@localhost.localdomain> <877gywy40l.fsf@thomas.inf.ethz.ch>
 <201203071903.02373.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@inf.ethz.ch>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Michal Privoznik <mprivozn@redhat.com>,
	Jeff King <peff@peff.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 07 19:19:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5LSd-000187-Fa
	for gcvg-git-2@plane.gmane.org; Wed, 07 Mar 2012 19:19:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964971Ab2CGSTf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Mar 2012 13:19:35 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62668 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932423Ab2CGSTe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Mar 2012 13:19:34 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7C54178F6;
	Wed,  7 Mar 2012 13:19:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rq67fBwns8yp/SLg2jyWrlxGfpw=; b=Kj/gnl
	ZGTFwTGArNTpyOHKcSmRAPt1bafIOXiJZZ7rDxzOTyusL6i4DT3ReN4CIFlMVp79
	Tr7XSNMgMaYNu54DBtdpUgNMbw2EMIfA5Crfdtb33/QXarph30y9ry+HiA1n2iQw
	e9rZaTne1JNPEcfnS8cE8j9tP2wlAKWbpBH2g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IQANDJ2yvCRKEaEQ7Phu38ArapJuWgnx
	mQlW/ii5C2Zaq9KvjPXsK3JByo6zlACL38pn3MTtXB1AUNRCSOELd9bboIUFdPL7
	WQTb3ZEw8gC10YijmlvQPEZXqJqkPpF9dffZedVfGj0Z9NduUBVQ09VMK0dfgADW
	kgmSecIKDZk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7432478F5;
	Wed,  7 Mar 2012 13:19:33 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0558B78F4; Wed,  7 Mar 2012
 13:19:32 -0500 (EST)
In-Reply-To: <201203071903.02373.jnareb@gmail.com> (Jakub Narebski's message
 of "Wed, 7 Mar 2012 19:03:01 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 167FD602-6882-11E1-85F5-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192470>

Jakub Narebski <jnareb@gmail.com> writes:

> Beside extracting logic that sets GITPERLLIB into separate file like
> in Junio proposal?

That was not even a proposal.  The part that deals with valgrind is
blatantly wrong (it shouldn't create symlinks in that code, it only
should figure out where things should be).

> You can always assume that it is fixed relative
> to perl/Git.pm, and use __DIR__ or $FindBin to make "use lib", e.g.
>
>   use FindBin;
>   use lib "$FindBin::Bin/../../perl";

Use of FindBin to find the location of the script is OK, but does
using "../../perl" really work?

We have this

  GITPERLLIB="$GIT_BUILD_DIR"/perl/blib/lib:"$GIT_BUILD_DIR"/perl/blib/arch/auto/Git

to look for two places in test-lib.sh
