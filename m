From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] Add an update=none option for 'loose' submodules
Date: Thu, 25 Aug 2011 23:27:45 -0700
Message-ID: <7vbovcg00u.fsf@alter.siamese.dyndns.org>
References: <cover.1312923673.git.hvoigt@hvoigt.net>
 <7v8vqzreeo.fsf@alter.siamese.dyndns.org>
 <20110811195955.GA21185@book.hvoigt.net>
 <7vy5yujtr2.fsf@alter.siamese.dyndns.org> <20110822200052.GC11745@sandbox-rc>
 <7v62lpuky8.fsf@alter.siamese.dyndns.org>
 <20110823194350.GA57187@book.hvoigt.net> <4E540B03.2030909@web.de>
 <7vpqjvrebk.fsf@alter.siamese.dyndns.org>
 <20110824193007.GC45292@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Fri Aug 26 08:27:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwptR-0000qp-C8
	for gcvg-git-2@lo.gmane.org; Fri, 26 Aug 2011 08:27:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753356Ab1HZG1t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Aug 2011 02:27:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48471 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753092Ab1HZG1s (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Aug 2011 02:27:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7967C2CDE;
	Fri, 26 Aug 2011 02:27:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=v3/RekQTZDM8CD9cAbJpOfBO/Zo=; b=BsL4FI
	zmr0Hn4qYlJzoqkJJrubsXnKcvyonKMJxoYK+a2p/+8XNkMglsaSE9N2XYPscJdh
	iMle7pkJVMp82c5cDcALyPdh2OMeh4WzJp06qQoqLDexhPAXOlYRRNcZWLm0TIH2
	2/BQ7nIKf4z8extCtb0JNXCTLJ1RFlhattT+Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vZtJ/twaEDZGhcDKJ4a1ieJBjuVGIyOS
	Sp3wc7TH0VYNYgo1NrY5JBzov/Jexu3dhU7BQlryf0ME90vKidxvSY9g9jBhmO6O
	DPPVeIq0JPMYRBSD1ye1DanxyisnF1VW3ECvjvgJpWdMQZfVFKOC7KhREcwrM1qc
	PnRiWpRThIo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6EFDF2CDD;
	Fri, 26 Aug 2011 02:27:47 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BA1B52CDC; Fri, 26 Aug 2011
 02:27:46 -0400 (EDT)
In-Reply-To: <20110824193007.GC45292@book.hvoigt.net> (Heiko Voigt's message
 of "Wed, 24 Aug 2011 21:30:08 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 83720D26-CFAC-11E0-9F33-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180153>

Heiko Voigt <hvoigt@hvoigt.net> writes:

>> That is definitely a huge semantics change.
>
> Ok seeing it that way. You are right. How about this?

Actually I had an update to Documentation/git-submodule.txt in mind. For
example, we say this for "update":

  Update the registered submodules, i.e. clone missing submodules and
  checkout the commit specified in the index of the containing repository.

I know you added "yes, we earlier said this will clone missing ones and
checkout, but if this configuration is set to none then none of that
happens" much later in the section, but that feels backwards.

Thinking about it more, I am starting to think that this backwardness may
be an indication that we are describing a wrong solution to a wrong
problem.

Isn't the root cause of the issue that a "submodule init" without pathspec
limit adds everything to .git/config, ending up with all submodules fully
instantiated, and it is too easy to run such a lazy "submodule init"?

If we allowed the project managers (i.e. the ones who write .gitmodules)
to specify the default set of submodules to be initialized with such a
"submodule init", omitting some submodules from even getting registered to
the recipients' .git/config in the first place, wouldn't that solve the
issue you are trying to address equally well, without anything to worry
about this semantic change at all? I am trying to see if we can come up
with a solution with which we do not even have to add any entry for a
submodule to .git/config of the superproject, if it is "don't care" kind
of submodule for the copy of the superproject repository the user has.

The way in which the project managers specify that a module is not meant
to be "init"ed by default may be to have "submodule.$name.update = none"
in the .gitmodules file they ship, so externally there may not be huge
difference from the behaviour (but not the implementation) of your patch,
even though submodule.$name.update probably is not a good variable name to
be used for this purpose.

Another thing we may want to consider is to make .gitmodules describe
submodule dependencies. If your hypothetical superproject is about a
library, which consists of doc/, include/, and libsrc/ submodules, with
pre-built binary perhaps shipped as part of the superproject itself, those
who work on documentation may want to populate only doc/, those who are
interested in using the library may want to populate only include/ and
possibly doc/, and those who work on the library itself would populate
include/ and libsrc/, possibly with doc/ submodules. It wouldn't make any
sense to populate libsrc/ without populating include/ submodule, as the
source would not be buildable without the includes.

Now if we imagine that much more people are interested in using the
library than working on it, it is plausible that the project may want to
suggest:

 - Majority of people may want to omit libsrc/ submodule; and

 - If you populate libsrc/, then you would definitely want to populate
   include/ submodule.

Your "submodule.libsrc.update = none" in .gitmodules can express the
former, and I think it is natural to express the latter (i.e. submodule
dependency) in the same file, to be propagated in the same way to the
consumers.
