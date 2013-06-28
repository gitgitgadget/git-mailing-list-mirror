From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] status: really ignore config with --porcelain
Date: Fri, 28 Jun 2013 10:37:26 -0700
Message-ID: <7vhagip25l.fsf@alter.siamese.dyndns.org>
References: <1372077912-18625-1-git-send-email-artagnon@gmail.com>
	<1372077912-18625-2-git-send-email-artagnon@gmail.com>
	<vpqhagnwraj.fsf@anie.imag.fr>
	<CALkWK0=F_i95S+53eZmOAJtA+jG=jvi5-sDc3BgW3rNQo=n3Ng@mail.gmail.com>
	<vpqhagnv9xq.fsf@anie.imag.fr>
	<7vk3ljbh5r.fsf@alter.siamese.dyndns.org>
	<vpq7ghjtpv1.fsf@anie.imag.fr>
	<7vk3lj9xwn.fsf@alter.siamese.dyndns.org>
	<20130628014011.GA620@sigill.intra.peff.net>
	<7v61wyrikr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 28 19:37:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UsccB-0002ru-Nf
	for gcvg-git-2@plane.gmane.org; Fri, 28 Jun 2013 19:37:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752167Ab3F1Rhk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Jun 2013 13:37:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46120 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750769Ab3F1Rhj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Jun 2013 13:37:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9A55F2C4C9;
	Fri, 28 Jun 2013 17:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=l84U2z48jg6nAcQfVcISjdtr9hg=; b=C3ZgOQ
	/nDeS0s0D0gxTT9ngH3qDAR2DubxJqRAD80G0pm4LqgEkeXRCe4H2/o1bV/O3rSJ
	BnUE22PXNSPivCiRiH4xkmVKmZgcmN37OC/+Gd/PRuOYFRRPe2rMClWm5T0w5Q7j
	/GkkCIFnCW+plazXVRL6hW4i+LpPGisiW661E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yTelJYZn+a/nmGZqPlOdUAwc8L1J/exr
	+b6CSwQngijM1UonB8oW31EzNJkpN53lHbq9H8P0juqH2/Fgw3NmCX16VyHVIrkQ
	xt0d/BUsM8WDu1QJt4EZBTyI7faIPrHpg3MAoWDui0aLgTYXIfwf0AVm8g/aZyyy
	JiSwBBhORuo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8E6D12C4C8;
	Fri, 28 Jun 2013 17:37:38 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EC7BB2C4BE;
	Fri, 28 Jun 2013 17:37:36 +0000 (UTC)
In-Reply-To: <7v61wyrikr.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 27 Jun 2013 20:59:48 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6C44E284-E019-11E2-A811-E636B1368C5F-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229220>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> You lose the assertion that finalize_deferred_config has been called,
>> but I think the resulting code would be simpler, as it drops this
>> die("BUG") state entirely. Am I missing something?
>
> Probably not.  Depending on "-z", NONE is sometimes converted to
> PORCELAIN and sometimes left as-is.  I originally wanted to keep the
> "unspecified" state as long as possible so that this deferred config
> logic and the "-z" default logic can be kept separate.
>
> The final patch ended up folding that "-z" default logic into the
> same function, so it probably is saner to remove UNSPECIFIED.

Actually, the code needs to be able to differentiate between

	git status --no-short
        git status

the former telling us explicitly to defeat status.short while the
latter telling us to use whatever random value we happen to have in
the configuration.  Initializing the variable to UNSPECIFIED is one
way to achieve that, as the former will explicitly set it to NONE
while the latter will leave it UNSPECIFIED when the command line
parsing finishes.
