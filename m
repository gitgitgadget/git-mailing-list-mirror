From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Document the underlying protocol used by shallow
 repositories and --depth commands.
Date: Tue, 07 Jun 2011 13:28:41 -0700
Message-ID: <7vzklt4c92.fsf@alter.siamese.dyndns.org>
References: <loom.20110607T212226-56@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Alex Neronskiy <zakmagnus@google.com>
X-From: git-owner@vger.kernel.org Tue Jun 07 22:28:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QU2tU-0002ij-M1
	for gcvg-git-2@lo.gmane.org; Tue, 07 Jun 2011 22:28:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753895Ab1FGU2w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2011 16:28:52 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:37992 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753309Ab1FGU2v (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2011 16:28:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D5B725F9C;
	Tue,  7 Jun 2011 16:31:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sMihhTbYtDlK/Xw08nuhp/ODL0s=; b=GS6jUZ
	qvTKBWJlIL+nnSCGlYJfxU3lUPlNvoShhZdG3VgNhbUMZbc7tLCcskAFQqdL2Ltl
	shoncd8xM0H7s8latzZtaDhXjZPaGeLpJ+E5teZk/FRQJUXEMhQSvnogEmzOBg/c
	bhujvGb3DJYIeiadnL9qJEYX5KFJTmmvqQeiU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Y5kHGDDqywl9MRM8IkRKR2o6Du+L9qS1
	fri36aEqVIMzHC9kc+ksCO/yrfP5QvnC52rLkyZh1Sd6nY+iE2iq8OcvJH4XgJjz
	wPuLkHUglvdtGJx+vy3duGV5twf0sPb/yfaTRAaO0A9ErrpYOIax33vG4T5vGyAy
	sXLc4PRvD1k=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9E7495F9B;
	Tue,  7 Jun 2011 16:30:57 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 515105F95; Tue,  7 Jun 2011
 16:30:53 -0400 (EDT)
In-Reply-To: <loom.20110607T212226-56@post.gmane.org> (Alex Neronskiy's
 message of "Tue, 7 Jun 2011 19:24:30 +0000 (UTC)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0A39587E-9145-11E0-8EC5-85C8C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175264>

Alex Neronskiy <zakmagnus@google.com> writes:

>X-Gmane-NNTP-Posting-Host: sea.gmane.org
>User-Agent: Loom/3.14 (http://gmane.org/)

It seems like you posted from the news interface at gmane, and the
annoying &nbsp; are gone now.  The patch is still linewrapped (see the
hunk header starting with "@@ -187,26"), but this one I can fix up and
actually take a look ;-).

> Explain the exchange that occurs between a client and server when
> the client is requesting shallow history and/or is already using
> a shallow repository.

Notice the use of word "shallow" here. It talks about the depth of the
history.

> +... Commits whose parents are not received as a result are
> +defined as shallow and marked as such in the server. This information
> +is sent back to the client in the next step.

As it is documented for the first time, we didn't have a formal
terminology for calling these commits and it is this document's
responsibility to come up with a good one. We have used "shallow clone"
and "shallow history", and I agree with the use of adjective in these
contexts, but I am not sure if it is a good idea to call the commits at
the boundary of a shallow history "shallow"---the following sentences do
not parse well at least for me:

    "This commit is shallow."
    "This commit is not shallow, and it is a direct child of that commit,
    which is shallow."
    "That commit does not exist in this repository because it is an
    ancestor of a shallow commit".

But it may be just me. Better wording ideas, anybody?

By the way, Dscho, the shallow extension was your invention 4 and half
years ago. I think the description in this version is mostly accurate
(modulo the part that talks about an early client termination after
"shallow" and "deepen" are sent), but I'd appreciate if you can comment on
it to improve.

Thanks.
