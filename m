From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitk: Update and fix Makefile
Date: Tue, 08 Jan 2008 14:54:54 -0800
Message-ID: <7vk5mkq669.fsf@gitster.siamese.dyndns.org>
References: <200801082154.21282.stimming@tuhh.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
To: Christian Stimming <stimming@tuhh.de>
X-From: git-owner@vger.kernel.org Tue Jan 08 23:56:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCNMS-0005FP-BE
	for gcvg-git-2@gmane.org; Tue, 08 Jan 2008 23:55:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753572AbYAHWzS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2008 17:55:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753395AbYAHWzR
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jan 2008 17:55:17 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:38842 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753437AbYAHWzQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2008 17:55:16 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 37C7C2E09;
	Tue,  8 Jan 2008 17:55:14 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 4FE66402A;
	Tue,  8 Jan 2008 17:55:03 -0500 (EST)
In-Reply-To: <200801082154.21282.stimming@tuhh.de> (Christian Stimming's
	message of "Tue, 8 Jan 2008 21:54:20 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69934>

Christian Stimming <stimming@tuhh.de> writes:

> -# From here on, these are needed in git.git/gitk/Makefile.
> +prefix ?= $(HOME)
> +bindir ?= $(prefix)/bin
> +sharedir ?= $(prefix)/share
>  gitk_libdir   ?= $(sharedir)/gitk/lib
>  msgsdir    ?= $(gitk_libdir)/msgs
>  msgsdir_SQ  = $(subst ','\'',$(msgsdir))

I see somwhat funny spacing there.  I'd suggest giving up
aligning with spaces and consistently saying "var ?= val"
instead.

	I am reading the diff between the gitk-git/Makefile
	before and after merging gitk with your patch and
	the last three lines above are not context but additions
	from my point of view.

> +install:: all
> +	$(INSTALL) gitk-wish '$(DESTDIR_SQ)$(bindir_SQ)'/gitk
> +	$(INSTALL) -d '$(DESTDIR_SQ)$(msgsdir_SQ)'
> +	$(foreach p,$(ALL_MSGFILES), $(INSTALL) $p '$(DESTDIR_SQ)$(msgsdir_SQ)' &&) true

This is cute and correct (except I would have spelled "true" as
":" myself).  I think we need to fix a few such constructs that
use ";" instead of "&&" in Makefile in git.git.

> +uninstall::
> +	$(foreach p,$(ALL_MSGFILES), $(RM) '$(DESTDIR_SQ)$(msgsdir_SQ)'/$(notdir $p) &&) true
> +	$(RM) '$(DESTDIR_SQ)$(bindir_SQ)'/gitk

I have a mild dislike against uninstall target, but that's
Paul's call.

> +clean::
> +	$(RM) gitk-wish po/*.msg

And this makes me wonder if the last token should be $(ALL_MSGFILES).

Other than that, Ack from me.

Thanks.
