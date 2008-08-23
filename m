From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFH] two and half potential fixlets to the in-core index
 handling
Date: Sat, 23 Aug 2008 12:14:55 -0700
Message-ID: <7v1w0fzgpc.fsf@gitster.siamese.dyndns.org>
References: <20080823060839.GB23800@genesis.frugalware.org>
 <1219479293-29111-1-git-send-email-vmiklos@frugalware.org>
 <48AFD62F.2090500@gnu.org> <7vej4g12dv.fsf@gitster.siamese.dyndns.org>
 <7v7ia8126z.fsf@gitster.siamese.dyndns.org>
 <7vbpzkypwz.fsf_-_@gitster.siamese.dyndns.org>
 <alpine.LFD.1.10.0808231104500.3363@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paolo Bonzini <bonzini@gnu.org>,
	Miklos Vajna <vmiklos@frugalware.org>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Aug 23 21:16:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWyar-0004PQ-2O
	for gcvg-git-2@gmane.org; Sat, 23 Aug 2008 21:16:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753098AbYHWTPI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Aug 2008 15:15:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752813AbYHWTPI
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Aug 2008 15:15:08 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:43284 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751508AbYHWTPH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Aug 2008 15:15:07 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 8424A65BB4;
	Sat, 23 Aug 2008 15:15:04 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id EC4DE65BB2; Sat, 23 Aug 2008 15:14:57 -0400 (EDT)
In-Reply-To: <alpine.LFD.1.10.0808231104500.3363@nehalem.linux-foundation.org> (Linus
 Torvalds's message of "Sat, 23 Aug 2008 11:13:14 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: CA8278C0-7147-11DD-9347-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93473>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Sat, 23 Aug 2008, Junio C Hamano wrote:
>> 
>> A hacky solution I have in the attached patch is to waste an xmalloc(1)
>> and store it there when o->result is created, and also make
>> read_from_index() pay attention to the cache_nr and the cache_changed
>> bit. I think it is the safest and minimum fix.
>
> Hmm. Wouldn't it be nicer to just add another bit to istate? We have the 
> space already, since we already have a bitfield there, with just one bit 
> used?

cache_changed can also become a single-bit field.

The oldest "the_index" users work from it in the BSS initialized all
zero.  We'd also need to mark it as initialized, wouldn't we?
