From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/5] test-lib: filesystem prerequisites
Date: Thu, 26 Jul 2012 13:10:18 -0700
Message-ID: <7vzk6m5ln9.fsf@alter.siamese.dyndns.org>
References: <5001B82B.1060201@web.de>
 <cover.1343309173.git.git@drmicha.warpmail.net>
 <7vtxwu75gy.fsf@alter.siamese.dyndns.org>
 <20120726184337.GB16037@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org,
	tboegi@web.de
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jul 26 22:10:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuUOD-0004JH-8j
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jul 2012 22:10:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752632Ab2GZUKX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jul 2012 16:10:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57150 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752043Ab2GZUKV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2012 16:10:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BF7EC9EC8;
	Thu, 26 Jul 2012 16:10:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xYAivEQw+S7FGN+x/Epf5Kn/KDw=; b=nmzdxA
	9rU66HQhUU8we0O3EAOp+/OkU0M65SkQRC14ZtuTOHKQG0fxhd99EU6BNSUFVnqk
	UT8xrL7UlbDb//LOS282EvSHZ8RmpxRhs34hp4xuPFHZ8Lvh2PpsSQx/hQ/GA/lH
	RH8yOKiS4yJKVROM+4xQKf5Du3VktE/pcRIGU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DSHG1v54HrLpUxQR4ei8hj37CxwQJNck
	+rJPNJdKCcbtNPRg9bjAJf6R0xcHNMolqKdacrycnUEehVEVicBhiaOrWNKoZ0he
	6PqfSu6RNKe1jAL0GmJY9D9uD85kxb+aKGG+72E0clgUYum7SGLx8kvEnTGlpj8H
	zTEnb2GcBoo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AB8D49EC7;
	Thu, 26 Jul 2012 16:10:20 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 27B799EC6; Thu, 26 Jul 2012
 16:10:20 -0400 (EDT)
In-Reply-To: <20120726184337.GB16037@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 26 Jul 2012 14:43:37 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: ECBF451E-D75D-11E1-8110-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202301>

Jeff King <peff@peff.net> writes:

> That looks like a maintenance annoyance. Can't we just have the
> prerequisite-checker lazily perform the test on demand and cache the
> result?  It should be OK as long as:
>
>   1. The prereq is careful about its pre- and post- conditions. We
>      already make sure to clean up after those tests so as not to taint
>      later tests. We would probably want to also make them more careful
>      about preconditions like which directory they are in (so, for
>      example, refer to "$TRASH_DIRECTORY/junk" and not "junk").
>
>   2. The prereq test does not accidentally munge any existing test
>      state from previous tests. That should not be a big deal as long as
>      we avoid names like "junk" in favor of more unique names like
>      "check-case-sensitivity-prereq".

Yeah, it is very desirable if we could lazy-eval, and we _should_ be
able to arrange the above.
