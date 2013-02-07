From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] git-remote-mediawiki: use Git's Makefile to build
 the script
Date: Thu, 07 Feb 2013 11:28:31 -0800
Message-ID: <7vhaln7wkg.fsf@alter.siamese.dyndns.org>
References: <vpqobfxwg2q.fsf@grenoble-inp.fr>
 <1360174292-14793-1-git-send-email-Matthieu.Moy@imag.fr>
 <1360174292-14793-5-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Thu Feb 07 20:29:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3X9W-0005ZF-G9
	for gcvg-git-2@plane.gmane.org; Thu, 07 Feb 2013 20:28:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932128Ab3BGT2e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2013 14:28:34 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41601 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755511Ab3BGT2e (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2013 14:28:34 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B6B48B23C;
	Thu,  7 Feb 2013 14:28:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=dgiE2b1iu0IR23TTs/Pyu5ZkQq4=; b=CRfhUwQ4Tw6eqbLtvzA1
	E4/p1SzWFpdBu1DXs2bDAKon+0WkqrOh7gI/UG3qJKVLdhUiVUvEYbsolAio3obE
	XtXmAS8xnKKLqFWMTPKa+lfYi6/i6QiUPFztyzjRi7vBeoJRrkgIUlxMLI/iBY/k
	ZIG7DVwlWYZRm1HaL8EWDd0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=XF2jRbtm96AkTO9D4lMFzRO5V7+dzEsachzUv8Tm9+KGqx
	MKjaWmrrutpIbx0B3kb9U3dOXq860yOiWbx2WMLPWEizu+XWCXcEYvHTSt6LuN8B
	tZTDS+UOIjAk07nRPnkY6HUtZ/4lECz+nXrI4rBXww4LtXpFD+ybAN/LYyAaY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AADF7B23A;
	Thu,  7 Feb 2013 14:28:33 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 27B46B232; Thu,  7 Feb 2013
 14:28:33 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8F6C8E0A-715C-11E2-9ACB-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215715>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> The configuration of the install directory is not reused from the
> toplevel Makefile: we assume Git is already built, hence just call
> "git --exec-path". This avoids too much surgery in the toplevel Makefile.
>
> git-remote-mediawiki.perl can now "use Git;".
>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---

Continuing to the comment on 3/4, I wonder if it would be a lot
simpler and more maintainable if you replaced 1/4 to 3/4 with a
smaller patch to the top-level Makefile to teach it to munge
arbitrary path/to/foo.perl to path/to/foo the same way as we do to
other path/tool.perl that are known to the top-level Makefile
(similarly, another target to install the resulting path/to/foo at
an arbitrary place).  Then do something like

	all::
		$(MAKE) -C ../.. \
			PERL_SCRIPT=contrib/mw-to-git/git-remote-mediawiki.perl \
                        build-perl-script
	install::
		$(MAKE) -C ../.. \
			PERL_SCRIPT=contrib/mw-to-git/git-remote-mediawiki.perl \
                        install-perl-script

in this step.
