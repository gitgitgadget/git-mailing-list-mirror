From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Makefile: fix location of listing produced by "make
 subdir/foo.s"
Date: Sun, 22 Jul 2012 22:11:21 -0700
Message-ID: <7vk3xvnjt2.fsf@alter.siamese.dyndns.org>
References: <20120722234726.GC2012@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 07:11:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StAvY-0005Xp-Ld
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jul 2012 07:11:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753401Ab2GWFLY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jul 2012 01:11:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49812 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752974Ab2GWFLX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2012 01:11:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 404D45B7D;
	Mon, 23 Jul 2012 01:11:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6EBgmKzCuCjlmtaGghsq5l5vAxY=; b=Wk0Gls
	QCzhNygdJPNDaaLYdAc6ExWTyh6ILmEmdUt4cZOhVn65VYhWBLEeY9twNn7QhJlM
	x4ASuwEFtKaUlUUpoEKTrX4O/pWX9skiZ4LmHm3L0ayLsnxVnaCsjeBx1J+4pWvB
	PYd3O6O7Ex5+0fSG35AinDDNrYXfW7jcNdeUY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CHT4e4LnLfGJAUkJUy/DZVqcJbN1rKkv
	FtK9QlLIINGECAN7Liv2LT2Gon0QnnipzW3SeDTQGBwT5cknWb2Xg5jU8S236Xyw
	6AqvPhCK/bq7bZweQGwbSs19hIuL2utV8bqu9E3Mr/RI3ln1gzDO2q+ZGRprvS6i
	TI340yqhB0k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2DC8D5B7C;
	Mon, 23 Jul 2012 01:11:23 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7D58E5B7B; Mon, 23 Jul 2012
 01:11:22 -0400 (EDT)
In-Reply-To: <20120722234726.GC2012@burratino> (Jonathan Nieder's message of
 "Sun, 22 Jul 2012 18:47:26 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D829B3E0-D484-11E1-9182-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201900>

Jonathan Nieder <jrnieder@gmail.com> writes:

> When I invoke "make block-sha1/sha1.s", 'make' runs $(CC) -S without
> specifying where it should put its output and the output ends up in
> ./sha1.s.  Confusing.
>
> Add an -o option to the .s rule to fix this.  We were already doing
> that for most compiler invocations but had forgotten it for the
> assembler listings.
>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> Hi,
>
> This patch is from below the scissors at
> http://thread.gmane.org/gmane.comp.version-control.git/201434/focus=201485
>
> I think it's a good change, but as usual it's nice if someone else
> takes a look at it and gives it a sanity check.  If it seems sane,
> I'd be happy to see it applied.  What do you think?
>
> Thanks,
> Jonathan

Yeah, I think it is a sensible thing to do.

>  Makefile |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index 285c660e..8bfa19cd 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2263,7 +2263,7 @@ $(ASM_OBJ): %.o: %.S GIT-CFLAGS $(missing_dep_dirs)
>  endif
>  
>  %.s: %.c GIT-CFLAGS FORCE
> -	$(QUIET_CC)$(CC) -S $(ALL_CFLAGS) $(EXTRA_CPPFLAGS) $<
> +	$(QUIET_CC)$(CC) -o $@ -S $(ALL_CFLAGS) $(EXTRA_CPPFLAGS) $<
>  
>  ifdef USE_COMPUTED_HEADER_DEPENDENCIES
>  # Take advantage of gcc's on-the-fly dependency generation
