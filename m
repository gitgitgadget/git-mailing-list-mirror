From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Remove diff machinery dependency from read-cache
Date: Thu, 21 Jan 2010 19:56:18 -0800
Message-ID: <7vvdeubxnh.fsf@alter.siamese.dyndns.org>
References: <alpine.LFD.2.00.1001211119130.13231@localhost.localdomain>
 <7vljfrp6g2.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1001211215080.13231@localhost.localdomain>
 <alpine.LFD.2.00.1001211355500.13231@localhost.localdomain>
 <alpine.LFD.2.00.1001211515470.13231@localhost.localdomain>
 <7v636vj7c2.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1001212131230.1726@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Fri Jan 22 04:56:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYAdQ-0001jf-63
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jan 2010 04:56:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752029Ab0AVD4c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2010 22:56:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751979Ab0AVD4c
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jan 2010 22:56:32 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:59943 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751915Ab0AVD4a (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jan 2010 22:56:30 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 64A5392D84;
	Thu, 21 Jan 2010 22:56:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uJLdqhDzvpTAvp8R+uc4RhTWdgI=; b=dRQ+8c
	bQ4l8GsPF+sBK9dEhZx2gh/+76IrU+Ygt0z1uU4FIJlvmZ77amnKCupocD5yzINX
	vknGBM2YIJpeUqak732wtsYvqbZOrwLogugzMJ6/svxPrKD2WSgPkrAQJDB93wAb
	KrOZQsGSbrcr3MwCkV3YRpUfCWzw4InMlrZnU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nT05VUoHx3zYkCEB/dsLEwyxiaUrGLZp
	jlQZkxCQWiDxGjHehd0HshA9SLE/Sf+ARQMzfeHQ+gEG7kShzjTBhs+jT2I0obiG
	CbPuR0V9b0utpXcaCjhLdmqLFGoAuer4VybyuMCtJYPDrTzGLn6WeRi7a6jsRRu0
	jUG3k6TqUHc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2333B92D83;
	Thu, 21 Jan 2010 22:56:26 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1571B92D82; Thu, 21 Jan
 2010 22:56:19 -0500 (EST)
In-Reply-To: <alpine.LFD.2.00.1001212131230.1726@xanadu.home> (Nicolas
 Pitre's message of "Thu\, 21 Jan 2010 21\:35\:08 -0500 \(EST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1CF2F25C-070A-11DF-B0B4-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137733>

Nicolas Pitre <nico@fluxnic.net> writes:

> I do use it, but for developing/debugging pack stuff.  I don't suggest
> removing it, but I don't think making it a built-in has value either.

I thought people _might_ have used it for satistics purposes, but it
appears that the command doesn't even give in-pack size of objects nor
delta chain length, so probably anybody doing pack statistics would be
using "verify-pack -v" and wouldn't mind if it became test-show-index.

> So I really think that Linus' patch (which is missing hex.c btw) is a 
> good thing to do, even if only for the cleanup value.
>
> Then, git-show-index could probably become test-show-index and no longer 
> leave the build directory.

Yeah, I think that is a sensible long term plan, too.
