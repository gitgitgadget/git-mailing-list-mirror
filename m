From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG?] git checkout $commit -- somedir doesn't drop files
Date: Tue, 17 Sep 2013 13:27:08 -0700
Message-ID: <xmqq61tzxkgz.fsf@gitster.dls.corp.google.com>
References: <20130917190659.GA15588@pengutronix.de>
	<xmqqeh8nxltc.fsf@gitster.dls.corp.google.com>
	<20130917201259.GB16860@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 17 22:27:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VM1rg-0003al-R4
	for gcvg-git-2@plane.gmane.org; Tue, 17 Sep 2013 22:27:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753592Ab3IQU1N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Sep 2013 16:27:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54521 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753271Ab3IQU1M (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Sep 2013 16:27:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A76E24349C;
	Tue, 17 Sep 2013 20:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SCzWV0PPTiMlL0WckvP3r1lBxs8=; b=VgPmbf
	mdOUEhTBdq/nupXvADahLwhVpjEtUESrIFV+dgOO3O7pCIZQ0m7m5R2B4vUeH083
	w9vfigEPbLtCc2aKOnarvHgqBhIE3qO7ZZOTcQIke5LXhDCv/6hF5IBrms2Oo2/a
	Vw0G92aV785OBbX8MnCfiiWEouWISMYGdwREA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Eier+kBaQGrV7S2DSFJt3NVlF/T2kSvx
	JanxTbtH2WwC5wJZf/oo7V7raxP4pyjbFYDquYltc96bpr7/WOzuZxdYnkRctsGe
	P4zTu1I0uao4CQZ3/4TjY1bxKNu2d9Vl1Sz93mczF3NfAy8ZtJ5EKFbp5YvRlosi
	E8fhd71A2oE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9A77B43496;
	Tue, 17 Sep 2013 20:27:10 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EDD2B43495;
	Tue, 17 Sep 2013 20:27:09 +0000 (UTC)
In-Reply-To: <20130917201259.GB16860@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 17 Sep 2013 16:13:00 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 87501EBA-1FD7-11E3-9039-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234920>

Jeff King <peff@peff.net> writes:

> On Tue, Sep 17, 2013 at 12:58:07PM -0700, Junio C Hamano wrote:
>
>> I could argue that the above intended behaviour is suboptimal and it
>> should have been "the resulting paths in the index and the work tree
>> that match the given pathspec must be identical to that of the
>> tree-ish".  In the resulting index or working tree, paths that match
>> "subdir" pathspec in the above result is subdir/a and subdir/b, and
>> that is different from what exists in the given tree-ish (which has
>> only subdir/a and not subdir/b), and under that modified definition,
>> what the current one does is not correct.
>
> Our emails just crossed, but I basically ended up saying a similar
> thing.  Could we simply replace the "update_some" in builtin/checkout.c
> with a two-way merge via unpack-trees?

Would it work to resolve a conflicted index by checking out from a
known tree?

>> I vaguely recall arguing for the updated behaviour described in the
>> above paragraph, and I even might have started working on it, but I
>> do not think we changed this behaviour recently, unfortunately.
>
> Yes, I did some digging and I think it has always been this way, even
> before git-checkout was a builtin.
>
> -Peff
