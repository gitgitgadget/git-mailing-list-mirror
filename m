From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] add -u: only show pathless 'add -u' warning when
 changes exist outside cwd
Date: Tue, 19 Mar 2013 08:06:03 -0700
Message-ID: <7v620nl99g.fsf@alter.siamese.dyndns.org>
References: <20130313040845.GA5057@sigill.intra.peff.net>
 <20130313041037.GB5378@sigill.intra.peff.net>
 <20130319034415.GI5062@elie.Belkin> <20130319034822.GL5062@elie.Belkin>
 <vpq1ubb3o5g.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Mar 19 16:06:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHy7i-0004O7-UZ
	for gcvg-git-2@plane.gmane.org; Tue, 19 Mar 2013 16:06:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756898Ab3CSPGP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Mar 2013 11:06:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42285 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756886Ab3CSPGM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Mar 2013 11:06:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DA461B6E2;
	Tue, 19 Mar 2013 11:06:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JS76tiDTCHQZSs6i+G9qlsh8tFg=; b=XcwgFV
	v8ekz/7pyt6CYRZD1MxRtCGUPDR8bf7brsSS5scQNiB9yOhAqLsIdHDg3LJXrWSg
	9SRrClqnzLTqhjhAZoVQbenQiIj2IH6LLhPgpkKkP7s1JYfZMPTve0vDmLLnAoVA
	SPcw8K0IeGQk7LPqiuVzugErfisEFGOEvYM98=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YORLFuNLjpiVpyfvJs9zDELkI5T/k12I
	Uc8DSWnckDOROrMCOleltn1pFYdZeAXDmIQDBIGOB40mUzte4kcoeFDptJakr5jn
	P/2uEZV5FU+OKA1KMP5istn1R4YQp4Fhq1F8/iGq1xBOHdXRs6p/Aj/GY7YGRlj0
	kL8mxq3BDv4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CCE17B6E0;
	Tue, 19 Mar 2013 11:06:11 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DB903B6D6; Tue, 19 Mar 2013
 11:06:10 -0400 (EDT)
In-Reply-To: <vpq1ubb3o5g.fsf@grenoble-inp.fr> (Matthieu Moy's message of
 "Tue, 19 Mar 2013 07:21:47 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8906BF36-90A6-11E2-90F5-4AAA2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218521>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> No time to review the code now. I thought about implementing something
> like that, but did not do it because I didn't want the change in the
> code to be too big. At some point, we'll have to remove the warning and
> it's easier with my version than with yours. But the "damage" to the
> code do not seem too big, so that's probably OK and will actually reduce
> the pain for some users.

Getting these warnings is a *good* thing.

You may happen to have no changed path outside the current directory
with this particular invocation of "git add -u", or you may do, or
you may not *even* remember if you touched the paths outside.

Training your fingers to type "git add -u ." without having to even
think, is primarily to help the last case.

Squelching of the warning at the top-level is much less problematic
as it is much harder to forget if you are at the top level of the
working tree than forget if you touched paths outside the current
directory.  "I know I am at the top, so I type 'git add -u' without
dot---why do you punish me with the warning?" is a much more valid
complaint.
