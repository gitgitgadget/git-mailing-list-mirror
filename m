From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [GSoC] Designing a faster index format - Progress report week 13
Date: Tue, 24 Jul 2012 09:58:08 -0700
Message-ID: <7vy5m9f65b.fsf@alter.siamese.dyndns.org>
References: <20120716203300.GA1849@tgummerer.surfnet.iacbox>
 <7vwr23zb65.fsf@alter.siamese.dyndns.org>
 <20120717082452.GC1849@tgummerer.surfnet.iacbox>
 <500C1AA9.4000306@dewire.com> <7vfw8jsk5o.fsf@alter.siamese.dyndns.org>
 <87629fvaxz.fsf@thomas.inf.ethz.ch> <7vr4s3pkqr.fsf@alter.siamese.dyndns.org>
 <500DD05D.8030708@dewire.com> <87d33lqsrp.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Thomas Gummerer <t.gummerer@gmail.com>, <git@vger.kernel.org>,
	<mhagger@alum.mit.edu>, <pclouds@gmail.com>,
	JGit Developers list <jgit-dev@eclipse.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Jul 24 18:58:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StiR7-0001ZG-LT
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jul 2012 18:58:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754366Ab2GXQ6M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jul 2012 12:58:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58209 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753780Ab2GXQ6L (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2012 12:58:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D99216525;
	Tue, 24 Jul 2012 12:58:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rJLMBF6O94n0tBMVUR0Lh2ZXuus=; b=i/5fb6
	TnzWTftLjjVfx/khMkLKJ/ZuO1slPvu+oZJihAPWXlNjERIrq/tcyOi7oFplNh9i
	vXYddPySr8VxKF2K7nY8JCsOQ44bRgeWV+Zlg/blXJEZqkkcJ5cCCQW9WW2yoa2I
	xkq5lsgr+PnlB5bo4bBA0yBEezZrRkbPHTiow=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BFts8hVHKr3udpdax+1ow4RXdCDdx0iH
	oMqEIFoGlqg8MI756FPLhhKlYpChM4gFIKKOgZ3Mst4yNDb1WQ3lVUj8zSloYssQ
	0/Ywp5YdRZBdLedRtxVHDWb5tWJ0P3n0Q5AgZwGsM44TaUz0Dk/OsZz6evtVd3Mt
	7yAnWncVUGQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C76736524;
	Tue, 24 Jul 2012 12:58:10 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3F9856523; Tue, 24 Jul 2012
 12:58:10 -0400 (EDT)
In-Reply-To: <87d33lqsrp.fsf@thomas.inf.ethz.ch> (Thomas Rast's message of
 "Tue, 24 Jul 2012 13:54:02 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BF9472FC-D5B0-11E1-BA72-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202046>

Thomas Rast <trast@student.ethz.ch> writes:

> Junio's index-v4 was a speed boost mainly because it cuts down on the
> size of the index.  Do we want to throw that out?

That's pretty much orthogonal, isn't it?

The index-v4 is merely to show how a stupid prefix compression of
pathnames without nothing else would reduce the file size and I/O
cost, in order to set the bar for anything more clever than that.

I thought that this discussion is about keeping, squishing, or
discarding part of the cached stat info, and nobody is suggesting
what to do with the prefix compression of pathnames.
