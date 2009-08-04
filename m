From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix compiler warning by properly initialize failed_errno
Date: Tue, 04 Aug 2009 12:09:33 -0700
Message-ID: <7v3a87o0pe.fsf@alter.siamese.dyndns.org>
References: <1249241675-77329-1-git-send-email-sn_@gmx.net>
 <7vmy6g6rj1.fsf@alter.siamese.dyndns.org> <4A78834C.20002@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Soria Parra <sn_@gmx.net>, git@vger.kernel.org,
	David Soria Parra <dsp@php.net>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Aug 04 21:09:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYPOW-00009G-0h
	for gcvg-git-2@gmane.org; Tue, 04 Aug 2009 21:09:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933026AbZHDTJr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2009 15:09:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933162AbZHDTJr
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Aug 2009 15:09:47 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:48500 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932992AbZHDTJq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2009 15:09:46 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id A8C4E20BD3;
	Tue,  4 Aug 2009 15:09:44 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id CDE1820BD2; Tue, 
 4 Aug 2009 15:09:36 -0400 (EDT)
In-Reply-To: <4A78834C.20002@kdbg.org> (Johannes Sixt's message of "Tue\, 04
 Aug 2009 20\:51\:56 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5ECD0DD6-812A-11DE-A550-F699A5B33865-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124803>

Johannes Sixt <j6t@kdbg.org> writes:

> Junio C Hamano schrieb:
>
>> We would want to be able to distinguish between a workaround for a
>> compiler that is not clever/careful enough, and a necessary
>> initialization.  In this particular case, it is the former, and we should
>> say
>>
>> 	int failed_errno = failed_errno;
>>
>> instead.
>
> Frankly, I prefer the initialization with 0; this is not a performance
> critical place and micro-optimization is not appropriate here.

It is not about optimization at all.  This is about documenting the fact
that we have audited and know that the use of this variable in the code
that follows is Ok.  Initializing to 0 gives a false impression that the
code may rely on that value, but in this case nobody will ever read that
zero before overwriting it with an assignment.

The compiler may optimize this out, but that is an insignificant (I agree
this is not a performance critical codepath) side effect.
