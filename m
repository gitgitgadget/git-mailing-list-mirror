From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git help prune accuracy?
Date: Thu, 15 Dec 2011 14:18:19 -0800
Message-ID: <7v1us5mqc4.fsf@alter.siamese.dyndns.org>
References: <201112151432.09252.mfick@codeaurora.org>
 <201112151453.52157.mfick@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Martin Fick <mfick@codeaurora.org>
X-From: git-owner@vger.kernel.org Thu Dec 15 23:18:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbJdC-0000IQ-JY
	for gcvg-git-2@lo.gmane.org; Thu, 15 Dec 2011 23:18:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759528Ab1LOWSW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Dec 2011 17:18:22 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34563 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756377Ab1LOWSV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Dec 2011 17:18:21 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2FF027396;
	Thu, 15 Dec 2011 17:18:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=S8kwUrXe6Yl9pfrclrRKlzBUsM8=; b=uWOpQJ
	fcybTS4yTpM+M/qiy9qmJ+Rh5qLB5I8Ne8S9f/v9eavgRlrNC3FL6R9H3BODGOof
	qCbpXJKtFkc5Ht2HLR05E+8RvVGGTZikiHzYTbTWPcZ/cf91lVBBN6EqmHAwFCyc
	YLFUmsm1pXWDn/SLqkuGWluLrAcR1uR0Eli0Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ryJULBT5aOruNksyTlzo2yH5SBYXfrZ0
	/LizHgWYCUjcqJyhGmSMokBEV/bzR8iLGFOSbg468agyH9qPZ4ChxMWaOmFb4FM9
	zM4xgcHgYyK6CcN1O+7llEGWt9D8UaVkBqzrv1cnShwQIk0WJ4y84uw1Uv9Z3z31
	8A0+osUIqAw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 27CBF7395;
	Thu, 15 Dec 2011 17:18:21 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B22937394; Thu, 15 Dec 2011
 17:18:20 -0500 (EST)
In-Reply-To: <201112151453.52157.mfick@codeaurora.org> (Martin Fick's message
 of "Thu, 15 Dec 2011 14:53:52 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B231294C-276A-11E1-8B4E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187248>

Martin Fick <mfick@codeaurora.org> writes:

>>   objects from the object database. In addition, it
>> prunes the unpacked objects that are also found in packs
>> by running git prune-packed.
>> 
>> The last sentence seems like it should maybe have the
>> following fix:
>> 
>> s/it prunes the unpacked/it prunes the unreferenced/
>
> Ack, I meant:
>
> s/it prunes the unpacked/it prunes the unreachable/

"In addition" part is about objects that exist in loose format that are
also found in packs and has nothing to do with reachability.

Running "git pack-objects" to collect loose objects into a new pack will
not remove these loose objects that are copied into that new pack. Because
we try to access objects from an already open packfile before trying a
loose object file, removing these now-redundant loose ones after they are
packed makes sense. And that is what "git prune-packed" does.
