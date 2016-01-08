From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 10/10] t/t9001-send-email.sh: get rid of unnecessary backquotes
Date: Fri, 08 Jan 2016 15:52:12 +0100
Message-ID: <vpqa8ogdsyr.fsf@anie.imag.fr>
References: <1452251188-12939-1-git-send-email-gitter.spiros@gmail.com>
	<1452251188-12939-11-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 08 15:55:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aHYRr-0001e2-WD
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jan 2016 15:55:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755272AbcAHOzY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2016 09:55:24 -0500
Received: from mx2.imag.fr ([129.88.30.17]:58006 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754172AbcAHOzY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jan 2016 09:55:24 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id u08EqAg4006984
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Fri, 8 Jan 2016 15:52:10 +0100
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u08EqCfv012956;
	Fri, 8 Jan 2016 15:52:12 +0100
In-Reply-To: <1452251188-12939-11-git-send-email-gitter.spiros@gmail.com>
	(Elia Pinto's message of "Fri, 8 Jan 2016 12:06:28 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 08 Jan 2016 15:52:10 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u08EqAg4006984
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1452869531.13582@dE1DAid69CnkhDpbpHKoHg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283556>

Elia Pinto <gitter.spiros@gmail.com> writes:

> Instead of making the shell expand 00* and invoke 'echo' with it,
> and then capturing its output as command substitution, just use
> the result of expanding 00* directly.

This is not actually how it happens. cover=`echo *` expands the * before
the assignment to $cover, while cover="*" assigns a litteral * to
$cover.

Then, when you use $cover, the variable is expanded to * and then it is
expanded to filenames here:

>  	mv $cover cover-to-edit.patch &&

On the other hand, this instance of $cover is quoted, hence the
*-expansion won't happen:

>  	perl -pe "s/^From:/$header: extra\@address.com\nFrom:/" cover-to-edit.patch >"$cover" &&

So, I believe this patch is not correct.

OTOH, patches 1 to 9 look good to me.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
