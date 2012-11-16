From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 5/6] completion: refactor __gitcomp related tests
Date: Fri, 16 Nov 2012 15:40:33 -0800
Message-ID: <7vip95ktfy.fsf@alter.siamese.dyndns.org>
References: <1352644558-9410-1-git-send-email-felipe.contreras@gmail.com>
 <1352644558-9410-6-git-send-email-felipe.contreras@gmail.com>
 <20121116210242.GZ12052@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Sat Nov 17 00:40:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZVWl-0004as-Sw
	for gcvg-git-2@plane.gmane.org; Sat, 17 Nov 2012 00:40:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753385Ab2KPXkh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Nov 2012 18:40:37 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55690 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753173Ab2KPXkg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Nov 2012 18:40:36 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 98D91A9C7;
	Fri, 16 Nov 2012 18:40:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=CwwKFLafBWZt
	xkPNkRWWaSjCm/k=; b=JDq4uLuNnTFONXKrNgmAUjZu8tN3LFstiI2H72g/vV6D
	dy3byXliwdJczcqbdJPBq4CExRk+rl+4JUeuEgRSQ+SuiWLqZdI65vQkstAGhI3r
	xFBJ0EBKdFZV8e+fxytzEl8X2wEwQbecj+gnDe+kAfPhkr7GaYkIZeBvCLqs9Gg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=cQU4j9
	RqNrMwac9Y0sXSQzd9MtuiZfyFIzba6glqNefx36D0bfxHpqTJmdH73GXSLYn961
	pzmUwdcQxpP3FAURBhc1Szv02gP+voGATp/u7X6dG3W4Ypy3Aeou+SPbSgl+LpdT
	j7BIQjgOABzLWL4s+i7eJ4T1LWOMOgdWIPIgY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8548EA9C6;
	Fri, 16 Nov 2012 18:40:35 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E8706A9C5; Fri, 16 Nov 2012
 18:40:34 -0500 (EST)
In-Reply-To: <20121116210242.GZ12052@goldbirke> ("SZEDER =?utf-8?Q?G=C3=A1?=
 =?utf-8?Q?bor=22's?= message of "Fri, 16 Nov 2012 22:02:42 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 046D36FC-3047-11E2-A402-54832E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209919>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

> On Sun, Nov 11, 2012 at 03:35:57PM +0100, Felipe Contreras wrote:
>> Lots of duplicated code!
>>=20
>> No functional changes.
>>=20
>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>> ---
>>  t/t9902-completion.sh | 76 ++++++++++++++++++----------------------=
-----------
>>  1 file changed, 27 insertions(+), 49 deletions(-)
>
> Despite the impressive numbers, these tests are more useful without
> this cleanup.

Is this because consolidation of the duplicated part of the tests
into a single helper makes it harder to instrument one test you are
interested in (or developing) for debugging?

It indeed is a problem, and cutting and pasting the same code to
multiple tests is one way to solve the problem (you can easily
instrument the copy in the test you are interested in while leaving
others intact), but I do not think that is a good solution.  A bugfix
or enhancement to the shared (or duplicated) part can be done by
touching one place only after this change, while with the current
code you have to repeat the same fix to all places, no?

>> +# Test __gitcomp.
>> +# Arguments are:
>> +# 1: typed text so far (cur)
>
> The first argument is not the typed text so far, but the word
> currently containing the cursor position.

Care to update this with a follow-up patch, so that I do not have to
keep track of minute details ;-)?
