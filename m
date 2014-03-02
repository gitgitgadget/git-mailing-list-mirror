From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] git-compat-util.h:rewrite skip_prefix() as loop
Date: Sun, 2 Mar 2014 00:00:22 -0500
Message-ID: <CAPig+cRDHb9usJW2zC20zXXM_9KxuEQ+=dkFmghp9JiVPcL1_w@mail.gmail.com>
References: <1393680724-19983-1-git-send-email-siddharth98391@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Siddharth Goel <siddharth98391@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 02 06:00:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJyWD-0006Fy-JM
	for gcvg-git-2@plane.gmane.org; Sun, 02 Mar 2014 06:00:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750760AbaCBFAY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2014 00:00:24 -0500
Received: from mail-yh0-f48.google.com ([209.85.213.48]:52135 "EHLO
	mail-yh0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750711AbaCBFAX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2014 00:00:23 -0500
Received: by mail-yh0-f48.google.com with SMTP id z6so2421372yhz.21
        for <git@vger.kernel.org>; Sat, 01 Mar 2014 21:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=5kkEDcMk/9IBtmzgc55jt0f0J8Qcr6caWlgWpQIDHa4=;
        b=GwPdXHx2cbArO/FSFmYWKg05RPIFbJLObwg3nGA/aeWmf/OupMkLgFtdP/2xu41t0s
         l7Y3KOiuY9r3Cn3vw6BThEiYQtFjkD+O8JNpnXYbA0xeFl/c4Pqpq3AGWKjG76Dzt6xW
         +JbwY79j2jDGV5GDRhK+cAibP6oKfgYAC0PmcBN9BK/Y4C+Z91XzR4r8yrISK+wd4Uhj
         xDu1vuyWCfzjAXZohzGt3lcxdEQXLsknYKijU9GCvHKmGK4NaUhD7HoD4uR12eKxLAzL
         2ulcd5tUrtS2bgVaTuJSvSsMGiPt/lIqO8wpb9CKmTzqBgW2s5OjH4QpLwUMHdRseKpJ
         8vog==
X-Received: by 10.236.157.102 with SMTP id n66mr12557403yhk.41.1393736422700;
 Sat, 01 Mar 2014 21:00:22 -0800 (PST)
Received: by 10.170.180.195 with HTTP; Sat, 1 Mar 2014 21:00:22 -0800 (PST)
In-Reply-To: <1393680724-19983-1-git-send-email-siddharth98391@gmail.com>
X-Google-Sender-Auth: nxGJdm6WWztH4XaWOhZsumllmY0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243132>

Thanks for the submission. Minor comments below to give you a taste of
what it's like to contribute to this project...

On Sat, Mar 1, 2014 at 8:32 AM, Siddharth Goel <siddharth98391@gmail.com> wrote:
> Rewrote skip_prefix() function so that prefix is scanned once.

Good description. In this project, use imperative tone, so say
"Rewrite skip_prefix()..." as you did in the subject. In fact, this
description is short enough and conveys sufficient information that it
could just be placed in the subject as the entire commit message.

    Subject: skip_prefix: rewrite so that prefix is scanned once

> Signed-off-by: Siddharth Goel <siddharth98391@gmail.com>
> ---
>  git-compat-util.h | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/git-compat-util.h b/git-compat-util.h
> index 614a5e9..550dce3 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -357,8 +357,11 @@ extern int suffixcmp(const char *str, const char *suffix);
>
>  static inline const char *skip_prefix(const char *str, const char *prefix)
>  {
> -       size_t len = strlen(prefix);
> -       return strncmp(str, prefix, len) ? NULL : str + len;
> +       while (*prefix != '\0' && *str == *prefix) {
> +               str++;
> +               prefix++;
> +       }
> +       return (*prefix == '\0' ? str : NULL);
>  }
>
>  #if defined(NO_MMAP) || defined(USE_WIN32_MMAP)
> --
> 1.9.0.138.g2de3478.dirty
