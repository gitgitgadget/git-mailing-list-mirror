From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] some systems don't have (and need) sys/select.h
Date: Thu, 24 Jan 2008 13:17:14 -0800
Message-ID: <7vk5ly9b51.fsf@gitster.siamese.dyndns.org>
References: <20080124183446.GJ30676@schiele.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robert Schiele <rschiele@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 24 22:18:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JI9ST-0001pZ-9Q
	for gcvg-git-2@gmane.org; Thu, 24 Jan 2008 22:18:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753658AbYAXVR2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2008 16:17:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753428AbYAXVR2
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jan 2008 16:17:28 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:54728 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753395AbYAXVR1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2008 16:17:27 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id B072A322C;
	Thu, 24 Jan 2008 16:17:25 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 35E0D3227;
	Thu, 24 Jan 2008 16:17:21 -0500 (EST)
In-Reply-To: <20080124183446.GJ30676@schiele.dyndns.org> (Robert Schiele's
	message of "Thu, 24 Jan 2008 19:34:46 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71664>

Robert Schiele <rschiele@gmail.com> writes:

> The select stuff is already in sys/time.h on on some systems like HP-UX
> thus we should not include sys/select.h in that case.
>
> Signed-off-by: Robert Schiele <rschiele@gmail.com>

The patch looks good.  I'd rather try to be a bit more helpful
to people who want to port git to their system that is not
HP-UX, though.

How about wording it like this?

Subject: pre-POSIX.1-2001 systems do not have <sys/select.h>

POSIX.1-2001 has declaration of select(2) in <sys/select.h>, but
in previous version of SUS, it is declared in <sys/time.h>,
which is already included in git-compat-util.h.

This introduces NO_SYS_SELECT_H macro in the Makefile to be set
on older systems, to skip inclusion of <sys/select.h> that does
not exist on them.

We could check _POSIX_VERSION with 200112L and do this
automatically, but earlier it was reported that the approach
does not work well on some vintage of HP-UX.  Other systems may
get _POSIX_VERSION itself wrong.  At least for now, this manual
configuration is safer.
