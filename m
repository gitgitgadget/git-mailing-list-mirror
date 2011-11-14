From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Compile warnings
Date: Mon, 14 Nov 2011 12:36:00 -0800
Message-ID: <7v39dqjvbj.fsf@alter.siamese.dyndns.org>
References: <op.v4xyekju0aolir@keputer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: "Frans Klaver" <fransklaver@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 14 21:36:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQ3GE-0002V5-3K
	for gcvg-git-2@lo.gmane.org; Mon, 14 Nov 2011 21:36:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756243Ab1KNUgF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Nov 2011 15:36:05 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55853 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753565Ab1KNUgD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2011 15:36:03 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9BC0663EA;
	Mon, 14 Nov 2011 15:36:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ckat/AawQPWl+TmbN2+vmZHbQh8=; b=FlqooB
	WypARY66Tziy/g72Nmb82RIKI0lfI92tF5JiDL+86iCZ5WGaV9Q12KJDq2G81kVX
	9ekjp9shRvi9QZgsxfpQ6Ouf5bn87tBd5cOfJHJHGcV/0RfVRr+X120GqDUxpKIL
	HiOpz9rpoTuUbWpvG5cXhoBLi/yW7TqXCW7mA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=f3j7ydjz2i3vVfaykYcwYTIopsjAbHwV
	bOakB6GY+ZstlV9D6j4nH1npWRoO5hUIJGgi99OCaCbMsSagt0TJ69IZCVuqSSA2
	BMS5TXSJqcFPrNPst7ErsnBAra4loyY6qHjDDctEthKX2UWPU/KsUL5gUKRjSFM5
	nRIcVn3Hwtk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9442B63E9;
	Mon, 14 Nov 2011 15:36:02 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1264B63E8; Mon, 14 Nov 2011
 15:36:01 -0500 (EST)
In-Reply-To: <op.v4xyekju0aolir@keputer> (Frans Klaver's message of "Mon, 14
 Nov 2011 15:55:22 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 44768FF0-0F00-11E1-8C1E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185401>

"Frans Klaver" <fransklaver@gmail.com> writes:

> Every now and then I see an 'unused result' warning come by during
> building. What is the general attitude towards these warnings? Remove
> them  (by properly checking)? Or leave them be as a kind of
> documentation -- we  know we're ignoring the info, but it's good to be
> reminded?

A callsite of a function whose return value is better checked should be
checked (e.g. not checking return from close(2) or write(2) in a non-error
codepath), but there is no strong mechanical "General attitude".

Sprinkling (void) that casts the return values all over the place makes
our code illegible, and we do not prefer it as a solution. A function
that returns a value that is useful for some callers but can be safely
ignored by others is sometimes an indication of a poor API, and for our
own code, we tend to prefer designing the API to pass optional pointer
to return value from callers that do want to use the return value (and
others that do not care about the return value pass NULL).
