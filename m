From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Correct references to /usr/bin/python which does not
 exist on FreeBSD
Date: Sun, 21 Mar 2010 14:15:34 -0700
Message-ID: <7veijdl6kp.fsf@alter.siamese.dyndns.org>
References: <20100321190145.GA32578@kiwi.sharlinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "R. Tyler Ballance" <tyler@monkeypox.org>
X-From: git-owner@vger.kernel.org Sun Mar 21 22:15:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtSV3-0002sZ-40
	for gcvg-git-2@lo.gmane.org; Sun, 21 Mar 2010 22:15:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753592Ab0CUVPq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Mar 2010 17:15:46 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:55118 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752739Ab0CUVPp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Mar 2010 17:15:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D402A4E79;
	Sun, 21 Mar 2010 17:15:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=sBB14a9TMgwkI+Ll6w3r0FaOCnc=; b=UtPxUJS2lsvVJIflbCGiDV9
	xRMMdmOTxnew57tWaWkP086hfvyYpwOmnuweHWHktSd4kDjIH55TnP7UwEDG7mrH
	ZNhUJOZF7OgesLwcGfTWDMNLZkTwms8kEgS9/sUsjy9b7hThCXEBWvL+YndO/z/K
	OmDlNO1AKqrdCzTU9AaI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=tKoXUDcHpXuKAe9ozIzjCGeJnwMUzaCuL5r7DRRpYS5PNEYnH
	aNvlpSrrxezYmf6zvL5cu4HLfkcvNRRlFNx74TsbUOuIaia+723d5YORqR8dczlX
	T2i4aVE6q9TFW6C6iC5+M/yNjiP0Xj296jSIJ0dhnwkF8TK1HgOdxkfMbg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0AE90A4E78;
	Sun, 21 Mar 2010 17:15:39 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 644A2A4E77; Sun, 21 Mar
 2010 17:15:36 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E621B1F2-352E-11DF-8719-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142862>

"R. Tyler Ballance" <tyler@monkeypox.org> writes:

> On FreeBSD, Python does not ship as part of the base system but is available
> via the ports system, which install the binary in /usr/local/bin.
> ---

Sign-off?

> diff --git a/Makefile b/Makefile
> index 3a6c6ea..4f8fbf0 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -444,7 +444,11 @@ ifndef PERL_PATH
>  	PERL_PATH = /usr/bin/perl
>  endif
>  ifndef PYTHON_PATH
> -	PYTHON_PATH = /usr/bin/python
> +	ifeq ($(uname_S),FreeBSD)
> +		PYTHON_PATH = /usr/local/bin/python
> +	else
> +		PYTHON_PATH = /usr/bin/python
> +	endif
>  endif

I would have expected that the patch would look more like this:

diff --git a/Makefile b/Makefile
index 98372eb..5bb0769 100644
--- a/Makefile
+++ b/Makefile
@@ -831,6 +831,7 @@ ifeq ($(uname_S),FreeBSD)
 		NO_UINTMAX_T = YesPlease
 		NO_STRTOUMAX = YesPlease
 	endif
+	PYTHON_PATH = /usr/local/bin/python
 endif
 ifeq ($(uname_S),OpenBSD)
 	NO_STRCASESTR = YesPlease

What am I missing?
