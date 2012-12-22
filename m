From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] Makefile: use -Wdeclaration-after-statement if
 supported
Date: Sat, 22 Dec 2012 10:39:19 -0800
Message-ID: <7vsj6yq6co.fsf@alter.siamese.dyndns.org>
References: <1355686561-1057-1-git-send-email-git@adamspiers.org>
 <1355686561-1057-4-git-send-email-git@adamspiers.org>
 <7vk3shphru.fsf@alter.siamese.dyndns.org> <20121217021501.GA13745@gmail.com>
 <7v8v8xpazq.fsf@alter.siamese.dyndns.org>
 <CAOkDyE_+3n8PS_6vs-HG6v5A4SirBPVVCdgeUPOPpwaNpkk9Uw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Adam Spiers <git@adamspiers.org>
X-From: git-owner@vger.kernel.org Sat Dec 22 19:39:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TmTz3-0006M2-Hw
	for gcvg-git-2@plane.gmane.org; Sat, 22 Dec 2012 19:39:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751945Ab2LVSjX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Dec 2012 13:39:23 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47649 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751790Ab2LVSjW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Dec 2012 13:39:22 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 997B4A2A0;
	Sat, 22 Dec 2012 13:39:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FwRcey/hfusaWd5RR/TGguTpFlk=; b=AFLz6o
	/glydFrkJS0VnTmVKQ/UpMRqYCbILA2zHjeKvpisZkI1jWnUxgQn/PalYJ0vxsxD
	DFge057e5FPeJhmPJxiOuboBafswL3dGYMDQiofFQaPcjmkDJUrKc775v9H7HJYs
	BZcIU3YOoWdMsg8Yplm9MnkkECUl3QLUVG1Kk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MTQf0AtuzEyqhSIxaiJfFuf5T0+/1sKP
	v73gG4q2Jy2ZGa6Hgqq6EuZnTy9wxunFiYgmtUtYthLMzQHyiELCiR2LnOH6b1H/
	mAY5+Hg2qXo1dghq1l+NPs53VonGVzsQIp97a/5eHFFGfC0ow4TGrHwlnxA9lNh4
	E6IWIL4LYjA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 84BF4A29F;
	Sat, 22 Dec 2012 13:39:21 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 01699A29D; Sat, 22 Dec 2012
 13:39:20 -0500 (EST)
In-Reply-To: <CAOkDyE_+3n8PS_6vs-HG6v5A4SirBPVVCdgeUPOPpwaNpkk9Uw@mail.gmail.com> (Adam
 Spiers's message of "Sat, 22 Dec 2012 12:25:07 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E6642404-4C66-11E2-ADFE-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212065>

Adam Spiers <git@adamspiers.org> writes:

> Fair enough, but let's not allow perfect to become the enemy of good.

That is why I would prefer a solution without any false positive
while allowing false negatives, i.e. not force everybody to use
these flags without giving a way to turn them off.

You could perhaps sell us a solution like this:

 * Put these more strict options to CC_FLAGS_PEDANTIC (you may later
   want to come up with LD_FLAGS_PEDANTIC and friends to make other
   comands also more strict).

 * Introduce PEDANTIC variable that turns XX_FLAGS_PEDANTIC
   variables to less strict when set to 0 and more strict when set
   to 1, similar to the way the variable V makes "make V=0" and
   "make V=1" behave slightly differently.

Then we could introduce PEDANTIC=0 as default first to have people
try it out, with an expectation that later we can flip the default
to 'on' when the feature matures.
