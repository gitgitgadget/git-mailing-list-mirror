From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] push: warn users about updating existing tags on push
Date: Mon, 30 Aug 2010 14:20:26 -0700
Message-ID: <7v7hj7er1h.fsf@alter.siamese.dyndns.org>
References: <20100828012101.GB2004@burratino>
 <1282983736-3233-1-git-send-email-cxreg@pobox.com>
 <7v7hj8frxg.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.2.00.1008300924550.20874@narbuckle.genericorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: jrnieder@gmail.com, git@vger.kernel.org
To: Dave Olszewski <cxreg@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 30 23:20:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqBmT-0003Jf-Cz
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 23:20:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754321Ab0H3VUg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Aug 2010 17:20:36 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:41482 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753632Ab0H3VUf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Aug 2010 17:20:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2414FD2C24;
	Mon, 30 Aug 2010 17:20:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9E6u1zXsIcoTOMoJH/CsbahvySk=; b=wal3ug
	dIZExnXo5msRHuy4vYXXk00Q9ps3canvu7ye19DSKBZMpI7wb0YHUgLa7Cb1SU2s
	iJ5P8wwEgqFfCaYHfl2Yfd2h/rscZVlmb9t/v6UskrfH08lKZQQuzyStok4BG2SU
	WuNUbRAHxjWQR0C5y4UK9x3Ue9nUVa/YOiU5E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CNqow5dUBFTaNQWXWle8fgrKD/ephHB3
	WW/4b/TO1JNK8e7igQBe8McDf4J5BDsO3K1KdKyo4FG+IRzAeA4cRJsXVhgRFO9M
	yz69c/4aSK5DE95J+5yVuvs8EKKOGA9dWllFrz0e9ppv/Mvnh4q0VyVVzUGEIii4
	IEx9ZDtGhy8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DF57AD2C23;
	Mon, 30 Aug 2010 17:20:31 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 139B2D2C1F; Mon, 30 Aug
 2010 17:20:27 -0400 (EDT)
In-Reply-To: <alpine.DEB.2.00.1008300924550.20874@narbuckle.genericorp.net>
 (Dave Olszewski's message of "Mon\, 30 Aug 2010 09\:38\:59 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6B9E4846-B47C-11DF-847B-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154847>

Dave Olszewski <cxreg@pobox.com> writes:

> On Mon, 30 Aug 2010, Junio C Hamano wrote:
>
> Thanks for the critique and comments
>
>> Dave Olszewski <cxreg@pobox.com> writes:
>> 
>> > Generally, tags are considered a write-once ref (or object), and updates
>> > to them are the exception to the rule.
>> 
>> This may be just the naming issue and you could say "moving them",
>> "updates to them" or "changing them" interchangeably in the above;
>> among them, "updates to them" sounds the most natural.
>> 
>> Can you change the "moving" in the patch to make them consistent with the
>> above description?
>
> Sure, no problem.  Would you like this changed in the variable and
> config names as well, or just the printed text?

The goal being making them consistent, the text and configuration variable
(which are user-facing names) should match variables and functions (which
are internal names).  It would be inconsistent to store the value of the
xfer.denyupdatetag configuration in deny_moving_tags variable, no?

I wondered if denyupdatetag should also forbid "git tag -f"; it would be
awkward if we did so.  The configuration is only about forbidding ref
transfer operations from updating the tags.

But somehow core.denyupdatetag sounds as if "git tag -f" is also verboten
and that is why I weatherballooned xfer.* in the first paragraph of this
message.
