From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCHv2 3/5] submodule--helper clone: remove double path checking
Date: Thu, 31 Mar 2016 17:58:32 -0400
Message-ID: <CAPig+cToyvzc4RbBmAAQtGmJ3WpxO6Z+XzrxrXQqYVH2RJcb-g@mail.gmail.com>
References: <1459458280-17619-1-git-send-email-sbeller@google.com>
	<1459458280-17619-4-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Norio Nomura <norio.nomura@gmail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Mar 31 23:58:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alkbu-0007LX-FK
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 23:58:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752957AbcCaV6d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2016 17:58:33 -0400
Received: from mail-yw0-f171.google.com ([209.85.161.171]:35873 "EHLO
	mail-yw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751933AbcCaV6c (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2016 17:58:32 -0400
Received: by mail-yw0-f171.google.com with SMTP id g3so116208560ywa.3
        for <git@vger.kernel.org>; Thu, 31 Mar 2016 14:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=sqpO7Jx86FJGvlkmgq00EYM2QesgSdZ5VO6pxyk+EFI=;
        b=WekEH3cp9ANShw+ggBs5paMCv+y1WMjX7HnBLaNpaZQgysdrb6FV7TUTlbIx0YqfzG
         wVkVZ2MRpmbUMsnMWCv+65yRhVuCfiq/btgS3fFBVJBAjNXCWd5DRyLbhfSltQBaoy4N
         qoV39hBV3dK/pw6m4X65tqCSG9lV791TXzEe901rrEZXJSYQR8w8PeeaA0rjOIfdFaFH
         E93x6wBmB967zZtZJSoObQETVarJ0E0v73n/iJqsGvL9g2q7r9kWN8QEw5c3bMmxuCtr
         2txpISYmthBmIinpqvQxfdrwFG8sL0NqHabZ8IGsso1H6j01YvH5G/QHxBeBFk9JdwFy
         TcMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=sqpO7Jx86FJGvlkmgq00EYM2QesgSdZ5VO6pxyk+EFI=;
        b=A+wzqlHIelBn1yd8ibLUyeSkKWWbmD+8HuuVh4hyzGKMJXRU5wgSqOndFLIm2d9GlE
         IQQOrhERuxRIwzEkBABiffDtK+1T2TV8pS5JCrQBkE9VDAVRinfdzMMbxS42IxAm5eSD
         wccX65sEW61XwA9calfimcTJCtSCvDTkWGctt8ICV0dxB3BqzagcvD0AZ47rWnpOoG1r
         4IpPQE6CESxRb1oLkJG7YBfnoNUYNFWcAprYYMuQ28r5q/pbbSWqqREHDEfIO7Hoojpi
         sf8i3CduHiOYH1D9JRHW3CDoci5gR/9cWi1SFLed7LkMCDw/RgV3V4v89tVQzYfGkVKw
         eINA==
X-Gm-Message-State: AD7BkJLSFIXlpj3runV6p3j7fUtjhRLgqMz4ebrjMViY3VA2IZI4B2UyaXZM7UoXEVtDlkAR1L8GF4axxaq+0w==
X-Received: by 10.31.8.142 with SMTP id 136mr2432375vki.14.1459461512147; Thu,
 31 Mar 2016 14:58:32 -0700 (PDT)
Received: by 10.31.62.203 with HTTP; Thu, 31 Mar 2016 14:58:32 -0700 (PDT)
In-Reply-To: <1459458280-17619-4-git-send-email-sbeller@google.com>
X-Google-Sender-Auth: m8df0_WzCkxFChkYH5JxzKiCUVM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290475>

On Thu, Mar 31, 2016 at 5:04 PM, Stefan Beller <sbeller@google.com> wrote:
> submodule--helper clone: remove double path checking

I think Junio mentioned in v1 that calling this "path checking" is misleading.

> We make sure that the parent directory of path exists (or create it
> otherwise) and then do the same for path + "/.git".
>
> That is equivalent to just making sure that the parent directory of
> path + "/.git" exists (or create it otherwise).

This part of the commit message is nicely improved.

The patch itself looks fine.

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> @@ -215,11 +215,7 @@ static int module_clone(int argc, const char **argv, const char *prefix)
>         }
>
>         /* Write a .git file in the submodule to redirect to the superproject. */
> -       if (safe_create_leading_directories_const(path) < 0)
> -               die(_("could not create directory '%s'"), path);
> -
>         strbuf_addf(&sb, "%s/.git", path);
> -
>         if (safe_create_leading_directories_const(sb.buf) < 0)
>                 die(_("could not create leading directories of '%s'"), sb.buf);
>         submodule_dot_git = fopen(sb.buf, "w");
> --
> 2.5.0.264.g39f00fe
