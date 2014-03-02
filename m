From: Siddharth Goel <siddharth98391@gmail.com>
Subject: Re: [PATCH] git-compat-util.h:rewrite skip_prefix() as loop
Date: Sun, 2 Mar 2014 11:22:43 +0800
Message-ID: <CANQLRip4zpOuF=GUsuhsQtQ4z5Z9VtCHo8yBb6vL3npuMHHgZA@mail.gmail.com>
References: <1393680724-19983-1-git-send-email-siddharth98391@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Siddharth Goel <siddharth98391@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 02 04:23:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJx04-0002Lv-CE
	for gcvg-git-2@plane.gmane.org; Sun, 02 Mar 2014 04:23:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751081AbaCBDXG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2014 22:23:06 -0500
Received: from mail-vc0-f178.google.com ([209.85.220.178]:60056 "EHLO
	mail-vc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750788AbaCBDXF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2014 22:23:05 -0500
Received: by mail-vc0-f178.google.com with SMTP id ik5so2302540vcb.23
        for <git@vger.kernel.org>; Sat, 01 Mar 2014 19:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Hece9PPYqNlNg5yGgaJhiLBOlKOtLG6/oQMuyyuy4Lw=;
        b=MbZe9zfvMv1wsVz7z9I40ohu7fT4Tmr6jJu1swNikQVMDrhUP2OXaiYpZzvL+It9uN
         k8yaS2CNlSJVIF5u74u+tenHx4spk+s1sBoPaXmrfwBNujkoKgCZPnM71Aqj9asKRO6d
         zg+7EO6IutCrogOKW9KWAmgvzh8PmS1jByeKVNmjNCd1YNP/nnrOLeEVKXIeOKOF28tK
         jUL5ovAsiBRMsaP66HIUDg9uO1uPeE3HU1mbDdiFlfheNCj2TmCxs/FjCQOJ/y9zqWhY
         u3ogvF8fa4Xwis6lJYeLhEc1ku2iMnX1+hTlTt4HSSrpxKuauF+4dYXoFwOaxwkvtP5m
         jdDg==
X-Received: by 10.58.248.5 with SMTP id yi5mr34120vec.42.1393730583912; Sat,
 01 Mar 2014 19:23:03 -0800 (PST)
Received: by 10.58.243.137 with HTTP; Sat, 1 Mar 2014 19:22:43 -0800 (PST)
In-Reply-To: <1393680724-19983-1-git-send-email-siddharth98391@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243127>

To my surprise, git format-patch had removed the Git Notes that I had
put to my commit (regarding GSoC). I have written this patch as a part
of the GSoC 2014 MicroProject for Git. Going through the mail-chain I
observed that many students have attempted this Microproject. So is it
ok if I stick to this Microproject or should I go with another one?

On Sat, Mar 1, 2014 at 9:32 PM, Siddharth Goel <siddharth98391@gmail.com> wrote:
> Rewrote skip_prefix() function so that prefix is scanned once.
>
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
>
