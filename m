From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [RFC PATCH] stash: accept options also when subcommand 'save' is omitted
Date: Tue, 18 Aug 2009 23:52:15 +0200
Message-ID: <vpqtz0423jk.fsf@bauges.imag.fr>
References: <1250599567-31428-1-git-send-email-Matthieu.Moy@imag.fr>
	<vpqws51l1hb.fsf@bauges.imag.fr>
	<20090818174509.GA27518@coredump.intra.peff.net>
	<alpine.DEB.1.00.0908182337200.8306@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Aug 18 23:52:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdWbb-0006tJ-KU
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 23:52:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751125AbZHRVw1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 17:52:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751104AbZHRVw1
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 17:52:27 -0400
Received: from mx1.imag.fr ([129.88.30.5]:50635 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751054AbZHRVw0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2009 17:52:26 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id n7ILnVHu024793
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 18 Aug 2009 23:49:31 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1MdWbH-0005XD-9I; Tue, 18 Aug 2009 23:52:15 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1MdWbH-0002ou-7y; Tue, 18 Aug 2009 23:52:15 +0200
In-Reply-To: <alpine.DEB.1.00.0908182337200.8306@pacific.mpi-cbg.de> (Johannes Schindelin's message of "Tue\, 18 Aug 2009 23\:42\:58 +0200 \(CEST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.91 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 18 Aug 2009 23:49:31 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: n7ILnVHu024793
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1251236972.56996@9/WA8FxAauT8go1hGNPDUQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126469>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> But it is sloppy, in that it blindly accepts options that might be valid
> for several subcommands, not just "save".

I wouldn't call that sloppy. 'save' is the default command, if you
don't provide any command, then 'save' will be used.

So, "git stash -p" means "git stash save -p" regardless of the fact
that there exists somewhere else a "git stash list -p". Actually, in
the current form of pu, it is already the case since

f300fab (Thomas Rast, DWIM 'git stash save -p' for 'git stash -p')

which came right after your patch.

> So please register my objection.

I will if you register my objection to yours ;-).

Jokes aside, if you insist in rejecting 'git stash -p', then my patch
can be slightly modified to say something like

+case "$1" in
+    -k|--keep-index|--patch)
+       set "save" "$@"
+       ;;
+esac

instead, which also allows multiple arguments (unlike your initial
proposal), and can control more precisely the list of options for
which 'save' is a default.

--
Matthieu
