From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Make git selectively and conditionally ignore certain
 stat fields
Date: Mon, 14 Jan 2013 16:11:38 -0800
Message-ID: <7vy5fv71ad.fsf@alter.siamese.dyndns.org>
References: <7vmwwb8m25.fsf@alter.siamese.dyndns.org>
 <1815551092.2039693.1358207014937.JavaMail.root@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, j sixt <j.sixt@viscovery.net>
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Jan 15 01:13:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tuu9v-0006lR-13
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 01:13:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751673Ab3AOALm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 19:11:42 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33644 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751340Ab3AOALm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2013 19:11:42 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 324B8BCA1;
	Mon, 14 Jan 2013 19:11:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/7GjQXMRHCAdG4TGrMHYjpHvhVI=; b=l0x+gg
	Q4wDDz6PVkRBWXtmiywqXjJCzVOB2Ac6xQ0NhmAfsmbWhwHKlcuHT6WaqzOjibI/
	hlZcEhFxknkv/JkFhzG9dcAkT+3VRGjYu4em6nG351I0HgJcm12OUg+d1xe4h2zo
	iaIKxhOKI2ep+4SLoN1i4MsWYx6lRvsNXyIn0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dcgFbRx8jTdl3S8gZilHPQHp1eHh8PKq
	Tuv6oK70BnFurX0AGJ+/C0cZZy4whSmIA4vqJcethoGcVrAnZFUA0pd8t5ziBXtW
	EIgolUnz4Cemw9IWofACLMTXeS5Rihip4all91yJ5uEN+4ik3VdVWa4yGCnOIANL
	tHXjU34tHQ8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2667BBC9F;
	Mon, 14 Jan 2013 19:11:41 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 826EFBC9D; Mon, 14 Jan 2013
 19:11:40 -0500 (EST)
In-Reply-To: <1815551092.2039693.1358207014937.JavaMail.root@dewire.com>
 (Robin Rosenberg's message of "Tue, 15 Jan 2013 00:43:34 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 22C59A24-5EA8-11E2-B4AB-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213547>

Robin Rosenberg <robin.rosenberg@dewire.com> writes:

> Semantically they're somewhat different. My flags are for ignoring
> a value when it's not used as indicated by the value zero, while
> trustctime is for ignoring untrustworthy, non-zero, values.

Yeah, I realized that after writing that message.

> Another thing that I noticed, is that I probably wanto to be able to filter on the precision
> of timestamps. Again, this i JGit-related. Current JGit has milliseconds precision (max), whereas
> Git has down to nanosecond precision in timestamps. Newer JGits may get nanoseconds timestamps too,
> but on current Linux versions JGit gets only integral seconds regardless of file system. 
>
> Would the names, milli, micro, nano be good for ignoring the tail when zero, or n1..n9 (obviously
> n2 would be ok too). nN = ignore all but first N nsec digits if they are zero)?

It somehow starts to sound like over-engineering to solve a wrong
problem.

I'd say a simplistic "ignore if zero is stored" or even "ignore this
as one of the systems that shares this file writes crap in it" may
be sufficient, and if this is a jGit specific issue, it might even
make sense to introduce a single configuration variable with string
"jgit" somewhere in its name and bypass the stat field comparison
for known-problematic fields, instead of having the user know and
list what stat fields need special attention.

Is this "the user edits in eclipse and then runs 'git status' from the
terminal" problem?
