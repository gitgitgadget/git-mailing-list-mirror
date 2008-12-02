From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/6 (v2)] upload-pack: send the HEAD information
Date: Mon, 01 Dec 2008 18:20:52 -0800
Message-ID: <7v1vwrqpvf.fsf@gitster.siamese.dyndns.org>
References: <1228140775-29212-1-git-send-email-gitster@pobox.com>
 <1228140775-29212-2-git-send-email-gitster@pobox.com>
 <1228140775-29212-3-git-send-email-gitster@pobox.com>
 <1228140775-29212-4-git-send-email-gitster@pobox.com>
 <1228140775-29212-5-git-send-email-gitster@pobox.com>
 <1228140775-29212-6-git-send-email-gitster@pobox.com>
 <20081201174414.GA22185@coredump.intra.peff.net>
 <7vk5ajqs63.fsf@gitster.siamese.dyndns.org>
 <20081202015924.GA6529@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 02 03:22:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7KuX-0002rS-4J
	for gcvg-git-2@gmane.org; Tue, 02 Dec 2008 03:22:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753875AbYLBCVb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2008 21:21:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753825AbYLBCVa
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Dec 2008 21:21:30 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:59996 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753434AbYLBCV3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2008 21:21:29 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 0B52417E89;
	Mon,  1 Dec 2008 21:21:28 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 9987B17E80; Mon, 
 1 Dec 2008 21:20:53 -0500 (EST)
In-Reply-To: <20081202015924.GA6529@coredump.intra.peff.net> (Jeff King's
 message of "Mon, 1 Dec 2008 20:59:25 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: ECC8B1BE-C017-11DD-816B-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102103>

Jeff King <peff@peff.net> writes:

>   (1) If there are multiple symrefs to report, we have to keep
>       re-sending the server capabilities (I think you mentioned this in
>       the subthread with Shawn).

This is nothing new, so there is nothing to complain about here.

The ref advertisement section is not very extensible to begin with and we
should consider ourselves lucky that Sergey Vlasov found the hole
(cf. $gmane/10710) we are exploiting to carry "server capabilities"; I do
not think we should nor can stuff any more than absolute minimum in the
section.

>   (3) If HEAD doesn't point to a valid object, we have no place to put
>       the symref. Or is it kosher to say
>
>         0000000000000000000000000000000000000000 HEAD\0...\0refs/heads/master
>
>       ? I think it would be nice eventually to be able to clone a HEAD
>       pointing to yet-to-be-born branch.

I think sending 0{40} would break older clients, but older clients cannot
clone from an empty repository anyway, so that should not be so bad.  I
however do not think it is such a big thing to be able to clone void
anyway.

You just have to train yourself to announce that your repository is
clonable _after_ making it actually clonable.
