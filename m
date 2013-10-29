From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/2] merge-base: teach "--fork-point" mode
Date: Tue, 29 Oct 2013 13:11:25 -0700
Message-ID: <xmqq61sfet1u.fsf@gitster.dls.corp.google.com>
References: <CAPig+cQrBMMqSmOk0GSZJ9PTHNt-t+vuOG2Aq=7VTR1EZSeLsw@mail.gmail.com>
	<xmqq61smmkc0.fsf@gitster.dls.corp.google.com>
	<CAPig+cQ2tWFXX-RYnUrHEZCaqaPV6ZwgoPfiNPv9P1jFNTGEYg@mail.gmail.com>
	<xmqqwql2l3ln.fsf@gitster.dls.corp.google.com>
	<xmqqsivql37i.fsf_-_@gitster.dls.corp.google.com>
	<526A19CA.9020609@viscovery.net>
	<xmqqmwlxjnq6.fsf@gitster.dls.corp.google.com>
	<xmqq61sljakf.fsf_-_@gitster.dls.corp.google.com>
	<20131026090034.GH10779@serenity.lan>
	<xmqq38nlfbu5.fsf@gitster.dls.corp.google.com>
	<20131029085111.GA24023@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Tue Oct 29 21:11:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbFdU-0004vN-TY
	for gcvg-git-2@plane.gmane.org; Tue, 29 Oct 2013 21:11:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752299Ab3J2UL3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Oct 2013 16:11:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56112 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752001Ab3J2UL2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Oct 2013 16:11:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D66474C859;
	Tue, 29 Oct 2013 20:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DovYQvBfOF2Gt5Fz8Qu8qMvn3+E=; b=Y3UMtb
	HhmrbTZMkkoRyexrkCgy1KZx1M/LiJ0V4+/uFAqfU5iJSpkAYSg29cObJjQ7ulX6
	A9eXJ2gs/iucpBcnZCuN2mkcpirI1t8fuXubC881ABVL8qKQACpSEsSc+kzCi52M
	2NjiLNVYdSoU8KePe/oA1K3BPU/YboqGTZeg4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yadx22ZiVJK2D/sXOYq7MDY4hQtvtWwK
	j7ne0xsxzBgBDqmjS58bYVeYSRUH88yXVDlmLCNMB58qbfXRvz9OOCfO0aYZkyTx
	TvGtRMZaucU7DUmzkYDNBnJ3puJHpnkS2+i+NUa/2EWihPVZuM9KQ1Ey1jtoDEvS
	4VR7yNT1itk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C774F4C858;
	Tue, 29 Oct 2013 20:11:27 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 122724C853;
	Tue, 29 Oct 2013 20:11:27 +0000 (UTC)
In-Reply-To: <20131029085111.GA24023@serenity.lan> (John Keeping's message of
	"Tue, 29 Oct 2013 08:51:11 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 4AB1556C-40D6-11E3-B023-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236948>

John Keeping <john@keeping.me.uk> writes:

> OK - given this reasoning I agree that --fork-point makes sense.
>
> I think this would have been clearer if the short description said
> something like:
>
>     Find the point at which a branch forked from another branch; this
>     does not just look for the common ancestor of the two commits but
>     also takes into account the reflog of <ref> to see if the branch
>     forked from an earlier incarnation.

That's much easier to read. Will squash the following in (I do want
to make sure that it is clear that <commit> does not have to be at
the tip, and also <ref> does not have to be a branch---it could be
any ref).

Thanks.

 --fork-point::
-	Given a commit that is derived from possibly an earlier
-	incarnation of a ref, find an appropriate fork-point of the
-	derived history to rebase it on top of an updated base
-	history (see discussion on this mode below).
+	Find the point at which a branch (or any history that leads
+	to <commit>) forked from another branch (or any reference)
+	<ref>. This does not just look for the common ancestor of
+	the two commits, but also takes into account the reflog of
+	<ref> to see if the history leading to <commit> forked from
+	an earlier incarnation of the branch <ref> (see discussion
+	on this mode below).
 
 OPTIONS
 -------
