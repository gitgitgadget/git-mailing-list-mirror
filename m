From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2] tag: add --points-at list option
Date: Tue, 07 Feb 2012 12:20:44 -0800
Message-ID: <7v1uq61jkz.fsf@alter.siamese.dyndns.org>
References: <20120206081119.GA3939@sigill.intra.peff.net>
 <1328598076-7773-2-git-send-email-tmgrennan@gmail.com>
 <20120207160527.GC14773@sigill.intra.peff.net>
 <20120207190228.GB6264@tgrennan-laptop>
 <20120207191202.GA496@sigill.intra.peff.net>
 <20120207192135.GC6264@tgrennan-laptop>
 <20120207193632.GC32367@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tom Grennan <tmgrennan@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com, jasampler@gmail.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 07 21:20:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RurX1-00008W-FB
	for gcvg-git-2@plane.gmane.org; Tue, 07 Feb 2012 21:20:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756793Ab2BGUUr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Feb 2012 15:20:47 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38481 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756458Ab2BGUUq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Feb 2012 15:20:46 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 355995BBB;
	Tue,  7 Feb 2012 15:20:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5bat7AfkcZBHpFxG4QfdcnUrhZY=; b=htrhZf
	vVBaZ5PK5ZWr0nPMeBUBl/3bk7rNwxbbgrW11GBGPCxf937KuN3g135CzxewmBrb
	op2N2XQpyuh9n0CE8DQY88fzlvXrP0reZj7q1L2sJNqthQOxvUfSoz9ye9VGLlU8
	6iPlOaTKieVLqQBToB/VtxCFHCHCQ+RHOE0Xg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VZL1WCrM9y4FJnUMff1hA9aRm2rvUQKw
	mrSXqlruSMYlsJLOkEdxMu3pURUihYwJi4RA1l55vUu50CFHosjVsEjkT0p8PXJk
	EsFE3j88oWHUxj5EXnfVzBSqBCOw88S0p7KIKCflAVevgotHzEx8B/UXuDGARMt/
	zyiYL+TnIVY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2BFA15BBA;
	Tue,  7 Feb 2012 15:20:46 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8E1CD5BB9; Tue,  7 Feb 2012
 15:20:45 -0500 (EST)
In-Reply-To: <20120207193632.GC32367@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 7 Feb 2012 14:36:33 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 374DAC94-51C9-11E1-86F9-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190210>

Jeff King <peff@peff.net> writes:

>> I think the following would show the pointed at tag too.
>>   $ git tag my-v1.7.9 v1.7.9
>>   $ ./git-tag -l --points-at v1.7.9
>>   my-v1.7.9
>>   v1.7.9
>> 
>> vs.
>> 
>>   $ ./git-tag -l --points-at v1.7.9
>>   my-v1.7.9
>> 
>> I found that I had to filter matching refnames.
>
> Ah, so you are trying _not_ to show lightweight tags (I thought you
> meant you also wanted to show them)? But I still don't see why the code
> I posted before wouldn't work in that case. The "object" field of v1.7.9
> is not the sha1 of the v1.7.9 tag object, but rather some commit, so it
> would not match.

I think he is trying to avoid saying "v1.7.9 points at itself", and wants
to know not just the value of $(rev-parse v1.7.9) but the refname.
