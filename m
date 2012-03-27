From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC v2 1/4] fetch-pack: new --stdin option to read refs
 from stdin
Date: Tue, 27 Mar 2012 16:26:05 -0700
Message-ID: <7vwr65y6b6.fsf@alter.siamese.dyndns.org>
References: <loom.20120318T083216-96@post.gmane.org>
 <m3fwd550j3.fsf@localhost.localdomain>
 <20120318190659.GA24829@sigill.intra.peff.net>
 <CACsJy8BNT-dY+wDONY_TgLnv0135RZ-47BEVMzX6c3ddH=83Zw@mail.gmail.com>
 <20120319024436.GB10426@sigill.intra.peff.net> <4F69B5F0.2060605@gmx.net>
 <CAJo=hJu0H5wfXB_y5XQ6=S0VJ9t4pxHWkuy_=rehJL_6psf00g@mail.gmail.com>
 <20120321171423.GA13140@sigill.intra.peff.net> <4F715CF7.5070903@gmx.net>
 <4F715D55.8020109@gmx.net> <7vhaxaj7yi.fsf@alter.siamese.dyndns.org>
 <4F724ADC.2030909@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Ivan Todoroski <grnch@gmx.net>
X-From: git-owner@vger.kernel.org Wed Mar 28 01:26:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCfmh-0006aN-GR
	for gcvg-git-2@plane.gmane.org; Wed, 28 Mar 2012 01:26:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756772Ab2C0X0P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Mar 2012 19:26:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56245 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755717Ab2C0X0I (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2012 19:26:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F14B67D6E;
	Tue, 27 Mar 2012 19:26:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hkvVngCtqMcs7VWMh+0vM8QW5Z0=; b=h/mVls
	TPP+y3JqzmhB+RCN3tUMEi3Ftai5aG+32KnN65WzB7GoJgN5vBI0QkENfSpERHGl
	PqGz7hGzUlJdAdvPu7VSi5pcQEhqNKfI39m8TEtVKXOUptrhKiqBl/D3/H9KmTp1
	sXbI8kfh6zgGfofNGLRDJQLGuuIMMRQDSCsjc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OE+gnVLNa0G4oK/tyuPorNzOIqLtpbIq
	pA6HEBjesf1GYP9xNFhX4DxDENuugmdpxUMol0pHkWxztZYMuppUsrPEOo/4/xJY
	7oXMAEFeuaqDYFJikws9d4BGsAPqCQvBI/+78TgZwCbMQqV95KR9XVgwK8B62XQP
	eOI4pLA4Uxo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D3C727D6C;
	Tue, 27 Mar 2012 19:26:07 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 39C9A7D6B; Tue, 27 Mar 2012
 19:26:07 -0400 (EDT)
In-Reply-To: <4F724ADC.2030909@gmx.net> (Ivan Todoroski's message of "Wed, 28
 Mar 2012 01:18:52 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3A914ADE-7864-11E1-AFA7-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194096>

Ivan Todoroski <grnch@gmx.net> writes:

> On 27.03.2012 18:59, Junio C Hamano wrote:
>> Ivan Todoroski <grnch@gmx.net> writes:
>>
>>> +		int alloc_heads = nr_heads;
>>> +		int size = nr_heads * sizeof(*heads);
>>> +		heads = memcpy(xmalloc(size), heads, size);
>>> +		if (args.stateless_rpc) {
>>> +			/* in stateless RPC mode we use pkt-line to read
>>> +			   from stdin, until we get a flush packet */
>>> +			static char line[1000];
>>
>> We will never have a refname that is longer than this limit?
>
> I don't know. I grepped the code for existing usages of packet_read_line
> and that seemed to be a common idiom everywhere. Should I just bump up
> the size or is there some accepted way to read arbitrary length packets?

As you may have already guessed, you can have up to (64k - slop) bytes in
a packet.  But it probably does not matter, as a loong ref that bust your
limit will not fit in the packet used in the normal codepath anyway.

>> Curious.  "stop at EOF", "trim" and "skip empty" imply that you are
>> catering to people who debug this from the terminal by typing (or copy
>> pasting).  Is that the expected use case?
>
> The expected use case is people using this from shell scripts that
> could be getting refs by slicing and dicing output of other commands
> with regexps and what not

That kind of use would not have leading or trailing whitespaces, and if
the target audience is scripts, I would prefer to force them to be
strict.
