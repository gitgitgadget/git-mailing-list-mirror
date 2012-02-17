From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/3]
Date: Fri, 17 Feb 2012 15:28:51 -0800
Message-ID: <7vk43lqbt8.fsf@alter.siamese.dyndns.org>
References: <7v7gzmxw78.fsf@alter.siamese.dyndns.org>
 <cover.1329472405.git.trast@student.ethz.ch>
 <7v62f5v1d1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>, Jehan Bing <jehan@orb.com>
X-From: git-owner@vger.kernel.org Sat Feb 18 00:29:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RyXEt-0001Et-1R
	for gcvg-git-2@plane.gmane.org; Sat, 18 Feb 2012 00:29:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755317Ab2BQX24 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Feb 2012 18:28:56 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60095 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755218Ab2BQX2y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Feb 2012 18:28:54 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8D1617AFB;
	Fri, 17 Feb 2012 18:28:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Q3AsdVtPG4szHuZvywdkWPCTl4I=; b=obu8oY
	OWyAuQpmiyctawJJspVX5HcfqG178yt+1GOfzBsTFutbRSE96F1iLVtIsoBFp1lX
	G4jZZt7VQ2dnPmCewF3S4ODZ5YOjx9b9VERBwUWmbEjlBaupVz9A8enR9mzZaYxT
	Vjy3gMJ1hDZveaWxwHCgGPWVrODXbCr/6f6o4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=R9TkAPX2GEbE9oy+5efTH8JfiS/3Bzzu
	YTYzqvyhgXx9PJQzJLTExITBt1NVQAXRu4GoavsiTaI+gDoxywHGLDq1Vpg89Yl/
	PXXBLSOMbQLVRW/dSf+Hcq6VPKaqhim1xAnwigTqW/FSy9vm6GWe858N+vINAWxY
	ZfvotkQafcw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 845087AFA;
	Fri, 17 Feb 2012 18:28:53 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F0E6A7AF9; Fri, 17 Feb 2012
 18:28:52 -0500 (EST)
In-Reply-To: <7v62f5v1d1.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 17 Feb 2012 09:03:22 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 274040B6-59BF-11E1-B646-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190986>

Junio C Hamano <gitster@pobox.com> writes:

> Thomas Rast <trast@student.ethz.ch> writes:
> ...
> I seem to be getting intermittent test failures, and every time the
> failing tests are different, when these three are queued to 'pu'. I didn't
> look for what goes wrong and how.

False alarm. I suspect that it is jb/required-filter topic that is causing
intermittent failures from convert.c depending on the timing of how fast
filter subprocess dies vs how fast we consume its result or something.

Repeatedly running t0021 like this:

    $ cd t
    $ while sh t0021-conversion.sh ; do :; done

under load seems to make it fail every once in a while.

test_must_fail: died by signal: git add test.fc

Are we dying on SIGPIPE or something?
