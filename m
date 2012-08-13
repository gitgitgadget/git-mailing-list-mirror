From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] revisions passed to cherry-pick should be in
 "default" order
Date: Mon, 13 Aug 2012 14:05:20 -0700
Message-ID: <7vehnacxkf.fsf@alter.siamese.dyndns.org>
References: <7vpq6ygcy1.fsf@alter.siamese.dyndns.org>
 <50289e50.a19f320a.5d99.3fdfSMTPIN_ADDED@gmr-mx.google.com>
 <7vtxw6d0ct.fsf@alter.siamese.dyndns.org>
 <CAOeW2eEbe9_m_QSbsJUbWPhf6G17X3vqbh__TCefrB0G2VKXdw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 13 23:05:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T11pM-0001Cb-C5
	for gcvg-git-2@plane.gmane.org; Mon, 13 Aug 2012 23:05:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753809Ab2HMVFZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Aug 2012 17:05:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33901 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752880Ab2HMVFY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Aug 2012 17:05:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4012488F1;
	Mon, 13 Aug 2012 17:05:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/ZGgmG4u7ZeAnGfAVLCM7ghOVU4=; b=f/r391
	83wKWbV3EULyWCHEqufhUPrv0oyOPIpfnGcjuJ9f164UXSl+E78ZKCY8fTiI4Aqv
	+EYdDGghufhQ9lIO1/ath6FFkS39s9ROpuJ8bazm3oTaNEodThcY5ecuH7i/tFw+
	JBPhZq0t0JTkQKZQ8PzfSstI5HvPLHaYUnQCI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oYwn0BLfAWvZA/kH60KNVt6WjzGk+cEL
	CFqIQhtwiuEAU8+4GoRynp93v68+yJdI4e88BuXBik6NZVXK5qoPwm9Gai4eSbtF
	cqS1EEdFXCED0GIMpEisVJ5B/LD2X8hPa93u/GGBaMcRfx7mkKTGypGq7yRruJ9O
	vE4V+5/AjII=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2B79A88F0;
	Mon, 13 Aug 2012 17:05:23 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 916F588EF; Mon, 13 Aug 2012
 17:05:21 -0400 (EDT)
In-Reply-To: <CAOeW2eEbe9_m_QSbsJUbWPhf6G17X3vqbh__TCefrB0G2VKXdw@mail.gmail.com> (Martin
 von Zweigbergk's message of "Mon, 13 Aug 2012 13:50:35 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 97FD72D6-E58A-11E1-9B46-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203364>

Martin von Zweigbergk <martin.von.zweigbergk@gmail.com> writes:

> To connect to the other mail I sent on this thread (in parallel with
> yours), do you think "git cherrry-pick HEAD HEAD~1" should apply the
> commits in the same order as "git cherry-pick HEAD~2..HEAD" (which
> would give the same result if passed to 'rev-list --no-walk' for a
> linear history) or in the order specified on the command line?

Definitely the latter; I do not think of any semi-reasonable excuse
to do otherwise.

> I couldn't find any conclusive evidence of what was intended in
> either log messages or test cases.

Do not take the "multi-commit handling" that was bolted on to
cherry-pick and revert long after these commands with a single
commit form were polished and have become stable too seriously and
its behaviour cast in stone.  There is no reason to believe the
bolted-on part was designed with sufficient thoughts behind it, nor
was implemented with the same competency as the code before it was
introduced.  I recall myself applying these patches after only
cursory review, saying "Meh, I wouldn't do multiple commits anyway,
and bugs found by people can be fixed later" ;-).

It is OK to consider its doneness as "the developers declared
success based on their limited testing; it internally still sorts,
but sorting a range by timestamp happens to yield the correct result
most of the time, and this bug was not found until much later. There
certainly are other bugs, at both implementation and design level,
yet to be discovered." phase of its lifecycle.
