From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fix some clang warnings
Date: Wed, 16 Jan 2013 08:53:29 -0800
Message-ID: <7vk3rdxe5y.fsf@alter.siamese.dyndns.org>
References: <1358348003-11130-1-git-send-email-max@quendi.de>
 <20130116160410.GC22400@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Max Horn <max@quendi.de>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 16 17:54:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvWFQ-0006Eh-9x
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 17:53:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758017Ab3APQxf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2013 11:53:35 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62756 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758002Ab3APQxb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2013 11:53:31 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 57F6FAC5A;
	Wed, 16 Jan 2013 11:53:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fj1G48O/ekQ7/8fBIFtvcf3T4xU=; b=iT1Feu
	A29UDCHEzXGVGfatwFoETEO3HVRTGVs++2fEUwNVJrI19T0+eeuIuswK5FtijyG4
	m7wJioXNVOKC+mBuMzp3uVfgfajrkOdVXGmyktzKRNrbWeRTynPANtylpTgN0nMd
	rLz6cqVBaYIHiTJTNFDmkfZZgo9SwAg7Gi4rc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DIaArSle0Ti7LdTOBFDOLlSbkeDDzdrX
	ezxmeOr6NS0BctDyxAYrLEX5QOOBhJmPdhe/DRp+qpMdUlr3xp2dhAprvOrqCeFW
	2lWxhrXkNefCdOgU9bZDTLV4qQqBMRk2X+xuQcVvhnk/0g8KKSeOk/fi5RPVCdH6
	NdMCyPbtUFg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4D205AC59;
	Wed, 16 Jan 2013 11:53:31 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BF87CAC58; Wed, 16 Jan 2013
 11:53:30 -0500 (EST)
In-Reply-To: <20130116160410.GC22400@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 16 Jan 2013 08:04:10 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 41AF92B8-5FFD-11E2-98F7-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213769>

Jeff King <peff@peff.net> writes:

> On Wed, Jan 16, 2013 at 03:53:23PM +0100, Max Horn wrote:
>
>> -#ifdef __GNUC__
>> +#if defined(__GNUC__) && ! defined(__clang__)
>>  #define config_error_nonbool(s) (config_error_nonbool(s), -1)
>>  #endif
>
> You don't say what the warning is, but I'm guessing it's complaining
> about throwing away the return value from config_error_nonbool?

Yeah, I was wondering about the same thing.  The other one looks
similar, ignoring the return value of error().

Also, is this "some versions of clang do not like this"?  Or are all
versions of clang affected?
 
