From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/19] mingw: let's use gettext with MSYS2
Date: Sun, 24 Jan 2016 17:42:00 -0800
Message-ID: <xmqqio2ibfkn.fsf@gitster.mtv.corp.google.com>
References: <cover.1453650173.git.johannes.schindelin@gmx.de>
	<7162dcb55e6a317cba840ef1176d09d99fc37f6b.1453650173.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jan 25 02:42:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNWAT-0004ih-PE
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jan 2016 02:42:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754677AbcAYBmF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jan 2016 20:42:05 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:60913 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754209AbcAYBmD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jan 2016 20:42:03 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id F28313FE4A;
	Sun, 24 Jan 2016 20:42:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VJZrcCS2qJs4AXOadRSt9TEnnqU=; b=iNn1K1
	SGkxMcZ6nJZi6vRZVUxcNmCT2uNfZySlIVEU3n43EN+ldKzjOROerYKIwW5IPpWE
	F1SFUIwTQ7+PB1eEzapFPNZ/7HTM1TK7IpX7bcgoNOdu/Xz9YUISQExBs0oukqUU
	WGA/2HprAqBlMCDyJDwf5TqMGZ3qEsbeVC0vM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JP7XnJ3ZQeacs/vXUHifYZni7NsFohkH
	1p6ihWxMMrsl4NbkVY4wDakh94t+oFkMNsC6sTSN3mr5xsV062vf53glvVkewFvN
	+Gs+80NvDxgAs+YV9XjwOZL8b2DcNkcnqDE008KiaKzIVFqtpJ30sas8YnxMEmp7
	MIrjQ36yP6c=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CDF233FE49;
	Sun, 24 Jan 2016 20:42:02 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 90EF33FE45;
	Sun, 24 Jan 2016 20:42:01 -0500 (EST)
In-Reply-To: <7162dcb55e6a317cba840ef1176d09d99fc37f6b.1453650173.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Sun, 24 Jan 2016 16:43:13 +0100
	(CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D47070D2-C304-11E5-A62B-80A36AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284707>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> This solves two problems:
>
> - we now have proper localisation even on Windows
>
> - we sidestep the infamous "BUG: your vsnprintf is broken (returned -1)"
>   message when running "git init" (which otherwise prevents the entire
>   test suite from running)

It is unclear to me how gettext is related to use of vsnprintf().
"sidestep" hints me that perhaps we do not call vsnprintf() from
strbuf_vaddf() in a way that reveals its breakage when we are using
gettext, but I am not quite seeing how.

Because as the next sentence says, that does sound like a critical
issue not to be able to even run "init", I wanted to learn more
about the real issue.

>
> The latter issue is rather crucial, as *no* test passes in Git for
> Windows without this fix.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  config.mak.uname | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/config.mak.uname b/config.mak.uname
> index 4b2e1b8..6b25661 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -560,7 +560,7 @@ else
>  		NO_R_TO_GCC_LINKER = YesPlease
>  		INTERNAL_QSORT = YesPlease
>  		HAVE_LIBCHARSET_H = YesPlease
> -		NO_GETTEXT = YesPlease
> +		NO_GETTEXT =
>  		USE_LIBPCRE= YesPlease
>  		NO_CURL =
>  		USE_NED_ALLOCATOR = YesPlease
