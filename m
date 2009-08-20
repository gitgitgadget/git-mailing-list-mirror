From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make 'diff C^!' show the same diff as 'show C'
Date: Thu, 20 Aug 2009 16:01:27 -0700
Message-ID: <7v1vn6ozso.fsf@alter.siamese.dyndns.org>
References: <86d1201d8adf53c1f48c0f3526d8e81475b18244.1250806019.git.trast@student.ethz.ch> <7vab1up1gz.fsf@alter.siamese.dyndns.org> <20090820223424.GA5843@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	=?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	Abhijit Menon-Sen <ams@toroid.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 21 01:02:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MeGdw-0004t8-Gg
	for gcvg-git-2@lo.gmane.org; Fri, 21 Aug 2009 01:02:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755484AbZHTXBn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Aug 2009 19:01:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755428AbZHTXBm
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Aug 2009 19:01:42 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:37848 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755294AbZHTXBm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Aug 2009 19:01:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9751731365;
	Thu, 20 Aug 2009 19:01:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vGiGtCOjEwnr6pTXSkkg9eCfcaU=; b=cBu/IZ
	XN18LzvH3Zx+j6uwjG86lOhHaiJjirmAxPFDUiS5WiPSfFtNQSTFJCPhtG/Bg1DS
	CEa838f8NNFtGsF7Ucu4PJ1Tj9IdD7ynKlN6o9xXC9DCDP74I0+ZYQkfH7oXNSIn
	VjaKHjrVQW6n46EK7Svk3e3y+WfbLxz4rm8ys=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=u7L4Tj4dP77hwjh+qg1DjS7oD8HEXiWZ
	e5WcZaErrLw1Csfmylg38CdwZ6skc9x4g6nTxpPLrcRwY7b6FBmRLFE+2D+IKxMP
	tJV7PJzXySn+yliQXt4doQeABt4h0Rq651AeeyvYDVF+Gu3KdVKJlFjcvq8ESKlR
	yzZ9VYlPayI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 519FA31364;
	Thu, 20 Aug 2009 19:01:37 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 1751A31360; Thu, 20 Aug 2009
 19:01:28 -0400 (EDT)
In-Reply-To: <20090820223424.GA5843@coredump.intra.peff.net> (Jeff King's
 message of "Thu\, 20 Aug 2009 18\:34\:24 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 69F8820C-8DDD-11DE-AF00-3142836986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126657>

Jeff King <peff@peff.net> writes:

> On Thu, Aug 20, 2009 at 03:25:16PM -0700, Junio C Hamano wrote:
>
>> Thomas Rast <trast@student.ethz.ch> writes:
>> 
>> > Ideally, we'd like 'git diff C^!' to show the same diff that 'git show C'
>> > does (with log.showroot enabled).  This gives easy access to a readable
>> > diff for the commit, irrespective of how many parents it has and without
>> > any trickery to remove the commit message from the git-show output.
>> 
>> Not interested yet, as the "git show" discussion is not convincing at all.
>> 
>> Is the message annoying enough to warrant this change?
>
> I thought the same thing when I saw his message, but reading further,
> the current output is nonsensical. So if not this patch, we should
> probably at least complain about bogus input and die (though if it is
> easy to make it work, why not...).

Ok.
