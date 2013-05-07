From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/7] refname_match(): Caller must declare if we're matching local or remote refs
Date: Mon, 06 May 2013 18:48:37 -0700
Message-ID: <7vsj1zo8zu.fsf@alter.siamese.dyndns.org>
References: <1367711749-8812-1-git-send-email-johan@herland.net>
	<1367711749-8812-7-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue May 07 03:48:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZX1J-0006o7-5E
	for gcvg-git-2@plane.gmane.org; Tue, 07 May 2013 03:48:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759630Ab3EGBsl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 May 2013 21:48:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47253 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756580Ab3EGBsk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 May 2013 21:48:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D504E12C65;
	Tue,  7 May 2013 01:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kuBMqk2W/2OFqCMAcAw9lNotafA=; b=STKnfZ
	IO86lolnww+JiSzwMpbiXQi0c2+S8Kv8Jg1ihblhOGX3Lb/NZuSTZEEezZFfZ2fw
	ukdnU/lO8Z+n/dXq6W6mET6QDlwQX0MoJIwz0l0XoAfrWgXOlr/nDLjj38cWLNmW
	4ITKPntgBvd0uys+5Z459O7xDJgfaZ01v+Lp0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iJydqPKwtNK4F2UKz81I/N06p7MQCBcf
	Gnvk3V0grpiT6mvZHf8nAWjGlgrUPapCI+dahhm+pjYPMu94jBRs7fcOp3z2E6eO
	gh8UAYs12T59mwfH5+mvJpz2JZayso7kuwtHguVsofZLCHsKvcvqHGlCs1MXBFtn
	TXg9rKGLcYI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CA10812C64;
	Tue,  7 May 2013 01:48:39 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3FDDE12C61;
	Tue,  7 May 2013 01:48:39 +0000 (UTC)
In-Reply-To: <1367711749-8812-7-git-send-email-johan@herland.net> (Johan
	Herland's message of "Sun, 5 May 2013 01:55:48 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3D44FC92-B6B8-11E2-B40B-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223520>

Johan Herland <johan@herland.net> writes:

> refname_match() is used to check whether a given shorthand name matches a
> given full refname, but that full refname does not always belong in the
> local repo, rather it is sometimes taken from list of refs sent over from
> a remote repo.

That "local vs remote" is a wrong way to think about things.

All refs you can feed to resolve_ref() and dwim_ref() are local, and
"remotes" is not all that special.  It is just a convention to store
many different kind of things per different hierarchy, and the only
special hierarchy we have is refs/heads/* that can be updated by
making new commits through the index and the working tree.
