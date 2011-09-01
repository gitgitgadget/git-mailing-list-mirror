From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] remote: write correct fetch spec when renaming
 remote 'remote'
Date: Wed, 31 Aug 2011 20:18:40 -0700
Message-ID: <7vk49tx84v.fsf@alter.siamese.dyndns.org>
References: <1314841843-19868-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <20110901024211.GC31838@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 01 05:19:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qyxo4-0001bF-Py
	for gcvg-git-2@lo.gmane.org; Thu, 01 Sep 2011 05:19:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757534Ab1IADSq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Aug 2011 23:18:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45513 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757523Ab1IADSp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Aug 2011 23:18:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BD54448D8;
	Wed, 31 Aug 2011 23:18:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wfEspWyJrKbbXradcPzxboAVWS8=; b=VbxgUF
	clZkcPt9g+VVmVevyKgaDwloveWJqAcbcQnbMgZyY0+D56kfi9YwFYOURsmSjBPi
	sMv4yX1TnFEgrVPMK2xq//ry/OnrHJC2UY2lCSIaErAtXZHmw12v5+lKRf3VuAEp
	fksDFrDJUr1kur2fL2JYCLgCmVS5Iq/UV05tU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tqNBDi0Ll5iersMHeHyxD0q/ms6rr8PK
	M9yCTTlA2cgmcTntTlHm6e13BL3ezPBmo9CktPeNUipu10FR68wvoqBkQ7zhGV7g
	aJCVdGzSIEWdZgkxJdzyoiiDhIGJ+7irA2DB0Cx1M3XKkB/GE3c9LnOK8dG1qMS1
	kePRCmc0FQQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B3D8E48D7;
	Wed, 31 Aug 2011 23:18:42 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4CECA48D6; Wed, 31 Aug 2011
 23:18:42 -0400 (EDT)
In-Reply-To: <20110901024211.GC31838@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 31 Aug 2011 22:42:11 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 181B60A8-D449-11E0-9AFE-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180519>

Jeff King <peff@peff.net> writes:

> Actually, I think it's better to be more conservative, and rename only:
>
>   refs/remotes/$OLD/
>
> into
>
>   refs/remotes/$NEW/

Thanks.

I wholeheartedly agree with this. It would let me sleep better if we did
this rewriting only when remote.$name.fetch is set exactly to its default
value, "+refs/heads/*:refs/origin/$name/*" (it is Ok if the leading '+' is
missing, though), and we didn't touch either config nor the existing
tracking refs at all otherwise, and gave warning saying we didn't do
anything to them.
