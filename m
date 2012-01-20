From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Q] Determing if a commit is reachable from the HEAD ?
Date: Fri, 20 Jan 2012 11:18:50 -0800
Message-ID: <7v7h0mfahx.fsf@alter.siamese.dyndns.org>
References: <201201201433.30267.brian.foster@maxim-ic.com>
 <m2ehuu8nrt.fsf@igel.home> <20120120180620.GA8504@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	Brian Foster <brian.foster@maxim-ic.com>,
	git mailing list <git@vger.kernel.org>
To: David Brown <davidb@codeaurora.org>
X-From: git-owner@vger.kernel.org Fri Jan 20 20:18:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RoJzG-0006Wr-Jd
	for gcvg-git-2@lo.gmane.org; Fri, 20 Jan 2012 20:18:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755427Ab2ATTSy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jan 2012 14:18:54 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42599 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754413Ab2ATTSx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jan 2012 14:18:53 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6E41E77C8;
	Fri, 20 Jan 2012 14:18:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6RfR3xUHARySvO4YbYOKLWmHAbw=; b=q8lCcb
	QFEuRUOr1vUvEkFsk5pQgIs8LMdtoUXK+YYSdZcYno+ZxSSTJ1XJSE0I+EbKvmi8
	oY4CtkZMwJV5RzXAmgZuxHrz5+VKIjdI+8HEZJKCDRdAkyu6+gsheo+OTBn9Np/R
	y+0i5iqL1kBvah+xCD+JbapSfguWDKNLFzNK4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=u2Wti5RF2LCPwnK6GCNFyrK4gxGDKnuE
	2UxFzvVyLp8POv39uOub6lvcQmcHyf91v4WmJePpTQs43WZoewX23Tm6NnMd+VzX
	PKyPOYanPCDTgHtD47wohnkmYI5sZC1MaAeHVLWDJuDJIohN2TuhT06M2g0LJL4n
	bi6ODdR3dNA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6606E77C7;
	Fri, 20 Jan 2012 14:18:52 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F0F4277C6; Fri, 20 Jan 2012
 14:18:51 -0500 (EST)
In-Reply-To: <20120120180620.GA8504@codeaurora.org> (David Brown's message of
 "Fri, 20 Jan 2012 10:06:20 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 96649256-439B-11E1-AE4A-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188893>

David Brown <davidb@codeaurora.org> writes:

> On Fri, Jan 20, 2012 at 03:13:58PM +0100, Andreas Schwab wrote:
>> Brian Foster <brian.foster@maxim-ic.com> writes:
>> 
>> >  In a script, how can I determine commit Y is reachable
>> >  from the current HEAD ?
>> 
>> test $(git merge-base HEAD Y) = $(git rev-parse Y)
>
> Almost.  It works as long as there is only one merge base.  You really
> need to check if $(git rev-parse Y) is one of $(git merge-base --all
> HEAD Y)

Can you give us an example of a topology to which "merge-base --all HEAD Y"
gives more than one output and Y is still reachable from HEAD?

It is my understanding that merge-base computation will give only Y and
nothing else when Y is reachable from HEAD. I also think this assumption
is used by some of the internal code in Git, and that is why I care.
