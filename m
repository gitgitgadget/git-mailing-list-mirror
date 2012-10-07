From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Allow generating a non-default set of documentation
Date: Sun, 07 Oct 2012 16:25:58 -0700
Message-ID: <7vlifhooe1.fsf@alter.siamese.dyndns.org>
References: <7vzk3yow3f.fsf@alter.siamese.dyndns.org>
 <20121007214855.GB1743@sigill.intra.peff.net>
 <7vwqz1oqi4.fsf@alter.siamese.dyndns.org>
 <20121007230703.GC3490@sigill.intra.peff.net>
 <20121007231156.GD3490@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Oct 08 01:26:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TL0Em-0001h8-N4
	for gcvg-git-2@plane.gmane.org; Mon, 08 Oct 2012 01:26:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754753Ab2JGX0F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Oct 2012 19:26:05 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42428 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754698Ab2JGX0B (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2012 19:26:01 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 57C719B5F;
	Sun,  7 Oct 2012 19:26:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AB62nD6z8K8kHBQCf/WCnOSBdJQ=; b=QkPojG
	FN9uMdIVnXlpRIjoiV6Yo96Q2x5mSqOewqOGSyJebhqMcjn5NIE/zJ3Rnb6XN00+
	g8H9piKL7ScvoczYBktIL3673O8FN2+rYaP8bSbjDJO5KiuQeOOJfALk35oXJ8w2
	v5JeYkP+n7XSzINQO7gSL3yqkTmIj2Ifo4uac=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=acDBZ5GD8MZliE4wTne1jywn0rTzfEIZ
	8b8C5AVzdpirzK2IuXTQb0hD3dJfS1HsoFkM9Xe0+9aXUPXumoRSGWIIVll3gb8W
	a5xNAT8NGYjP0n6CvcSkyJ0NWvgkjh0FwY4Ga9czeOvWBQIKk3XzomWxwg7sTRI5
	7YYrfW3k+B0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 442029B5E;
	Sun,  7 Oct 2012 19:26:00 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8EF609B5D; Sun,  7 Oct 2012
 19:25:59 -0400 (EDT)
In-Reply-To: <20121007231156.GD3490@sigill.intra.peff.net> (Jeff King's
 message of "Sun, 7 Oct 2012 19:11:56 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5A24AC14-10D6-11E2-AB42-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207215>

Jeff King <peff@peff.net> writes:

> On Sun, Oct 07, 2012 at 07:07:03PM -0400, Jeff King wrote:
>
>> Would it make sense to pull all of our platform-specific tweaks out into
>> a config.mak.platform (right before config.mak.autogen)? That would be
>> less surprising for cases like this, and I think it would make the
>> Makefile a lot more readable.
>
> Something like the patch below. Note that you could then base even more
> decisions on the existing DEFAULT_HELP_FORMAT that is already in the
> Makefile (and after my patch, in config.mak.defaults). For example, when
> it is set to html, make both the default build and install targets in
> Documentation/Makefile do html instead of man.

Yeah, modulo that the "defaults" is tracked and does not have to
have the dash before "include" (it is an error if it is missing,
no?).  It may want to be named with s/defaults/autodetect/, though.

> diff --git a/Makefile b/Makefile
> index e3e3cd5..c00fd32 100644
> --- a/Makefile
> +++ b/Makefile
> ...
> -endif
> -
> +-include config.mak.defaults
>  -include config.mak.autogen
>  -include config.mak
