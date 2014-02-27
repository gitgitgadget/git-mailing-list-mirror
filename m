From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Rewrite git-compat-util.h:skip_prefix() as a loop
Date: Thu, 27 Feb 2014 11:35:45 -0800
Message-ID: <xmqqd2i8z6um.fsf@gitster.dls.corp.google.com>
References: <1393503197-29669-1-git-send-email-sunheehnus@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sun He <sunheehnus@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 27 20:35:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJ6kK-0007zu-MD
	for gcvg-git-2@plane.gmane.org; Thu, 27 Feb 2014 20:35:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752722AbaB0Tft (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Feb 2014 14:35:49 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40508 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752563AbaB0Tfs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Feb 2014 14:35:48 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C74F37060A;
	Thu, 27 Feb 2014 14:35:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NQYloSCNj9Cl8ngatTKcFY9IkAs=; b=YSh8h9
	0ViRcYrKElVYO0njQPntpXmDej+tr+1nr36MWOH5nrZq9rQ53ga4cRYLy/mZacrG
	cpWwoBe5/yfR3+ceZ4w3y9kaFJc/+Fv/8V17N5mlM3kOkZVg9jEgLbnceBVrShVr
	a4i+EzfJmdUEHbxPPcn6pVbmgH//71crrCHa4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iSq7edVSaIpnwrb9nMljzWPfkHZjw7Sq
	5S3cOWwHUUU2CeY9JxpQOtsxxS96gphZN3useKBWd9C9U/O9gcbdYozPak0O1beu
	nab9N9LCVvjGTmG730IgHtnqNabKgaxPhzNjpy+EWmdN1Uw83tepEbLwURpGZA9W
	scRTJ97MQs4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B74A170609;
	Thu, 27 Feb 2014 14:35:47 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F393770604;
	Thu, 27 Feb 2014 14:35:46 -0500 (EST)
In-Reply-To: <1393503197-29669-1-git-send-email-sunheehnus@gmail.com> (Sun
	He's message of "Thu, 27 Feb 2014 20:13:17 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 5B0C3ED0-9FE6-11E3-AFDE-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242841>

Sun He <sunheehnus@gmail.com> writes:

> Signed-off-by: Sun He <sunheehnus@gmail.com>
> ---
>  git-compat-util.h |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/git-compat-util.h b/git-compat-util.h
> index cbd86c3..4daa6cf 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -357,8 +357,8 @@ extern int suffixcmp(const char *str, const char *suffix);
>  
>  static inline const char *skip_prefix(const char *str, const char *prefix)
>  {
> -	size_t len = strlen(prefix);
> -	return strncmp(str, prefix, len) ? NULL : str + len;
> +    while( *prefix != '\0' && *str++ == *prefix++ );
> +    return *prefix == '\0' ? str : NULL;

Documentation/CodingGuidelines?

>  }
>  
>  #if defined(NO_MMAP) || defined(USE_WIN32_MMAP)
