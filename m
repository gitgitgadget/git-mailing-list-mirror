From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] parse-options: deprecate OPT_BOOLEAN
Date: Tue, 27 Sep 2011 21:22:55 -0700
Message-ID: <7vbou5s3c0.fsf@alter.siamese.dyndns.org>
References: <7v39fhv8se.fsf@alter.siamese.dyndns.org>
 <20110928035809.GC10662@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Pierre Habouzit <madcoder@debian.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 28 06:23:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8lfl-00061C-Ag
	for gcvg-git-2@lo.gmane.org; Wed, 28 Sep 2011 06:23:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752203Ab1I1EXA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Sep 2011 00:23:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42373 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751738Ab1I1EW7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Sep 2011 00:22:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7123E5A69;
	Wed, 28 Sep 2011 00:22:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MhF2nPx23u4pWPQzGpQtoyg/c5Q=; b=xYuqkS
	BlXSx2XJ/rRetYjiQYBvHsEsZSHDZdx3a8Ks4ZaaBpPGPoEQezX/5RMM8Y9KvjTA
	VBY1CjKqNWDqg6kXdjmpq4v+v/RtbzM9A6GETfbqCbnwP0R2CeOJwKHmMcGM3rKH
	nviHv2LF+kNg7n1hC6u6ZOtV3M/jJ4qwZxpH8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BJh+uqNATaRcbg1r6TFWj2r0A9PH8Go7
	5WPbgamx7ou53j3CHLIxlfok84dyJ+LjhPNNf1slaArpS34fCWd3jCbkpMmbbAIz
	6IEvgxqi8gmejYcPfIDbkaOSZBggHwlWFLRT6n1toCLqkZk5ujro0pjFB37tKxxY
	8Nh+cPXTmKE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 644AC5A68;
	Wed, 28 Sep 2011 00:22:58 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 459BD5A67; Wed, 28 Sep 2011
 00:22:57 -0400 (EDT)
In-Reply-To: <20110928035809.GC10662@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 27 Sep 2011 23:58:09 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8B00662C-E989-11E0-8635-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182291>

Jeff King <peff@peff.net> writes:

> On Tue, Sep 27, 2011 at 04:56:49PM -0700, Junio C Hamano wrote:
>
>> It is natural to expect that an option defined with OPT_BOOLEAN() could be
>> used in this way:
>> [...]
>> to easily tell three cases apart:
>> 
>>  - There is no mention of the `--option` on the command line;
>>  - The variable is positively set with `--option`; or
>>  - The variable is explicitly negated with `--no-option`.
>> 
>> Unfortunately, this is not the case. OPT_BOOLEAN() increments the variable
>> every time `--option` is given, and resets it to zero when `--no-option`
>> is given.
>
> Yes, please. I remember being bitten by this at one point. Your
> transition plan makes sense to me.

The best part of it is that this leaves many small bite-sized tasks, one
"struct option" per patch, most of which can be done by people who are not
uber experts in Git internals ;-).

> Can OPT_UYN be folded into this, as well?

Perhaps, but I would prefer to keep this simple at least during the first
pass of eradicating OPT_BOOLEAN and OPTION_BOOLEAN. After that is done, we
may want to tackle OPT_UYN() that uses 2 for "unset", which feels a tad
unnatural. It has only one user---even if it turns out that it was a
mistake, the damage would be relatively limited to fix it.
