From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] MSVC: Fix an "unresolved symbol" linker error on
 cygwin
Date: Thu, 05 Nov 2009 11:37:10 -0800
Message-ID: <7vhbt8ahll.fsf@alter.siamese.dyndns.org>
References: <4AE74408.7080103@ramsay1.demon.co.uk>
 <4AEFD9E2.6060004@viscovery.net> <7veiogt4g8.fsf@alter.siamese.dyndns.org>
 <4AF1E1FD.1050102@ramsay1.demon.co.uk> <4AF284EF.2030606@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>,
	Marius Storm-Olsen <mstormo@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Nov 05 20:37:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N689C-0002uW-OD
	for gcvg-git-2@lo.gmane.org; Thu, 05 Nov 2009 20:37:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758777AbZKEThT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Nov 2009 14:37:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758750AbZKEThT
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Nov 2009 14:37:19 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:53938 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758570AbZKEThS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Nov 2009 14:37:18 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 796757572C;
	Thu,  5 Nov 2009 14:37:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9OPmm9IXbs027KKPA08+BOH27pE=; b=B/ZEaL
	57ZuL1syWhgpIDmqXHHQY2nU3Pl6aWHyjNemfdV4ylDVJavhLLG6rMH9stBgIS+H
	HIbMtJSEbn6PdhI+qeUXIpg5t3Uiv8RsFSU5p+rLS8txSbjJRrmL7rXouoMUW32j
	0yh7mw79HzJVH7PWHS/6hKSePqxhPa9GekjW4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ao7A0azgtQGbUC493v7YIRy0TbGMTdei
	9eScEj7SvcgLxKFvp5pqPWB1ofcBiv7ZBnVD9lDOGcCy/XK+QaYKJowVN1ufDGP0
	nnBoocMXNgrKwmN5y06v+Wz93fdkqz9dbkSQjHS34hMmSiVDlQ57Bd4afZCptlkZ
	v6NnHEfT6J4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3368175729;
	Thu,  5 Nov 2009 14:37:18 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F20D075723; Thu,  5 Nov
 2009 14:37:11 -0500 (EST)
In-Reply-To: <4AF284EF.2030606@viscovery.net> (Johannes Sixt's message of
 "Thu\, 05 Nov 2009 08\:55\:27 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A0C6B17C-CA42-11DE-87AA-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132238>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Ramsay Jones schrieb:
>> Junio C Hamano wrote:
>>> Shouldn't this be solved by teaching the Makefile about this new "Cygwin
>>> but using MSVC as compiler toolchain" combination?
>> 
>> Yes. Err... see patch #3 :-P
>
> A clarifiction: Junio talks about using the MSVC tools to build Cygwin
> programs, that is, to merely substitute Cygwin's gcc by MSVC, but to still
> link against cygwin's C runtime.

Actually I do not talk about that; at least I meant to.

> When the "MSVC build" of git is made, then the MSVC compiler is used, and
> this will always use Microsoft libraries in the resulting executables,
> regardless of whether "make MSVC=1" was called from a "cygwin environment"
> or from and "msys environment".

> This series is about fixing "make MSVC=1" when it is run from a "cygwin
> environment" by disentangling the MSVC and Cygwin configuration sections
> in the Makefile.

Yup.

I think we all three are in agreement that "When on Cygwin we do this"
part of the Makefile should be adjusted.  Even though I lost track of the
exact text in "patch #3", I can tell from Ramsay's response that the
series is about that.
