From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 21/33] repack_without_ref(): write peeled refs in the
 rewritten file
Date: Mon, 15 Apr 2013 10:39:59 -0700
Message-ID: <7va9ozvgk0.fsf@alter.siamese.dyndns.org>
References: <1365944088-10588-1-git-send-email-mhagger@alum.mit.edu>
 <1365944088-10588-22-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Heiko Voigt <hvoigt@hvoigt.net>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Apr 15 19:40:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URnO0-0006ig-Ba
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 19:40:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934526Ab3DORkD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 13:40:03 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41044 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932679Ab3DORkC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 13:40:02 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0BFB615CE1;
	Mon, 15 Apr 2013 17:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=19xG99oN5e2DYrw0qb1XAijzw2s=; b=pcohvbYpecmlsdTWzKlU
	B/nnXdppyqEDpYC512IESFTNm2WaHOz1KxZKJSZxMdBsvGX48F2W3Y16cNkYaSI2
	zuxPUZnc+g55COkUUO/zJbetI0HgHgUq5BToNUOQEVvywRIfGb2u6D6E1CvTwLe+
	wKvzYNRSWyA2lK3y5siv9Oc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=kHrhQTayS3wjcwgCDwvVy6cKfTUNCHiX4HsaqtFaF8Eu1i
	PRGUHeGl+0mpO/2P4O2xBMALukFIK/7jwmj2MiJAgMCH2eNqrCyVuVoeApHyCdyp
	b/fMHaAPBFo5OvxE5FUL3FV0/jiiMmDawj5sn7mnoeDWdSn8Dc+26c0PANXmw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 03BB215CE0;
	Mon, 15 Apr 2013 17:40:01 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7F5D415CDF; Mon, 15 Apr
 2013 17:40:00 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7F438E2C-A5F3-11E2-83BD-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221266>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> When a reference that existed in the packed-refs file is deleted, the
> packed-refs file must be rewritten.  Previously, the file was
> rewritten without any peeled refs, even if the file contained peeled
> refs when it was read.  This was not a bug, because the packed-refs
> file header didn't claim that the file contained peeled values.  But
> it had a performance cost, because the repository would lose the
> benefit of having precomputed peeled references until pack-refs was
> run again.

Good.

> Teach repack_without_ref() to write peeled refs to the packed-refs
> file (regardless of whether they were present in the old version of
> the file).
