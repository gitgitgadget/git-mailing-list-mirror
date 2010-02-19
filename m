From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 4/4] Use git_mkstemp_mode and xmkstemp_mode in odb_mkstemp, not chmod later.
Date: Sat, 20 Feb 2010 00:19:02 +0100
Message-ID: <vpq7hq8stjt.fsf@bauges.imag.fr>
References: <1266597207-32036-1-git-send-email-Matthieu.Moy@imag.fr>
	<1266597207-32036-5-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 20 00:22:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NicB6-0006W9-SX
	for gcvg-git-2@lo.gmane.org; Sat, 20 Feb 2010 00:22:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756177Ab0BSXWX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2010 18:22:23 -0500
Received: from imag.imag.fr ([129.88.30.1]:41216 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755745Ab0BSXWW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2010 18:22:22 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o1JNJ3hh003735
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sat, 20 Feb 2010 00:19:03 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Nic7j-0001CV-25; Sat, 20 Feb 2010 00:19:03 +0100
In-Reply-To: <1266597207-32036-5-git-send-email-Matthieu.Moy@imag.fr> (Matthieu Moy's message of "Fri\, 19 Feb 2010 17\:33\:27 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.91 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Sat, 20 Feb 2010 00:19:03 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140495>

Junio C Hamano <gitster@pobox.com> writes:

> By not using mkstemp() from the platform but having our own would allow us
> to not even worry about this issue (this can be seen by the removal of a
> call to umask() in [PATCH 4/4]).

Exactly. BTW, we probably want to do the same for object files. The
problem is less important since object files are created 0444, and
therefore do not break ACLs, but that would at least increase
consistancy a bit.

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> -
> +	/*
> +	 * we let the umask do it's job, don't try to be more
> +	 * restrictive.
> +	 */
> +	int mode = 0666;

Actually, it may be safer to put 0444 here. With my patch, git still
creates read-only pack files, but to be honnest, I don't understand
which piece of code cuts the 'w' bit!

New patch serie comming with additional patches for the first point,
and a corrected [PATCH 4] for the second.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
