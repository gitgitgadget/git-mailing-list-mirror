From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix build problems related to profile-directed
 optimization
Date: Thu, 09 Feb 2012 10:22:38 -0800
Message-ID: <7vr4y3x3wx.fsf@alter.siamese.dyndns.org>
References: <20120206055750.GA6615@thunk.org>
 <1328508017-7277-1-git-send-email-tytso@mit.edu>
 <20120208185319.GB9397@thunk.org> <4F338242.8080907@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ted Ts'o <tytso@mit.edu>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Feb 09 19:22:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvYds-0005T1-0y
	for gcvg-git-2@plane.gmane.org; Thu, 09 Feb 2012 19:22:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758217Ab2BISWl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Feb 2012 13:22:41 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48796 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754163Ab2BISWk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Feb 2012 13:22:40 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1FE817140;
	Thu,  9 Feb 2012 13:22:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HXZ0BVZq3lxVXEeSwuYB/4qCx+M=; b=moDBb3
	07xSE6/pDDI6zh8VR1Xupcja5pn4RM2pB/jDne5tikf/bySNll3zdnMDT37h+06h
	AviPodQiqvdG5hf4qPCLdUcAkAr/jcADct7cgjq8YgfbP3rsC+caxEHAmOa3rEe4
	ZsPYDXUKLRVSVhboZnGfKI9qoWsWuZWalzgdc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Z0tnMjZ9I4El1tFSeFct+7YbMvm2wBJG
	vBraUFdzAyiFZXXM8IYR1vLxPV1DdePxU3RUrwtSgMLBOCsHcG/hCyETTOe9CpK6
	/iNJOdfTWVdVxe5UaUKEQx8qaK/MKAlWZI5PtMjqncosqU8d836wD7NODD7B87Ip
	u7p2tgIIHlA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 16F63713F;
	Thu,  9 Feb 2012 13:22:40 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 92799713E; Thu,  9 Feb 2012
 13:22:39 -0500 (EST)
In-Reply-To: <4F338242.8080907@viscovery.net> (Johannes Sixt's message of
 "Thu, 09 Feb 2012 09:22:26 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0C8DFA94-534B-11E1-AF70-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190302>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Am 2/8/2012 19:53, schrieb Ted Ts'o:
>> Junio, any comments on my most recent spin of this patch?  Any changes
>> you'd like to see?
>
> I need the following to unbreak my build on Windows.

Thanks; will apply.

> --- >8 ---
> From: Johannes Sixt <j6t@kdbg.org>
> Subject: [PATCH] Makefile: fix syntax for older make
>
> It is necessary to write the else branch as a nested conditional. Also,
> write the conditions with parentheses because we use them throughout the
> Makefile.
>
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
>  Makefile |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index bfc5daa..01a3c77 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1784,16 +1784,18 @@ endif
>  # data gathering
>  PROFILE_DIR := $(CURDIR)
>  
> -ifeq "$(PROFILE)" "GEN"
> +ifeq ("$(PROFILE)","GEN")
>  	CFLAGS += -fprofile-generate=$(PROFILE_DIR) -DNO_NORETURN=1
>  	EXTLIBS += -lgcov
>  	export CCACHE_DISABLE=t
>  	V=1
> -else ifneq "$(PROFILE)" ""
> +else
> +ifneq ("$(PROFILE)","")
>  	CFLAGS += -fprofile-use=$(PROFILE_DIR) -fprofile-correction -DNO_NORETURN=1
>  	export CCACHE_DISABLE=t
>  	V=1
>  endif
> +endif
>  
>  # Shell quote (do not use $(call) to accommodate ancient setups);
