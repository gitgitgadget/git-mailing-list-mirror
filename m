From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] MSVC: link dynamically to the CRT
Date: Wed, 30 Apr 2014 11:36:37 -0700
Message-ID: <xmqqa9b2fyve.fsf@gitster.dls.corp.google.com>
References: <20140429102509.GA16706@camelia.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Stepan Kasal <kasal@ucw.cz>
X-From: git-owner@vger.kernel.org Wed Apr 30 20:36:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfZNC-000434-Of
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 20:36:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759428AbaD3Sgo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2014 14:36:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58996 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759421AbaD3Sgn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2014 14:36:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CD6AA7E0B7;
	Wed, 30 Apr 2014 14:36:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=A1nElu7bjnQBo4Bg8BM7sjaSAP0=; b=k7OIV2
	NZ72pj3USdm7teCFMyuGyZuYAYWx/v/sOqk3dGysiHeI3L+YDRnsyOWTC/oVZ0iD
	QI/2camMdELmV5mdt/KOXb+HiiE7H3ZG2bscX5aneWlzi+0XRC2sCQWvOfPLjjN2
	dvUBXDpLE30mxTw2scb0WB87AAUWvP8gwVN2Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uO+1otIOiVkU4oa+Ask3YyUllwLAbf5Z
	jeF2vX2d2p6M6Tasfx8ELqXmmwEa9X8phwC+DooBeAENEMNUudUKNYR4SK4E47jr
	f0YagcMr7OLYU0LqRPZ+qkcLKMN8s1PZapaMKSiwFl1SE32lwIwobThlRIu2E0Oc
	k3n8GVUI0DI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B09BC7E0B6;
	Wed, 30 Apr 2014 14:36:42 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 762A07E0AE;
	Wed, 30 Apr 2014 14:36:39 -0400 (EDT)
In-Reply-To: <20140429102509.GA16706@camelia.ucw.cz> (Stepan Kasal's message
	of "Tue, 29 Apr 2014 12:25:09 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 5E31CD60-D096-11E3-B59E-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247755>

Stepan Kasal <kasal@ucw.cz> writes:

> From: Karsten Blees <blees@dcon.de>
> Date: Fri, 7 Jan 2011 17:20:21 +0100
>
> Dynamic linking is generally preferred over static linking, and MSVCRT.dll
> has been integral part of Windows for a long time.
>
> This also fixes linker warnings for _malloc and _free in zlib.lib, which
> seems to be compiled for MSVCRT.dll already.
>
> The DLL version also exports some of the CRT initialization functions,
> which are hidden in the static libcmt.lib (e.g. __wgetmainargs, required by
> subsequent Unicode patches).
>
> Signed-off-by: Karsten Blees <blees@dcon.de>
> Signed-off-by: Stepan Kasal <kasal@ucw.cz>
> ---
>
> Another patch from msysgit.
> Cheers,
>   Stepan

Thanks.

I am not intimate with the msysgit developer community, and I do not
know if it is appropriate for me to respond with a

	Does this look OK with msysgit folks?

cc'ed to the usual suspects (Erik Faye-Lund, Dscho and J6t).  Just
like I do not have to ask "does this look ok?" question when seeing
a patch from Erik or J6t, is it unnecessary for me to do so for a
patch from you?

>  config.mak.uname | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/config.mak.uname b/config.mak.uname
> index efaed94..eebc847 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -365,16 +365,16 @@ ifeq ($(uname_S),Windows)
>  		compat/win32/pthread.o compat/win32/syslog.o \
>  		compat/win32/dirent.o
>  	COMPAT_CFLAGS = -D__USE_MINGW_ACCESS -DNOGDI -DHAVE_STRING_H -DHAVE_ALLOCA_H -Icompat -Icompat/regex -Icompat/win32 -DSTRIP_EXTENSION=\".exe\"
> -	BASIC_LDFLAGS = -IGNORE:4217 -IGNORE:4049 -NOLOGO -SUBSYSTEM:CONSOLE -NODEFAULTLIB:MSVCRT.lib
> +	BASIC_LDFLAGS = -IGNORE:4217 -IGNORE:4049 -NOLOGO -SUBSYSTEM:CONSOLE
>  	EXTLIBS = user32.lib advapi32.lib shell32.lib wininet.lib ws2_32.lib
>  	PTHREAD_LIBS =
>  	lib =
>  ifndef DEBUG
> -	BASIC_CFLAGS += -GL -Os -MT
> +	BASIC_CFLAGS += -GL -Os -MD
>  	BASIC_LDFLAGS += -LTCG
>  	AR += -LTCG
>  else
> -	BASIC_CFLAGS += -Zi -MTd
> +	BASIC_CFLAGS += -Zi -MDd
>  endif
>  	X = .exe
>  endif
