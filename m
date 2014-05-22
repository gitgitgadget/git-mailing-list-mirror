From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git reset for index restoration?
Date: Thu, 22 May 2014 15:29:24 -0700
Message-ID: <xmqqwqddla63.fsf@gitster.dls.corp.google.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Turner <dturner@twopensource.com>,
	Elijah Newren <newren@gmail.com>,
	git mailing list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 23 00:29:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnbUV-0004Ov-83
	for gcvg-git-2@plane.gmane.org; Fri, 23 May 2014 00:29:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751482AbaEVW3b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2014 18:29:31 -0400
Received: from smtp.pobox.com ([208.72.237.35]:56717 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751011AbaEVW3b (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2014 18:29:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 67A6A1A180;
	Thu, 22 May 2014 18:29:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ktyAqObJ+Vzah5iu8PLwuAYl4WA=; b=Kl8QSt
	uTbAkpTFbFRGDvZzbl77ZHPJo0Rz/tGEQW89xYqORRGbYma2aQqZtfu8D0Nt+eSs
	ixOxwSC+2g32flnpACEDAGC3BvF7OI9cCeBCHW83xHKmGtMLKFCByO3VO8xmzZt2
	KtQwy1kLMcHM/4S+VyFu9G9QZ8B8NZi7aNfhA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=O6p3TP5cesZFJDwbQC7V8v3thCZ6LJA5
	LWi6Ysr4H63NPV5lFLncym+QWrADFlOlhs83tWMI84vtBkkg8MT6voEN8oV/27Vm
	iLHaaGRH8iTUyijWkG3cXnA1zPcb9ByipPxar9dkyqUCWTUsM4Tq0at4qZswNMPw
	uriwJJwiVys=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5DCEB1A17F;
	Thu, 22 May 2014 18:29:30 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6D5A31A177;
	Thu, 22 May 2014 18:29:26 -0400 (EDT)
In-Reply-To: <xmqq61kxmphw.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 22 May 2014 15:12:59 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 883951D4-E200-11E3-83DD-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249953>

Junio C Hamano <gitster@pobox.com> writes:

> But at least my understanding has been that "git commit" (no partial
> commit, write the whole index as a commit) which uses the "git
> write-tree" machinery knows which subtree has what tree object name
> and populates the cache-tree fully.

Here is what I tried just now.

    $ rm .git/index
    $ git read-tree HEAD HEAD

Note that a single-tree read-tree will populate the cache-tree and
that is why I am forcing "switch branches" 2-way read-tree here,
which I know will discard the cache-tree fully.

    $ ls -l .git/index
    -rw-r----- 1 jch eng 249440 May 22 15:20 .git/index
    $ git checkout HEAD^0
    $ ls -l .git/index
    -rw-r----- 1 jch eng 249440 May 22 15:21 .git/index

Still the same size, without cache-tree.

    $ git write-tree
    57361c4add61b638dad1c1c2542edf877f515c48
    $ ls -l .git/index
    -rw-r----- 1 jch eng 254383 May 22 15:21 .git/index

The size differences come from the recomputation of the cache tree.
The result is the same if we replace "git write-tree" with a
whole-index commit, e.g.

    $ git commit --allow-empty -m foo

and test-dump-cache-tree seem to see a fully populated cache-tree
after these steps.
