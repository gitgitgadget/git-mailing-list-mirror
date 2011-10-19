From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git --reference bug(?)
Date: Tue, 18 Oct 2011 23:21:20 -0700
Message-ID: <7vpqhtec2n.fsf@alter.siamese.dyndns.org>
References: <CAK-xaQaUxJ5c_kN48g7-J9fosDv6awbAFQSFLpF2fA+hc-i-MA@mail.gmail.com>
 <4E9E59A7.7070307@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andrea Gelmini <andrea.gelmini@gmail.com>, gitster@pobox.com,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Oct 19 08:21:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGPWp-0006PZ-Pm
	for gcvg-git-2@lo.gmane.org; Wed, 19 Oct 2011 08:21:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754856Ab1JSGVY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Oct 2011 02:21:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51274 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751469Ab1JSGVX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2011 02:21:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0C7342D12;
	Wed, 19 Oct 2011 02:21:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fJyylQ9WDkWAAfzUf3dUVbIMkuk=; b=qC5nDB
	KwKJMTp1K3a7wuyH+BKwuqe1mV6EY6lSxrD9XGyZR6lZDRD7JmQP0QcSgJdcLO52
	tRzKppQnk0cSnh9JqfnkdMmbEuZ4G/6b/7A6E+2oVNhAsht4pQIMjkKYha31ShiE
	OUDFPoG1EBxaZC11HJRX7QrBhanj+WGxPjKh8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XJ/SrynXj/aIA+q3ZM5LXyXpFB2x8fok
	UabyA2TgPdsUIcku+W8x+d+XlMHRErxvOpKmhuyb2ZYrOnN/9+JrQGXtgqX0T8MX
	iQbKgrlXI16IjtCVVMZTNPynnwIDCe7M0OdJ97pC2WFLN8Ku+rDyHukXlE3wUbQE
	53RjH0Xqf80=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 000812D11;
	Wed, 19 Oct 2011 02:21:22 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5DB1E2D10; Wed, 19 Oct 2011
 02:21:22 -0400 (EDT)
In-Reply-To: <4E9E59A7.7070307@alum.mit.edu> (Michael Haggerty's message of
 "Wed, 19 Oct 2011 07:01:27 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 90A505C8-FA1A-11E0-AC05-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183918>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> On 10/19/2011 12:04 AM, Andrea Gelmini wrote:
>> git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
>> /tmp/3.1 --reference /home/gelma/dev/kernel/linus/
>> Cloning into /tmp/3.1...
>> fatal: Reference has invalid format: 'refs/tags/3.1.1.1^{}'
>> fatal: The remote end hung up unexpectedly
>
> The upstream repo reports what look like non-reference references:
>
> $ git ls-remote --tags
> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git | head
> 5dc01c595e6c6ec9ccda4f6f69c131c0dd945f8c	refs/tags/v2.6.11
> c39ae07f393806ccf406ef966e9a15afc43cc36a	refs/tags/v2.6.11^{}
> 5dc01c595e6c6ec9ccda4f6f69c131c0dd945f8c	refs/tags/v2.6.11-tree
> c39ae07f393806ccf406ef966e9a15afc43cc36a	refs/tags/v2.6.11-tree^{}
> 26791a8bcf0e6d33f43aef7682bdb555236d56de	refs/tags/v2.6.12
> 9ee1c939d1cb936b1f98e8d81aeffab57bae46ab	refs/tags/v2.6.12^{}
> 9e734775f7c22d2f89943ad6c745571f1930105f	refs/tags/v2.6.12-rc2
> 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2	refs/tags/v2.6.12-rc2^{}
> 0397236d43e48e821cce5bbe6a80a1a56bb7cc3a	refs/tags/v2.6.12-rc3
> a2755a80f40e5794ddc20e00f781af9d6320fafb	refs/tags/v2.6.12-rc3^{}
> [...]
>
> I've never seen this format before; is this the remote protocol for
> peeled refs or maybe the behavior of an old version of git?

This should be very well documented and has been the output from fairly
early days of ls-remote.
