From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC 0/3] Reflogs for deleted refs: fix breakage and suggest
 namespace change
Date: Sun, 19 Aug 2012 18:01:43 -0700
Message-ID: <7v7gsunzpk.fsf@alter.siamese.dyndns.org>
References: <20120719213311.GA20385@sigill.intra.peff.net>
 <1345310086-20089-1-git-send-email-mhagger@alum.mit.edu>
 <7vboi8rl2q.fsf@alter.siamese.dyndns.org>
 <B88EFDF9-0AB6-49AC-87E5-7515B99AE601@gmail.com>
 <7vehn3rbom.fsf@alter.siamese.dyndns.org>
 <A15D5621-7EF5-4409-967A-0DA20B007899@gmail.com>
 <7v1uj2pysd.fsf@alter.siamese.dyndns.org>
 <9E4BBC27-5B26-4048-93D4-FE02C550F4E2@gmail.com>
 <7vobm6o1cu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: mhagger@alum.mit.edu, Jeff King <peff@peff.net>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Alexey Muranov <alexey.muranov@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 20 03:01:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3GNN-0008DX-AF
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 03:01:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752139Ab2HTBBr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Aug 2012 21:01:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39773 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751217Ab2HTBBq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Aug 2012 21:01:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B11DC96B1;
	Sun, 19 Aug 2012 21:01:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FkZXbQWJJ9DqRbCy1F3a7splDOI=; b=ll6iT9
	/kk/I5G/oHKIny+vom4ZWIFnSrI+bqRpdtrzZkN7XeVfVoE8D2Lw+59wSHs0N2sW
	+59ukHovtCYIoDTLJ1dGgSdCtX5waAddXOMjA9M1XpJfUVc+nD7tQNxCe3ioxgwr
	Jy/BOLeH+xdqomJgdPtByAFZ7xvEAh52EEzWk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QgT/9xo5Vjg+k7VzFNdx6PJluL8hqrhq
	Gi64VqMhc2mTATRDTU7bbFUTk+uprmiaIZE6QeKN0A4L8dj/uKafCfPKcOAWoe+w
	vTUxWoeXXGPZBFM/x9grHUjqQ8tvjrAlpXFHSK98P2wxonE91/ZkcXWsPHKxQcPF
	3edSAJTg/y4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9E48196B0;
	Sun, 19 Aug 2012 21:01:45 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E92F296AD; Sun, 19 Aug 2012
 21:01:44 -0400 (EDT)
In-Reply-To: <7vobm6o1cu.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 19 Aug 2012 17:26:09 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9C6909DE-EA62-11E1-AE82-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203748>

Junio C Hamano <gitster@pobox.com> writes:

> Either Jeff's "refname $name's log goes to logs/graveyard/$name~" or
> Michael's "append ~d to each directory component, append ~f to the
> leaf component" that are already proposed will keep "one file per
> name" property to allow us to open once and efficiently read the
> file through.  Why would we want to see an inferiour alternative
> added to the discussion?

Note that there may be some "other" advantage I am not seeing in the
"directory with timestamp in its name"; if it is a big enough
advantage over what have already been proposed, then that would be a
valid reason why we may want to see it as an alternative (and at
that point, it is no longer inferior).  That is the reason why I
asked "How would that help us in what way?"
