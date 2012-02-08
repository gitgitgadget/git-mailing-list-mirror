From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/4] Deprecate "not allow as-is commit with i-t-a
 entries"
Date: Wed, 08 Feb 2012 09:34:55 -0800
Message-ID: <7v8vkdz0sg.fsf@alter.siamese.dyndns.org>
References: <1328618804-31796-1-git-send-email-pclouds@gmail.com>
 <7v8vke38a1.fsf@alter.siamese.dyndns.org>
 <CACsJy8DSM3kPXJ4oYexCLs5qp6YdZ4Mf9RrGo78a0tHkRaTe4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 08 18:35:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvBQ7-0002Rt-LY
	for gcvg-git-2@plane.gmane.org; Wed, 08 Feb 2012 18:35:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755597Ab2BHRe6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Feb 2012 12:34:58 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59859 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753964Ab2BHRe6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Feb 2012 12:34:58 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2917D5DDE;
	Wed,  8 Feb 2012 12:34:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kcaWt9il9Z6g7aQvp5KPIXUFNv0=; b=H1pO0u
	Vrwynt3kglvYzDzV+bXstU2StHRPPJci7GRM8Xn+KhLRN1zXg91Bf0j7WCjCiwCq
	9s+jLrE6OklGLLeoWyxLuisKg8Q2LpoS9Rpard7Ki66a7/eiQdgEih/bVzNXunv5
	i15yGky2h1t23lQRsR16L244UdPyAqEoBvEP0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PtYkp4+qpywmz82JG38V+y9bGdTjRoFx
	1x9iUvYJ32TAlML1I4pyX8LWq6zYwqZ4z58PE9ww5ldvq1l2vBAYdIcO4l4qLMun
	HiN6Ut1rcmH9SDjLKVCFu8ybAuUeP71Of4B1DXy2V9qLP8kChSOMVUmKtD11RMB6
	5YYDvlGRot8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2087F5DDD;
	Wed,  8 Feb 2012 12:34:57 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A25D55DDC; Wed,  8 Feb 2012
 12:34:56 -0500 (EST)
In-Reply-To: <CACsJy8DSM3kPXJ4oYexCLs5qp6YdZ4Mf9RrGo78a0tHkRaTe4g@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Wed, 8 Feb 2012 11:03:46 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 37B30348-527B-11E1-BF45-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190244>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> 2012/2/7 Junio C Hamano <gitster@pobox.com>:
>> But when I said "let's admit that this is just fixing an UI mistake, no
>> configuration, no options", I really meant it. Without the backward
>> compatiblity "For now please do not fix this bug for me and keep being
>> buggy until I get used to the non-buggy behaviour" fuss, which we never do
>> to any bugfix.
>
> Ahh I missed something again. Your patch looks good too.

Ok, the strategy part is now behind us, but I have this slight suspicion
(I didn't look at the code nor tried it out myself---I don't have time to
do this myself today) that using this codepath might result in a corrupt
cache-tree, whose entries point at a section of the index it covers as a
subtree of the whole project but with incorrect counters or something like
that.  It would be good to make sure this "just ignoring i-t-a" is doing
the right thing not to the resulting commit, but in the resulting index as
well, before we go forward with this change.
