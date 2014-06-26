From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/8] commit: provide a fast multi-tip contains function
Date: Thu, 26 Jun 2014 12:26:03 -0700
Message-ID: <xmqqd2dv4gms.fsf@gitster.dls.corp.google.com>
References: <20140625233429.GA20457@sigill.intra.peff.net>
	<20140625234730.GF23146@sigill.intra.peff.net>
	<xmqqtx774i1r.fsf@gitster.dls.corp.google.com>
	<xmqqha374gx3.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 26 21:26:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X0FJI-0001zt-Od
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jun 2014 21:26:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751139AbaFZT0N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2014 15:26:13 -0400
Received: from smtp.pobox.com ([208.72.237.35]:63201 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750849AbaFZT0M (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2014 15:26:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 64FCE22C53;
	Thu, 26 Jun 2014 15:26:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yqNx2M4bVoAY9lyOXcr8ML1cRyI=; b=V5/uaq
	ZBkGzB9jayEk3J6rHxVOtqfsFq9eyRj+iyouYEc1YyCw61gH2tess04Ng/Wvlk1K
	29jHRlru4oo9NVMqcEU8lujGoasSnIDo5pXepTNw1uL1DUNBT5vZgEziHJ1DEJ8p
	GULuSGrvPtN83BchxkqrJIigwwOHedz074Y0M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CQvhoT/82GdKZ5/fdNwD56HtIOeoc+Qe
	ii8kscTreHz2ORWa2JZ5iQO0URHnFRacESxAWOvJYO9bbnVi9qhEgLSU39bZKL7r
	Yg6qJauqH09c8P6UaaYGgEH61kQFbqKlk6+69a9kz+0/hHUwu6ZtJZtZMOlKECdi
	8e9n8dMFMJs=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5C7DB22C52;
	Thu, 26 Jun 2014 15:26:05 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6875122C4B;
	Thu, 26 Jun 2014 15:26:00 -0400 (EDT)
In-Reply-To: <xmqqha374gx3.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 26 Jun 2014 12:19:52 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B495A110-FD67-11E3-965F-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252521>

Junio C Hamano <gitster@pobox.com> writes:

> What does it mean to look for "branch --with $commit1 $commit2"
> (i.e. more than one in the Left set)?  If we are trying to see which
> branches reach _both_ of these commits, then replace the ablve with
> "if a commit is already painted as reachable from both $commit{1,2},
> then painting it with any branch bits is futile---its parents will
> never reach either $commit1 nor $commit2", so the additional
> termination condition will be "If left bits are full, then stop".
>
> I do not know how you can optimize the traversal if you are trying
> to see which branches reach at least one of these commits, though.

By the way, don't we do 80% of this already in show-branch?
