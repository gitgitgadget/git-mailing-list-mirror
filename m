From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] attribute "eol" with "crlf"
Date: Fri, 16 Dec 2011 13:21:25 -0800
Message-ID: <7vmxasgqlm.fsf@alter.siamese.dyndns.org>
References: <CAN0XMO+OOdTJ+aNMSc2G3RVc7Wfypr4+7dU3US9GVAmMiSJ7cg@mail.gmail.com>
 <vpqr504wf70.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ralf Thielow <ralf.thielow@googlemail.com>,
	git <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Dec 16 22:21:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbfDi-00021G-1k
	for gcvg-git-2@lo.gmane.org; Fri, 16 Dec 2011 22:21:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760738Ab1LPVVa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Dec 2011 16:21:30 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42944 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755967Ab1LPVV2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Dec 2011 16:21:28 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 236C36681;
	Fri, 16 Dec 2011 16:21:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4Vu9/d2iJ7zj8jcOcrq+pDUbFG8=; b=XPyoL9
	SG8JaLKL4U97wfQqFguXZ6t0z47q+s1aN+pA8i8658DM41QYx8Ihk+gnhuFcGMdZ
	RLYpg7NlTUknxrxLNU1C9nE8T+S08Y9r5yrCdIeegPX4UWluiyTbYKGS2bailm/9
	D6cXeFYTHEwnXf8WJpwCnNkCGA7Zwy6+apZk4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QyHOEZtHRz1BbOEG0NUOQkXRL300Ch5P
	5nScoMoYwofKL9G7gESeWG0Dqml7jwhznfGBE0MGA5FP4YQpbqAFZdTZmhDsyACE
	IktrPs7e4A+zXt7/Ug/BP/YtC0DIEZbJZLjctgsyk/VZsiKMajJFCBwvaEzPi7gk
	HmteAjyt/A8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1B6956680;
	Fri, 16 Dec 2011 16:21:28 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E5978667E; Fri, 16 Dec 2011
 16:21:26 -0500 (EST)
In-Reply-To: <vpqr504wf70.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Fri, 16 Dec 2011 19:21:07 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E9D3DF36-282B-11E1-B387-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187320>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Ralf Thielow <ralf.thielow@googlemail.com> writes:
>
>> There's a bug in git-1.7.8 if you use the attribute "eol" with "crlf".
>>
>> Steps to reproduce:
>> - add and commit a text file which uses 0d0a for line breaks
>> 7465 7374 0d0a 0d0a 7465 7374 0d0a       test....test..
>> - add ".gitattributes" with "*.txt eol=crlf"
>> - change a line in the file
>> - execute "git checkout [file]"
>>
>> The result is:
>> 7465 7374 0d0d 0a0d 0d0a 7465 7374 0d0d  test......test..
>
> It seems to me to be the expected behavior. You committed a file whose
> line endings are not normalized to LF in the repository, and asked for a
> conversion LF -> CRLF on checkout, which Git did.
>
> Git can't know exactly the moment when you edit .gitattributes, so it
> can't do the conversion at the time you add the eol=crlf attribute. It
> does it on checkout.
>
>> 0d0a was replaced by 0d0d0a.
>
> I'd say 0a (LF) was replaced by 0d0a (CRLF).
>
> What behavior would you have expected?

The sequence adds "test\r\n" file without .gitattributes to have the
repository record that exact byte sequence for the file. But then later
goes around and says "This file wants to express the end of line with CRLF
on the filesystem, so please replace LF in the repository representation
to CRLF when checking out, and replace CRLF in the working tree to LF when
checking in".

So it is not surprising that "\r\n" coming from the repository is replaced
to "\r\r\n" when checked out. As far as the repository data is concerned,
that line has a funny byte with value "\r" at the end, immediately before
the line terminator "\n".

What you said is _technically_ correct in that sense.

However, I think the CRLF filter used to have a hack to strip "\r" if the
repository data records "\r" at the end of line. This was intended to help
people who checked in such a broken text file (if it is a text file, then
raw ascii CR does not have a place in it in the repository representation)
and it was a useful hack to help people recover from such mistakes to
start the project from DOS-only world (with CRLF in the repository data)
and migrate to cross platform world (with LF in the repository data, CRLF
in the DOS working tree).  I suspect that the streaming filter conversion
may not have the same hack in it.
