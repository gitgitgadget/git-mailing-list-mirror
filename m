From: Junio C Hamano <gitster@pobox.com>
Subject: Re: OK, how should I have done this...
Date: Mon, 22 Nov 2010 16:05:06 -0800
Message-ID: <7vr5ecvr9p.fsf@alter.siamese.dyndns.org>
References: <AANLkTim0_J0i_a0o+z1oCC4mramfUxCGtCg_Y+ab+h+-@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Patrick Doyle <wpdster@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 23 01:05:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKgNw-0006qw-54
	for gcvg-git-2@lo.gmane.org; Tue, 23 Nov 2010 01:05:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932344Ab0KWAFQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Nov 2010 19:05:16 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:34678 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932177Ab0KWAFP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Nov 2010 19:05:15 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id F1AF530DF;
	Mon, 22 Nov 2010 19:05:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VJUlDaqTZMGQb05Wq76/ApQHt1U=; b=X/GGBV
	yE6Mzv4QRseg5jMKc/WAPM1o0ts+txPc7GuJ45BjnYEr0gADmQD6d3vNDQ7lIuWr
	1K7gDHmceG0wiHvVksB0cy8pQ+bsUNWkgcylWcllC4Wh36beybNgGSrevwjZWTNN
	9wK65K5N+4iUHvA3/T5jh52xMein082vULmB4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jZjtZhYF861XVm+jkloeJD0DopB3FGmq
	rFI9EvpOz+JkZdRrkFfx/Txi5CIsl4cwEsozvWrYFU1JjQD4Z2NuuGx32HIcw1uy
	ah4pTm0P3LXYY5vfQs95ILeLG5RY6t2y3IDNMojSHSZylwBi2HqG6rel5JPU1izi
	C8cuUuCv8yQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CF2CB30DB;
	Mon, 22 Nov 2010 19:05:25 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E276730D4; Mon, 22 Nov 2010
 19:05:22 -0500 (EST)
In-Reply-To: <AANLkTim0_J0i_a0o+z1oCC4mramfUxCGtCg_Y+ab+h+-@mail.gmail.com>
 (Patrick Doyle's message of "Mon\, 22 Nov 2010 08\:22\:09 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5F8D5604-F695-11DF-AB28-DF8536391E49-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161919>

Patrick Doyle <wpdster@gmail.com> writes:

> But I _know_ that there must be a better way to do this.  What should
> I have done?

Depends on how you wanted to fix your history (we already know from your
description what shape of tree you want to end up in).

If you want to pretend that you were perfect and never made mistakes in
these three files you had to fix later, then history surgery like what
Matthieu suggested would be necessary (I won't repeat how).

On the other hand, if you want to record what you did in the time order,
then I would probably do this:

 $ git checkout master ; test ;# broken
 $ git checkout 5ccce3 ; test ;# ok
 $ git checkout master -- file1 ; test ;# ok
 $ git checkout master -- file2 ; test ;# ok
 $ git checkout master -- blah/file7 ; test ;# broken
 $ edit blah/file7 ; test ;# ok
 $ git reset --soft master
 $ git commit -a -m 'The change to file3 was borked on the other env' -e

and in this particular case, this would be what I would have done, as a
separate "fix-up" commit will give me a place to describe why a solution
different from the initial attempt, which was Ok on the original machine,
was necessary.

 
