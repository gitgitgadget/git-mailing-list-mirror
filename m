From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] send-email: Fix documentation of --signed-off-by-cc option
Date: Thu, 20 Jun 2013 22:15:53 +0530
Message-ID: <CALkWK0n+CMV64VxLMV6AqVxwpC2nyk=vh=0F+ESvKG2Mn9G7oA@mail.gmail.com>
References: <1371716811-12043-1-git-send-email-namhyung@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Minchan Kim <minchan@kernel.org>,
	Namhyung Kim <namhyung.kim@lge.com>
To: Namhyung Kim <namhyung@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 20 18:46:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Upi0M-00063J-W7
	for gcvg-git-2@plane.gmane.org; Thu, 20 Jun 2013 18:46:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965476Ab3FTQqf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jun 2013 12:46:35 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:43728 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965232Ab3FTQqe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jun 2013 12:46:34 -0400
Received: by mail-ie0-f179.google.com with SMTP id c10so16909562ieb.38
        for <git@vger.kernel.org>; Thu, 20 Jun 2013 09:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=WZ3T12F+lLBCUFLg1d0zrm4ugIxfvHW4j/5RVhqQ3WM=;
        b=xie5Ivip7NF42EJxwsSD8nd6ssPCU6+jvkNzBZKKAffTlKCDZSDIM2ER6B1jIPUvTd
         Xjbc5mEs9JvHFgjfPzGAKoWnRjzS3MhfeCEBxvRASbgS6CZRlWUpixzCZ3uXWVnBgmjX
         EzDU5sMNWJC6m7IfM7r0jHvqP5F5h09plbgGjNotwvO8ZnOleEpMShnAAI52R6esgsFZ
         akBUQ21HefPWaxPUTjidNHFUGP09IghuMngkZ+RaifY0fzeUHPnDy3xX2V6/VHrt9g+j
         ZzvebUCPQgiN7IIOJUnzVvwt/kfFZWml5mQxpLQEul9Q9qaO+z1CyGHmz8Ctyzt57dZp
         ZDwg==
X-Received: by 10.50.1.37 with SMTP id 5mr165038igj.29.1371746793656; Thu, 20
 Jun 2013 09:46:33 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Thu, 20 Jun 2013 09:45:53 -0700 (PDT)
In-Reply-To: <1371716811-12043-1-git-send-email-namhyung@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228512>

Namhyung Kim wrote:
> diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
> index 40a9a9a..5694d98 100644
> --- a/Documentation/git-send-email.txt
> +++ b/Documentation/git-send-email.txt
> @@ -238,7 +238,7 @@ Automating
>         the value of 'sendemail.identity'.
>
>  --[no-]signed-off-by-cc::
> -       If this is set, add emails found in Signed-off-by: or Cc: lines to the
> +       If this is set, add emails found in Signed-off-by: lines to the
>         cc list. Default is the value of 'sendemail.signedoffbycc' configuration
>         value; if that is unspecified, default to --signed-off-by-cc.

Correct, but I'd urge you to step back and look at all the options.
Cc lines in the body (called bodycc) are parsed: see
git-send-email.perl:1361.  By default, everyone (cc, author, self,
sob, bodycc) is cc'ed by default.  You can turn off each of these
individually using --supress-cc which can take values
(all|cccmd|cc|author|self|sob|body|bodycc).  As you can see from
git-send-email.perl:400, the real purpose of --signed-off-by-cc is to
override a sendemail.suppresscc=sob; however, it can't override any
stronger values of suppresscc (body, all).  So, it's mostly a
no-option, and there is no corresponding --[no-]bodycc-cc.  Overall,
the way out of this horrible mess of options is to deprecate
--[no-]signed-off-by-cc, and modify --supress-cc to have a
--no-suppress-cc counterpart, just like --[no-]suppress-from.

Thanks.
