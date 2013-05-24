From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH 1/3] for-each-ref: introduce %C(...) for color
Date: Fri, 24 May 2013 22:56:57 +0200
Message-ID: <CALWbr2yuEczF-G7uJ0r-teUJrZowrY8mYm+xwJmv4+CT6NgDPA@mail.gmail.com>
References: <1369405177-7855-1-git-send-email-artagnon@gmail.com>
	<1369405177-7855-2-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 24 22:57:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ufz2u-00049T-DW
	for gcvg-git-2@plane.gmane.org; Fri, 24 May 2013 22:57:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755359Ab3EXU47 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 16:56:59 -0400
Received: from mail-qe0-f51.google.com ([209.85.128.51]:61290 "EHLO
	mail-qe0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754970Ab3EXU46 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 16:56:58 -0400
Received: by mail-qe0-f51.google.com with SMTP id nd7so2851904qeb.38
        for <git@vger.kernel.org>; Fri, 24 May 2013 13:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=5Bq7kIr8x/MOZMMTBLwRAsiDQFheOyP+WAjjW6iq8w4=;
        b=WsPEIFAW9pU5t8NbyAyNIugVDLscZAKtomnHcErnlCGjguvcYVGZw0VzkhuaXk+fot
         2CxoHX7YqQpYXcQYasUoghsaJInHfywdMzrrRv3V31y700Y5nu1TDucCJqwEZjm2LVAn
         C1M31UDakvk2jFXlWVH3+gwKWFl5rCFzheWNAtuJC6BoMtPX83Oww81RcsuUpnBw0pLG
         uHjfl0recQYmZ9/VAsoMkJrjh96nHoGf82hiKkRhwVlUQphmJmSL4xc5hs+FgPbo5i2J
         LIn0fUBVHf6kaegMZR9yKcapnbRAaTmCDRKQ7oyz41d1x7dwNMTx/FRpMW/xpUv4U/14
         E36Q==
X-Received: by 10.229.167.131 with SMTP id q3mr3869331qcy.133.1369429017750;
 Fri, 24 May 2013 13:56:57 -0700 (PDT)
Received: by 10.49.81.99 with HTTP; Fri, 24 May 2013 13:56:57 -0700 (PDT)
In-Reply-To: <1369405177-7855-2-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225400>

On Fri, May 24, 2013 at 4:19 PM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> @@ -928,12 +936,22 @@ static void emit(const char *cp, const char *ep)
>  static void show_ref(struct refinfo *info, const char *format, int quote_style)
>  {
>         const char *cp, *sp, *ep;
> +       char color[COLOR_MAXLEN];
>
>         for (cp = format; *cp && (sp = find_next(cp)); cp = ep + 1) {
>                 ep = strchr(sp, ')');
>                 if (cp < sp)
>                         emit(cp, sp);
> -               print_value(info, parse_atom(sp + 2, ep), quote_style);
> +
> +               /* Do we have a color specification? */
> +               if (!prefixcmp(sp, "%C("))
> +                       color_parse_mem(sp + 3,
> +                                       ep - sp - 3,
> +                                       "--format ", color);
> +               else {
> +                       printf("%s", color);

Is it not possible for "color" to be used uninitialized here ?

> +                       print_value(info, parse_atom(sp + 2, ep), quote_style);
> +               }
>         }
>         if (*cp) {
>                 sp = cp + strlen(cp);
