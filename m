From: Timo Hirvonen <tihirvon@gmail.com>
Subject: Re: [PATCH] Fix bug in parse_color that prevented the user from
 changing the background colors.
Date: Tue, 5 Feb 2008 20:39:40 +0200
Message-ID: <20080205203940.1dcff0ce.tihirvon@gmail.com>
References: <47A89E2A.9010905@kergoth.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Chris Larson <clarson@kergoth.com>
X-From: git-owner@vger.kernel.org Tue Feb 05 19:40:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMSiV-0006nr-61
	for gcvg-git-2@gmane.org; Tue, 05 Feb 2008 19:40:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758452AbYBESjt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2008 13:39:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758383AbYBESjt
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Feb 2008 13:39:49 -0500
Received: from wa-out-1112.google.com ([209.85.146.179]:57192 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757823AbYBESjr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2008 13:39:47 -0500
Received: by wa-out-1112.google.com with SMTP id v27so33763wah.23
        for <git@vger.kernel.org>; Tue, 05 Feb 2008 10:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        bh=ufwS8AkqVK+aNc5lz13rtkxWsEoVqJ2h/omg4XkWGsk=;
        b=BiKT4PcuAA21VnD3dVu0NAulmu2x8UMAMjVhucYxHC3xQI55cToSRkupxRSVn3me7BleD07Z2POOcxtKYuwIAudrZNaKpNh/FugD5aK8FJrZzI/P/wW7PfoTCigb9OK1g/t5CpVp7M6WNZTK9geoTXZkA1v/nGe1nlpvHkllghE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=GdrV2UdiZ74cA9AUB6hPrzo1349waqpL4F0hhR6PHfX8GwS/2zCOtMBtSWajqS8ulJr2tgtjnAQzr1i016vFeiC/Wd2q9kXYXyABn9dWMNJEHt50Heds2rPUD/L3Gr3fUmB8a48kEl4RQnOHC0An9Xbbw2MIKWX5pRQ4WUs4kL4=
Received: by 10.114.123.1 with SMTP id v1mr984691wac.147.1202236787093;
        Tue, 05 Feb 2008 10:39:47 -0800 (PST)
Received: from garlic.home.net ( [85.23.16.168])
        by mx.google.com with ESMTPS id g12sm23825303nfb.27.2008.02.05.10.39.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 05 Feb 2008 10:39:45 -0800 (PST)
In-Reply-To: <47A89E2A.9010905@kergoth.com>
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.5; x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72676>

Chris Larson <clarson@kergoth.com> wrote:

> The comments in color.c indicate that the syntax for the color options 
> in the
> git config is [fg [bg]] [attr], however the implementation fails if 
> strtol is
> unable to convert the string in its entirety into an integer.
> 
> Signed-off-by: Chris Larson <clarson@kergoth.com>
> ---
>  color.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/color.c b/color.c
> index 7f66c29..62518fa 100644
> --- a/color.c
> +++ b/color.c
> @@ -17,7 +17,7 @@ static int parse_color(const char *name, int len)
>              return i - 1;
>      }
>      i = strtol(name, &end, 10);
> -    if (*name && !*end && i >= -1 && i <= 255)
> +    if (*name && i >= -1 && i <= 255)
>          return i;
>      return -2;
>  }

My bug, sorry. I should have tested more.

I think this new code accepts "7bold" (didn't test).  Maybe you should
do something like this instead:

	if (*name && (!*end || isspace(*end)) && i >= -1 && i <= 255)

Untested of course.  BTW, your patch is whitespace corrupted.
