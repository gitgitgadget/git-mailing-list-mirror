From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] clone: inform the user we are checking out
Date: Mon, 07 May 2012 12:03:46 -0700
Message-ID: <7v397b6cfh.fsf@alter.siamese.dyndns.org>
References: <1336381787-6484-1-git-send-email-kusmabite@gmail.com>
 <4FA7952C.90702@viscovery.net>
 <CABPQNSZ+FtMJ1msSmqvROP6YqRGKvz1uz8w1z5mF3YDXZyiPQw@mail.gmail.com>
 <CABPQNSbbH3ULjgYxW6RdH0emrgXoKf1mkiEAm2fR19LsC5q8_w@mail.gmail.com>
 <CABPQNSYe6dDf20D2pQpF=K97rZnWxqe5weEdO+FdKck9rwwzWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Tay Ray Chuan <rctay89@gmail.com>, git@vger.kernel.org
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Mon May 07 21:03:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRTDu-0006F6-1U
	for gcvg-git-2@plane.gmane.org; Mon, 07 May 2012 21:03:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757578Ab2EGTDu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 May 2012 15:03:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40460 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757564Ab2EGTDt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2012 15:03:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A88D27A7A;
	Mon,  7 May 2012 15:03:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=x+WR5BlHUQbkd8fpbs+0CfzIMM4=; b=mkqh/5
	kgL/sivD0bTE/R395FCSa1sV3+wow0PdTdS3yP85hFmJlcfBuMdz3mLanm7MDAC5
	kNGsXqWn1yfnTP+53It9lKoPRz+m9lgwcsoSLrYuD2Q/4XxzI0ddHDkDb9E0k//i
	n4wyZTs3LakiU0T/aZLF85vgucfXtf3W4v3Uc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=U1zmUR8XaQxxV5N7nemWRhwudi4VvPsS
	lyooWNP1UYPyxAaARMRdSlXXh4ZjYCdjKMQMUZzBeFeYtbLgFNXyrwo4LKydVOxX
	HVWHJupOQpjM/KBcwT/5fear0ZzHyp0EFmLyWMdV/oODgoboSFeTv8ZMp/PbEGG9
	gnj1X+E0i/s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9EEBA7A78;
	Mon,  7 May 2012 15:03:48 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3274E7A77; Mon,  7 May 2012
 15:03:48 -0400 (EDT)
In-Reply-To: <CABPQNSYe6dDf20D2pQpF=K97rZnWxqe5weEdO+FdKck9rwwzWg@mail.gmail.com> (Erik
 Faye-Lund's message of "Mon, 7 May 2012 12:02:46 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 604F76DC-9877-11E1-B39B-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197298>

Erik Faye-Lund <kusmabite@gmail.com> writes:

> OK, some blaming shows that this changed in 5bd631b3 ("clone: support
> multiple levels of verbosity"), back in February 2010. Before this
> patch, one would have to specify the "quiet"-flag to clone to suppress
> progress-output, after the patch the default is progress being off.
>
> This seems like the right thing to do if we want to resurrect the
> progress-output's default-on behavior:
> ---8<---
> diff --git a/builtin/clone.c b/builtin/clone.c
> index 3f863a1..f48e603 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -569,7 +569,7 @@ static int checkout(void)
>  	opts.update = 1;
>  	opts.merge = 1;
>  	opts.fn = oneway_merge;
> -	opts.verbose_update = (option_verbosity > 0);
> +	opts.verbose_update = (option_verbosity >= 0);
>  	opts.src_index = &the_index;
>  	opts.dst_index = &the_index;
>
> ---8<---

Sounds sensible, as the original said "verbosely update unless we were
told to be quiet", so the normal case should be verbose_update which will
give progress only if it takes too long.

Care to roll a signed-off patch?
