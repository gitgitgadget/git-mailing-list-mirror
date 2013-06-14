From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] am: handle stray $dotest directory
Date: Fri, 14 Jun 2013 10:20:47 -0700
Message-ID: <7vehc4pq1c.fsf@alter.siamese.dyndns.org>
References: <1371196058-23948-1-git-send-email-artagnon@gmail.com>
	<1371196058-23948-2-git-send-email-artagnon@gmail.com>
	<7vhah0raps.fsf@alter.siamese.dyndns.org>
	<CALkWK0m6r4yRfCLb3dejdY+1KJgdOHPfrvPXbftNucApXFx+0A@mail.gmail.com>
	<7v1u84ra77.fsf@alter.siamese.dyndns.org>
	<CALkWK0n+KSrehL3tZ557c2hfKna6p_jVGL+a2az5V+h4=DstJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 14 19:21:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnXgV-0001fd-60
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 19:21:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752264Ab3FNRUv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jun 2013 13:20:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37966 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751913Ab3FNRUu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jun 2013 13:20:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4BDB925C68;
	Fri, 14 Jun 2013 17:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CbVJsDJDci+yPe7Wxxo/qqpHDRI=; b=Wz5XzR
	Sx3InvO3EuK70eB9waw+TogBjQu78xa+NSLEe/1pKKLrTsBFJjnWdMmXBh8IUssD
	3xSkzQLPdo5Mn8YCL85cfKN5iE6Uy5Xpwf6z5JbBoZWPGIP9u3mjb1aRYziPTd29
	NN1jyNADkuYtT7s2OMG1V1TNjeNNGjbtgItWs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bLsQtLSmI+otbDwR3rLsQCvjJgF95CZ3
	qx7APB4cQBhgwdoE84E52A3EZG+WlHlIWd92pFa25t9dSAiqnrHCj0e+wB9qySRO
	/hlXK74RKkK8+oSvXrNC4Tt4LWZ8LrdGCZewaZCLM7Cp+Zg40kv3GZPcFP2qLPsj
	o+kjJmCLwD8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3F90C25C67;
	Fri, 14 Jun 2013 17:20:50 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8CA3C25C65;
	Fri, 14 Jun 2013 17:20:49 +0000 (UTC)
In-Reply-To: <CALkWK0n+KSrehL3tZ557c2hfKna6p_jVGL+a2az5V+h4=DstJQ@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Fri, 14 Jun 2013 21:45:24 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C208B4C4-D516-11E2-8245-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227900>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Junio C Hamano wrote:
>> The reason would become clear once you think what string you are
>> feeding eval_gettext with if you do not escape.  The translators
>> translate a fixed string (possibly with placeholders) to a fixed
>> translated string (possibly with placeholders).
>>
>>         eval_gettext "Stray $dotest directory found. ..."
>>
>> would allow the shell to expand $dotest before eval_gettext sees it,
>> which would mean the string is no longer a constant.
>
> Ah.  I was scratching my head wondering why $dotest needed to be
> translated (it's just a path).

"Stray" and "directory found" are to be translated.  You can have
infinite possibilities to $dotest that is computed at runtime, so
that should be kept as a variable, untranslated in the message
template.
