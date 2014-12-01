From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix build with LDFLAGS="-Wl,--as-needed"
Date: Mon, 01 Dec 2014 07:58:53 -0800
Message-ID: <xmqqsigzqs3m.fsf@gitster.dls.corp.google.com>
References: <1417426409-7328-1-git-send-email-polynomial-c@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Lars Wendler <polynomial-c@gentoo.org>
X-From: git-owner@vger.kernel.org Mon Dec 01 16:59:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvTNU-00020W-Bq
	for gcvg-git-2@plane.gmane.org; Mon, 01 Dec 2014 16:59:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932139AbaLAP7D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2014 10:59:03 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:56147 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932074AbaLAP7B (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2014 10:59:01 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D1617226DE;
	Mon,  1 Dec 2014 10:58:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lKvnaFRvLSrdRPmWv58fTIKP1Xg=; b=QWvsPU
	LQ/K1raNe0Rv6xBYgILqInpuW6R64f6NMCBtmmVXLcgWV/oDxBSc8PhFQOdicPiG
	8VDwoDncKf70EnBYNoxyAyz9tcucRBNwDN6SyfQzLrg7LGNgeQWZNALie5sV7pkN
	VmvqLPNveuCyebkvChvGGFaoqBZK7620930hA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FVJu2VnjBV06VBvJ712z12GOOPsJBo1U
	MBJx+LaqmELfwcHKEqe2oYmt6MRsw5ZYB+jJ9Ea+WPsJztgKEXUoG/qaUEOSuHOR
	hAAJayWO5rrVQEHjT1lCN9c/KDMf2jckrQmbJCzBpmlaWf86XYBpbZ4pwcY8aDxA
	XQe18l2KCHY=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C870B226DD;
	Mon,  1 Dec 2014 10:58:55 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 456D0226DC;
	Mon,  1 Dec 2014 10:58:55 -0500 (EST)
In-Reply-To: <1417426409-7328-1-git-send-email-polynomial-c@gentoo.org> (Lars
	Wendler's message of "Mon, 1 Dec 2014 10:33:29 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F3E364F6-7972-11E4-92B8-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260487>

Lars Wendler <polynomial-c@gentoo.org> writes:

> Subject: Re: [PATCH] Fix build with LDFLAGS="-Wl,--as-needed"

Please identify what area you are touching, e.g.

	Subject: contrib/svn-fe: avoid early $(EXTLIBS) on linker invocation

or whatever.

"Fix build" does not tell us why this change is needed; it does not
say what breaks, how and most importantly why it breaks.  Please
have explanation in the commit message body, e.g.

	When attempting to build svn-fe with LDFLAGS=-Wl,--as-needed,
	I noticed that ... breaks in such and such way.  This is
	because you must not have X before Y due to Z.

        Fix this by doing A, B and C, which makes sure X comes after
        Y.

or somesuch.

> Signed-off-by: Lars Wendler <polynomial-c@gentoo.org>
> ---

>  contrib/svn-fe/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/contrib/svn-fe/Makefile b/contrib/svn-fe/Makefile
> index e8651aa..b90cf87 100644
> --- a/contrib/svn-fe/Makefile
> +++ b/contrib/svn-fe/Makefile
> @@ -74,7 +74,7 @@ endif
>  endif
>  
>  svn-fe$X: svn-fe.o $(VCSSVN_LIB) $(XDIFF_LIB) $(GIT_LIB)
> -	$(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) $(EXTLIBS) -o $@ svn-fe.o $(LIBS)
> +	$(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) -o $@ svn-fe.o $(LIBS) $(EXTLIBS)

I do not understand the original, which has

	EXTLIBS =

	GIT_LIB = ../../libgit.a
	VCSSVN_LIB = ../../vcs-svn/lib.a
	LIBS = $(VCSSVN_LIB) $(GIT_LIB) $(EXTLIBS)

i.e. it shouldn't be necessary to explicitly list EXTLIBS, as it
already has LIBS at the end, which in turn has EXTLIBS at the end.

Which in turn means I do not understand your updated version,
either.  If having EXTLIBS before svn-fe.o is bad (and it is---a
linker invocation lists *.o files that need to be linked first, and
then libraries to find the symbols requested by those *.o files),
wouldn't a fix be to just drop $(EXTLIBS)?  Why is it necessary to
list it twice?
