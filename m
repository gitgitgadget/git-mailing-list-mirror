From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Expected behaviour of 'git log -S' when searching in a
 merged/deleted file?
Date: Wed, 22 Dec 2010 10:17:57 -0800
Message-ID: <7vzkrx4qp6.fsf@alter.siamese.dyndns.org>
References: <AANLkTimXk6ei6EAQfvTTfnMzdBqYHkNoaxkEab+atnHd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Jonathan del Strother <jdelstrother@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 22 19:18:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PVTGP-0002PS-7J
	for gcvg-git-2@lo.gmane.org; Wed, 22 Dec 2010 19:18:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752845Ab0LVSSH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Dec 2010 13:18:07 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:35858 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752328Ab0LVSSG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Dec 2010 13:18:06 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D9BA13917;
	Wed, 22 Dec 2010 13:18:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xweTDCckh8s/uU2zleDXitndkLE=; b=Q9yqs/
	Tjjbx1CIcGTyGKmm7/AhGIj5on4G7pZwkD/mnb1p4/8gFzHop/NZVNGwnwSB1uwo
	3/dMxsqOphVZhv2NzsmBGD7O9bQruWjR2VRLRWMLauw/RzHNF9c/T07wXDURLUXV
	jb+fz7lN1w0hSl19dZxDvrI3vqzyK28Tcx2Yg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TS8/jOcg3wtzTltikGFfOw2vJXmQAdt0
	c6rQyRCLGsDPkIkcjFZEhuVM5gkgwME9iP9EfPzfmV4QIU4j19dyKRiUQHkp/dmw
	t1rCynKEiHvCdurUsnFMpYftP+BSnP4cP84WZCumkaUFGlvaG0KiUsdsJwy8TvxX
	gQt+IOrapd4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4F52A3911;
	Wed, 22 Dec 2010 13:18:32 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 6F65F3910; Wed, 22 Dec 2010
 13:18:29 -0500 (EST)
In-Reply-To: <AANLkTimXk6ei6EAQfvTTfnMzdBqYHkNoaxkEab+atnHd@mail.gmail.com>
 (Jonathan del Strother's message of "Wed\, 22 Dec 2010 13\:37\:19 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E21E7796-0DF7-11E0-8E92-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164092>

Jonathan del Strother <jdelstrother@gmail.com> writes:

> I was trying to find a particular string in my project this morning.
> 'git grep mystring' suggested that the string didn't exist in my repo,
> but 'git log -Smystring' turned up a single commit that had added it.
> It took me a long time to figure out that in the past, a branch had
> added that string to foo.c, but a second branch deleted foo.c, and the
> two branches were later merged (deleting foo.c and ignoring mystring).

This is a typical case of the history simplification in action, isn't it?

"log" will give you one possible and simplest explanation of how the
project came into the current shape.  Because side branches with changes
that were discarded before merging it to the history that lead to the
commit you run "log" from do not contribute anything to the end result,
"log" will not traverse the entire side branch when it sees the merge.

Try your "log" with --full-history, perhaps?
