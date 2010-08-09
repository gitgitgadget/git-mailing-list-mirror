From: Junio C Hamano <gitster@pobox.com>
Subject: Re: understanding how remote tracking works
Date: Mon, 09 Aug 2010 12:31:32 -0700
Message-ID: <7vaaov60rv.fsf@alter.siamese.dyndns.org>
References: <AANLkTi=J3tDnZUg3k5bzDk2ydzYVVLKLwoW0gpBypYAs@mail.gmail.com>
 <i3nlq0$8un$1@dough.gmane.org>
 <AANLkTinktpx-rXj1K0BSy0Qwo62SEGFAJWvhKo0nJq=i@mail.gmail.com>
 <AANLkTi=usaZGfOM67acmdAWwvbHe_eHyjmRLGmdTYNaC@mail.gmail.com>
 <20100809021900.GA10596@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Witten <mfwitten@gmail.com>, geoffrey.russell@gmail.com,
	Ralf Ebert <info@ralfebert.de>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 09 21:32:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OiY4k-0006qo-Oa
	for gcvg-git-2@lo.gmane.org; Mon, 09 Aug 2010 21:31:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754934Ab0HITbx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Aug 2010 15:31:53 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:36530 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754829Ab0HITbw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Aug 2010 15:31:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0FD2CCC868;
	Mon,  9 Aug 2010 15:31:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=9TPg+B76jsRp
	YqqQch03t0Y0OTc=; b=mneYdQRgC/cU/CJDvxWGG6+udAzGkpC/r2QWxBBwz6uJ
	kEuidVyJQbIftIPwaj60z4rcpa7rEwIE+XfSqWqZGToI6LY7t5yWEGzQBks3yls2
	vogOSJ46VAMAmZWNoUAdPZrIG7l0X0YkG5YidVrHpxqX8PfJVaRTSABIrsHo2IQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=dfb2M5
	8sxR7dQC9Eu/sM8cZzG/BDEjp7OXATMX08FVwSNk027o7gyEB0vxeUs8AzsrnyKO
	bP7y5ZL5QMdHpJx8FU7N9wQG8P2D92S65MH/s7nYIcxZqWQ8NF2CjaDFXMdzTCjz
	Oh4O4jY8yHW0SnaodYl/tsNsv6tiogvni/ZhY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A89D5CC863;
	Mon,  9 Aug 2010 15:31:46 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.126]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 71E89CC853; Mon,  9 Aug
 2010 15:31:38 -0400 (EDT)
In-Reply-To: <20100809021900.GA10596@burratino> (Jonathan Nieder's message of
 "Sun\, 8 Aug 2010 21\:19\:00 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: BF9B2608-A3EC-11DF-BE22-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153004>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Michael Witten wrote:
>> On Sun, Aug 8, 2010 at 20:53, Geoff Russell <geoffrey.russell@gmail.=
com> wrote:
>
>>> I'm working my way through Jon Loeliger's Git book and it's
>>> confusing when the actual behaviour differs from that in the book
>>
>> This probably results from the git culture's conflation (or should I
>> say confusion?) of low-level and high-level representations and
>> commands.
>
> I guess I=E2=80=99ll bite.  What does that mean?  We have =E2=80=9Csh=
ow-ref=E2=80=9D and
> =E2=80=9Cupdate-ref=E2=80=9D precisely as low-level commands that are=
 independent
> of representation.

I tend to agree with Michael (modulo s/ culture/'s early&/) here.  Many
documents written in the early days, the "tutorial" document by Linus
being the most prominent example, were written in a way to focus exposi=
ng
the implementation details to show how simple the structure is.  These
documents and tips by early adopters, simply by virtue of being old, ar=
e
found more easily by search engines.  Later we started encouraging use =
of
show-ref and update-ref to isolate users from the implementation detail=
s
that can be changed for performance reasons.

> Probably the more relevant question: what do you want to do about it?

Continue the current course of encouraging the use of plumbing commands
and not looking at the low-level implementation detail.  Perhaps help
people update their documents, moving stale descriptions into "historic=
al
note" sections.
