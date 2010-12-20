From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] convert filter: supply path to external driver
Date: Mon, 20 Dec 2010 09:59:31 -0800
Message-ID: <7v8vzkcol8.fsf@alter.siamese.dyndns.org>
References: <20101218223822.GA18902@arf.padd.com>
 <20101219212925.GA7393@arf.padd.com>
 <7vzks1e84p.fsf@alter.siamese.dyndns.org>
 <20101220160911.GA32136@honk.padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Mon Dec 20 18:59:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PUk1W-000325-52
	for gcvg-git-2@lo.gmane.org; Mon, 20 Dec 2010 18:59:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752981Ab0LTR7o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Dec 2010 12:59:44 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:46036 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751012Ab0LTR7o (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Dec 2010 12:59:44 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E9BF12029;
	Mon, 20 Dec 2010 13:00:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hNW5qP7iTKN5J2jlr+XGhjskjg8=; b=VMMZaT
	Ij1GOhHgVU9r7EpDo7r3mF7x2eNzUYxiGGPHxlihiXguQbeBVA+gogjEa3W5/nQJ
	UqEq7qqK+NAwFTtVohS7rkA3gb+rcnzqxGSEoj2eD9gyR7xPFeq0/2cGvt9LlAZM
	pmN0I736VCpkosJ0o/qfLB/LaSiW/1/d+RWxI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VsgPywBXszdVzpnNMmCB7ShbN4XB3SdT
	B2X5qD51e+Z7XpLWZsxwyEOmJGWrbNmTmu/KynbdJA3LPYLkyXKsT+yK7/zEgtVA
	YsevE44yYEFGR4aqWh6i8ndDLDDU8KK8MgGkxAb0JKd8QHW1ogNN+RatrT+D44nv
	12ctr3e++dg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A94CF2027;
	Mon, 20 Dec 2010 13:00:07 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 607F62026; Mon, 20 Dec 2010
 13:00:02 -0500 (EST)
In-Reply-To: <20101220160911.GA32136@honk.padd.com> (Pete Wyckoff's message
 of "Mon\, 20 Dec 2010 08\:09\:11 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FAE1A2DA-0C62-11E0-90C4-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164000>

Pete Wyckoff <pw@padd.com> writes:

> This version of the patch handles quoting of shell
> meta-characters, as pointed out by Hannes.  I decided to invoke
> sq_quote_buf directly on the path before expanding %s, rather
> than writing a dict entry to understand %'s.

Ahh, that's much more preferable than my horrible suggestion ;-)  If the
user wants to have concatenation with other parameters, that can be left
to the shell that is invoked, e.g. "--clean foo/%s" for "hello world.c"
would expand to "--clean foo/'hello world.c'" and does what we want.

Another nitpick is if 's' is the right letter to use for the pathname
information.  I think you took 's' after "string", but if this is to be
extensible, you should anticipate that later there will be other kinds of
information you may want to throw at the filters, and expect that some of
them also will be of type "string", and you will have painted the person
who wants to add that new information into a tight corner as you already
took the valuable 's'.

Which would suggest that you shouldn't be naming the placeholder after the
type but after what the placeholder means, no?  Perhaps %f (for filename)
would be a better choice?
