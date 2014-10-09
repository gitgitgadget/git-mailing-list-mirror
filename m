From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v1] rebase -m: Use empty tree base for parentless commits
Date: Thu, 09 Oct 2014 13:18:42 -0700
Message-ID: <xmqqoatl574t.fsf@gitster.dls.corp.google.com>
References: <5434312E.6040407@redhat.com>
	<bf0e177fbaac91f8c55526729e580fade9f0f395.1412879523.git.bafain@gmail.com>
	<xmqq1tqh6p3y.fsf@gitster.dls.corp.google.com>
	<5436E83A.7070603@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Fabian Ruch <bafain@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 09 22:18:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XcKAk-0004as-EF
	for gcvg-git-2@plane.gmane.org; Thu, 09 Oct 2014 22:18:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751208AbaJIUSr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Oct 2014 16:18:47 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61332 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751060AbaJIUSp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Oct 2014 16:18:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E0BBC13F17;
	Thu,  9 Oct 2014 16:18:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kxFUgF1WdBqM7eMIjxzSgj8+xs8=; b=S7aOFY
	K104mFCf4IJiHNZedyuS4Z35e1A0ftbZ4ZbEVaMOK24gn80fe9zFotNiGi0F+oTg
	V97sxYJH07mlfcf6sfU0F1xIXlT8CI0ClisDG7Vg0Bym3iAZTrSk6NdmMbp+EkQ1
	GZyhU609r7NwEBgS/HIRF4oZ0EvE2kEuJFsFc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CCm3yuxKoIQMrIkB3fZ/dw0jsWAGA0am
	/jPFgqRl1fub36LQ2rZRCqKn15oDAEd9Q6DCXn5OM6YO3oT9S2c7xItkmDgfeDwO
	lQtvm3GfGUQUR0hhPhnvlewU2nnSgLmtQhFSyaF46567tVelCMsSdVZp9nmOldkh
	19up/o2Z/iE=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D80FD13F16;
	Thu,  9 Oct 2014 16:18:43 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 61D4013F15;
	Thu,  9 Oct 2014 16:18:43 -0400 (EDT)
In-Reply-To: <5436E83A.7070603@gmail.com> (Fabian Ruch's message of "Thu, 09
	Oct 2014 21:55:38 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 773C134E-4FF1-11E4-AE2B-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fabian Ruch <bafain@gmail.com> writes:

>> The interface to "git-merge-$strategy" is designed in such a way
>> that each strategy should be capable of taking _no_ base at all.
>
> The merge strategies "resolve" and "octopus" seem to refuse to run if no
> base is specified. The former silently exits if no bases are given and
> the latter dies saying "Unable to find common commit".

That just means these two strategies are not prepared to do a merge
without base (yet).  It does not automatically give license to the
caller to pass a random tree as if it is the merge base the user
wanted to use.

For "resolve", I think it is OK for it to detect that the caller did
not give a common ancestor tree and use an empty tree when merging
(which is what merge-recursive ends up doing internally).

I am not offhand sure if the same is sensible for "octopus", though.
