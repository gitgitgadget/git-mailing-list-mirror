From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Include xmlparse.h instead of expat.h on QNX
Date: Mon, 11 Feb 2013 13:41:48 -0800
Message-ID: <7vehgmle8z.fsf@alter.siamese.dyndns.org>
References: <1360616395-18912-1-git-send-email-kraai@ftbfs.org>
 <20130211210621.GC32740@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matt Kraai <kraai@ftbfs.org>, git@vger.kernel.org,
	Matt Kraai <matt.kraai@amo.abbott.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 11 22:42:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U518h-0007Zl-7I
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 22:42:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932620Ab3BKVlw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2013 16:41:52 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45494 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932219Ab3BKVlv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2013 16:41:51 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D0352C949;
	Mon, 11 Feb 2013 16:41:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wsaZVMrB+mNdwY/5VmrBCo7GX1g=; b=ao7NKQ
	Dghtj+7Y0+5sr63MYnEkMx6ega19+ToFANPWE1toHUhRHd7fBrazvgzEMnfhkrg1
	/bJkoqOU3MyhVZrMV1jRwNLruuKvbDa5Y9pJTrDLx+HBVPhCn1wUyN6hU4wQrFe4
	4I5HHSpai3jaR/F0fOygmuNOyS506/qq0iDQk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BcBBDh3E09ZliMhGlvzJb/2+YgzLrycM
	qRdlnvN3/UucuiQJwKaBJOLCZUW6pNE3vwIcFXcjW2ti3Ude/I8ZX463PtsGp/Fe
	UsKenfEPmEEBkdD9v9OWDIpq39447dcIR/2YhWC8Y9/a2ri1K1T97NZjxpRy8YX+
	Cj4xT+c36rM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C5957C948;
	Mon, 11 Feb 2013 16:41:50 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 49212C944; Mon, 11 Feb 2013
 16:41:50 -0500 (EST)
In-Reply-To: <20130211210621.GC32740@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 11 Feb 2013 16:06:21 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D7BD8B48-7493-11E2-9F1B-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216095>

Jeff King <peff@peff.net> writes:

> On Mon, Feb 11, 2013 at 12:59:55PM -0800, Matt Kraai wrote:
>
>> From: Matt Kraai <matt.kraai@amo.abbott.com>
>> 
>> QNX 6.3.2 through 6.5.0 include Expat 1.1, which provides xmlparse.h
>> instead of expat.h, so include the former on QNX systems.
>
> So it is not just QNX, but rather older versions of expat?
>
>> diff --git a/http-push.c b/http-push.c
>> index 9923441..55c575e 100644
>> --- a/http-push.c
>> +++ b/http-push.c
>> @@ -11,7 +11,11 @@
>>  #include "list-objects.h"
>>  #include "sigchain.h"
>>  
>> +#ifndef __QNX__
>>  #include <expat.h>
>> +#else
>> +#include <xmlparse.h>
>> +#endif
>
> If that is the case, should this #ifdef look for EXPAT_NEEDS_XMLPARSE_H,
> and that macro triggered externally?

Heh, our mails crossed.  Another thing neither of us mentioned is
how compatible the subset of libexpat our codebase uses to what was
offered by the older versions of expat.  I would not be surprised if
nobody has tried running the resulting binary linked with expat 1.
