From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] Git.pm: Allow pipes to be closed prior to calling
 command_close_bidi_pipe
Date: Wed, 06 Feb 2013 16:14:15 -0800
Message-ID: <7vip659e08.fsf@alter.siamese.dyndns.org>
References: <cover.1360183427.git.mina86@mina86.com>
 <c0966644278b0addbef6a03289ef9c553addf573.1360183427.git.mina86@mina86.com>
 <20130206230406.GK27507@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michal Nazarewicz <mpn@google.com>,
	Ted Zlatanov <tzz@lifelogs.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 07 01:14:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3F8c-0008GB-7t
	for gcvg-git-2@plane.gmane.org; Thu, 07 Feb 2013 01:14:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758577Ab3BGAO1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2013 19:14:27 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38954 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757945Ab3BGAO0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2013 19:14:26 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 13FD2B94F;
	Wed,  6 Feb 2013 19:14:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GCTslqpPrifGvEJC2jkkRrqK4MY=; b=q6R9Xy
	yo94nc10Iz/IVSdrLN9SI0X8OLs6qsZm04+QKvbECv9x1xN0SpAOaNRZ4KiOWg6R
	5rgoHOy1k3Yss5F/kU0t/WagRlDC+PhpvsfEpKt6i81GctyUBddG6phKf6lJfx4d
	oWhQTmjwsMSkJVTExGMzlcaoSV/qqRW9+NyKk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YBif61ayoWWoVtvnFOiM3ufeF2jAiToV
	1i0xoaE119dOlyhNGav0JZRIGHjLaOs71SlFYWtOqKuB9ZR41U3oANEaaKk7bOTY
	JgctiKd/n1xNg/uw7r48VKve0py/t1UK6pJv9befINOcFBfl/g1Z37ShqMA3hsHY
	rR7nTK0a6Ag=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F0EDFB94E;
	Wed,  6 Feb 2013 19:14:25 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CC5EBB939; Wed,  6 Feb 2013
 19:14:24 -0500 (EST)
In-Reply-To: <20130206230406.GK27507@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 6 Feb 2013 18:04:06 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 548F019C-70BB-11E2-B7D6-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215668>

Jeff King <peff@peff.net> writes:

> On Wed, Feb 06, 2013 at 09:47:04PM +0100, Michal Nazarewicz wrote:
>
>> From: Michal Nazarewicz <mina86@mina86.com>
>> 
>> The command_close_bidi_pipe() function will insist on closing both
>> input and output pipes returned by command_bidi_pipe().  With this
>> change it is possible to close one of the pipes in advance and
>> pass undef as an argument.
>> 
>> This allows for something like:
>> 
>>   my ($pid, $in, $out, $ctx) = command_bidi_pipe(...);
>>   print $out "write data";
>>   close $out;
>>   # ... do stuff with $in
>>   command_close_bidi_pipe($pid, $in, undef, $ctx);
>
> Should this part go into the documentation for command_close_bidi_pipe
> in Git.pm?

Yeah, it probably should.
