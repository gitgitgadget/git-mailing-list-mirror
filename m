From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] status: really ignore config with --porcelain
Date: Thu, 27 Jun 2013 20:59:48 -0700
Message-ID: <7v61wyrikr.fsf@alter.siamese.dyndns.org>
References: <1372077912-18625-1-git-send-email-artagnon@gmail.com>
	<1372077912-18625-2-git-send-email-artagnon@gmail.com>
	<vpqhagnwraj.fsf@anie.imag.fr>
	<CALkWK0=F_i95S+53eZmOAJtA+jG=jvi5-sDc3BgW3rNQo=n3Ng@mail.gmail.com>
	<vpqhagnv9xq.fsf@anie.imag.fr>
	<7vk3ljbh5r.fsf@alter.siamese.dyndns.org>
	<vpq7ghjtpv1.fsf@anie.imag.fr>
	<7vk3lj9xwn.fsf@alter.siamese.dyndns.org>
	<20130628014011.GA620@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 28 05:59:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UsPqm-0004R4-Qe
	for gcvg-git-2@plane.gmane.org; Fri, 28 Jun 2013 05:59:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754161Ab3F1D7x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Jun 2013 23:59:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35431 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754101Ab3F1D7w (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Jun 2013 23:59:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3CE2E266C8;
	Fri, 28 Jun 2013 03:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QEFei5JppLnZ5Fdw1y34MG7q3lQ=; b=NSKiXf
	kBF29KSzijHlHAqZ+1NhSdu5nu8d7kPpp9e8oPnIwp4MACf+xAkmndXp1T6w2Tw4
	Iji+K2KQsMY9La9AwWynV5WoFFrL4KRIlM6qboGN+ZF3tFVXxmzipbnluVIz2eMW
	qEtNcO2pNE21/0FfN8qEJlD9SiqRDKaJ8Z3lY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=geNlkSiKQsgft3I2qMDi/HKqOhxPXFfF
	LYoadsNux1KLvEwmp0toYBNl+e5U50PHguQyO5FdUj4ata2GMW78H1mp8Og50kY1
	V+Evm1C5COszUpRjtGZjZvhb5zUvw7f4rcs9y1RJrXK866HRU4r9ZGz0Mi5Qe0SQ
	d/kXD6H7xUY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3127C266C7;
	Fri, 28 Jun 2013 03:59:51 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A5217266C5;
	Fri, 28 Jun 2013 03:59:50 +0000 (UTC)
In-Reply-To: <20130628014011.GA620@sigill.intra.peff.net> (Jeff King's message
	of "Thu, 27 Jun 2013 21:40:11 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2E7AD7F0-DFA7-11E2-91AB-E636B1368C5F-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229175>

Jeff King <peff@peff.net> writes:

> You lose the assertion that finalize_deferred_config has been called,
> but I think the resulting code would be simpler, as it drops this
> die("BUG") state entirely. Am I missing something?

Probably not.  Depending on "-z", NONE is sometimes converted to
PORCELAIN and sometimes left as-is.  I originally wanted to keep the
"unspecified" state as long as possible so that this deferred config
logic and the "-z" default logic can be kept separate.

The final patch ended up folding that "-z" default logic into the
same function, so it probably is saner to remove UNSPECIFIED.
