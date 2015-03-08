From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [GSoC][PATCH 1/2] userdiff: add built-in patterns for CSS
Date: Sun, 8 Mar 2015 19:08:31 -0400
Message-ID: <CAPig+cTEbX+cD39-_5EC8o7uciBw7uL58C31ePMXCJ3SLzYJtg@mail.gmail.com>
References: <1425812624-6671-1-git-send-email-sh19910711@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Hiroyuki Sano <sh19910711@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 09 00:08:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUkJJ-0005IE-1A
	for gcvg-git-2@plane.gmane.org; Mon, 09 Mar 2015 00:08:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752536AbbCHXId (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Mar 2015 19:08:33 -0400
Received: from mail-yk0-f172.google.com ([209.85.160.172]:40785 "EHLO
	mail-yk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752510AbbCHXIb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2015 19:08:31 -0400
Received: by ykq142 with SMTP id 142so5757335ykq.7
        for <git@vger.kernel.org>; Sun, 08 Mar 2015 16:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=+oT84Jh8JxSy4l5Tp52sRHiFaXvXDdBGFeogAzEsNqA=;
        b=kNPeRgQ6Y25WtRlvz9rhV/mMQQQkqF97dIDiRKOBamWdqmgZAP3hIFG5uuqpY8QsqW
         Omww5z6bfivsneEyKJ2RaVJwtZe7iyBQIESwA1I6OQ16H2JtO5W4rRgrxWP1J3ZzCkct
         RbfHM7jZcUHpgBH5H3ja4E3o735O/krgtqqTj7OjBLq1kQqTlvldrVzxuAwSE2kYRsov
         EAxut62jF3N1jG9PKL8fxmIO+lMGaVHmYSzevVWWx//vSK8GUac/jmtlB1hl6NZps8E4
         OAcChijD9C4RBP0412Sdx12joIWGPMmopSHyE90g6p8IWUDgeeBotCXpXlPeLw+GVcpn
         cSqg==
X-Received: by 10.236.70.100 with SMTP id o64mr24166334yhd.94.1425856111346;
 Sun, 08 Mar 2015 16:08:31 -0700 (PDT)
Received: by 10.170.73.7 with HTTP; Sun, 8 Mar 2015 16:08:31 -0700 (PDT)
In-Reply-To: <1425812624-6671-1-git-send-email-sh19910711@gmail.com>
X-Google-Sender-Auth: dgS92onNAMbHAxdDVPFAc6n6bYM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265118>

On Sun, Mar 8, 2015 at 7:03 AM, Hiroyuki Sano <sh19910711@gmail.com> wrote:
> Add regex patterns for CSS. The word regex maches selectors, properties,
> and values. On the other hand, the funcname regex matches lines contains
> the curly brace character.
>
> Signed-off-by: Hiroyuki Sano <sh19910711@gmail.com>
> ---
> diff --git a/t/t4034/css/post b/t/t4034/css/post
> new file mode 100644
> index 0000000..7e64463
> --- /dev/null
> +++ b/t/t4034/css/post
> @@ -0,0 +1,32 @@
> [...]
> +.class, elm:hover, elm:first-child, elm:lang(en), #id, elm#id, .num123{

Mental note: colon and parentheses are present

> diff --git a/userdiff.c b/userdiff.c
> index 2ccbee5..8374a2a 100644
> --- a/userdiff.c
> +++ b/userdiff.c
> @@ -37,6 +37,9 @@ IPATTERN("fortran",
>          "|//|\\*\\*|::|[/<>=]="),
>  PATTERNS("html", "^[ \t]*(<[Hh][1-6][ \t].*>.*)$",
>          "[^<>= \t]+"),
> +PATTERNS("css",
> +        "^.*[{].*$",
> +        "[-_\\.,#a-zA-Z0-9]+"),

Is the intention that this should match "elm:lang(en)" as an atom, or
separately match "elm", "lang", and "en"?

>  PATTERNS("java",
>          "!^[ \t]*(catch|do|for|if|instanceof|new|return|switch|throw|while)\n"
>          "^[ \t]*(([A-Za-z_][A-Za-z_0-9]*[ \t]+)+[A-Za-z_][A-Za-z_0-9]*[ \t]*\\([^;]*)$",
> --
