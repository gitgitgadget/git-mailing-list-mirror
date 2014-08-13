From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/git-rebase.txt: fix -f description to match actual git behavior.
Date: Wed, 13 Aug 2014 09:48:02 -0700
Message-ID: <xmqqha1g49q5.fsf@gitster.dls.corp.google.com>
References: <87bnrq22uf.fsf@osv.gnss.ru>
	<xmqq4mxh5w34.fsf@gitster.dls.corp.google.com>
	<xmqqzjf94f5n.fsf@gitster.dls.corp.google.com>
	<87mwb8ahtb.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sergey Organov <sorganov@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 13 18:48:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XHbij-0004Vm-4h
	for gcvg-git-2@plane.gmane.org; Wed, 13 Aug 2014 18:48:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752918AbaHMQsN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2014 12:48:13 -0400
Received: from smtp.pobox.com ([208.72.237.35]:56483 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752090AbaHMQsM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2014 12:48:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 11FFA2FDDC;
	Wed, 13 Aug 2014 12:48:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=I+6BKXUOuZ4LG3GXQl4VfY+YtQA=; b=rfijsK
	jYFqHstGykjoh+3ggSic0bNV2LjPcH6BlC9FRlBm4NqY7B2AaLMN2R7VqQvC3d+T
	Dz7BYU9/T5P+fZr06Xm7Re/Cl+VFDWvhJPc+UYDiz+8heFqNFKdr+J+zamwyAwrG
	Rez7sv5rS9lrCIwPQaAvyzp1VClLzaa/PQVBs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tapcb862pCdzCiHmFDlfJF/7nuowTuis
	Ua6R1OX5UN7jSofrMDEtXEK4Ghdo3gejX8mXTcgC1Z9hciWJ4auDtea1YzABmFIo
	N4fI0jSvWY2i8m5ylRtnTbP9qtEeF9yc3zq+08S0+7TlsZant9jQ8BUvNiKJ8Zps
	mGmnVxOGW3A=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 01FF32FDD9;
	Wed, 13 Aug 2014 12:48:12 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 7E0092FDB6;
	Wed, 13 Aug 2014 12:48:04 -0400 (EDT)
In-Reply-To: <87mwb8ahtb.fsf@osv.gnss.ru> (Sergey Organov's message of "Wed,
	13 Aug 2014 12:56:48 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 9853D77A-2309-11E4-89CE-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255216>

Sergey Organov <sorganov@gmail.com> writes:

> ... I.e., git must not rebase anything
> when "Current branch is a descendant of the commit you are rebasing
> onto", unless -f is given. Simple, reasonable, straightforward.

It may be simple and straightforward, but breaks the use case the
plain vanilla rebase is used for, doesn't it?  You seem to ignore,
or perhaps you don't realize the existence of, the need of those who
want to flatten the history on top of the tip from the other side;
your statements in the "pull --rebase[=preserve]" thread may be
coming from the same place, I suspect.

For the "flatten the history on top of that commit" use case, two
conditions must be satisfied before the command can say "the history
is already in the desired shape and nothing needs to be done" to
allow it to make a short-cut.  It is not sufficient for the current
tip to be merely descendant of the tip from the other side (which is
the documentation bug we are fixing here).  The history between the
two commits need also to be linear, or it would not be flattening.

Punting when when only one of the two conditions is met and
requiring "--force" to perform what the user wanted to ask the
command to do does not fall into the "reasonable" category.

If your workflow does not involve the flattening plain vanilla
"rebase", not using it is perfectly fine.  But please do not break
it for other people only because you do not use it yourself.
