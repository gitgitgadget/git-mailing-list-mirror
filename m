From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] strbuf_write: omit system call when length is zero
Date: Fri, 26 Feb 2016 07:47:44 +0700
Message-ID: <CACsJy8DgjmdX681fRwB-JajPBRN+cNy=jFwEDW6D-dXhNi=_6g@mail.gmail.com>
References: <1456439678-5433-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Feb 26 01:48:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ6Zw-0002ki-IY
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 01:48:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752754AbcBZAsR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 19:48:17 -0500
Received: from mail-lf0-f44.google.com ([209.85.215.44]:35278 "EHLO
	mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752543AbcBZAsQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 19:48:16 -0500
Received: by mail-lf0-f44.google.com with SMTP id l143so44037821lfe.2
        for <git@vger.kernel.org>; Thu, 25 Feb 2016 16:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=oOScppk9DKp9VPSDVtcblBvP47UDY0QP7mcjokciPHg=;
        b=op24hUHJ2dcUIbMep6X+3JjyC5gSFxFt3bcpBnObWcAdg18HH/KL3JgqedbZcyz0TP
         qB+NxXyRhvKqB0oQ7JOspEOVGFjPMCN1vW2T9y6taf8q3kG8QLFUjqmXjcHf5apN0sIx
         /U4JTJ2Z1/d+y2lNG93MdGYRg7/fhGAHN9AGfoWSC2lwtLtpllqz20zY4GZBP3kVxOjm
         I+ULI9JJixuPcDLW2vQAjn+tgF9NnAiHs7tVoMMWXo9tiiYMRMWhVytDYLZ39xOwjReT
         LZnjTYP9lCpxZt8v5bUrxBaKlPsOWgkKlZ5gkwXUn+dJU7J7sorA1dxjybSTdBHgSM+a
         41LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=oOScppk9DKp9VPSDVtcblBvP47UDY0QP7mcjokciPHg=;
        b=UNvv14zON5UAOIOV3aJQfSHoj3+K2ETuLmQjO39w7q1T1MlPaXEmHpEIDzgBoICcG2
         hZYFRn+vu0B3yksVzrSXHZl54Y5VV/Hv6yIzx6hhg40T5Pttm+kSo3elN//+PtE8nHjY
         SrwDEOXN8Y66Ef6lzRQPQWzR3Ak+xEuMS1/Z0B2gDPFrzN5ZCoSf0iAPC6sZKBnPZ3zk
         fCGE8/V4sYGKu1+GfzRfVM6M04vgHnlbYDrMO3lQp5wCSJQxzWaNxJ1WPRpyp8yFG382
         kVTMniPD95vKo69gj3RBobvlrJPDegsk+m6NptLdzc6a84GJObDaDc3VqZf7xte7I5J9
         BFAQ==
X-Gm-Message-State: AG10YOQKDEPXAvC2mIlwcsHl/WfmY3jHrmsr6Pzts+XcWKbNKdKWrxpPa/dMDpNxDIhW5MbURSWSU9rhk+UEZA==
X-Received: by 10.25.147.202 with SMTP id v193mr18293938lfd.162.1456447694408;
 Thu, 25 Feb 2016 16:48:14 -0800 (PST)
Received: by 10.112.97.72 with HTTP; Thu, 25 Feb 2016 16:47:44 -0800 (PST)
In-Reply-To: <1456439678-5433-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287510>

On Fri, Feb 26, 2016 at 5:34 AM, Stefan Beller <sbeller@google.com> wrote:
> In case the length of the buffer is zero, we do not need to call the
> fwrite system call as a performance improvement.

fwrite is a libc call, not system call. Are you sure it always calls
write() (assuming buffering is off)?

>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>
>  This applies on top of v17 for origin/sb/submodule-parallel-update.
>
>  In case there are other reasons for origin/sb/submodule-parallel-update
>  to need a reroll I'll squash it in. But as this is a pure performance
>  optimization in a case we are not running into with that series and that
>  series is clashing with Davids refs backend series, I figure we may not
>  want to have a reroll for this fix alone.
>
>  Thanks,
>  Stefan
>
>
>  strbuf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/strbuf.c b/strbuf.c
> index 71345cd..5f6da82 100644
> --- a/strbuf.c
> +++ b/strbuf.c
> @@ -397,7 +397,7 @@ ssize_t strbuf_read_once(struct strbuf *sb, int fd, size_t hint)
>
>  ssize_t strbuf_write(struct strbuf *sb, FILE *f)
>  {
> -       return fwrite(sb->buf, 1, sb->len, f);
> +       return sb->len ? fwrite(sb->buf, 1, sb->len, f) : 0;
>  }
>
>
> --
> 2.7.2.374.ga5f0819.dirty
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Duy
