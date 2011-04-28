From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Honor sysconfdir when set as an configure option
Date: Thu, 28 Apr 2011 14:05:09 -0700
Message-ID: <7vzkna2ika.fsf@alter.siamese.dyndns.org>
References: <20110428022922.GC4833@camk.edu.pl>
 <7v62py5nbp.fsf@alter.siamese.dyndns.org> <20110428192751.GE4833@camk.edu.pl>
 <20110428200113.GF4833@camk.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
	Steffen Prohaska <prohaska@zib.de>
To: Kacper Kornet <kornet@camk.edu.pl>
X-From: git-owner@vger.kernel.org Thu Apr 28 23:05:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFYOy-0001LO-JN
	for gcvg-git-2@lo.gmane.org; Thu, 28 Apr 2011 23:05:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752761Ab1D1VF0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2011 17:05:26 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:33973 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752675Ab1D1VFY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2011 17:05:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8EB445497;
	Thu, 28 Apr 2011 17:07:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/16IcOhfxoBirY/KYO2ySdJkZl0=; b=esG6cM
	7hUOHhdq/x4jcyJDO7CW9TLIutuqba0p2ORwhXt1irjO7jR9mLmfdya1Eh/PReyN
	P6PN7hd/2exYGhxcEIBPiC5AxAGOXCkifh/e8clkZuhOKpB8vk1JQJ+v0CMCDhqi
	00aQb0BEjsIVJGh+rgu4pawjqgzHgE0C+v8yE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EIcPjssH4uQJqpkwqEsQHXaQ8dgxI+aR
	Fu6vKiLBg/OBlQW4JyWjITf6+im+aNY3qNfPWC/JURpR73c7S+AQRZmKDCDM8xAb
	AuwOSkmLK5Xor+ssc/xfDvF8rj6m8pTkW6/KD088XAEa/f7XzRkJIo8G9IqWUgeE
	R1IvAYv+nZo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 47D765491;
	Thu, 28 Apr 2011 17:07:19 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E1D29548A; Thu, 28 Apr 2011
 17:07:13 -0400 (EDT)
In-Reply-To: <20110428200113.GF4833@camk.edu.pl> (Kacper Kornet's message of
 "Thu, 28 Apr 2011 22:01:13 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 80B1BAAC-71DB-11E0-9697-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172408>

Kacper Kornet <kornet@camk.edu.pl> writes:

> ./configure can be run with option --sysconfdir=...
> and Makefile should respect that choice.

Thanks.  That statement is not wrong per-se, but your patch will result in
git_etcdir always set to the same as $(sysconfdir) that is an absolute
path, which in turn would mean that the build product with prefix set to
something other than /usr won't relocate well, no?

Not that I personally deeply care about it, but I understand msysgit folks
spent considerable amount of brainpower to come up with the arrangement,
so they may want to have a say on this patch.

"git shortlog -n --no-merges --grep=msys --grep=Win -- Makefile" tells
me that Steffen Prohaska and J6t are the people to whom I need to Cc:
this.

>  ifeq ($(prefix),/usr)
> -sysconfdir = /etc
> -git_etcdir = /etc
> +sysconfdir ?= /etc
> +git_etcdir ?= /etc
>  else
> -sysconfdir = $(prefix)/etc
> -git_etcdir = etc
> +sysconfdir ?= $(prefix)/etc
> +git_etcdir ?= etc
>  endif
>  
>  ifdef CHECK_HEADER_DEPENDENCIES
> diff --git a/config.mak.in b/config.mak.in
> index e378534..ac5912d 100644
> --- a/config.mak.in
> +++ b/config.mak.in
> @@ -15,6 +15,8 @@ TCLTK_PATH = @TCLTK_PATH@
>  prefix = @prefix@
>  exec_prefix = @exec_prefix@
>  bindir = @bindir@
> +sysconfdir = @sysconfdir@
> +git_etcdir = @sysconfdir@
>  gitexecdir = @libexecdir@/git-core
>  datarootdir = @datarootdir@
>  template_dir = @datadir@/git-core/templates
> -- 
> 1.7.5
