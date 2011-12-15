From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 2/4] test-lib: allow testing another git build tree
Date: Thu, 15 Dec 2011 11:05:01 -0800
Message-ID: <7vaa6toduq.fsf@alter.siamese.dyndns.org>
References: <cover.1323876121.git.trast@student.ethz.ch>
 <94f64a03398829bb9a11c18577efb39d9b153eca.1323876121.git.trast@student.ethz.ch> <7vsjkmpm6g.fsf@alter.siamese.dyndns.org> <3016269.uH93UWUbx5@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Dec 15 20:05:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbGcE-0008Ih-7O
	for gcvg-git-2@lo.gmane.org; Thu, 15 Dec 2011 20:05:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759363Ab1LOTFG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Dec 2011 14:05:06 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49060 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751749Ab1LOTFF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Dec 2011 14:05:05 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1CAAF603A;
	Thu, 15 Dec 2011 14:05:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=X8nqOSF+953uZSg2grKEKPn5+4M=; b=GZFeR4
	XsYKD4ZKXKcuN+vJa5am0R0d62AAj90qcHSxPIh708fQH2ze0AKx/S6FfQSHU0Xo
	NKX1w78KSTXAvc+89hZ/LopCddhf9tfAmz46yH/DuP0dmSliOE3KgXl+pHWvqfJ0
	hlGfnaEIpgPRXNxNbTkvqnr7js9ZUR0gpAmw0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MNjOe1qGBzee9YxVrDCT2dKMgmCRMd3u
	1r1FZoiVWp/TNVcAyM4Vp9Pfu9B0C49IDCMsDadpQNH86UfwQhdt0OAM6r/Uxvxz
	GPFaj9sbTiMH+kfNhlVrCV8qbGD8hEeQS+s7nL3dFyglz8FDTbhW0WNhspOIPhv5
	ec5G1TSuoJo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 14FBB6039;
	Thu, 15 Dec 2011 14:05:04 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 88AA86036; Thu, 15 Dec 2011
 14:05:02 -0500 (EST)
In-Reply-To: <3016269.uH93UWUbx5@thomas.inf.ethz.ch> (Thomas Rast's message
 of "Thu, 15 Dec 2011 11:33:45 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B124FDFA-274F-11E1-A9E7-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187223>

Thomas Rast <trast@student.ethz.ch> writes:

> On Wednesday 14 December 2011 19:07:35 Junio C Hamano wrote:
>> Thomas Rast <trast@student.ethz.ch> writes:
>> > The perf-lib work wants this feature, so we may as well do it for
>> > test-lib in general.
>> 
>> How is this different from what GIT_TEST_INSTALLED already gives us
>> (other than "needs more diskspace to keep another source tree fully
>> built", that is)?
>
> I was scared away by the note that it would use (among others) perl
> libs from the current build tree.  Upon investigation I also see that
> the test-* situation is still not satisfactory.  Some (like
> test-chmtime) are used by the tests for a vital task, and if they ever
> have to be fixed, we would want to use the fixed version in any "test
> an old git" run.  OTOH, others (e.g., test-dump-cache-tree) are linked
> with the rest of the code and serve to test an otherwise not
> accessible part of it, and testing an old git should use them from the
> tested tree.

Okay, so GIT_BUILD_DIR variant should now use everything from the tree
being tested for consistency to improve the situation, right?

Ehh, not quite, if you worry about an old one having broken test-chmtime,
you actively do not want that consistency; how is that addressed?

Not that I think we should address such issues---these standalone programs
tend to be small and simple, so always using them from the tree being
tested is a much better policy than using them from the tree you are
running the tests from.

> The disk space argument is moot IMO:

I was not really worried about "space" (disks are cheap) but more about
mental burden of having to keep multiple build trees in the source area.
Keeping multiple installed versions is already necessary to be able to
quickly respond to "I am using Git version X and this does not work".
