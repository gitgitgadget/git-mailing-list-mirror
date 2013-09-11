From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Windows: Do not redefine _WIN32_WINNT
Date: Wed, 11 Sep 2013 11:29:14 -0700
Message-ID: <xmqq4n9rtdol.fsf@gitster.dls.corp.google.com>
References: <52309507.1090908@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Karsten Blees <karsten.blees@gmail.com>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 11 20:29:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJpAM-0002U9-NT
	for gcvg-git-2@plane.gmane.org; Wed, 11 Sep 2013 20:29:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755331Ab3IKS3X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Sep 2013 14:29:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55471 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754840Ab3IKS3V (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Sep 2013 14:29:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 094DC4033B;
	Wed, 11 Sep 2013 18:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XlYJ+msBMReIt88+gxN0364fLMQ=; b=Rm5N/e
	0mbOLKk2SAyDZPopOfRtUT4qN7crc61XIdqzT7sfQQuL/TD7IEde9mla4jRmx1YW
	pLI4ph4frGyZTonezYtrYORdpcWXFhJj3+Ks5a8mCprnJZqeCzl2DUGQe1yzfSjL
	GWdOxSLMvMw04rilHcZsR4eWONnzsf73VwXFQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=d/uIj/hG8Xmn2YxwrCHxzYCPfNv3zW6O
	+WUOlZelogkfIZ7+eVyJnXAQK+LrDk9Co9TydarmC2GLnUP58ZgQ7j5okvMDQ5CI
	iunsT7wQpIb2bC0deUF19mbXjxnI+J89T2KsPNjr7+twRm2+VHV3TDbBcCPwRAur
	3QtlYsbnUYY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D63E340335;
	Wed, 11 Sep 2013 18:29:19 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E28FC40322;
	Wed, 11 Sep 2013 18:29:16 +0000 (UTC)
In-Reply-To: <52309507.1090908@gmail.com> (Sebastian Schuberth's message of
	"Wed, 11 Sep 2013 18:06:31 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 1192B0F0-1B10-11E3-9A64-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234593>

Sebastian Schuberth <sschuberth@gmail.com> writes:

> diff --git a/git-compat-util.h b/git-compat-util.h
> index 664305c..f5c756d 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -93,7 +93,9 @@
>  #undef __NO_INLINE__
>  
>  #ifdef WIN32 /* Both MinGW and MSVC */
> +#ifndef _WIN32_WINNT
>  #define _WIN32_WINNT 0x0502
> +#endif
>  #define WIN32_LEAN_AND_MEAN  /* stops windows.h including winsock.h */
>  #include <winsock2.h>
>  #include <windows.h>

This unfortunately does not seem to match what I have. I think the
patch is based on the codebase before these two:

 380395d0 (mingw: rename WIN32 cpp macro to GIT_WINDOWS_NATIVE, 2013-05-02)
 41f29991 (msvc: Fix compilation errors caused by poll.h emulation, 2013-01-31)

I could of course wiggle it in, if you want, but I wanted to know
what is going on.  Is it a pre-release freeze period on your side or
something?
