From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Index format v5
Date: Thu, 03 May 2012 12:03:52 -0700
Message-ID: <7v8vh9f5nr.fsf@alter.siamese.dyndns.org>
References: <CALgYhfMKdbv8TiT4ALDSvD3pSXHEPLWHM09DxYnRmRdBWRjh8Q@mail.gmail.com>
 <87obq5p1t0.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Gummerer <t.gummerer@gmail.com>, <git@vger.kernel.org>,
	<gitster@pobox.com>, <mhagger@alum.mit.edu>, <peff@peff.net>,
	<spearce@spearce.org>, <davidbarr@google.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu May 03 21:04:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQ1Jo-00016e-Ju
	for gcvg-git-2@plane.gmane.org; Thu, 03 May 2012 21:04:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758253Ab2ECTD4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 May 2012 15:03:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46900 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758210Ab2ECTDz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 May 2012 15:03:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3943D78BF;
	Thu,  3 May 2012 15:03:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5y+oELs+KdEcUZBRt6jA8RynHaE=; b=sh/3oH
	N99fwEJoBI4GVKlgwwf3Y3EtWKm6SDqTgMgCDiSw/XfXY4JK5AJCfIyx4qbIR2nJ
	/OFqAD8+9ZaP6eLGhMNwZCmAD2iNcwtQBKrINSDz/Uz8PhE5m3IHhY7RJhBfTORI
	owgJ51PtQw+x0BRdXDPVY4hp9vxYDiX5w3e2I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YFpfjnl+MhJTr3BYn8XjXkrvwdXZB5U/
	3RJOInLDMDljl0gDQTx8GH2cwBvfVVbdIaysSXAUnHtl6a9K1worhrmJUc0THiRK
	9NyBZGmBGvfvz5kYgre8PlR8gQBMrHNr/u+tTAnEpRHJ1C9194ZlyU/EoHvWt1wP
	sQmhTMPvOeA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2EB0978BE;
	Thu,  3 May 2012 15:03:55 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BDE3878BA; Thu,  3 May 2012
 15:03:53 -0400 (EDT)
In-Reply-To: <87obq5p1t0.fsf@thomas.inf.ethz.ch> (Thomas Rast's message of
 "Thu, 3 May 2012 20:16:59 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B9FDA7BC-9552-11E1-98D9-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196942>

Thomas Rast <trast@student.ethz.ch> writes:

> So what's wrong in this thinking?

We tolerate giving occasional false positive "Yes" to "Has this changed?",
but do not allow false negative "No".  So the value st_{ino,dev,uid,gid}
gives us is strictly "these are not likely to change, but if even a single
bit in them change, we need to suspect that it may have changed."  The
primary field that protect us is mtime, and all the rest are more or less
belt-and-suspender safety.
