From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2] config: allow ~/ and ~user/ in include.path value
Date: Wed, 25 Apr 2012 17:53:47 +0200
Message-ID: <vpqehrbolis.fsf@bauges.imag.fr>
References: <1335265689-2270-1-git-send-email-Matthieu.Moy@imag.fr>
	<1335292396-8502-1-git-send-email-Matthieu.Moy@imag.fr>
	<20120425120036.GB21579@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 25 17:56:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SN4Za-0000EU-Kg
	for gcvg-git-2@plane.gmane.org; Wed, 25 Apr 2012 17:56:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755569Ab2DYP4B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Apr 2012 11:56:01 -0400
Received: from mx1.imag.fr ([129.88.30.5]:36285 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755117Ab2DYP4A (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2012 11:56:00 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q3PFlGGq019956
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 25 Apr 2012 17:47:17 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SN4XM-00062X-NE; Wed, 25 Apr 2012 17:53:48 +0200
In-Reply-To: <20120425120036.GB21579@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 25 Apr 2012 08:00:36 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 25 Apr 2012 17:47:20 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q3PFlGGq019956
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1335973640.99454@olLkIJK+Bzy0G4Cvb3PAUQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196319>

Jeff King <peff@peff.net> writes:

>  Documentation/config.txt  |    5 ++++-
>  t/t1305-config-include.sh |    8 ++++++++

Nice, thanks.

> --- a/config.c
> +++ b/config.c
> @@ -37,6 +37,11 @@ static int handle_path_include(const char *path, struct config_include_data *inc
>  {
>  	int ret = 0;
>  	struct strbuf buf = STRBUF_INIT;
> +	char *expanded = expand_user_path(path);
> +
> +	if (!expanded)
> +		return error("Could not expand include path '%s'", path);
> +	path = expanded;
>  
>  	/*
>  	 * Use an absolute path as-is, but interpret relative paths
> @@ -63,6 +68,7 @@ static int handle_path_include(const char *path, struct config_include_data *inc
>  		inc->depth--;
>  	}
>  	strbuf_release(&buf);
> +	free(expanded);

Clearly better than my version.

Acked-by: Matthieu Moy <Matthieu.Moy@imag.fr>

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
