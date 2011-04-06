From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 2/2] stash: drop dirty worktree check on apply
Date: Wed, 06 Apr 2011 16:01:31 -0700
Message-ID: <7vfwpvgf1w.fsf@alter.siamese.dyndns.org>
References: <20110405212025.GA3579@sigill.intra.peff.net>
 <20110405212314.GA3613@sigill.intra.peff.net>
 <7vvcysl5pz.fsf@alter.siamese.dyndns.org>
 <20110405221827.GA4123@sigill.intra.peff.net>
 <20110405225038.GB7358@sigill.intra.peff.net>
 <20110405230245.GA7631@sigill.intra.peff.net>
 <7v7hb8l23q.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Brian Lopez <brian@github.com>
To: Jeff King <peff@github.com>
X-From: git-owner@vger.kernel.org Thu Apr 07 01:01:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7bjU-0002C6-Rd
	for gcvg-git-2@lo.gmane.org; Thu, 07 Apr 2011 01:01:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756769Ab1DFXBq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2011 19:01:46 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:53674 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756708Ab1DFXBp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2011 19:01:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 29E1B5D8A;
	Wed,  6 Apr 2011 19:03:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=L723tIHqEkNr8xJTRyCs27H8M1s=; b=IMyabx
	b6hi2J8Gapg2vtzG6ynuk7iLyEJ6K45LF+PfEO9kEZz68GiHVGvRe5ZDZM3KscBl
	cMpcQJdIpk2xY9tWzr710XzV0l1fOROKmufFv4RYfMCNDSfRJHwXyEneD6v352/B
	Ow1is8qlTcwwWgsGbic0Gr7QBJRy4SOwb7EOQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BZo0lOh+xTuPL0lmZpmWsMEgY7bOt5Hg
	GoHgrlmEL5c8MiQcwZSTOiia59MouqBuiwEBMHGXM/YNW/6+GJeDsGgh/NTmHEYu
	/mq0hXbQ3oS6wX1OmYlSI9p3vobfxacTAJpGMAt20oVZpNoPNHhFVm4m5cRAP8ws
	gdguJ+Fjqkc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E78FE5D89;
	Wed,  6 Apr 2011 19:03:31 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 8D5F25D86; Wed,  6 Apr 2011
 19:03:27 -0400 (EDT)
In-Reply-To: <7v7hb8l23q.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 05 Apr 2011 16:17:45 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 17A2235C-60A2-11E0-9C04-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171025>

Junio C Hamano <gitster@pobox.com> writes:

>> So perhaps there is no broken case at all, and it was just a matter of
>> being overly conservative from the beginning.
>
> Perhaps.
>
> If we are going to treat this as another mergy operation, we should at
> least still make sure that the index is clean (i.e. "diff --cached" is
> empty), I think.

Please disregard this.  

If the user is doing "stash apply" without --index, it is Ok for the index
to be different from HEAD.  On the other hand, if the "stash apply" is
used with --index, even if the result conflicted in the working tree and
then resolution gets marked with "git add" for conflicted paths, it is Ok
to have a path that is unrelated to the "stash apply" already added to the
index.

So I don't think there is no point to insist that the index is clean. I
was just confused and was thinking about the "git merge" (where we must
have a clean index, as we are going to commit the index as the result of
the merge with conflict resolution).
