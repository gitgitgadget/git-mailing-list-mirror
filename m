From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH v3 04/13] match_basename: use strncmp instead of strcmp
Date: Tue, 12 Mar 2013 18:40:40 +0100
Message-ID: <CALWbr2w71DsORxsFBBj4N2wzYQomjvCqxGfovbTDjGAT9eASyQ@mail.gmail.com>
References: <1362896070-17456-1-git-send-email-pclouds@gmail.com>
	<1363093500-16796-1-git-send-email-pclouds@gmail.com>
	<1363093500-16796-5-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 12 18:49:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFTJx-0004oI-Or
	for gcvg-git-2@plane.gmane.org; Tue, 12 Mar 2013 18:49:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932470Ab3CLRsj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Mar 2013 13:48:39 -0400
Received: from mail-qe0-f46.google.com ([209.85.128.46]:59391 "EHLO
	mail-qe0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932453Ab3CLRsi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Mar 2013 13:48:38 -0400
Received: by mail-qe0-f46.google.com with SMTP id a11so73038qen.5
        for <git@vger.kernel.org>; Tue, 12 Mar 2013 10:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=PwtK2ldRNcSogefUsPnysj2u4e20KeLsddGS235zz1I=;
        b=DHT8Udl0SHT88UR+QYSJyq17RR31XvAYdvOAvyRYo1NAcn7AtEjuyWZndHSUyFrEtd
         kN3uPadA/ZYWCvf5k8zDYYm4oPfIE58kdxTUylQZghDEYTJrjuYHm+6B2feLeDGkgJMJ
         kERLpytjg47N/MZQ/sbjYuS1h6NX5MM2zF9n+1+yel2U9A7ayoDHTAenM5RiJ1fOtXQ8
         MIwNx8s7uJLnFzGcBI57G8AibwWNjPbNiJ3J8czZlEX9VfDSHuP1dFblkeZqUjTeVqOa
         JCU8lSEGnVdpZvPoI+Pca3HusKI2rYUHVa7VXPjeLttRjxJ/feSBdwKI3cQ6mdh2Pjib
         9SzQ==
X-Received: by 10.224.70.3 with SMTP id b3mr17172027qaj.47.1363110040792; Tue,
 12 Mar 2013 10:40:40 -0700 (PDT)
Received: by 10.49.70.163 with HTTP; Tue, 12 Mar 2013 10:40:40 -0700 (PDT)
In-Reply-To: <1363093500-16796-5-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217977>

> --- a/dir.c
> +++ b/dir.c
> @@ -636,12 +636,14 @@ int match_basename(const char *basename, int basenamelen,
>                    int flags)
>  {
>         if (prefix == patternlen) {
> -               if (!strcmp_icase(pattern, basename))
> +               if (patternlen == basenamelen &&
> +                   !strncmp_icase(pattern, basename, patternlen))
>                         return 1;
>         } else if (flags & EXC_FLAG_ENDSWITH) {
>                 if (patternlen - 1 <= basenamelen &&
> -                   !strcmp_icase(pattern + 1,
> -                                 basename + basenamelen - patternlen + 1))
> +                   !strncmp_icase(pattern + 1,
> +                                  basename + basenamelen - patternlen + 1,
> +                                  patternlen - 1))
>                         return 1;


I can see that you kept strncmp(), was it worse with memcmp() ?
