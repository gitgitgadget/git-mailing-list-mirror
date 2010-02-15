From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] Refactoring: remove duplicated code from transport.c
 and builtin-send-pack.c
Date: Sun, 14 Feb 2010 22:34:20 -0800
Message-ID: <7v7hqfknwz.fsf@alter.siamese.dyndns.org>
References: <1266182863-5048-1-git-send-email-michael.lukashov@gmail.com>
 <20100215052853.GJ3336@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Lukashov <michael.lukashov@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 15 07:34:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NguXW-0001Jy-7f
	for gcvg-git-2@lo.gmane.org; Mon, 15 Feb 2010 07:34:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753231Ab0BOGec (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2010 01:34:32 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:50284 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752332Ab0BOGec (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2010 01:34:32 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E65019ABFA;
	Mon, 15 Feb 2010 01:34:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type; s=sasl; bh=Omm9u3D/k+JUiX03Qmps++khick=; b=dyohNr
	9I5V3z0ux2Z+omeI+CZJHT1YGAUVOurEoU42U5IKz8rKyqSqbyjv6YKJ78Zjubp3
	fPcbtDLVC4lpCMIWpwsHPXPvGrgUvjvlS3KAkjDUE45yD85/GHl641p+vAE2JN4A
	v+N2iQzFYvxKSluKDbZ4uRV+SFEB714Uwkmmg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=p77aHBG6zGHd6gkMuSL7VTUWeeq4PEcz
	hd62HOsgt3/w8ax54xO7fOjdKtX3tOOJUmH1cDITk+elEY3y/0dJucADKPx6ecp1
	+ZcOaT/uNqy4qpW5oQYPpCFGg70ZnE6oIXn4uLQeolKoDCqlJ3U17xyj1yDzPMBB
	9JZAXOEG2JI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A51879ABF4;
	Mon, 15 Feb 2010 01:34:26 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C1BF39ABF3; Mon, 15 Feb
 2010 01:34:21 -0500 (EST)
In-Reply-To: <20100215052853.GJ3336@coredump.intra.peff.net> (Jeff King's
 message of "Mon\, 15 Feb 2010 00\:28\:53 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 29B29362-19FC-11DF-B713-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139987>

Jeff King <peff@peff.net> writes:

> On Sun, Feb 14, 2010 at 09:27:40PM +0000, Michael Lukashov wrote:
>
>> The following functions are duplicated:
>> 
>>   verify_remote_names
>>   update_tracking_ref
>>   print_ref_status
>>   status_abbrev
>>   print_ok_ref_status
>>   print_one_push_status
>>   refs_pushed
>>   print_push_status
>> 
>> Signed-off-by: Michael Lukashov <michael.lukashov@gmail.com>
>> ---
>>  builtin-send-pack.c |   89 ++++++++++++++----------
>>  send-pack.h         |   20 +++++
>>  transport.c         |  196 ---------------------------------------------------
>
> I think this is backwards. The versions in send-pack were there first,
> and then were ported to transport.c so that other transports could
> benefit from them. And that is where they should ultimately be.
>
> I can't remember the exact details of why the originals were not
> removed, though (I think I complained about it once before, and there
> was some technical reason, but I don't recall now). Daniel (cc'd) might
> remember more.

Also the names of these functions probably need to be made more specific
so that people not so familiar with the transport code can tell that they
are from "transport" family.  The names didn't matter much while they were
file scope static, but this series changes that.
