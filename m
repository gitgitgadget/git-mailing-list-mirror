From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v3] git cherry-pick: Add NULL check to sequencer parsing of HEAD
Date: Thu, 03 May 2012 18:48:40 +0200
Message-ID: <vpqtxzx5hxz.fsf@bauges.imag.fr>
References: <1336044026-16897-1-git-send-email-nhorman@tuxdriver.com>
	<1336054159-5123-1-git-send-email-nhorman@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mmueller@vigilantsw.com,
	rene.scharfe@lsrfire.ath.cx, gitster@pobox.com
To: Neil Horman <nhorman@tuxdriver.com>
X-From: git-owner@vger.kernel.org Thu May 03 18:49:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPzDF-0007KR-Mp
	for gcvg-git-2@plane.gmane.org; Thu, 03 May 2012 18:49:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754944Ab2ECQtA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 May 2012 12:49:00 -0400
Received: from mx2.imag.fr ([129.88.30.17]:37143 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753517Ab2ECQs7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 May 2012 12:48:59 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q43Gflww027662
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 3 May 2012 18:41:48 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SPzCr-0002n7-00; Thu, 03 May 2012 18:48:41 +0200
In-Reply-To: <1336054159-5123-1-git-send-email-nhorman@tuxdriver.com> (Neil
	Horman's message of "Thu, 3 May 2012 10:09:19 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 03 May 2012 18:41:53 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q43Gflww027662
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1336668113.14097@ckxJDiUw5Yd680nNSLvN4w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196921>

Neil Horman <nhorman@tuxdriver.com> writes:

> -	if (!head_commit || parse_commit(head_commit))
> -		return error(_("could not parse commit %s\n"),
> -			     sha1_to_hex(head_commit->object.sha1));
> +
> +	if (parse_commit(head_commit))
> +		return -1;

Why did you replace the error("...") with only a -1? error() also
returns -1, but displays a message before, which I think was fine. If
you want to remove the message, then explain why in the commit message.

If you do not test for head_commit to be null, you can't use it in the
error message. But from the context, it seems you can use head_sha1. If
not, a message like "Could not parse HEAD commit" seems better than
nothing.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
