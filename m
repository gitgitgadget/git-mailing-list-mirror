From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Add strtoimax() compatibility function.
Date: Mon, 05 Sep 2011 23:19:18 -0700
Message-ID: <7v62l6b3bt.fsf@alter.siamese.dyndns.org>
References: <1315223155-4218-1-git-send-email-nix@esperi.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nix <nix@esperi.org.uk>
X-From: git-owner@vger.kernel.org Tue Sep 06 08:19:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0p0Q-0006ba-Q4
	for gcvg-git-2@lo.gmane.org; Tue, 06 Sep 2011 08:19:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752546Ab1IFGTW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Sep 2011 02:19:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35067 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752200Ab1IFGTV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Sep 2011 02:19:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7CA7A2CFE;
	Tue,  6 Sep 2011 02:19:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6Hfglk8JRoXeidUVGesSVxqFbvM=; b=wDLRSt
	AmMFkeMGQbz+vcjJqDoyYRZUbZHdzE6yrvSy++L3te5smB2PSS+RbjuuNUA186wh
	FnwNASn99EMSKYJxxVBEPdoyDVYMdA++t1xWt+06jWcgMkJjtJQD0uE4TD4fW+eo
	PJ/rrt6WBGs/gjIqsIxBzfozN4Jn6vmkYUpno=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VEp/M0ULBQyKRBuV5yA8nVgUiVRez68y
	7JyuRBHSVp1dkGNCLu3YB8Ld/CrHaQJoS44/xUkLqDFdy7ubALVfKPUZ2ITmBOdx
	q8D8uvtysOpTIRRXDc6jj7Zdf9BeZnElsucLPA7qaJeADLwG6hHQfWzPowuKjc4M
	wR67y9rrEoM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 74D582CFD;
	Tue,  6 Sep 2011 02:19:20 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 09C132CFC; Tue,  6 Sep 2011
 02:19:19 -0400 (EDT)
In-Reply-To: <1315223155-4218-1-git-send-email-nix@esperi.org.uk>
 (nix@esperi.org.uk's message of "Mon, 5 Sep 2011 12:45:54 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 27F59F42-D850-11E0-9C52-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180771>

Nix <nix@esperi.org.uk> writes:

> Since systems that omit strtoumax() will likely omit strtomax() too,
> and likewise for strtoull() and strtoll(), we also adjust the
> compatibility #defines from NO_STRTOUMAX to NO_STRTOMAX and from
> NO_STRTOULL to NO_STRTOLL, and have them cover both the signed and
> unsigned functions.

What would happen to people who know their systems lack strtoumax and have
happily using NO_STRTOUMAX in their config.mak already? Do their build
suddenly start breaking after this patch is applied and they all have to
adjust to the new name?

Even though "no strtoumax() likely means no strtoimax()" may be a good
heuristics, I am not sure what we would gain by renaming these Makefile
variables. Can't you get the same effect by making existing NO_STRTOUMAX
imply not having strtoimax(), and if you did so, wouldn't it be much less
likely that you would break existing people's build?
