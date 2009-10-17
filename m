From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] Add proof-of-concept
 %[w(width,in1,in2)<<any-string>>%] implementation
Date: Fri, 16 Oct 2009 17:18:43 -0700
Message-ID: <7vy6naq3do.fsf@alter.siamese.dyndns.org>
References: <1255681702-5215-1-git-send-email-gitster@pobox.com>
 <200910170020.01756.jnareb@gmail.com>
 <7v7huurkif.fsf@alter.siamese.dyndns.org>
 <200910170200.03681.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 17 02:19:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Myx0d-0008Lf-Lx
	for gcvg-git-2@lo.gmane.org; Sat, 17 Oct 2009 02:19:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750923AbZJQASt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2009 20:18:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750838AbZJQASt
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Oct 2009 20:18:49 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:54930 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750789AbZJQASs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2009 20:18:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A12207AE99;
	Fri, 16 Oct 2009 20:18:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NE+XaJnTuCVvtWJut7DLzJg5t7E=; b=Ng9f0C
	b9jZWvE7yXZCPcCE3hoGeglfo0K85umSQ6kX6YtvGcw9fwad9Uk14ITytHWRJed8
	FgZbyPhLPjK3MxeeUje9z85o9mtrtTFfrB1rXyed6vAd8ftEMGiVaPBdu90eBRt/
	hVovSX9tvA6mko+w+FI3zX5qS6M9GS2124UK0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=u4mFLFrNmm2f06CGty/FUtMI1EuIZt49
	RGHlxCxyW1mFDrbvmJkE+CtRPnuZKxKI/Wo4YNAJAz09InW/fB7soSwRZZu3suWR
	4OHlPuLLcml631DsUruHqOrBPxZB1lA2H2zsBFkqM7iuESjeHFzRljJB9vtPC+0y
	Pn/Rev7wwWI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 77FDA7AE98;
	Fri, 16 Oct 2009 20:18:49 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 49D5E7AE97; Fri, 16 Oct 2009
 20:18:45 -0400 (EDT)
In-Reply-To: <200910170200.03681.jnareb@gmail.com> (Jakub Narebski's message
 of "Sat\, 17 Oct 2009 02\:00\:02 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A4801334-BAB2-11DE-9F07-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130539>

Jakub Narebski <jnareb@gmail.com> writes:

> Why not
>
>     %[w(-1,4,4)%s%+b]

Yeah.  As you said "subject unwrapped and body indented" or something like
that, I excluded that part outside the indentation, but log output indents
everything, so placing both inside %[w] would be correct.

> (i.e. %+ is this empty line between subject and body, if it exists).

As %+ is to add LF iff the next expansion is non-empty, it must always be
followed by an expansion, i.e. %something.  That means "%+%something" is
unnecessary verbose and "%+something" is enough.  "%+anything" syntax,
just like "%[func()anything]" syntax, is not limited to any particular
expansion.

> The %+x seems a bit strange... but I guess implementing conditional
> expansion a la shell or rpn spec/queryformat would be out of question
> (i.e. %?s:+ )...

Why not?

I can see us doing something like %[conditional%|iftrue%|iffalse%] quite
easily, now we have the "nested" variant of the strbuf_expand()
infrastructure.

But that is not the primary focus of the two patch series I've
demonstrated so far.
