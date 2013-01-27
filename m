From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] tests: turn on test-lint-shell-syntax by default
Date: Sun, 27 Jan 2013 09:15:35 -0800
Message-ID: <7vham2y2bs.fsf@alter.siamese.dyndns.org>
References: <201301120650.46479.tboegi@web.de>
 <7vvcb37xfe.fsf@alter.siamese.dyndns.org> <50F28BB5.9080607@web.de>
 <20130113173207.GC5973@elie.Belkin> <7v4nikiu81.fsf@alter.siamese.dyndns.org>
 <50F5B83E.9060800@web.de> <7vk3re2ncb.fsf@alter.siamese.dyndns.org>
 <51037E5F.8090506@web.de> <20130127093121.GA4228@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org, kraai@ftbfs.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 27 18:16:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzVpr-0008BT-9a
	for gcvg-git-2@plane.gmane.org; Sun, 27 Jan 2013 18:16:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754064Ab3A0RPm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2013 12:15:42 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49907 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753525Ab3A0RPk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2013 12:15:40 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 133B9C962;
	Sun, 27 Jan 2013 12:15:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IIFbWFIBAhM4+MzWEjcbBLPRAkM=; b=owL2TN
	XKpowtSmWT5fYWnvgUpEjDUCIDN71Vir0olfEKkJju0XbiznwATcPP+69/jHSxdm
	2p1wsHEHSRyITBvmql4D7sk6GVZTK2HGxUY4gkbW9OmaMvxwcMSSo+Hu1Ir/Udtp
	vuUOl8rOlf1/wmkObQThnZA7dZv48Ec0S8Es4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=q23q86cQOBroSYz2q7OJu2FPOAnISAIN
	BpE6zAMbbOMrAGIhxWLSTBT6f+jjBWL/45yDPaXeUNL1Oz5r8yaiXzB67+RvfuYw
	m+PDWs1foESn/TQ/CZw0KegX/pnyN8eNwo18GRRYqbrw3/PbIkK6Db4ZlDAtiRtb
	scy9gKD1mhI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 07665C95F;
	Sun, 27 Jan 2013 12:15:38 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6AF7DC95D; Sun, 27 Jan 2013
 12:15:37 -0500 (EST)
In-Reply-To: <20130127093121.GA4228@elie.Belkin> (Jonathan Nieder's message
 of "Sun, 27 Jan 2013 01:31:21 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2AFA5412-68A5-11E2-9BC9-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214708>

Jonathan Nieder <jrnieder@gmail.com> writes:

> ...
> With the above definition of "which", the only sign of a mistake would
> be some extra output to stderr (which is quelled when running tests in
> the normal way).  The "exit" is caught by the subshell and just makes
> the "if" condition false.
>
> That's not so terrible --- it could still dissuade new test authors
> from using "which".  The downside I'd worry about is that it provides
> a false sense of security despite not catching problems ...
> ...
> In the end the analysis that works best would probably involve a
> full-fledged shell script parser.  Something like "sparse", except for
> shell command language.

Exactly.

That is why I keep saying that whole test-lint-shell-syntax should
stay outside the default until it gets more robust by becoming a
reasonable shell parser; it may not necessarily have to become
"full" parser though.

As we discourage the use of tricky features of the language like
eval in individual test scripts to implement their own mini test
framework, the "something like sparse" parser may initialy start
small and still be useful; for example it can learn to exclude
anything inside <<HERE_DOCUMENT from getting inspected.
