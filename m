From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] notes: avoid recommitting identical trees
Date: Tue, 31 Aug 2010 09:44:47 -0700
Message-ID: <7vfwxud94w.fsf@alter.siamese.dyndns.org>
References: <4C7CD65F.10509@atlas-elektronik.com>
 <bc44b3393db4018487bb956d00a12fa73f04ca9e.1283267564.git.git@drmicha.warpmail.net> <20100831160145.GC11014@sigill.intra.peff.net> <4C7D2AAE.9000701@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Johan Herland <johan@herland.net>,
	stefan.naewe@atlas-elektronik.com
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Aug 31 18:45:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqTxa-0008Ni-DD
	for gcvg-git-2@lo.gmane.org; Tue, 31 Aug 2010 18:45:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753666Ab0HaQpE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Aug 2010 12:45:04 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:54809 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753999Ab0HaQpD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Aug 2010 12:45:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E0999D2279;
	Tue, 31 Aug 2010 12:45:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LL2aVZNadQWTHLl9fd4/cRMFtuU=; b=u3DZ+n
	71AXiyE1roCM7l2syg2AsXPOmQlNHZZG2qog49tEBHGeVs+HgkmIUIf43VeSjb5a
	bwOVRgcCcff/Ll1hLtyFDkXGP+cRT5Aj4pZB4IU4ItywrDbVvO1zA083QOBBgoXu
	0Zz6uI8tlXcmC7GkH7DciXVVrEaw5ZP1AnymM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RDBSQdoGk1o+2n3G3I7PKu8WQpg2BElq
	qz6PH/f8Y+3PIDVEAHuow7zDXAw38tmsMSTL5LD66ZOwZumoHBwI9a8eCcF8FWnz
	vjdZ4HQ14uu9J5WM68e8paxzBun+oX3vLSfHLsugN411k0+8HAWrQzRvFxSm1/cs
	ZWCXUIl4t6A=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 87E6CD2278;
	Tue, 31 Aug 2010 12:44:55 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8A3E2D2277; Tue, 31 Aug
 2010 12:44:49 -0400 (EDT)
In-Reply-To: <4C7D2AAE.9000701@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Tue\, 31 Aug 2010 18\:15\:42 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1597D040-B51F-11DF-B21F-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154936>

Michael J Gruber <git@drmicha.warpmail.net> writes:

>>> +	if (!parent || parse_commit(parent->item) || parse_tree(parent->item->tree) ||
>>> +		hashcmp(parent->item->tree->object.sha1, tree_sha1)) {
>> 
>> I didn't check, but I can imagine you can drop the parse_tree here. We
>> should know the object sha1 once the commit is parsed.
>
> parse_commit() does a lookup_tree() but I don't think that it parses the
> tree, i.e. I don't hink it fills in tree->object.sha1.

Huh?  parse_tree(tree) calls read_sha1_file(tree->object.sha1) to parse
the tree.  How can it do without filling tree->object.sha1?
