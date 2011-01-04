From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2] Fix false positives in t3404 due to SHELL=/bin/false
Date: Tue, 04 Jan 2011 23:28:58 +0100
Message-ID: <vpqhbdoxpzp.fsf@bauges.imag.fr>
References: <robbat2-20101227T024837-537032076Z@orbis-terrarum.net>
	<7vsjxjyce6.fsf@alter.siamese.dyndns.org>
	<20101227080343.GA15026@orbis-terrarum.net>
	<982E526FA742C94E9AC26DA766FD07090A3399@NYCMBX3.winmail.deshaw.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "'Robin H. Johnson'" <robbat2@gentoo.org>,
	Junio C Hamano <gitster@pobox.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: "Vallon\, Justin" <Justin.Vallon@deshaw.com>
X-From: git-owner@vger.kernel.org Tue Jan 04 23:29:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PaFNe-0005NH-2u
	for gcvg-git-2@lo.gmane.org; Tue, 04 Jan 2011 23:29:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750946Ab1ADW3U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jan 2011 17:29:20 -0500
Received: from mx1.imag.fr ([129.88.30.5]:53236 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750699Ab1ADW3U (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jan 2011 17:29:20 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id p04MSuMs015497
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 4 Jan 2011 23:28:56 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1PaFNC-0007Au-QG; Tue, 04 Jan 2011 23:28:58 +0100
In-Reply-To: <982E526FA742C94E9AC26DA766FD07090A3399@NYCMBX3.winmail.deshaw.com> (Justin Vallon's message of "Tue\, 4 Jan 2011 09\:43\:12 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 04 Jan 2011 23:28:57 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p04MSuMs015497
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1294784937.82126@8I31GlH/jrr+PO0gN0F2jQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164522>

"Vallon, Justin" <Justin.Vallon@deshaw.com> writes:

> How was SHELL=/bin/false causing problems?  Is git using $SHELL?

The explanation is in the comment right above the modification in the
patch. "user's shell" can be read as "$SHELL":

> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -71,8 +71,9 @@ test_expect_success 'setup' '
>  # "exec" commands are ran with the user shell by default, but this may
>  # be non-POSIX. For example, if SHELL=zsh then ">file" doesn't work
>  # to create a file. Unseting SHELL avoids such non-portable behavior
> -# in tests.
> +# in tests. It must be exported for it to take effect where needed.
>  SHELL=
> +export SHELL

(my bad, I wrote this SHELL= without exporting it. Since bash
re-exports already exported variables when they are assigned, and my
/bin/sh points to bash, I didn't notice)

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
