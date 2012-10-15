From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] exclude: fix a bug in prefix comparison optimization
Date: Mon, 15 Oct 2012 11:09:26 +0700
Message-ID: <CACsJy8DEqkPob+KjFS_Y3BraS40CSP7snS3aB41hg0Ng0DuJDg@mail.gmail.com>
References: <1350214522-3242-1-git-send-email-pclouds@gmail.com> <7v8vb9yn09.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 15 06:10:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNc0K-0004o7-CW
	for gcvg-git-2@plane.gmane.org; Mon, 15 Oct 2012 06:10:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751125Ab2JOEJ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2012 00:09:58 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:38482 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751012Ab2JOEJ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2012 00:09:57 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so4559795oag.19
        for <git@vger.kernel.org>; Sun, 14 Oct 2012 21:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=XTbljAkdliO9GuZh6a1KYTrco446Tfc/UF8rqSf66ko=;
        b=KPsKK/fzBP+QZKe5oRikw7ippKzWYMDDvMIGw+BR73qDuMAIfTc1vnPxKkPIMjidED
         VX93N/mdlA9uLnNXTwL3Z7eOExf3+GqMaxpF+ZZu1dWQmPPGPm1zlWHHN6kYyV7p9y88
         ZZZdyv1oQvmLKZ8a5jvQj3FRKB3sSFZ2snNyNqhtpmpt5AGcCWtiW2lTHdGYBwoXvOj/
         8/qkEdYh2Pb0M8XyQi26qRNDkhnsqihLFaFKT0hGcjC/SuFeR03Q/4AgT3dLPMpY8wER
         wTYcwsAAHBbfn84iLVuBDsODOgrLmj7jg5qKA7Biw4MoNLwEZwOBb19sVxfMpCtC7InU
         Eq7g==
Received: by 10.60.1.40 with SMTP id 8mr6797209oej.55.1350274196405; Sun, 14
 Oct 2012 21:09:56 -0700 (PDT)
Received: by 10.182.108.10 with HTTP; Sun, 14 Oct 2012 21:09:26 -0700 (PDT)
In-Reply-To: <7v8vb9yn09.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207688>

On Mon, Oct 15, 2012 at 12:36 AM, Junio C Hamano <gitster@pobox.com> wrote:
> With your "teach attr.c match the same optimization as dir.c"
> series, you would need something like this
>
> diff --git i/attr.c w/attr.c
> index 6d39406..528e935 100644
> --- i/attr.c
> +++ w/attr.c
> @@ -710,7 +710,7 @@ static int path_matches(const char *pathname, int pathlen,
>          * if the non-wildcard part is longer than the remaining
>          * pathname, surely it cannot match.
>          */
> -       if (!namelen || prefix > namelen)
> +       if (prefix > namelen)
>                 return 0;
>         if (baselen != 0)
>                 baselen++;

If there's still a chance to rewrite attr-match-optim-more series (I
see it's in next now), then I could reorder the patches so that
excluded_from_list code refactoring goes first, then rewrite "teach
attr.c match... as dir.c" patch makes use of the new functions without
code duplication. The end result would be the same, except that we
won't see this bug in attr.c's history. Not much value so if it may
take a lot of your time, don't bother.
--
Duy
