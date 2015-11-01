From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Allow hideRefs to match refs outside the namespace
Date: Sun, 01 Nov 2015 10:18:37 -0800
Message-ID: <xmqqy4ehh9c2.fsf@gitster.mtv.corp.google.com>
References: <1445846999-8627-1-git-send-email-lfleischer@lfos.de>
	<1446046920-15646-1-git-send-email-lfleischer@lfos.de>
	<xmqq1tcfm09k.fsf@gitster.mtv.corp.google.com>
	<20151031084917.26006.98611@typhoon.lan>
	<xmqqsi4rhrmc.fsf@gitster.mtv.corp.google.com>
	<20151031234039.3799.78352@typhoon.lan>
	<20151101112716.3758.7843@typhoon.lan>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Lukas Fleischer <lfleischer@lfos.de>
X-From: git-owner@vger.kernel.org Sun Nov 01 19:18:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZsxDI-000552-F4
	for gcvg-git-2@plane.gmane.org; Sun, 01 Nov 2015 19:18:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752567AbbKASSk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Nov 2015 13:18:40 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:62566 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752408AbbKASSj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Nov 2015 13:18:39 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E03C027111;
	Sun,  1 Nov 2015 13:18:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bAQrmQmZ/1YgnKOksg7ZxrW+C9w=; b=FyxnQm
	HDeN9lk000MIDF0zynGO1vG+gf5cCon3RzmbJrzYUmhXuVcUFeZLGIYxCTDVQTST
	ja+vyXK5aw5IaeMWv+3JC5EA71QwygC81UuF/zOMiwkqiVD8xGAuiTYyZzQ82r60
	FCr+AznkT6BRJK/zqYuN2L+H7TNvLdzXmFT30=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eduYrLTRR87TwhXkCdEqwM6NylJ5q7f/
	Mp6sdWoTbzhja104FQB2XbTFXZTuk2ask7UevkvwycqrGQLRAV6EAUdg0N1XRpON
	c20Z34y4eURBhW2rsbFdhU9GXv3n+LifmWdssV99QZZPZKhQsTNUF3VE0z+XYpp4
	7vkYPnDxHwg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D7DB727110;
	Sun,  1 Nov 2015 13:18:38 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 60BCE2710F;
	Sun,  1 Nov 2015 13:18:38 -0500 (EST)
In-Reply-To: <20151101112716.3758.7843@typhoon.lan> (Lukas Fleischer's message
	of "Sun, 01 Nov 2015 12:27:16 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F8FEFF2C-80C4-11E5-A096-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280646>

Lukas Fleischer <lfleischer@lfos.de> writes:

> Now, this cannot be intended behavior and I do not think this is
> something we want to retain when improving that feature.

Yup, that makes me suspect that namespace support with hiderefs was
done without giving much thought even stronger than before, and the
fact that nobody has brought it up so far suggests it would be much
smaller deal than usual if a fix brings in incompatibilities to
those who use namespaces.

> 1. Define the (current) semantics of hideRefs pattern. It either needs
>    to be defined to match full references or stripped references. Both
>    definitions are equivalent when Git namespaces are not used.
>    
>    It probably makes sense to define hideRefs patterns to match stripped
>    references.

OK.

> 2. Improve the documentation and describe the hideRefs semantics better.
> 3. Fix the send_ref() code in either receive-pack or upload-pack,
> 4. Improve hideRefs patterns and allow to match both full references and
> 5. Add a note on the change in behavior to the release notes of the

All OK.

> The second thing I noticed is that having syntax for allowing matches
> against both full references and stripped references is extremely handy
> and desirable, even if we would not have to introduce it for backwards
> compatibility. For example, using the syntax Junio described earlier, my
> initial use case could be solved by
>
>     receive.hideRefs=^refs/
>     receive.hideRefs=!refs/
>
> which means "Hide all references but do not hide references from the
> current namespace." Here, I am assuming that patterns for stripped refs
> never match anything outside the current namespace because those
> patterns become NULL after stripping.

I would instead assume that the presence of ^ (or !^) in front would
signal "do not strip before checking".  !refs/ would mean "after
stripping, does it begin with refs/?  If so then do not hide it".

But that does not change the conclusion.  With ^refs/ that says
"hide everything that matches refs/ before stripping" (i.e. do not
include anything from anywhere), that is overriden by !refs/ that
says "but do not hide anything that matches refs/ after stripping"
(do include everything from my namespace), I'd think that you'd get
your desired behaviour.

Thanks.
