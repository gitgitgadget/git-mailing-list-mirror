From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG?] Patches created with 'diff.noprefix=true' don't 'git apply'.
Date: Tue, 06 May 2014 11:10:13 -0700
Message-ID: <xmqqa9aug4my.fsf@gitster.dls.corp.google.com>
References: <CAO8RVvdgN3U5hUEsJjYY9urfeVUDWwHiEur4NQp=H93W37RRnw@mail.gmail.com>
	<20140501024042.GX9218@google.com>
	<CAO8RVveV4SgXmJzWpYnyB3rnQALQkrrLNtLL5Ej5Y9Mjjekmmw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git <git@vger.kernel.org>
To: Nathan Collins <nathan.collins@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 06 21:46:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Whjot-00016N-RF
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 20:10:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751339AbaEFSKT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2014 14:10:19 -0400
Received: from smtp.pobox.com ([208.72.237.35]:61787 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752197AbaEFSKS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2014 14:10:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9C9E81333A;
	Tue,  6 May 2014 14:10:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rcVh8SkdnkfyAqhUSrj5nFacqxU=; b=A9s3wA
	cQDrL8vq0Nbk390muvzfT8u6OEb5OXSghCbpWKq0DUVsPDpNmMd+yBONbDi3OeX0
	TxuzEcKdNTNvMcAWWidLEJJqDZElunNPW9xH4TafmUUWFAJfbcfw7x4dA8fEBNuQ
	475KWfxc999KMu9ut85D0c/hI0cpNxG54IGSk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=m6n76zN7pjvu2GqYFRMlBExoOUn1ur8y
	/zw0z/ZSgmjq0IOIHWDvkA1iXJL9X5py/MS7X850G2Y9aBtdko9h+bgz3bS1jsNs
	duueaoDcd5Q/4U0A00ZWv1yhdrp9Gi4kqKxjaa64UdRAG5I58muIoR3sp7oEPdCZ
	JL/CtGKvq3g=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 924F313337;
	Tue,  6 May 2014 14:10:17 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 3E44713335;
	Tue,  6 May 2014 14:10:15 -0400 (EDT)
In-Reply-To: <CAO8RVveV4SgXmJzWpYnyB3rnQALQkrrLNtLL5Ej5Y9Mjjekmmw@mail.gmail.com>
	(Nathan Collins's message of "Mon, 5 May 2014 18:33:28 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: AC61AC3C-D549-11E3-A75C-9CEB01674E00-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248224>

Nathan Collins <nathan.collins@gmail.com> writes:

> Hmmm. Maybe a warning that the patch is expected to be in '-p1'
> format, and that setting 'diff.noprefix=true' makes some commands
> generate '-p0' patches?

"some"?  Do you have exceptions in mind?

> But I worry this would just confuse / distract
> the people that don't have 'diff.noprefix=true' set,

Probably.  But that would suggest that the place to improve the doc
is for diff.noprefix configuration variable, no?

> Better I think would be for 'git apply' to be
> smarter, as you suggest below.

As it is a plumbing command behind "add -p", "am", and friends, I
would hate to see "git apply" pretend to be smarter than its users.
When the user tells it to use -p0, it shouldn't guess, and when the
user tells it to use -p1 by not giving any -p$n, it shouldn't guess.

As long as we make it clear "git apply" without any explicit -p$n
means the user is telling it to do -p1 in its documentation, I think
it would be fine.

>> I personally think setting diff.noprefix is not very sane (it also
>> breaks "patch -p1"), and I suppose I should have been louder about
>> that when it was introduced.

I share the same feeling ;-)  But the boat has sailed, so the best
we could do is to warn in its doc (i.e. where diff.noprefix is
described) about its pitfalls.
