From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] introduce git root
Date: Sun, 30 Nov 2014 20:53:08 -0800
Message-ID: <xmqqwq6cq8cr.fsf@gitster.dls.corp.google.com>
References: <1417291211-32268-1-git-send-email-arjun024@gmail.com>
	<2AC7B765F56B4AA8A0DB76E8C670A889@PhilipOakley>
	<CAJFMrCEciWXhBb36MVeFPi7Y7D=9zQ2xGPpiyUz9y4_hOh_taw@mail.gmail.com>
	<vpqoaro99xd.fsf@anie.imag.fr>
	<xmqqd284rryz.fsf@gitster.dls.corp.google.com>
	<CAP8UFD2jES1i+6zOt1gXqTWFy1UHu2GBwAisQktd_Ymbj9Db2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Arjun Sreedharan <arjun024@gmail.com>,
	Philip Oakley <philipoakley@iee.org>, Git <git@vger.kernel.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 01 05:53:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvIz5-0006Hw-U7
	for gcvg-git-2@plane.gmane.org; Mon, 01 Dec 2014 05:53:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752472AbaLAExM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Nov 2014 23:53:12 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:56691 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752336AbaLAExL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Nov 2014 23:53:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3638C23CEC;
	Sun, 30 Nov 2014 23:53:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PcGAiBcRJbJwdPwTI6/pgydB1n4=; b=IJGaQM
	644mBfeW4RPCBAd+qzy7qaUXDan2pu7KoI+xY8Kbtf0YeN9o1NBp+hg14ZIfp7wV
	UYnYF06l2GvkJr5vl3HN/OVq5OfY/DWYEHxC+CYwQ4zhwx67r/Ua6DOh5JPDtOWl
	pEYVOZzH4k0LwiPLRmrdbqm3Jkdfc8rbH8glA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kNgaFUNN/H10YutDFJEtAyXVrzmgSQp5
	T+Rr6rQ1b8i48XM9EYxsC1DdnZL/eRxVvSpntWchCNduba4eNvSg61IrdRVwDYfT
	8SRRUbOOky7s1hWhXK7cHluP4udVZJ9QzQe46SgjN+vEu61jnbsAe6/GNEqb+Uf/
	xamrgmkSIr8=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2AA5023CEB;
	Sun, 30 Nov 2014 23:53:10 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8A97D23CEA;
	Sun, 30 Nov 2014 23:53:09 -0500 (EST)
In-Reply-To: <CAP8UFD2jES1i+6zOt1gXqTWFy1UHu2GBwAisQktd_Ymbj9Db2g@mail.gmail.com>
	(Christian Couder's message of "Mon, 1 Dec 2014 05:17:22 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F26E660A-7915-11E4-9E9B-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260469>

Christian Couder <christian.couder@gmail.com> writes:

> I wonder if we could reuse "git config" which is already a "kitchen
> synk" command to get/set a lot of parameters.

I doubt it makes much sense.

 * Things like toplevel and cdup are not even something you
   configure.  It is where you are, the current state of you.
   "git config" does not make any sense at all.

 * manpath and execpath and friends _might_ be something you may
   want to configure, and teach relevant codepaths to pay attention
   to the new configuration values.  But until that happens, it does
   not make sense to have that information in "git config".  "git
   config" does not show values that are not actually configured, so
   it won't be a replacement for "git --man-path" for those who do
   not have nonstandard place configured.

So...
