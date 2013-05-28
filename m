From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] wildmatch: properly fold case everywhere
Date: Tue, 28 May 2013 19:53:47 +0700
Message-ID: <CACsJy8Bu2XvapGHjcKZJuATqB90MXSCoNHkke9CBeiwSvzpH8A@mail.gmail.com>
References: <1369744361-44918-1-git-send-email-n.oxyde@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Anthony Ramine <n.oxyde@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 28 14:54:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhJPz-0007YF-EY
	for gcvg-git-2@plane.gmane.org; Tue, 28 May 2013 14:54:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933912Ab3E1MyT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 May 2013 08:54:19 -0400
Received: from mail-oa0-f51.google.com ([209.85.219.51]:48442 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933886Ab3E1MyS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 May 2013 08:54:18 -0400
Received: by mail-oa0-f51.google.com with SMTP id f4so9871532oah.38
        for <git@vger.kernel.org>; Tue, 28 May 2013 05:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=tUMy80mWXZ7NfkPoG0/A6Ic2Dmb+51WsT4noDnE72mk=;
        b=YBpFBlFjTqUYGtJNNFwWzZjyqvVG/0MiUug6CV631pwjySHS0bDtnklh5AROfXQSkS
         Qysh358Iu+4bVBgFHZhO314y70iE4pYywvpWl2/Zdp8nFJ+X6wEk53Ns3m6zBN+BDXsi
         HbmrOI+Jf9UGj13eGCnKZ382gvRCmRBODGd4sZ0PK4Z37lt+2/9fblv4adbZ9I4GN4RJ
         eDDn7MwqFaYvn23GRM5OQhrCUqXnqXgZ+dvrgf5lIaIqUsA96JlX9NuM/1i6VBMhwnYz
         qAjyskUCxLSlKud1ngOcmq1hcjtNLXgbT5wlKHpJ5p9Y8NECJ+ry7uVjGaO4bu7gmiTl
         mBkQ==
X-Received: by 10.60.59.37 with SMTP id w5mr3055858oeq.7.1369745658250; Tue,
 28 May 2013 05:54:18 -0700 (PDT)
Received: by 10.76.171.199 with HTTP; Tue, 28 May 2013 05:53:47 -0700 (PDT)
In-Reply-To: <1369744361-44918-1-git-send-email-n.oxyde@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225632>

On Tue, May 28, 2013 at 7:32 PM, Anthony Ramine <n.oxyde@gmail.com> wrote:
> @@ -196,6 +196,11 @@ static int dowild(const uchar *p, const uchar *text, unsigned int flags)
>                                         }
>                                         if (t_ch <= p_ch && t_ch >= prev_ch)
>                                                 matched = 1;
> +                                       else if ((flags & WM_CASEFOLD) && ISLOWER(t_ch)) {
> +                                               t_ch = toupper(t_ch);

This happens in a while loop where t_ch may be used again. Should we
make a local copy of toupper(t_ch) and leave t_ch untouched?

> +                                               if (t_ch <= p_ch && t_ch >= prev_ch)
> +                                                       matched = 1;
> +                                       }
>                                         p_ch = 0; /* This makes "prev_ch" get set to 0. */
>                                 } else if (p_ch == '[' && p[1] == ':') {
>                                         const uchar *s;
--
Duy
