From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Okay to invoke merge-recursive with an empty workdir?
Date: Mon, 12 Sep 2011 20:55:12 -0700
Message-ID: <7v4o0h14gv.fsf@alter.siamese.dyndns.org>
References: <CAG+J_Dyz-aeLYn43ARTG4GJz0+zRw_RyDr80bmPCayd9BjzCwg@mail.gmail.com>
 <20110913032900.GA3296@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jay Soffian <jaysoffian@gmail.com>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 13 05:55:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3K6F-0007Ok-4H
	for gcvg-git-2@lo.gmane.org; Tue, 13 Sep 2011 05:55:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754084Ab1IMDzY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Sep 2011 23:55:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35133 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753801Ab1IMDzQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Sep 2011 23:55:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DCAC25C04;
	Mon, 12 Sep 2011 23:55:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XvJVc06A1MgosrhNhN+4cYcfEWE=; b=bhGgt2
	egeeo5ejL1LqGjV7OAd+JS0MtN/B/TkMslDshJ8wbKmGe0qh8h6TdaCUH8hW84AT
	mcSoL+bMAcCBn8VKfygwrFCkkJhlhO4WiZsFeHRBjvDCSSASVIvMk8djLqFoUia6
	KhqC9tGRnfcTf/GoOazsfqgauoZXaNVsPTrb4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pPLIpOFcqXPR9P+uRANo/Q7qTmdyAA1Y
	vsjA2hKNv6X5TQgLVAoMS6B5W0pSSD4ZToBR38MHjL7YMI23cbMknE8rgpEkVTlE
	xg57viFxlnk6E0hgIKU/n3kXTm6lCyHPuX+SO017u+Mw0wMqQYi3X1q0GBUn0z0M
	XYViAmN3gkA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D3F2E5C03;
	Mon, 12 Sep 2011 23:55:14 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 434465C02; Mon, 12 Sep 2011
 23:55:14 -0400 (EDT)
In-Reply-To: <20110913032900.GA3296@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 12 Sep 2011 23:29:00 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2F92F6F2-DDBC-11E0-AE5F-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181265>

Jeff King <peff@peff.net> writes:

> I'm not sure if we were ever using merge-recursive like that. Especially
> with Elijah's latest patches to handle worktree dirtiness better, I
> wouldn't be surprised if it has issues.

I am parsing the above as "seeing the need for such an extensive fix-up,
it is not surprising if the base code is broken", and I have to agree.

In principle, "git merge" should be usable in an empty working tree in the
sense that with correctly populated index the absense of the working tree
file is _meant_ to be treated the same as having the file unchanged from
the index and the HEAD version, but I suspect that "merge-recursive" is
pretty much broken with that regard.

I have much more faith in "git merge -s resolve" performing correctly.
