From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] t3600: test rm of path with changed leading symlinks
Date: Thu, 04 Apr 2013 21:59:49 -0700
Message-ID: <7vsj35efne.fsf@alter.siamese.dyndns.org>
References: <20130404190211.GA15912@sigill.intra.peff.net>
 <20130404190621.GA7484@sigill.intra.peff.net>
 <7v6202hykh.fsf@alter.siamese.dyndns.org>
 <20130404195554.GA20823@sigill.intra.peff.net>
 <7v1uaqhwb4.fsf@alter.siamese.dyndns.org>
 <20130404210304.GA25811@sigill.intra.peff.net>
 <7vhajlgabi.fsf@alter.siamese.dyndns.org>
 <20130404232903.GA27128@sigill.intra.peff.net>
 <7vd2u9g9bg.fsf@alter.siamese.dyndns.org>
 <20130405000009.GA27775@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: jpinheiro <7jpinheiro@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 05 07:00:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNylC-0002Bn-OH
	for gcvg-git-2@plane.gmane.org; Fri, 05 Apr 2013 07:00:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752129Ab3DEE7x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Apr 2013 00:59:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59378 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751148Ab3DEE7w (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Apr 2013 00:59:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0B24B11F78;
	Fri,  5 Apr 2013 04:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HcKnts9b1YGjW+T0udVivgr22V0=; b=YevhyR
	OSIcNY3I6itgwK1kB194mJM3QdTrjjyQrL+yaal3al08DzsMLqKuSR9HQBRzQeRJ
	3at/CRIMZEsTBa9Di3oymaF2p/AKaAycbgojBOW8N4lg/OKjIZmLD/5kWvB1gmPT
	O6j3ygYtFkEEjWRq5aN+3TI1s6h0b3PsNa4Bk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=L7GO/cLZ3rUqB3sAroPMm/T2F4zKmHdS
	TGKnzScznoatMYmu3RZdZR2bzv8dnnjhPkJtfUFtAkhDeqAYqKq+7dp6pB8sPCHX
	1bk0Wrgs2fYNXVQhe+aR/tfmcybKPoUA6MUmr5yjixw/IbRalonqNSPE67Q2ZOcZ
	LPA8ePW01d0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F231311F77;
	Fri,  5 Apr 2013 04:59:51 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 74D8D11F74; Fri,  5 Apr
 2013 04:59:51 +0000 (UTC)
In-Reply-To: <20130405000009.GA27775@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 4 Apr 2013 20:00:09 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A606CF9A-9DAD-11E2-BDB5-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220141>

Jeff King <peff@peff.net> writes:

> Here's a replacement for patch 3, then. I wasn't sure if the
> editorializing in the last 2 paragraphs should go in the commit message
> or the cover letter; feel free to tweak as you see fit.

They look fine as they are.

> That means the worst case is not the accidental loss of content,
> but rather confusion by the user when a copy of a file another
> part of the tree is removed.

A copy of a file that is on the filesystem that may not be related
to the project at all may be lost, and the user may not notice the
lossage for quite a while.  A symlink that points at /etc/passwd may
cause the file to be removed and the user will hopefully notice, but
if the pointed-at file is something in $HOME/tmp/ that you occasionally
use, you may not notice the lossage immediately, and when you notice
the loss, the only assurance you have is that there is a blob that
records what was lost _somewhere_ in _some_ of your project that had
a symlink that points at $HOME/tmp/ at some point in the past.

"Exists somewhere, not lost" is not a very useful assurance, if you
ask me ;-)
