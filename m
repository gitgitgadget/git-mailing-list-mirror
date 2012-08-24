From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Support non-WIN32 system lacking poll() while keeping
 the WIN32 part intact
Date: Fri, 24 Aug 2012 09:07:10 -0700
Message-ID: <7vsjbc1dg1.fsf@alter.siamese.dyndns.org>
References: <004001cd81f9$21e68e10$65b3aa30$@schmitz-digital.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, "Erik Faye-Lund" <kusmabite@gmail.com>
To: "Joachim Schmitz" <jojo@schmitz-digital.de>
X-From: git-owner@vger.kernel.org Fri Aug 24 18:08:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4wQm-0002YW-JR
	for gcvg-git-2@plane.gmane.org; Fri, 24 Aug 2012 18:08:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759730Ab2HXQHl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Aug 2012 12:07:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63841 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759721Ab2HXQHM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Aug 2012 12:07:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6965E8A27;
	Fri, 24 Aug 2012 12:07:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Hx9Vg53OYhUXbNaOuEbCdKc9Bos=; b=UkE+iJ
	O1bRp/0KjvmlG+ai5Knp0DxB528gYJ7/v/oPXoqB4CyCzBNuIOo0hzewBcxXV4aw
	5eWmDKtDZZgOmXTyN7XXNh9YJc5VQIFnEjo4aBuOAo2epxqvVsq24hzDVGNNiL3x
	T0srLRPKiwqTFoSw1YYV0AL3IX/GdRwPRAs30=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZodFHZRRg6Cs1MmtF5/7HubMcOvHYYVz
	N9ajYmhI/pqz+1XNKzOGcZw4z09rudze3WhwlMkboSYFLqyxmFUd/k/sABfbH9wv
	kLqeZXoXwGJShaiLwSxjCOnYrL/VxNtlv/9bmig74tjJB7ZeHdJTIjgGl9TP+4OJ
	wqmfTQfNeTw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 569DC8A26;
	Fri, 24 Aug 2012 12:07:12 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B351E8A25; Fri, 24 Aug 2012
 12:07:11 -0400 (EDT)
In-Reply-To: <004001cd81f9$21e68e10$65b3aa30$@schmitz-digital.de> (Joachim
 Schmitz's message of "Fri, 24 Aug 2012 15:05:26 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C358586E-EE05-11E1-876D-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204218>

"Joachim Schmitz" <jojo@schmitz-digital.de> writes:

> There is a downside with this: In order to make use of it, in Makefile it 
> adds "-Icompat/win32" to COMPAR_CFLAGS. This results in 
> compat/win32/dirent.h to be found, rather than /usr/include/dirent.h. 
> This should be fine for WIN32, but for everybody else may not. 
> For HP NonStop in particular it results in a warning:
>
>         };
>          ^
> "... /compat/win32/dirent.h", line 17: warning(133): expected an identifier
>
> And this is because there it uses an unnamed union, which is a GCC extension 
> (just like unnamed struct), but not part of C89/C99/POSIX.
>
> One possible solution might be to move compat/win32/poll.[ch] to compat/.

I think that is the most sensible way to go, because poll.[ch]

 (1) has proven itself to be useful outside the context of win32, and
 (2) the code is coming from gnulib anyway.

I thought I already suggested going that route in my previous
review, but perhaps I forgot to do so.
