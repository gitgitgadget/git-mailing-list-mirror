From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] submodule add: always initialize .git/config entry
Date: Wed, 29 Jun 2011 17:47:18 -0700
Message-ID: <7vwrg4qh61.fsf@alter.siamese.dyndns.org>
References: <0D2618D7-0681-4E71-B412-36D490D45B9D@gmail.com>
 <7v7h8c4nv3.fsf@alter.siamese.dyndns.org> <4E0390A7.8040505@web.de>
 <7vboxo2ne9.fsf@alter.siamese.dyndns.org>
 <7vy60r27et.fsf_-_@alter.siamese.dyndns.org> <4E066E8A.7060209@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Phil Hord <hordp@cisco.com>,
	Maarten Billemont <lhunath@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Andreas =?utf-8?Q?K=C3=B6hler?= <andi5.py@gmx.net>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Jun 30 02:47:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qc5Pj-0006Wl-Eh
	for gcvg-git-2@lo.gmane.org; Thu, 30 Jun 2011 02:47:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754964Ab1F3ArX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jun 2011 20:47:23 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:57997 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752785Ab1F3ArW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2011 20:47:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5C1606346;
	Wed, 29 Jun 2011 20:49:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=R2NT0ghG6HMsksaD9wMO5UMbm6E=; b=e0OvRV
	mtdhQkwxgsklZwVKmau/Qi9DAQwY0055un+6ZLic9V3etDg4e9imLnvRxIgf/sb4
	MZxVeftZwamjYf4y6Nr7dQMaGdXcc6rT/9Vze6h2Acn+EZToDVB7+/bAlGz/liUX
	NepkjyZKNoj2QY0Es1JVJnjsd/Gfz1mVgSZok=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZyzFqN3lb0uzfTzNZLmP2AFcKPtZxR5W
	He0y/qV1SB4CGdzhTlNzXICDFd6+fZePxRVdMtXwZ4aG+YF1pnwmE70Acu5zgjjg
	hOpjMvaleug1p4wXXzIPK/MyyZod4UkyCUzCG4N4Qs37unD61wBvBKiQAPfayld7
	o815zHrnb7Y=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3D93D6344;
	Wed, 29 Jun 2011 20:49:35 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 5F8956343; Wed, 29 Jun 2011
 20:49:34 -0400 (EDT)
In-Reply-To: <4E066E8A.7060209@web.de> (Jens Lehmann's message of "Sun, 26
 Jun 2011 01:26:02 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D2B98174-A2B2-11E0-A5F9-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176466>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Am 24.06.2011 06:13, schrieb Junio C Hamano:
>> Shouldn't "submodule add" add an entry for .git/config even when it cloned
>> from elsewhere?
>
> Yes, we should be consistent here.
>
>> I suspect this fix will cascade to breakage elsewhere, but I've run out of
>> energy and inclination to look at the submodule code tonight, so I'll let
>> the list to take it further from here.
>
> Ok, t7406 expected "git submodule init" to copy the new update setting
> into .git/config for a newly added submodule, which it didn't do anymore
> because it already found the url set. I solved that by teaching init to
> only then copy the url and update settings if they aren't present yet.
> Now all tests are running fine and your change to the test I added in
> jl/submodule-add-relurl-wo-upstream isn't necessary anymore.
>
> When I cherry pick that onto cbd0a3c6bc in your current pu branch and
> resolve the conflicts all tests run fine (if you want me to resend this
> patch based on that commit to avoid the conflicts with i18n and the
> "submodule add: clean up duplicated code" patch please just say so).

Hmm, now 7610 seems to expect somewhat different behaviour and fails.
