From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Small rerere in rebase regression
Date: Mon, 23 May 2016 15:11:16 -0700
Message-ID: <xmqqk2ik77cr.fsf@gitster.mtv.corp.google.com>
References: <57434572.6030306@kdbg.org>
	<xmqqy4708ss0.fsf@gitster.mtv.corp.google.com>
	<57437693.3030106@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue May 24 00:11:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4y4K-0003GE-UT
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 00:11:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752081AbcEWWLV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2016 18:11:21 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50669 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751951AbcEWWLU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2016 18:11:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D31251D949;
	Mon, 23 May 2016 18:11:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VpOPnto7fryVUNvlGH4Pmkq81Ks=; b=nAu78q
	CqDDSXCaCr8V05YjV04hh2ZoAPtxO0UxcMCcrj/ZF2IjdUaguwAaEMNuOKH6FcY5
	v+BecnBx7ek44x47tfwnpn1f82kiOorVYBIs2nugR1f+oQ09MW0UZlqQyA+/UXH5
	UrmFcnsVgOzgeXHOqc/0LcaWG++FRNPGY4AbQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xd4BV+F+T6IltrQhT4MXfyvbPOuJctLg
	OwMA5/MwGAOd2GZG6Xbpg7JQFTa8edQhpafAIGpkJJzaC96pDFts6Cn6CGbEg8q/
	IPCMsLIW2vP6WC9SJHnwPi869KKNFrnzERk/RWixNbz+0FhzGyy3w5o3FrZmMX+l
	etk9rxyVceY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id CB61A1D93D;
	Mon, 23 May 2016 18:11:18 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 45AD51D93B;
	Mon, 23 May 2016 18:11:18 -0400 (EDT)
In-Reply-To: <57437693.3030106@kdbg.org> (Johannes Sixt's message of "Mon, 23
	May 2016 23:30:59 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 46023FFA-2133-11E6-AFDC-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295403>

Johannes Sixt <j6t@kdbg.org> writes:

> I also come to the conclusion that die_with_patch shouldn't have to
> have a call to "git rerere". die_with_patch can be called after "git
> cherry-pick", "git merge", "git commit", all of which have their own
> rerere() invocation.
>
> However, calling "git rerere" after a failed "git commit" may be
> destructive: it would record a resolution even though the commit has
> not be completed. Think of an squash commit being aborted because the
> user notices an error in the last minute. If that error is in a
> conflict resolution, that wrong resolution would be recorded.

So, the behaviour change you observed uncovered a small bug in
"rebase -i" that was covered by the old limitation of "rerere" that
refrained from creating preimage when there already is one?

I think removing the call to "git rerere" there is a safe and
sensible thing regardless, but perhaps authors of "rebase -i" had
their own reasons.  I dunno (it is unlikely I'll have a chance to do
blame and digging today).
