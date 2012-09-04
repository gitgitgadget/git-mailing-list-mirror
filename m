From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 4/9] Refactor excluded_from_list
Date: Tue, 4 Sep 2012 19:32:09 +0700
Message-ID: <CACsJy8AJoR-b6bbKraNp+-eYE8vGUMUTJ2siH=rdUv2POEe-0Q@mail.gmail.com>
References: <1346544731-938-1-git-send-email-git@adamspiers.org> <1346544731-938-5-git-send-email-git@adamspiers.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git list <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Adam Spiers <git@adamspiers.org>
X-From: git-owner@vger.kernel.org Tue Sep 04 14:32:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T8sJD-000270-Om
	for gcvg-git-2@plane.gmane.org; Tue, 04 Sep 2012 14:32:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756996Ab2IDMcl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Sep 2012 08:32:41 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:54027 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756969Ab2IDMck (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2012 08:32:40 -0400
Received: by iahk25 with SMTP id k25so5199322iah.19
        for <git@vger.kernel.org>; Tue, 04 Sep 2012 05:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ZSD7dLKkYb9rxG3Aher3Vu9I0HYrpcZeEFSnsJBIFZ8=;
        b=R5r2VRctfUvGwOSuR4WU7TV12MLpbSCoEeimvrjumy16d0aBwMyMIo/x/8u5uilztJ
         In2zAVU178dAehf7GkL3A/1ibVcwF7uJMCPmD9Ft2qQOge4VrZv3E8r3UGVGxANiqsq+
         zudhPkeWYb40ehwmHIrlSgHG+62Z+y5bwr3eSZ7688xUiIDVtIIJEYPFTAFHtnDV4jJm
         Pf/fgaV0hE+r415I4q650MSgytgW94bhcKhGgbfk0YI4HU1Lj0sO83ZWJQkys0VIyC4f
         e2tJMdawTU6D0YGkszFl9Aeum5me+tNzONDaab1fk0kb44mYUu3QiPtymJnyJEpTxM43
         Rxdg==
Received: by 10.50.159.130 with SMTP id xc2mr13806814igb.15.1346761960023;
 Tue, 04 Sep 2012 05:32:40 -0700 (PDT)
Received: by 10.64.64.72 with HTTP; Tue, 4 Sep 2012 05:32:09 -0700 (PDT)
In-Reply-To: <1346544731-938-5-git-send-email-git@adamspiers.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204741>

On Sun, Sep 2, 2012 at 7:12 AM, Adam Spiers <git@adamspiers.org> wrote:
> diff --git a/dir.c b/dir.c
> index 57a5d11..3a532d5 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -509,22 +509,24 @@ static void prep_exclude(struct dir_struct *dir, const char *base, int baselen)
>         dir->basebuf[baselen] = '\0';
>  }
>
> -/* Scan the list and let the last match determine the fate.
> - * Return 1 for exclude, 0 for include and -1 for undecided.
> +/*
> + * Scan the given exclude list in reverse to see whether pathname
> + * should be ignored.  The first match (i.e. the last on the list), if
> + * any, determines the fate.  Returns the exclude_list element which
> + * matched, or NULL for undecided.
>   */
> -int excluded_from_list(const char *pathname,
> -                      int pathlen, const char *basename, int *dtype,
> -                      struct exclude_list *el)
> +struct exclude *excluded_from_list_1(const char *pathname, int pathlen,
> +                                    const char *basename, int *dtype,
> +                                    struct exclude_list *el)
>  {
>         int i;
>

You should keep the new function static.
-- 
Duy
