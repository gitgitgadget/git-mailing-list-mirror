From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] Let submodule command exit with error status if path
 does not exist
Date: Tue, 14 Aug 2012 13:59:01 -0700
Message-ID: <7vmx1x8a22.fsf@alter.siamese.dyndns.org>
References: <1340872080.2103.92.camel@athena.dnet>
 <20120809200302.GA93203@book.hvoigt.net>
 <7vboijol03.fsf@alter.siamese.dyndns.org>
 <20120811064912.GA83365@book.hvoigt.net>
 <7vy5lkfyx1.fsf@alter.siamese.dyndns.org>
 <20120813163911.GA6418@book.hvoigt.net>
 <7vvcgmemyk.fsf@alter.siamese.dyndns.org>
 <20120814203526.GA33843@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Daniel Milde <daniel@milde.cz>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Tue Aug 14 22:59:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1OCm-0007PL-9B
	for gcvg-git-2@plane.gmane.org; Tue, 14 Aug 2012 22:59:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757520Ab2HNU7G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Aug 2012 16:59:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41466 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757422Ab2HNU7E (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2012 16:59:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DE67D889F;
	Tue, 14 Aug 2012 16:59:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1uY7s+4bRUDqvImE+6UUXCWpLsc=; b=rngckD
	BPTkszAYWKY4sbONp/i+GRji+8OifaOZTD6gFjoP/2c7dUf5IgKGZ+z3EDvC1Z8h
	1Rl93MuIEQ8quePF/qeAfyywJEn4XKplyfS9BWo5VP0oX7buVtYZmwhynQ+gkF+f
	ejda1R0XbndjXaGreB5lxIuUEBYgQ6o5WudE8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NQQtFP76a/0yHAYi/Je4INLLbxPIR//y
	J1StipP+VIHdPhpejb73IQs134/KEA63KkXxob4evh2v+fVJNr14d0D1AE2mRr3h
	JF/calIkT7tvNnarLMB2pTShMadEDhohEAbdvSqSm7T5iuZGFtgUXc8QUYReJz0f
	ue4PALW8ww8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CBB44889E;
	Tue, 14 Aug 2012 16:59:03 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2FFB0889C; Tue, 14 Aug 2012
 16:59:03 -0400 (EDT)
In-Reply-To: <20120814203526.GA33843@book.hvoigt.net> (Heiko Voigt's message
 of "Tue, 14 Aug 2012 22:35:27 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E0DBF414-E652-11E1-B87D-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203452>

Heiko Voigt <hvoigt@hvoigt.net> writes:

> Previously the exit status of git submodule was zero for various
> subcommands even though the user specified an unknown path.

As any patch that fixes behaviour deals with "Previously", I'd
prefer to omit it and describe the current problem in present tense
instead.

Will queue with minor tweaks.  Thanks.

> this is an updated version with your proposal incorporated. I changed
> the name of check_unmatched to die_if_unmatched because IMO it describes
> more clearly what the function is doing.

In general, I would actually prefer to call this kind of function
"check".  That way, all the call sites only need to be aware that
there is a check done there, without having to know what happens
when the check triggers, and the implementation of "check" could
decide that dying is too much and weaken the behaviour to only warn
in later updates.

Such an update would not easily apply for this particular case
because you would need to spit out all of @out from the module_list
before giving the "#unmatched" warning token, and find a way to
buffer the error message from ls-files so that it can be given when
the warning is issued at the end if we wanted to weaken this to
warn.  So in this particular case, I do not mind renaming it to
die-if.

Thanks.
