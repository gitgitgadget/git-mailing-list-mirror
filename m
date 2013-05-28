From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git clone does not understand insteadOf URLs
Date: Tue, 28 May 2013 13:06:54 -0700
Message-ID: <7v8v2yzx5t.fsf@alter.siamese.dyndns.org>
References: <51A11DD0.4040802@svario.it>
	<CA+EOSB=ow9Vc2J8qb3GAp4xj2GgY8qes=5Q-k-rH6VsVLjzCsg@mail.gmail.com>
	<51A24C75.3090100@svario.it> <87a9nhhb9c.fsf@hase.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Gioele Barabucci <gioele@svario.it>,
	Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Tue May 28 22:07:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhQAf-0008FE-IV
	for gcvg-git-2@plane.gmane.org; Tue, 28 May 2013 22:07:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755336Ab3E1UG5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 May 2013 16:06:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49698 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755033Ab3E1UG5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 May 2013 16:06:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 61D1B22666;
	Tue, 28 May 2013 20:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=HsQtbSFKry6wqc6myuR4rPMsZfA=; b=A8fZ45n8s35zgXtRDXsL
	c7vuBvQNZ9XajxBq0D/Iqb7fUlZKHqMwuPB2SKpHUpOLLwkPiZ3S7JnK2Nd7nfxb
	p+JjgIsV0ZtOwkKf5wU9jURjv4PZBewOSa2ajjmfvaFrmj0kIbq/pC5hz4dW/dyS
	2ZxTM9n2kHXEeauzaw//er8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=wPJ1eIRAxHdasuKXE3BsCzZzj6bqj8faum4uuJCi4Rh/QB
	CskvxpVZI4+YIy3cGlrKlGXCZAmxxA5IfSMrITyFISePDV301zpjveUQ5fJ7oom8
	+8b0u0bNKdM2+keDVUh/9oAUmibWePYYCNJomHz3pg6yW1FOWTBLS08qWslvo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5393322665;
	Tue, 28 May 2013 20:06:56 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A59B322662;
	Tue, 28 May 2013 20:06:55 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2545639A-C7D2-11E2-BA9B-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225685>

Andreas Schwab <schwab@linux-m68k.org> writes:

> Gioele Barabucci <gioele@svario.it> writes:
>
>> Simple, I keep all my projects on the same server, so I would like to
>> refer to that server + path using 'remote-repo'.
>>
>> "git+ssh://git.example.org//users/gioele/projects" insteadOf "remote-repo"
>
> You can use "remote-repo:" instead.

That "with colon" is pretty much how it was designed to be used, but
the code did not insist that the insteadof has at least the scheme
part, and by mistake allowed something like this

	[url "k.org:/pub/scm/git"] insteadOf = g

to be used with "g/foo" to expand to "k.org:/pub/scm/git/foo".

But if "git fetch g/foo" with such a configuration happily goes to
"k.org:/pub/scm/git/foo" without problems, then I think it is very
reasonable to delay the "is that a local filename?" short-cut "git
clone" does and let the insteadof URL expand take place before it.
