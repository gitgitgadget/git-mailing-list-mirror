From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rev-parse --parseopt: fix handling of optional arguments
Date: Wed, 16 Oct 2013 14:40:07 -0700
Message-ID: <xmqqsiw051zc.fsf@gitster.dls.corp.google.com>
References: <1381838425-18244-1-git-send-email-boklm@mars-attacks.org>
	<20131015231427.GF9464@google.com>
	<xmqqfvs29kjc.fsf@gitster.dls.corp.google.com>
	<20131015235739.GI9464@google.com> <525E3A80.5000500@viscovery.net>
	<20131016085316.GA31314@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Nicolas Vigier <boklm@mars-attacks.org>, git@vger.kernel.org,
	Pierre Habouzit <madcoder@debian.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 16 23:40:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWYpF-0000G1-OZ
	for gcvg-git-2@plane.gmane.org; Wed, 16 Oct 2013 23:40:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760181Ab3JPVkN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Oct 2013 17:40:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36686 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755565Ab3JPVkK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Oct 2013 17:40:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 92E404BFD6;
	Wed, 16 Oct 2013 21:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=WBMbVONlTVDKLidy9NMJpt3nA+Q=; b=n892uzQXb8rLCWZFj70M
	vdqpEZnCFh/uXkduX5vJYRSOX5AermjhYidTSbVVQQh4OLJd7Q6Prz/zotLVynK0
	v2fDKyYOdBCoqmh/NwE4lLlSJN+es0qq5nSmugzI8LRILg4ZS0FMnuhs1G8dVss4
	upGUNBpN5/X/Ki0rFprmxn8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=nDdoyytOxQcxYeH7D6rWxs7+fJrU8W0OHi7yuaaGUpY799
	HjWMiRJqPvPmPJJ4tOm/4qBlpOic214gl/uw7knq6UL2fOc83j95wdwmRe5S792L
	6EAweA7AOesFQOE3fwwQ79Ro/1S3XQgqbnbrcwJS4KMCMrBKI+uc5IVMekQSk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7C6A44BFD5;
	Wed, 16 Oct 2013 21:40:10 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D8BFB4BFC8;
	Wed, 16 Oct 2013 21:40:08 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 8771E6E0-36AB-11E3-997A-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236269>

Jeff King <peff@peff.net> writes:

> ... But what is the normalized form for an
> optional argument? It either needs to be consistently "sticked" or
> "unsticked", either:
>
>   set -- -S '' --     ;# default
>   set -- -S 'foo' --  ;# not default
>
> or
>
>   set -- -S --    ;# default
>   set -- -Sfoo -- ;# not default
>
> so that reading the normalized form is unambiguous.

The analysis makes sense.  Either form do not let you distinguish
between the case where the end user wanted to explicitly pass "" as
the optional parameter to -S and the case where she gave -S without
any optional parameter, though.

Which pretty much agrees with j6t's (and my earlier) comment that
there is no way to solve this issue completely, I think.

It is an acceptable compromise to use your suggestion as a solution
that works for cases other than passing an explicit empty string as
an optional parameter, I would say, if the limitation is clearly
documented.

Thanks.
