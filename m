From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-am: indicate where a failed patch is to be found.
Date: Thu, 12 Jul 2012 11:53:28 -0700
Message-ID: <7va9z4byl3.fsf@alter.siamese.dyndns.org>
References: <1342108243-8599-1-git-send-email-paul.gortmaker@windriver.com>
 <7vhatcc1ql.fsf@alter.siamese.dyndns.org> <4FFF1821.7030705@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
X-From: git-owner@vger.kernel.org Thu Jul 12 20:53:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SpOW9-0006f4-Jn
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jul 2012 20:53:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755689Ab2GLSxc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jul 2012 14:53:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40665 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755221Ab2GLSxb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2012 14:53:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D2392848A;
	Thu, 12 Jul 2012 14:53:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=c0CMzEBJRVhnqDNgD1WRV6ruU9w=; b=Jlf1fU
	j00VjlqP2V9oFf/6tsWV8GICzyVARu/MSa1Nkfnax7bafe68kt57iUvR88/Z83tg
	ifTf1C6qL0URMARvoOc3SKGFPFPeKUPRYUSGWY8ixGyTYPTABotYBNlirqZHWq6x
	VR0Nc4xnRYZludP9ZTHOstlCSbWtjcmidVszs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vKQ2bCzwM7X0E/ssIv9NO59vXqvd18Ea
	M60bIUfsdTYZOlq6AWSPXSg6hhhhaBtlH9KXqWFi1NSoycTNmg50ii0d+3fqevu+
	os5WG1/xteEzmpXWhN2P8UYc+cj8jqwgACZQG694AEs48gk4Z41hZ9l7VtLEaCO/
	9qMrYnR/DhQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BF4E28489;
	Thu, 12 Jul 2012 14:53:30 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2409E8487; Thu, 12 Jul 2012
 14:53:30 -0400 (EDT)
In-Reply-To: <4FFF1821.7030705@windriver.com> (Paul Gortmaker's message of
 "Thu, 12 Jul 2012 14:32:01 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DF2E2D22-CC52-11E1-B4DD-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201374>

Paul Gortmaker <paul.gortmaker@windriver.com> writes:

> On 12-07-12 01:45 PM, Junio C Hamano wrote:
>> Paul Gortmaker <paul.gortmaker@windriver.com> writes:
>> 
>>> If git am wasn't run with --reject, we assume the end user
>>> knows where to find the patch.  This is normally true for
>>> a single patch,
>> 
>> Not at all.  Whether it is a single or broken, the patch is fed to
>> underlying "apply" from an unadvertised place.
>
> What I meant by this was the difference between:
>
> 	git am 0001-some-standalone-single.patch
> vs.
> 	git am mbox
>
> In the 1st, the standalone patch is 100% clear and easy to access,
> because we really don't need/care about the unadvertised place.

It does not matter at all that 0001-foo.patch only has a single
patch.  If you are going to fix up the patch after you saw "git am"
failed, you will be fixing .git/rebase-apply/patch with your editor
and re-run "git am" without arguments, at which point "git am" will
not look at your 0001-foo.patch file at all.

>> This is _NOT_ fine, especially if you suggest "patch" the user may
>> not have, and more importantly does not have a clue why "git apply"
>> rejected it ("am" does _not_ use "patch" at all).
>
> I'm not 100% sure I'm following what part here is not OK.  If you
> can help me understand that, I'll respin the change accordingly.

Do not ever mention "patch -p1".  It is not the command that "git
am" uses, and it is not what detected the breakage in the patch.

The command to guide the user to is "git apply".
