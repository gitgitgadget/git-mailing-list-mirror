From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Surprising interaction of "binary" and "eol" gitattributes
Date: Tue, 10 Mar 2015 15:54:53 -0700
Message-ID: <xmqqsidcxy2q.fsf@gitster.dls.corp.google.com>
References: <54F88684.3020905@alum.mit.edu>
	<xmqqwq2v14iv.fsf@gitster.dls.corp.google.com>
	<54F9422D.2020800@web.de> <54F9E907.4040703@alum.mit.edu>
	<54FA1C7B.3040906@web.de> <54FF450F.7040506@alum.mit.edu>
	<xmqq385c1v13.fsf@gitster.dls.corp.google.com>
	<54FF6D23.4060301@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	git discussion list <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Mar 10 23:55:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVT3E-0007nD-Ve
	for gcvg-git-2@plane.gmane.org; Tue, 10 Mar 2015 23:55:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750890AbbCJWy5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2015 18:54:57 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:62152 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750780AbbCJWy4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2015 18:54:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 706A03E812;
	Tue, 10 Mar 2015 18:54:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uHeMwlBi7P3WHrzSfn/J+nL6o5k=; b=O2g22G
	F0HQGb8gTU5vh5EfF7dyHsk7g30+Zc3aCOiT3THcfMF+BzaUqEkKlhH+GzA+4A1p
	pvvXlr3KYp7aC3oW99/QLw5MlrZAE9FSpSYcYGA+cFIAtKLYFMZpLVohbDmEQXTF
	Ehaa5Rb7Ah85dzVxMXMuWH0ndkznH+fc+IQ4w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DSbrL/HMRYQtdYbDyw5AITnqzKrPHbWA
	y5R3mVBu8K1TmeuMQA2oWM3e1KKgEkki96UXDxI7VSC2U4SeFfKcqLg+7YzcGw84
	6TiHARLtHg6bGZ3d/n8T0EazCjNJXXazdGOPNb81qZ+RN0DmmF7WqEk1Wi8WrQY/
	848QT8+c53E=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 68DC73E80C;
	Tue, 10 Mar 2015 18:54:55 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E2B2C3E80B;
	Tue, 10 Mar 2015 18:54:54 -0400 (EDT)
In-Reply-To: <54FF6D23.4060301@alum.mit.edu> (Michael Haggerty's message of
	"Tue, 10 Mar 2015 23:16:03 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 77E46892-C778-11E4-9BDE-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265276>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Well, that's true, but the "eol" attribute can regain its effect if
> "binary" is followed by "text" or "text=auto". So I guess the simplest
> question is as follows. Suppose I have the following .gitattributes:
>
>     a.foo eol=crlf
>     a.foo binary
>     a.foo text
>
> It is obvious in this case that a.foo should be treated as a text file.
> Should it be processed with "eol=crlf", or should the intervening
> "binary" imply "-eol"?

I would say former.  You find out what attributes apply to a path
and then consider the collective effect of these attributes that
survived.

So the second "No it is not text" which is overruled by the "oops,
no that is text" later should not get in the picture, I would say.

As binary is not just -text and turns other things off, those other
things will be off after these three.
