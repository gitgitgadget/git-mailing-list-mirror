From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git reset for index restoration?
Date: Thu, 22 May 2014 16:14:34 -0700
Message-ID: <xmqqsio1l82t.fsf@gitster.dls.corp.google.com>
References: <1400775763.1933.5.camel@stross>
	<CABPp-BHtYnput7SiAbnqUjpDibTi5o_2MAXfSj17fCdKSC7Hjg@mail.gmail.com>
	<1400782642.18134.8.camel@stross>
	<20140522183930.GB1167@sigill.intra.peff.net>
	<1400785669.18134.21.camel@stross>
	<20140522190959.GA18785@sigill.intra.peff.net>
	<20140522193030.GA22383@sigill.intra.peff.net>
	<xmqqha4hmr9d.fsf@gitster.dls.corp.google.com>
	<1400795586.18134.40.camel@stross>
	<xmqqd2f5mq5h.fsf@gitster.dls.corp.google.com>
	<1400796077.18134.41.camel@stross>
	<xmqq61kxmphw.fsf@gitster.dls.corp.google.com>
	<xmqqwqddla63.fsf@gitster.dls.corp.google.com>
	<1400799746.18134.48.camel@stross>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	git mailing list <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri May 23 01:14:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WncCI-0004TN-KD
	for gcvg-git-2@plane.gmane.org; Fri, 23 May 2014 01:14:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753286AbaEVXOp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2014 19:14:45 -0400
Received: from smtp.pobox.com ([208.72.237.35]:65078 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753201AbaEVXOk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2014 19:14:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7DA841AC83;
	Thu, 22 May 2014 19:14:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Rtwh03oT0Jp0TNAPOmxsDJmKJq8=; b=ovhkEn
	vIlaCZ7/+RP/oZ7lNMGrpAyAl99bFhxUh5Sut5XhdGPbXa1VwjlRBSAZxohH5rHE
	WRmU3u0e1zbdZIxmkD3TlDgnbLV6nQrfHLlDvbJswW5UnNgRzhLVtdHutoGEQCpg
	i+3WYEk97jgF1sVbkiiUsIbOWvJ4AQQA6DROQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aWPorFZcHCmqZzmeXCOlDm1ow99L7nRx
	fRqE19ALeAA5Lbr1bsMCTkNI5Yd0+j9hDSddMRd/E41L3bUaUXYcp++L/7IzJgom
	GvHgYwyyEPUBIz7scGZ9XmvjoepmmK3URwVcbIf82s3xIclOlJUSLcxjdPOzYDX5
	Ssv0aHugnwQ=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 742341AC82;
	Thu, 22 May 2014 19:14:39 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 3B9551AC7F;
	Thu, 22 May 2014 19:14:36 -0400 (EDT)
In-Reply-To: <1400799746.18134.48.camel@stross> (David Turner's message of
	"Thu, 22 May 2014 19:02:26 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D76382E2-E206-11E3-BBAC-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249960>

David Turner <dturner@twopensource.com> writes:

> ... I still believe that the cache-tree behavior would be
> suboptimal, ...

I do not think anybody doubts that "suboptimal"-ness in this thread.
As you saw the "incremental" thing from Peff and my responses to it,
there may be more things we could be doing.  It just has not been at
a ultra high priority, and if we can choose only one change from
possibilities, losing the entire cache-tree upon switching branches,
like in my two-way read-tree example, would be the thing that would
give us the most benefit if we somehow change it.

That however is unfortunately not a low-hanging fruit.  The two-way
merge machinery we use for switching branches wants to populate the
index one entry at a time, without having any point where you can
say "OK the result in this subdirectory will exactly match this
subtree" which would allow us to say "prime the cache tree for that
subdirectory with this tree object".
