From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/9] autoconf: Check for struct itimerval
Date: Thu, 28 Aug 2014 12:38:42 -0700
Message-ID: <xmqqd2bk9zgd.fsf@gitster.dls.corp.google.com>
References: <1409187862-21257-1-git-send-email-sortie@maxsi.org>
	<1409187862-21257-6-git-send-email-sortie@maxsi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jonas 'Sortie' Termansen <sortie@maxsi.org>
X-From: git-owner@vger.kernel.org Thu Aug 28 21:39:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XN5X8-0006j7-B6
	for gcvg-git-2@plane.gmane.org; Thu, 28 Aug 2014 21:38:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752407AbaH1Tiy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2014 15:38:54 -0400
Received: from smtp.pobox.com ([208.72.237.35]:53047 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750923AbaH1Tix (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2014 15:38:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B557435107;
	Thu, 28 Aug 2014 15:38:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=I/frEbKuOtTdUsewowUv+sLd41w=; b=MQRn6n
	xyGRgayp1xrIDVgKOTeEThiCads/RiK4FrS86kIAIn3pehYyXS8glDiJ0Utw4v6S
	VBBzK0or0mB0V1RjISpFuFjIieYsRtVmd9cnFqsPZQpSIqrifpFnXsOeor71phRF
	F8ytL1i8nnGDLIjGa+WmmKF5t1pFvCaEJObEY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VKU0FpijbvcJoM1hszr/5GHgXP48UW9p
	9eb6Q2HvYhDIpvl2KNtiUV9fR4zw5qPH6Od5jrU6eyhKQrpT1sIJYO7TPN+vf/CR
	w8zxY27IGRaVEEPl9RMbe/qSRZQwuK5OAkI7OkPbUmZ8z1122eYwXCfaJjTiC64H
	CG302dIUY1E=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AC3D035106;
	Thu, 28 Aug 2014 15:38:52 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E5D8B350FD;
	Thu, 28 Aug 2014 15:38:43 -0400 (EDT)
In-Reply-To: <1409187862-21257-6-git-send-email-sortie@maxsi.org> (Jonas
	Termansen's message of "Thu, 28 Aug 2014 03:04:18 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: EBB23442-2EEA-11E4-86A4-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256118>

Jonas 'Sortie' Termansen <sortie@maxsi.org> writes:

> The makefile has provisions for this case, so let's detect it in
> the configure script as well.
>
> Signed-off-by: Jonas 'Sortie' Termansen <sortie@maxsi.org>
> ---

This, 1/9 and later 7/9, are independently good changes to the
current codebase, unlike all the other patches that become only
necessary if/when we want to migrate to timer_settime().

As such, we would prefer to have these "fixes to the current system"
at the beginning of the series before "enhancements to the current
system" patches.

Thanks.

>  configure.ac | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/configure.ac b/configure.ac
> index 31b3218..00842ae 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -761,6 +761,13 @@ AC_CHECK_TYPES([struct timespec],
>  [#include <sys/time.h>])
>  GIT_CONF_SUBST([NO_STRUCT_TIMESPEC])
>  #
> +# Define NO_STRUCT_ITIMERVAL if you don't have struct itimerval.
> +AC_CHECK_TYPES([struct itimerval],
> +[NO_STRUCT_ITIMERVAL=],
> +[NO_STRUCT_ITIMERVAL=UnfortunatelyYes],
> +[#include <sys/time.h>])
> +GIT_CONF_SUBST([NO_STRUCT_ITIMERVAL])
> +#
>  # Define NO_D_INO_IN_DIRENT if you don't have d_ino in your struct dirent.
>  AC_CHECK_MEMBER(struct dirent.d_ino,
>  [NO_D_INO_IN_DIRENT=],
