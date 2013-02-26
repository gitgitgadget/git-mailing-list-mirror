From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Better handling of erroneous git stash save "somemessage"
 --keep-index
Date: Tue, 26 Feb 2013 09:00:46 -0800
Message-ID: <7vsj4jm2m9.fsf@alter.siamese.dyndns.org>
References: <CAPs+M8JvcnTcZiySmpMBuOxek4THRnTx0jkZv7NHaSDNLhcOAQ@mail.gmail.com>
 <7vwqtvm4yr.fsf@alter.siamese.dyndns.org> <vpq1uc3cagy.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Gunnlaugur Thor Briem <gunnlaugur@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Feb 26 18:01:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UANty-00025e-Bl
	for gcvg-git-2@plane.gmane.org; Tue, 26 Feb 2013 18:01:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751515Ab3BZRAt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2013 12:00:49 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55933 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750784Ab3BZRAt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2013 12:00:49 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5794EBEAF;
	Tue, 26 Feb 2013 12:00:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ECAT8i7+lw3tYAMFEZyJUKRxp5E=; b=MGcftl
	ciTwAjLDZoG2hlobEI2jSSmNmkOeUfhoUV04Q9SG+eId6K9m/GUnWWBdMIXBteGa
	MjsrB2FT3n1Lx1yuK31kZR5RkPBTuPmDEBkw4tjn0a2iBaTkjqjroz0Zueye7pmI
	vxMc2ybAQv/z8wSyP3gSl4nu/SdSYZHM0pRaU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ipHn6Ttj+j/AOVdJw/qJ5PAAkH3dd6F6
	wIqWpZIC9VTSs1sxbhIBDKXTkk8uSO576MalvthMCAIzgRW48Da3d4kOzqqmv4pC
	0z3OGqOmi7xcL2z8Qk+19RwQiHqEBiIsjbtq6RgRDnw0iTfYPl+nRWrGsZ4jUHo2
	VuvTJNYEz+8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 47C1BBEAE;
	Tue, 26 Feb 2013 12:00:48 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B0669BEAD; Tue, 26 Feb 2013
 12:00:47 -0500 (EST)
In-Reply-To: <vpq1uc3cagy.fsf@grenoble-inp.fr> (Matthieu Moy's message of
 "Tue, 26 Feb 2013 17:21:17 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 110EE77C-8036-11E2-99A4-F3C82E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217149>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> I didn't even know that multi-words messages would be allowed this way.
> That seems to me to be really weird indeed.

Yeah, but it is understandable why it was done that way, considering
taht the whole point of "stash" is to save away quickly for higher
priority interrupt. IIRC, earlier iterations of the command did not
even require you to say "save", i.e.

	git stash wip: futzing with --keep-index

would have been a perfectly good invocation.

> My feeling is that "git stash save" should learn a "-m, --message"
> option analogous to the one of "git commit", and then the "message on
> the command-line" syntax could be deprecated.
>
> (One nice side effect would be that in the very long term, we may want
> to allow "git stash save -- <pathspecs>" to do a limited stash)
>
> But maybe it's not worth the effort, I don't know.

Yeah, if the user wants to be more elaborate perhaps

	git checkout -b temp
        git commit -m 'whatever message' -a
	git checkout -

would suffice; "stash" is for smaller changes in a very tentative
nature that do not deserve such a long command sequence, so
requiring "-m" may make the command less useful.
