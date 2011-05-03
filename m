From: Joshua Juran <jjuran@gmail.com>
Subject: Re: [Annoyance] "git log .." thinks ".." is ambiguous
Date: Mon, 2 May 2011 18:57:42 -0700
Message-ID: <FB837238-9953-4FD8-BC52-5C0AB061C291@gmail.com>
References: <7vr58glxro.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 03 03:57:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QH4s5-0004J6-An
	for gcvg-git-2@lo.gmane.org; Tue, 03 May 2011 03:57:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754996Ab1ECB5s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2011 21:57:48 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:63709 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754293Ab1ECB5r (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2011 21:57:47 -0400
Received: by pvg12 with SMTP id 12so3431280pvg.19
        for <git@vger.kernel.org>; Mon, 02 May 2011 18:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        bh=OTZJdyZ42n3PBxp+bPcXTjEb+XCgcG2VUoj8nMVLRU8=;
        b=eTv9pfAXE0wVnLOFK6lucbsx1E2NA5bN773HWAineLTCn9YPcJd0y6RRThVSSxUIMy
         TB/O9s6zbnZunvRS74gWrCFAo3rt+Msk0+3rLluWMMb0jXH8EKyoiyHK5mIvWofl8liX
         mJ1771Yfpie8kIKzaSCHbMrLdmBWsP7mx13Zw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        b=bo5odZKqy1ZaGG0V2FQUjpMwuIF0Y+064b3KCtkf2FEVtts3Ick3Wn0d0m2iA4h7/Z
         aW9G8LsNbzMS9ZQDv8fbDN/J8NVhipOPYmJjj2xVg/EoIaH9nAFVCMs6xD5pWOA5vasr
         3n0TmUBZJ+ojm8zLro3HOq1vjwCWsUJvVPO6Q=
Received: by 10.68.54.135 with SMTP id j7mr9674463pbp.390.1304387866738;
        Mon, 02 May 2011 18:57:46 -0700 (PDT)
Received: from zaphod.jjuran.dyndns.org (c-71-227-175-60.hsd1.wa.comcast.net [71.227.175.60])
        by mx.google.com with ESMTPS id m7sm4174542pbd.33.2011.05.02.18.57.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 02 May 2011 18:57:45 -0700 (PDT)
In-Reply-To: <7vr58glxro.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172640>

On May 2, 2011, at 12:15 PM, Junio C Hamano wrote:

> diff --git a/revision.c b/revision.c
> index f4b8b38..26271d1 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -905,14 +905,26 @@ int handle_revision_arg(const char *arg,  
> struct rev_info *revs,
> 		const char *this = arg;
> 		int symmetric = *next == '.';
> 		unsigned int flags_exclude = flags ^ UNINTERESTING;
> +		static const char head_by_default[] = "HEAD";
>
> 		*dotdot = 0;
> 		next += symmetric;
>
> 		if (!*next)
> -			next = "HEAD";
> +			next = head_by_default;
> 		if (dotdot == arg)
> -			this = "HEAD";
> +			this = head_by_default;
> +		if (this == head_by_default && next == head_by_default &&
> +		    !symmetric) {

Is there a reason not to write

	const char *head_by_default = "HEAD";

or even

	const char *const head_by_default = "HEAD";

instead?  Loading a static array and checking an init flag is a  
pessimization versus just pointing into a read-only segment.

Josh
