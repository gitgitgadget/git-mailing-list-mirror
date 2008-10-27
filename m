From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add support for uintmax_t type on FreeBSD 4.9
Date: Sun, 26 Oct 2008 22:30:17 -0700
Message-ID: <7vy70aip06.fsf@gitster.siamese.dyndns.org>
References: <1225021957-11880-1-git-send-email-david.syzdek@acsalaska.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "David M. Syzdek" <david.syzdek@acsalaska.net>
X-From: git-owner@vger.kernel.org Mon Oct 27 06:31:44 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KuKhb-0001IE-7h
	for gcvg-git-2@gmane.org; Mon, 27 Oct 2008 06:31:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751407AbYJ0Faa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Oct 2008 01:30:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751379AbYJ0Faa
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Oct 2008 01:30:30 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:55764 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751319AbYJ0Fa3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Oct 2008 01:30:29 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id D045074979;
	Mon, 27 Oct 2008 01:30:28 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 755E874977; Mon, 27 Oct 2008 01:30:23 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5D8F78AC-A3E8-11DD-8460-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99203>

"David M. Syzdek" <david.syzdek@acsalaska.net> writes:

> This adds NO_UINTMAX_T for ancient systems. If NO_UINTMAX_T is defined, then
> uintmax_t is defined as uint32_t. This adds a test to configure.ac for
> uintmax_t and adds a check to the Makefile for FreeBSD 4.9-SECURITY.
> ...
> diff --git a/Makefile b/Makefile
> index 0d40f0e..bf6a6dc 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -931,6 +931,9 @@ endif
>  ifdef NO_IPV6
>  	BASIC_CFLAGS += -DNO_IPV6
>  endif
> +ifdef NO_UINTMAX_T
> +	BASIC_CFLAGS += -Duintmax_t=uint32_t
> +endif

I have a stupid question.

Would it be a more appropriate improvement to do it like this:

	ifdef USE_THIS_AS_UINTMAX_T
            BASIC_CFLAGS += -Duintmax_t="$(USE_THIS_AS_UINTMAX_T)"
        endif

and then add a section for FreeBSD 4.9-SECURITY like this:

	ifeq ($(uname_R),4.9-SECURITY)
        	USE_THIS_AS_UINTMAX_T = uint32_t
	endif

That way, an oddball 64-bit machine can use uint64_t here if it wants to,
possibly including FreeBSD 4.9-SECURITY backported to 64-bit ;-).
