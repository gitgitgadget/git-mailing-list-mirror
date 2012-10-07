From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git 1.8.0.rc0.18.gf84667d trouble with "git commit -p file"
Date: Sun, 07 Oct 2012 15:23:31 -0700
Message-ID: <7vehl9q5uk.fsf@alter.siamese.dyndns.org>
References: <op.wlp1lws70aolir@keputer>
 <7vsj9ssgcp.fsf@alter.siamese.dyndns.org>
 <20121005225758.GA1202@sigill.intra.peff.net>
 <7v8vbkru8o.fsf@alter.siamese.dyndns.org>
 <20121006131200.GB11712@sigill.intra.peff.net>
 <7vvcenqx39.fsf@alter.siamese.dyndns.org>
 <20121006183026.GA3644@sigill.intra.peff.net>
 <CAOTq_pu=xWF7q3QobxSerkkbV56n5o+CPQSyHg8onwv73v25+A@mail.gmail.com>
 <20121006190753.GA5648@sigill.intra.peff.net>
 <7vr4paovjq.fsf@alter.siamese.dyndns.org>
 <20121007214958.GC1743@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Conrad Irwin <conrad.irwin@gmail.com>,
	Frans Klaver <fransklaver@gmail.com>, git@vger.kernel.org,
	"Horst H. von Brand" <vonbrand@inf.utfsm.cl>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Oct 08 00:23:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TKzGD-0003ua-7z
	for gcvg-git-2@plane.gmane.org; Mon, 08 Oct 2012 00:23:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751075Ab2JGWXf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Oct 2012 18:23:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48521 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750989Ab2JGWXe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2012 18:23:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8B0D488AB;
	Sun,  7 Oct 2012 18:23:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=F4+tk2L0JnmHKVcV+0HEntd75vU=; b=jj0fCn
	R/XXiIHdquActjXpQQ4Nbq+LSEdgVqdvCEfYPx7gVXnJH6GV7WLFvB+UA2tSzPea
	L3PDtJ4vc9n3IXQF5g0XjvMC6Lpg6S5zrWcn6cFoAONK0nyOx5jLdJCktNkQDnl2
	JrrsU9twa3R3YAG+Pbs+WSr/TU4cyHx0F/cPA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aY1eKgVNRVq2G8Ohk9Pcj1KMFxqX+mgJ
	M5D6kE7+l3OvTrN6B+lYzwe1asAxobynTWxkZvo/WiES+GwFc+YjTgrsC2Js9Dme
	X4ULrkBN5J2yOsbRFS9qkVRxxq1tthCCxb7A5aypcOSG+mrjj1ttQE1Q3x3lK2ZZ
	nKvlQjyZ9A0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7809F88AA;
	Sun,  7 Oct 2012 18:23:33 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EA93488A9; Sun,  7 Oct 2012
 18:23:32 -0400 (EDT)
In-Reply-To: <20121007214958.GC1743@sigill.intra.peff.net> (Jeff King's
 message of "Sun, 7 Oct 2012 17:49:58 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A10123F0-10CD-11E2-A03C-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207204>

Jeff King <peff@peff.net> writes:

> On Sun, Oct 07, 2012 at 01:51:21PM -0700, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> > Which is obviously one of:
>> >
>> >   1. Keep defaulting to "--include", as that is what we have been doing.
>> >
>> >   2. Forbid the cases where it would matter (i.e., when the index and
>> >      HEAD differ).
>> >
>> > The former is more convenient, but the latter is safer against
>> > future breakage. I'm OK either way, but option (1) clearly needs a
>> > documentation update.
>> 
>> Yeah, I agree with the reasoning.  This is an unessential feature
>> that is with the problem for a long time, so let's go the route #1
>> first before we do anything else.
>
> OK. I think Conrad's patch takes us most of the way there. I had a few
> minor comments, but I think another round should do it. Conrad?

I'd rather want to see a patch that _only_ documents the current
behaviour to unconfuse people first.  I definitely do not want any
patch that changes the command line parsing or any other behaviour
change with problems that have to take time from reviewers to point
them out mixed in it.
