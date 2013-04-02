From: Junio C Hamano <gitster@pobox.com>
Subject: Re: check-attr doesn't respect recursive definitions
Date: Tue, 02 Apr 2013 09:43:30 -0700
Message-ID: <7vhajog9xp.fsf@alter.siamese.dyndns.org>
References: <slrnkldd3g.1l4.jan@majutsushi.net>
 <20130402143130.GC23828@sigill.intra.peff.net>
 <7vtxnogbft.fsf@alter.siamese.dyndns.org>
 <20130402163034.GA19252@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jan Larres <jan@majutsushi.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 02 18:44:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN4JX-0002xL-Ms
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 18:44:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760011Ab3DBQne (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 12:43:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56884 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759653Ab3DBQnd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 12:43:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1FEFB11B46;
	Tue,  2 Apr 2013 16:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uN0WXuAuHl+plp/VahFNUtvttpo=; b=kzAmgS
	tfcsuqHNTrvnKB7eYjE26AdijDaAQYWDwwTXACJbKiwFBQMob+q4igABy/FeGOaH
	BccWFAjpi3FnkxGoigvhofP+pY/NrhT7Mys+gR7skKbDxiL7X5viAK6W/aEjDvkQ
	BorSaOwh6PwDAbBT6hIe+SPFmaELWu1OvTsF8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kJIWHvbLwyf8PVogVeIytn/kLq2VEsDc
	OIZewZe+SJ2CkI6gEh4ZuhuzBaR7JVP4qPM1PrTUtCK3CjIbFCTcYTCyh3TxfmrV
	BCdc1EWXIdbbLT0MMF3v4NYZagoHurQ5hbyCSq1PkwEmGsF58rUXOR4hm0MLzC+L
	0kgEWVpUgBw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1345D11B44;
	Tue,  2 Apr 2013 16:43:33 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7231311B40; Tue,  2 Apr
 2013 16:43:32 +0000 (UTC)
In-Reply-To: <20130402163034.GA19252@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 2 Apr 2013 12:30:34 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7474BBFE-9BB4-11E2-BB6A-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219794>

Jeff King <peff@peff.net> writes:

> On Tue, Apr 02, 2013 at 09:11:02AM -0700, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> > Yes, it is the expected behavior, though I cannot offhand think of
>> > anything that would break if we did apply it recursively.
>> 
>> Conceptually that breaks our brain.  "All files in doc/ directories
>> are text" and "doc/ directory is text" are two different things, no?
>
> In some systems, yes, but git does not have any notion of "doc/" as an
> item (after all, we track content in files, not directories), so I do
> not see what it means to specify a directory except to say "everything
> under it has this property".

That was true back when gitattributes (and ignore) was defined to
apply only to the paths we track.  But export-ignore abuses the
attrtibute system, allows a directory to be specified in the match
pattern, and we declared that is a kosher use by the patch that
caused 1.8.1.X regression, no?  So "Git does not have any notion of
"doc/' as an item" is no longer true, I think.
