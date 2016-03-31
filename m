From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/4] submodule--helper clone: simplify path check
Date: Thu, 31 Mar 2016 03:31:11 -0400
Message-ID: <CAPig+cTz3fTyXFM4oPNO3Tv6dP0hN152jf9_JZOrsAZad1+O6Q@mail.gmail.com>
References: <1459383457-6848-1-git-send-email-sbeller@google.com>
	<1459383457-6848-3-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	norio.nomura@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Mar 31 09:31:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alX4W-00008f-WC
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 09:31:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751210AbcCaHbN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2016 03:31:13 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:34879 "EHLO
	mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750941AbcCaHbM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2016 03:31:12 -0400
Received: by mail-vk0-f67.google.com with SMTP id e185so10223896vkb.2
        for <git@vger.kernel.org>; Thu, 31 Mar 2016 00:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=/q2f86TnCm79qW6Usk6IozyRbg4Wmh9HkdXxyZw8sLw=;
        b=ftOFN16yz3BQf2BsMTt2MtjnIJkTeEat5Zq1Pm5I4sXO/yEn47IYFuOuIJMjTEajwl
         UaGEOxYUrMalUL6Zxsv2S3jyufUBrUBRCB/b1EDUT1ig1z+P7wFzwG+R/vuYjN/PENlT
         vHJ8YucIoeSqrbne9zHtwCcHV5R7OtKAAIJ9IiPXTQdUjP2xpH6l5XLtvYv5o6CGcMUW
         6Yj1DBaL/PHYbtTM6gBWGD248GnXScxeRgiDZatrOn2pvkqHO1PWaN/xnpZmOl84tqZY
         uG4HlbpyxnYO/HaCnm+W+mNb2Nl+ucW6W8jSEN/j3KXGhMbBdvIgjBSFhVDLycfsvDTW
         sj0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=/q2f86TnCm79qW6Usk6IozyRbg4Wmh9HkdXxyZw8sLw=;
        b=eBEBHJHsQoNgX309gPI2NknAi2bapVd61BxblCxDW/LhmYmIlLebEOQRlVOkl8OJGX
         QT6M6I1y1w9nGGs+CqrDfMRPQOjG2eHgqSs5nP4jLRlL6OdnkGaVZMAFgfW1vRGg2rtj
         C87SdQ0wafFWnHaB5Vdx2krG61PtBnXMJWRb6Ysl30dCSS3bmmKdTs5ZHJ84VUFdnJg6
         p/60ANcmQos1T1DA90VU6IDnOa6xkwYXqnwMLlzheHbzAkY95iSb0y8R8MB6OObUMnB5
         JGsw4WbWCMCcHVMpQQacpmeCfgnUFFbnx2jbK8FemjCkO6LzKgutu0kvHtg4LToZrhw5
         7Meg==
X-Gm-Message-State: AD7BkJJp39AWmFaL88+pB57BmRHZJbAG0jJq0Dlm8FRRJt8/WKLJvltIaY80kf5/ZADIscPok7qtWGC9wMMKVw==
X-Received: by 10.176.1.54 with SMTP id 51mr3921288uak.123.1459409471750; Thu,
 31 Mar 2016 00:31:11 -0700 (PDT)
Received: by 10.31.62.203 with HTTP; Thu, 31 Mar 2016 00:31:11 -0700 (PDT)
In-Reply-To: <1459383457-6848-3-git-send-email-sbeller@google.com>
X-Google-Sender-Auth: 8XrlK328padH31vcXWeFVA6INng
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290375>

On Wed, Mar 30, 2016 at 8:17 PM, Stefan Beller <sbeller@google.com> wrote:
> The calling shell code makes sure that `path` is non null and non empty.
> (side note: it cannot be null as just three lines before it is passed
> to safe_create_leading_directories_const which would crash as you feed
> it null).

I'm confused by this. So, you're saying that it's okay (and desirable)
for git-submodule--helper to segfault when the user does this:

    % git submodule--helper clone
    Segmentation fault: 11

rather than, say, printing a useful error message, such as:

    submodule--helper: missing or empty --path

?

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> @@ -215,10 +215,7 @@ static int module_clone(int argc, const char **argv, const char *prefix)
>         if (safe_create_leading_directories_const(path) < 0)
>                 die(_("could not create directory '%s'"), path);
>
> -       if (path && *path)
> -               strbuf_addf(&sb, "%s/.git", path);
> -       else
> -               strbuf_addstr(&sb, ".git");
> +       strbuf_addf(&sb, "%s/.git", path);
>
>         if (safe_create_leading_directories_const(sb.buf) < 0)
>                 die(_("could not create leading directories of '%s'"), sb.buf);
> --
