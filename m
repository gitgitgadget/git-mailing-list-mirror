From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] completion: add format-patch options to send-email
Date: Mon, 15 Oct 2012 16:28:23 -0700
Message-ID: <7vhapvuxgo.fsf@alter.siamese.dyndns.org>
References: <1350231243-13485-1-git-send-email-felipe.contreras@gmail.com>
 <20121015224857.GA2156@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Tue Oct 16 01:28:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNu5O-0004l2-6e
	for gcvg-git-2@plane.gmane.org; Tue, 16 Oct 2012 01:28:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753902Ab2JOX21 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Oct 2012 19:28:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57348 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752754Ab2JOX20 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Oct 2012 19:28:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CC9029F36;
	Mon, 15 Oct 2012 19:28:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=VQfIR/b2v1le
	OlHohDPhTtAMOqc=; b=u1v1sgs7sUXk6Sphvhf4MXz648FPC+4XqKPbMtgn/K9d
	RQ1JPY4eJCpVqwdw/lZtynqsfgmEjhbQMnavn3ah0ZVa1KyR4+4ztSNVwGCGK6je
	qZWTtTaODcZTk3HOUis0vF8HHzQkmIPgorzvMWEHMsb8CmHtx+4aCU2fpR0w9EY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=eA7MEb
	fs3D/Ax1oVjXs11RC3id14Lvgdmr8nAb7Wf6suST4CChhcHwvfioPV6UfgD0hF3d
	LfizVvyJ5gP5l6yAnfzqAxTff4A7/S1yQvoSCBW5csEcqcI98eDVoABr8XEPuLDS
	vjyGPLz8fbY/LDR5lIGfW+pl30yIrgWhJ0Yus=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B7FED9F35;
	Mon, 15 Oct 2012 19:28:25 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1D0F49F34; Mon, 15 Oct 2012
 19:28:25 -0400 (EDT)
In-Reply-To: <20121015224857.GA2156@goldbirke> ("SZEDER =?utf-8?Q?G=C3=A1b?=
 =?utf-8?Q?or=22's?= message of "Tue, 16 Oct 2012 00:48:57 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0431AF00-1720-11E2-B853-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207786>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

>> +	cd test
>
> This 'cd' makes all subsequent tests to be executed in a different
> repository than previously, which breaks 'checkout completes ref
> names'.

Yeah, thanks for spotting and yelling at it ;-).

We really need to be careful about tests that cd around.  Even the
ones that only go down and expect the rest of the test to run in
that subdirectory may later have to be modified by somebody to run
back at the original level, and writing "cd ..", which leads to all
sorts of problems, becomes too tempting.

>> +'
>> +
>>  test_expect_success 'basic' '
>>  	run_completion "git \"\"" &&
>>  	# built-in
>> @@ -228,4 +244,9 @@ test_expect_success 'general options plus comman=
d' '
>>  	test_completion "git --no-replace-objects check" "checkout "
>>  '
>> =20
>> +test_expect_success 'send-email' '
>> +	test_completion "git send-email --cov" "--cover-letter " &&
>> +	test_completion "git send-email ma" "master "
>> +'
>> +
>>  test_done
>> --=20
>> 1.7.12.1
>>=20
