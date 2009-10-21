From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] What to you think about a loose status for submodules?
Date: Wed, 21 Oct 2009 13:23:19 -0700
Message-ID: <7vy6n4339k.fsf@alter.siamese.dyndns.org>
References: <20091021160122.GA2067@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens Lehmann <jens.lehmann@web.de>,
	Lars Hjemli <hjemli@gmail.com>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Wed Oct 21 22:23:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0hib-0007Ct-Dt
	for gcvg-git-2@lo.gmane.org; Wed, 21 Oct 2009 22:23:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753297AbZJUUX2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2009 16:23:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753079AbZJUUX1
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Oct 2009 16:23:27 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:56893 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750919AbZJUUX1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2009 16:23:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4112F8063F;
	Wed, 21 Oct 2009 16:23:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TroDj4KGTNVTOdt6C7HQ4u1mZQM=; b=nthB1u
	sGFRT9VjQoK9yN/u+PW0DX2kRqlMaaX6VBKYBPYiiNrrpXBp9GXVcgrNEtdkeu39
	AMLuEDbEVzKM0V7l1dXKRs/doJI+UpC9W0waKI/QOGAWEwnp3B6Pv06qIh59dyk/
	2Jsxp7tqcLUz3514nDmPVujGnUDZgoRDT7Bkk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Gx24lecEOjhkhuljhZkuEuKoNyr8yuk7
	8tevLYPju8KnPtVEHFEQiAURJx8NzpJc3vevX+Nx5lUM+dHVvtg7TeQmKz4SC6lQ
	KvtptLJSOlDySA0qOSZqltf1pR2p+lEff411zKZfEwrmSyL31fxWtyI65ehyrBAg
	lBHgfEd+Uz4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0A5E78063D;
	Wed, 21 Oct 2009 16:23:27 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E6F3780636; Wed, 21 Oct 2009
 16:23:20 -0400 (EDT)
In-Reply-To: <20091021160122.GA2067@book.hvoigt.net> (Heiko Voigt's message
 of "Wed\, 21 Oct 2009 18\:01\:23 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 96ED0CD8-BE7F-11DE-8535-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130959>

Heiko Voigt <hvoigt@hvoigt.net> writes:

> For such a workflow I would like to implement what I call 'loose'
> submodules. Where a
>
>   git clone project.git
>   cd project
>   git submodule init && git submodule update
>
> would omit the 'help' folder. But in case I specify it directly like

I thought a blanket "submodule init/update" wasn't even a recommended
practice for this exact reason.  We tried to keep the default not to
gratuitously populate and checkout all submodule repositories, but
probably what you are trying to do was made more difficult by mistake
because people who wanted the other behaviour pushed too hard?

Defaulting to "do not populate and checkout unless explicitly asked"
sounds like the right thing to do, and if we broke it, it should be
corrected, I think.  Shouldn't it be a simple matter of teaching "--all"
option to "submodule init" (and "update") to let them blindly affect all
submodules, while making the default not to do anything?

>   git submodule init help
>
> it would update to the recorded revision.
>
> Of course the relation would be configurable. E.g.:
>
>   git config submodule."name".relation loose
>
> and the opposite as
>
>   git config submodule."name".relation tight

I do not think this should be a project-wide configuration that is
recorded in .gitmodules; if you are "help documentation" participant to
the project you would want "help" submodule, and other people will want
different submodules.

It would probably make more sense to introduce the notion of "module
groups", similar to the way "remote update <group>" can name a group of
remotes to affect.  Then documentation people can say

    submodule init doc && submodule update

if .gitmodules file records the mapping from "doc" to one or more
submodules (e.g. "help" and "doc").  If we are going to take this route,
it would still make sense to teach "--all" to "submodule init" and perhaps
default to init the "default" group if one exists, instead of making the
parameterless "init" a no-op as I suggested earlier.

But it is quite a long time since I looked at git-submodule.sh so please
take the above with a healthy dose of salt.
