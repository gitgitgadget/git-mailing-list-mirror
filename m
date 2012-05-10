From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 6/8] apply: fall back on three-way merge
Date: Thu, 10 May 2012 09:26:38 +0200
Message-ID: <vpqy5p0bioh.fsf@bauges.imag.fr>
References: <1336629745-22436-1-git-send-email-gitster@pobox.com>
	<1336629745-22436-7-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 10 09:26:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSNlx-0004ta-Rx
	for gcvg-git-2@plane.gmane.org; Thu, 10 May 2012 09:26:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756244Ab2EJH0p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 May 2012 03:26:45 -0400
Received: from mx2.imag.fr ([129.88.30.17]:51162 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756134Ab2EJH0o (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2012 03:26:44 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q4A7JOai000701
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 10 May 2012 09:19:24 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SSNln-0006mf-DY; Thu, 10 May 2012 09:26:39 +0200
In-Reply-To: <1336629745-22436-7-git-send-email-gitster@pobox.com> (Junio C.
	Hamano's message of "Wed, 9 May 2012 23:02:23 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 10 May 2012 09:19:24 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q4A7JOai000701
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1337239165.23867@ZoPH500oay3c+tfPRrWWCQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197550>

Junio C Hamano <gitster@pobox.com> writes:

> +	/* Preimage the patch was prepared for */
> +	if (get_sha1(patch->old_sha1_prefix, pre_sha1) ||
> +	    read_blob_object(&buf, pre_sha1, patch->old_mode))
> +		return error("repository lacks necessary blobs to fall back on 3-way merge.");

What happens if there are multiple objects for the same pre_sha1? It's
just 7 characters, so conflicts are unlikely but possible. Ideally, we
could try applying the patch to all the blobs having the same prefix
sha1, and take the first one for which the patch applies cleanly.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
