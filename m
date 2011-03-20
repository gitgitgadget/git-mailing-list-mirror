From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] checkout: clear commit marks after detached-orphan
 check
Date: Sun, 20 Mar 2011 12:05:25 -0700
Message-ID: <7v8vw9wr2i.fsf@alter.siamese.dyndns.org>
References: <20110320090111.GA15641@sigill.intra.peff.net>
 <20110320090918.GB15948@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Mar 20 20:05:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1Nwa-00014U-Nb
	for gcvg-git-2@lo.gmane.org; Sun, 20 Mar 2011 20:05:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751627Ab1CTTFg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Mar 2011 15:05:36 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:63004 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751101Ab1CTTFf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Mar 2011 15:05:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id F31424E73;
	Sun, 20 Mar 2011 15:07:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XsnQbr5CSgggiEPiNh4FWhdE/ns=; b=F+sMxb
	dUDjhnVY2PGNiCZWDVugKYGcrJKHfr/YxvGUHC+YYwdUs46dqQK57b3LjHC3hB+S
	z+XBQeFlQp3Eq5jLS+LMKHqzp+13nitRpM4Ashw7ZejLAgwzequrCOuFhLeV3wKX
	IrLffSreH6OIsprodQ5M3CUkerbahv4Ul/Qlg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=A06Ng1zW31rNpg0MAQ4agH7yVxpz/lxK
	Y61dLRVvuVTogrShc7r8r5J7mCjMhO7JFuiLigX3pt0VJDupfx99+vD4cy3LuVdK
	S0dPsBOnaasOn/myd915caY44IyqmFcwiBs9kzRgL/hbO7dV2otNU/yk8xmaPkZh
	jNmNS/9wJw4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C24CE4E71;
	Sun, 20 Mar 2011 15:07:08 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B03244E70; Sun, 20 Mar 2011
 15:07:04 -0400 (EDT)
In-Reply-To: <20110320090918.GB15948@sigill.intra.peff.net> (Jeff King's
 message of "Sun, 20 Mar 2011 05:09:18 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 40CC2226-5325-11E0-A5F8-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169519>

Jeff King <peff@peff.net> writes:

> This uses for_each_ref to re-find the list of commits we touched in our
> traversal, which feels a little hacky. prepare_revision_walk already
> generates the exact list of tips, but unfortunately writes it
> into revs->commits, which then gets munged by limit_list in the second
> half of prepare_revision_walk. I wonder if it should keep a copy
> elsewhere in revs...

There is a precedence in merge-bases codepath that tries to be reusable by
doing its own clearing (C.f. get_merge_bases_many() and its use of cleanup
parameter). If that codepath becomes cleaner if prepare_revision_walk()
left an extra copy in revs structure, it would be a strong sign that it is
worth doing, I think.
