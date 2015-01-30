From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Makefile: Handle broken curl version number in version check
Date: Fri, 30 Jan 2015 14:09:50 -0800
Message-ID: <xmqq61bnc441.fsf@gitster.dls.corp.google.com>
References: <54CA2E84.6090604@statsbiblioteket.dk>
	<1422611554-15393-1-git-send-email-tgc@statsbiblioteket.dk>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>
To: "Tom G. Christensen" <tgc@statsbiblioteket.dk>
X-From: git-owner@vger.kernel.org Fri Jan 30 23:09:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YHJlF-0008Fs-Qq
	for gcvg-git-2@plane.gmane.org; Fri, 30 Jan 2015 23:09:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754194AbbA3WJx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2015 17:09:53 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55564 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758767AbbA3WJw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jan 2015 17:09:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2925133C15;
	Fri, 30 Jan 2015 17:09:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cSrpy594uKoUuSAY58LM+0JgiCI=; b=hK+hGm
	6S859ca6NxGOOobBe+V6rGKDJXk1zf2GovDNotoLUemAwq875UlvLQXIJQCytuvI
	39r4TlgbWGNhguMAMKNNZH6NUyq15Eg+B20NeOpO3FHm93Ae5teRjZWR6nA9OfX4
	15Jp2kBZ56Priet7+NnzkKPnXyJa765xhF4T4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GNZW3J1yl5axXNdeL1lPYdVpA9SYDu7+
	44fuMokMS487G67AvZFmiWnEkJWb7BRIZw+6kpdq57fvGfPafVcOevV2x+YHHdFb
	aZ0B5Lvl1aVf/x7/QyYaL67Wo84hKfVo/2FBMIiyFmtuQgIKrguGseTk+oUgK8hm
	gSrh1/xfRJk=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1F66333C14;
	Fri, 30 Jan 2015 17:09:52 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 97A8133C13;
	Fri, 30 Jan 2015 17:09:51 -0500 (EST)
In-Reply-To: <1422611554-15393-1-git-send-email-tgc@statsbiblioteket.dk> (Tom
	G. Christensen's message of "Fri, 30 Jan 2015 10:52:34 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B67B7AC0-A8CC-11E4-A1F0-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263201>

"Tom G. Christensen" <tgc@statsbiblioteket.dk> writes:

> diff --git a/Makefile b/Makefile
> index c44eb3a..69a2ce3 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1035,13 +1035,13 @@ else
>  	REMOTE_CURL_NAMES = $(REMOTE_CURL_PRIMARY) $(REMOTE_CURL_ALIASES)
>  	PROGRAM_OBJS += http-fetch.o
>  	PROGRAMS += $(REMOTE_CURL_NAMES)
> -	curl_check := $(shell (echo 070908; curl-config --vernum) 2>/dev/null | sort -r | sed -ne 2p)
> +	curl_check := $(shell (echo 070908; curl-config --vernum | sed -e '/^70[B-C]/ s/^7/07/') 2>/dev/null | sort -r | sed -ne 2p)
>  	ifeq "$(curl_check)" "070908"
>  		ifndef NO_EXPAT
>  			PROGRAM_OBJS += http-push.o
>  		endif
>  	endif
> -	curl_check := $(shell (echo 072200; curl-config --vernum) 2>/dev/null | sort -r | sed -ne 2p)
> +	curl_check := $(shell (echo 072200; curl-config --vernum | sed -e '/^70[B-C]/ s/^7/07/') 2>/dev/null | sort -r | sed -ne 2p)
>  	ifeq "$(curl_check)" "072200"
>  		USE_CURL_FOR_IMAP_SEND = YesPlease
>  	endif

Thanks, will apply but with sed part tweaked to '/^70[BC]/s/^/0/'
instead.

The existing tests that copied and pasted are bad enough.  Can we
consolidate them into some helper or a shorter idiom that lets us
more easily ask "Do we have cURL version X or higher?"
