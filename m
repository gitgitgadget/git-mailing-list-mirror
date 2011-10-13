From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/9] completion: optimize refs completion
Date: Thu, 13 Oct 2011 10:28:12 -0700
Message-ID: <7vk4886btf.fsf@alter.siamese.dyndns.org>
References: <1318085683-29830-1-git-send-email-szeder@ira.uka.de>
 <1318085683-29830-3-git-send-email-szeder@ira.uka.de>
 <7v7h497m01.fsf@alter.siamese.dyndns.org> <20111013104047.GA15379@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Thu Oct 13 19:28:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REP4v-0000sv-5G
	for gcvg-git-2@lo.gmane.org; Thu, 13 Oct 2011 19:28:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756545Ab1JMR2Q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Oct 2011 13:28:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63200 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753833Ab1JMR2Q convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Oct 2011 13:28:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 07E4D5C46;
	Thu, 13 Oct 2011 13:28:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=5+4Ph/M7O9jL
	87CY+pC01Pu1z6E=; b=IayIrOTBnGfvKvjzZKs4VFjDDNlV0/NWBK7oIoWlpDkg
	f3LSAE0PafDVj4dHrgtSzGhKcQUOOi9WZNyvynuEOU+y3zCv4xS9RmGsEIGmglfi
	AixTC2n8+K7AYIhKGNB4ckLB4qeNzdPolhM8Eut5l7PPT2BLPACyokqEKw0W18U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=cUWmax
	vRtkYqKrzE77CXoH8sZ4kzLy/SNXNjOoaez7e7XJWNk2E0cuzo/2qVPKNUN5W+V4
	Nah5C5auMv/wpCaWqMK89IyqEOkygmHntaI04WcKdpA+5I4SVWJbR/lCRO+Lct+m
	4rN0aI6cN/L+3H9vWTGHh/KjuAszwa74myIcE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F1FF35C45;
	Thu, 13 Oct 2011 13:28:14 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 82FE75C42; Thu, 13 Oct 2011
 13:28:14 -0400 (EDT)
In-Reply-To: <20111013104047.GA15379@goldbirke> ("SZEDER =?utf-8?Q?G=C3=A1?=
 =?utf-8?Q?bor=22's?= message of "Thu, 13 Oct 2011 12:40:47 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BB44C2FE-F5C0-11E0-886E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183500>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

> ... If we use the default IFS containing an SP and append a SP to
> possible completion words by 'compgen -S " "' (or by word=3D"$word ",=
 as
> in __gitcomp_1()), then that SP will be promply stripped off when
> compgen's output is stored in the COMPREPLY array.  Using an IFS
> without SP keeps those SP suffixes.

Ahh, then I am perfectly fine with the "nl" in its name.

This is a function that unconditionally completes with trailing separat=
or,
avoiding the cost of having to inspect each element, but the user needs=
 to
keep in mind that the elements in the input must be separated with NL, =
so
ideally the name needs to convey both of these points---dropping "nl" w=
as
a bad suggestion.

Thanks for a clear explanation.
