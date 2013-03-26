From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 0/5] Verify GPG signatures when merging and extend %G?
 pretty string
Date: Tue, 26 Mar 2013 09:26:36 -0700
Message-ID: <7vvc8et9dv.fsf@alter.siamese.dyndns.org>
References: <7vli9bue40.fsf@alter.siamese.dyndns.org>
 <515180FD.7090906@physik.tu-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Sebastian =?utf-8?Q?G=C3=B6tte?= <jaseg@physik.tu-berlin.de>
X-From: git-owner@vger.kernel.org Tue Mar 26 17:27:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKWiq-0008FC-Em
	for gcvg-git-2@plane.gmane.org; Tue, 26 Mar 2013 17:27:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934666Ab3CZQ0l convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Mar 2013 12:26:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55750 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933863Ab3CZQ0j convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Mar 2013 12:26:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 881F9ABA8;
	Tue, 26 Mar 2013 12:26:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=92tq4DPynXJW
	LQ7TcwmhiX0mwyc=; b=K0/olRO1edQHffl425788BaKzsKgjJduIaxygqfbG2Rb
	Ojqf3+ox10jRZSNJU05qbW1Hj7LaTY96KAyEcBszhfsY8HJvC9SA8/ce8q033E3L
	eO3eP1n8zU4JnHgkLM77i8q+ogbnFrIrZbmVjQKuRs6TMn4LnA6CJqO/KL20MAQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=JIpbsK
	CCfMbE8tnC1x0xkEaZ2GcqbiLAxStbRTQ333XdwdY3pb3IVrlxGylSxIOUX6AsmK
	x0HNZDRV954od83ASVJF2lfNM8eUya7rQ29yhBMnlVywJSSpyLWuocHHHYMqKRaF
	VYLlEJSSYJhoo5muzlHxv1Vb79tDmaLfrz7r0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 766F3ABA7;
	Tue, 26 Mar 2013 12:26:38 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D8559ABA6; Tue, 26 Mar 2013
 12:26:37 -0400 (EDT)
In-Reply-To: <515180FD.7090906@physik.tu-berlin.de> ("Sebastian
 =?utf-8?Q?G=C3=B6tte=22's?= message of "Tue, 26 Mar 2013 12:05:33 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EED3855C-9631-11E2-898A-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219165>

Sebastian G=C3=B6tte <jaseg@physik.tu-berlin.de> writes:

> On 03/26/2013 02:46 AM, Junio C Hamano wrote:> Sebastian G=C3=B6tte <=
jaseg@physik.tu-berlin.de> writes:
>>> Rebased it onto the current 'master'. The second patch fixes that t=
he GPG
>>> status parser ignores the first line of GPG status output (that wou=
ld be caught
>>> by the new merge signature verification test case).
>>=20
>> Thanks.
>>=20
>> Does it still make sure that it won't be fooled by the expected
>> string appearing in the middle of a line, not at the beginning?
>
> I thought that would not be a problem until I noticed it checks for G=
OODSIG
> before it checks for BADSIG. Here is a fix.

What does the order of checking have to do with it?  I am confused...

I was more worried about a case where you may end up misinterpreting

[GNUPG:] BADSIG B0B5E88696AFE6CB [GNUPG:] GOODSIG B0B5E88696AFE6CB <y@x=
z>

as showing goodsig when the signer's name was set to "[GNUPG:]
GOODSIG B0B5E88696AFE6CB"

The "\n" in the original was to make sure the expected message is at
the beginning of a line.
