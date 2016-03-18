From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/2] dir.c: fix dir re-inclusion rules with "NODIR" and "MUSTBEDIR"
Date: Fri, 18 Mar 2016 11:00:06 -0700
Message-ID: <xmqqa8lvr7ix.fsf@gitster.mtv.corp.google.com>
References: <1458218744-15810-2-git-send-email-pclouds@gmail.com>
	<1458219254-16343-1-git-send-email-pclouds@gmail.com>
	<xmqqfuvoy89q.fsf@gitster.mtv.corp.google.com> <56EB8961.70302@fb.com>
	<CACsJy8A2FKn-8nWtK4QPMHDCDYvTZBrQs1RVMApnuejXQis19g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Durham Goode <durham@fb.com>,
	Git Mailing List <git@vger.kernel.org>,
	Mateusz Jakub Kwapich <mitrandir@fb.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 18 19:00:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agyh7-0004qZ-Ua
	for gcvg-git-2@plane.gmane.org; Fri, 18 Mar 2016 19:00:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754805AbcCRSAM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2016 14:00:12 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:51784 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751549AbcCRSAK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2016 14:00:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 202064DF89;
	Fri, 18 Mar 2016 14:00:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6JD3x1eFLkKG37HZ4s88kKqX104=; b=w4q/Wl
	6AFUcY9duAUFjdl5dm8MBE/ObCIoW2n0NDTt+H090N1qLHS10jvGAmbmgBQFs9WH
	fSU8bZl9F04Mx9SBTv8cTy6Siv8RqPE8LrJzD6LTMAGR/c8UkNzDeb+F9tTW2dFe
	/gCGmRWdUfaoTruv2ax8/EshhV7y06PfbViMI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FzelgSAB/PRCA/WcQFbYoHUIalSAKI1X
	I8JCwo9S9KhdAdbJ2Y9iG1fPwIS4OJCtWfeMiHgSbwC/aYf2pjOEfDT+3bCJPPBK
	LV2L+VtnKDXEkrqcJbmme2PGWuP6I3fBW1x/LGKUnHD42S3yYpswKRp6KdlJv10I
	YCo9sd1txr0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 14DF34DF88;
	Fri, 18 Mar 2016 14:00:09 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id AD6294DF7C;
	Fri, 18 Mar 2016 14:00:07 -0400 (EDT)
In-Reply-To: <CACsJy8A2FKn-8nWtK4QPMHDCDYvTZBrQs1RVMApnuejXQis19g@mail.gmail.com>
	(Duy Nguyen's message of "Fri, 18 Mar 2016 12:40:09 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3FFC369E-ED33-11E5-A498-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289237>

Duy Nguyen <pclouds@gmail.com> writes:

> v2.7.3 differs in the way "!" is handled. It does extend reversion
> outside dir1/dir2/show, back to dir1/dir2. While 2.8+1+2 recognizes
> and follows the "/*" and "!dir1/dir2/" pair.
>
> The way I interpreted the rules above, though, may be because I'm just
> trying to defend the current code. Junio, your call on whether to
> revert this whole patch series.

It seems that the more you dig into piling changes on this topic
there is somebody else who comes back with yet another corner case.

At this point in the release cycle, I am inclined to say that we
should revert the whole thing from 2.8-rc.  Even with that plan, we
probably need an extra rc as the reverting a topic this late in the
cycle is something I feel uncomfortable with.

What is the ultimate goal of nd/exclusion-regression-fix topic over
the behaviour before 2.7.0 and after 2.7.1 (there was a regression
in 2.7.0 that was reverted in 2.7.1)?  From the cover letter of the
series:

    Take one was bad and reverted in commit 8c72236. Take two provides a
    more complete solution to the pair of rules

      exclude/this
      !exclude/this/except/this

    3/4 should do a better job at stopping regressions in take 1. 4/4
    provides the solution. I think I have tested (and wrote tests) for all
    the cases I can imagine.

"solution to the pair of rules" hints there are some problem in the
pair of rules, without stating what it is trying to solve.

Isn't the root cause of the issue that treat_one_path() when
deciding if it is worth descending into a directory check if the
directory itself is excluded and returns path_excluded, even if some
paths inside it may have a countermanding ! entries that would match
them?  What if we change that part smarter and allow it to descend?
