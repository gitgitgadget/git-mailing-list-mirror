From: Junio C Hamano <gitster@pobox.com>
Subject: Re: gitdiffbinstat  -  git diff --shortstat -like output for changes
 in binary files
Date: Fri, 29 Mar 2013 12:30:11 -0700
Message-ID: <7vip4angvw.fsf@alter.siamese.dyndns.org>
References: <5155D864.8040007@famsik.de>
 <20130329184922.GB13506@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthias =?utf-8?Q?Kr=C3=BCger?= <matthias.krueger@famsik.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 29 20:31:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULf0q-0000km-SN
	for gcvg-git-2@plane.gmane.org; Fri, 29 Mar 2013 20:30:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756885Ab3C2TaQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Mar 2013 15:30:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42421 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756806Ab3C2TaO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Mar 2013 15:30:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 01DB1F2A0;
	Fri, 29 Mar 2013 19:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zVo3XDODF8aAl1oEmPTdBGadLGA=; b=iDyMuD
	+GT7aYFEpWaJl/NBx4Luv1+vDrueGadH6uW/I00uZimRsmR+8esJVIdJwGT9YCPS
	HoxLpARzLTP2OZkc8bDpgbs3x4613TIegLUCRffuoTEpN+UQE/yPXbuNN9a9NFTw
	aRR0qzRVOAzS3mq0aOhmafQRxzJtYm2sd3GZE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YnkqxUKqimlfrvowzTdqxO6NXBlm+zWp
	gGHqdWfo1m4IaBJzypV4yvSY5cOirL9tVVqbCqZCEckf8YeUHFA2JMmTtCpIPlHy
	xhq8M/Pzj33cAAfDMisCoUrAO4Shrc++ITYFjMI83q8ZkuSFVuLXupYFnjNkRAGU
	oNYUkTbr32Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EDA23F29F;
	Fri, 29 Mar 2013 19:30:13 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5E5A9F29D; Fri, 29 Mar 2013
 19:30:13 +0000 (UTC)
In-Reply-To: <20130329184922.GB13506@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 29 Mar 2013 14:49:22 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 13D10F9C-98A7-11E2-8469-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219523>

Jeff King <peff@peff.net> writes:

>> I use git mostly for game-development which means I have to deal with
>> a lot of binary files (images, sound files etc).
>> 
>> When I came to a point where I had run image optimization on a
>> branch, I wanted to know of course how much smaller the new branch
>> was in comparison to master.
>> Problem was that 'git diff --stat' would only summerize
>> per-binary-file size changes and 'git diff --shortstat' did skip the
>> binary files entirely.
>
> Have you tried "--summary"? Combined with --stat (or --shortstat) I
> wonder if it would get you closer to what you want.

"diff" is not about "how much did my project grow or shink".  If you
moved one block of lines up or down in the same file, you will see
double the number of lines moved in the statistics.

On the other hand, the use case to measure how much it helped to run
png optimizers only cares about the total size.

I do not think it is a good match to present the "binary stat" next
to the textual diff stats in the first place.  Adding two numbers do
not give us any meaningful number.

It is an interesting use case, but it just is not a problem core
Git, which is a source code management system, particularly wants to
bolt on a solution for, that does not mesh well with other parts of
the system.

We do want to make sure that people who want to deal with binaries
have access to raw statistics, so that they can build their solution
on top of, though.  "ls-tree -r -l" gives byte-size of each blob,
and the attribute system can let you tell which paths are binaries.
