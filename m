From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 3/3] Add support for -p/--patch to git-commit
Date: Sun, 08 May 2011 12:27:24 -0700
Message-ID: <7vliyhro0z.fsf@alter.siamese.dyndns.org>
References: <BANLkTi=Y5o=KP1LnkKqGq31Sqfn-ZZCGNA@mail.gmail.com>
 <1304791087-2965-1-git-send-email-conrad.irwin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Valentin Haenel <valentin@fsfe.org>
To: Conrad Irwin <conrad.irwin@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 08 21:27:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJ9du-0001KM-CD
	for gcvg-git-2@lo.gmane.org; Sun, 08 May 2011 21:27:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754601Ab1EHT1g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 May 2011 15:27:36 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:53635 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753946Ab1EHT1f (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2011 15:27:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3407A55DD;
	Sun,  8 May 2011 15:29:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=15cs2C1hLYrP3NpX3OGPFug0JTo=; b=kql9O4
	klF2I7WiCj/+sL7u8zIfUUUSqbDYSTdEzLAKhp+Qkf1BB8WA4PNYBpINDR/EMrf9
	7+9TyVD8pbdbD8AadPIAJCEzgrZ1NnijSC8jW1e+ESFP2pVvS5Ijwt4G9a6NAiX/
	3rARtTJsmLI5iDUF6f2jTaYVrSKr18YlOTAfc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=F8lz0rcOFGZYIIEMVreMYSH8iMFM3Wq2
	W9Jf/OL7PRLZ8Z2LHdgTkO4tZNKZMFo+5hT+1xannC/CKu3xQqHv9xzj7safLpfl
	y3vJkXZhzLXRl0FqBCxtG6cWlOOb8aKd0QvPnoqrwmuBZykLiypFzNtJ+rEZ46Uf
	+2AVbAsmTOI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 00B1955DC;
	Sun,  8 May 2011 15:29:35 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 8613555DB; Sun,  8 May 2011
 15:29:31 -0400 (EDT)
In-Reply-To: <1304791087-2965-1-git-send-email-conrad.irwin@gmail.com>
 (Conrad Irwin's message of "Sat, 7 May 2011 10:58:07 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8207ECF2-79A9-11E0-89EA-90BEB0B5FC3A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173173>

Conrad Irwin <conrad.irwin@gmail.com> writes:

> diff --git a/builtin/add.c b/builtin/add.c
> index d39a6ab..f02524b 100644
> --- a/builtin/add.c
> +++ b/builtin/add.c
> @@ -241,7 +241,7 @@ int run_add_interactive(const char *revision, const char *patch_mode,
>  	return status;
>  }
>  
> -int interactive_add(int argc, const char **argv, const char *prefix)
> +int interactive_add(int argc, const char **argv, const char *prefix, int patch)
>  {
>  	const char **pathspec = NULL;
>  
> @@ -252,7 +252,7 @@ int interactive_add(int argc, const char **argv, const char *prefix)
>  	}
>  
>  	return run_add_interactive(NULL,
> -				   patch_interactive ? "--patch" : NULL,
> +				   patch ? "--patch" : NULL,
>  				   pathspec);
>  }

This removes one reason for patch_interactive to be a file level global
variable. Perhaps we should plan to move builtin_add_options[] and the
file level global variables in builtin/add.c to cmd_add() and turn them
into on-stack variables.

It obviously is a totally separate topic, though.
