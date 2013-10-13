From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v4 2/2] version-gen: fix versions
Date: Sun, 13 Oct 2013 14:56:36 -0700
Message-ID: <CAJDDKr5K0UjcbhUpAjHjGcEk6=E2+cAVC8-RpxY+C1atSVj-Tg@mail.gmail.com>
References: <1381561628-20665-1-git-send-email-felipe.contreras@gmail.com>
	<1381561628-20665-3-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 13 23:56:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VVTef-0003Tz-Jk
	for gcvg-git-2@plane.gmane.org; Sun, 13 Oct 2013 23:56:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755306Ab3JMV4h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Oct 2013 17:56:37 -0400
Received: from mail-pb0-f43.google.com ([209.85.160.43]:38496 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755284Ab3JMV4h (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Oct 2013 17:56:37 -0400
Received: by mail-pb0-f43.google.com with SMTP id md4so6506913pbc.2
        for <git@vger.kernel.org>; Sun, 13 Oct 2013 14:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=s7vVB0KhmbarnmSjw8zrd8HWD6d+s62G8yP0ZMW450Y=;
        b=X8rShS64uW058QmTpnSyhyKicREh4+P25Ulm9CNaa2DRwEgOr8RteSBWUlZ+9yF7lg
         xRyFNgfnrIjq1OZz3p7AKFNe0pXSNPLsvoHdWgCritxVIuuDdiT/os/5GrAYzqph1r2S
         vTZPfIBpWRzVkV/vCL63Ohw6RgMEqdwY5MeBcTN+Py7Fq7DXxD6UtVKZBE1sPQBJ0cOa
         6cqztBGCPyy5cwkMtoiS8U4q/Atq6E4v1JR7IEHOt7QjiA5Y92j9VqbmWS3eEaPj2A+x
         NsUSSEcbHKIfP/uAZMNESrBIQbwWR4Rc8Ip2zW1XyCvniqOuci2bETh0sIi6PN/eb0q1
         tZyg==
X-Received: by 10.66.217.166 with SMTP id oz6mr34452723pac.22.1381701396456;
 Sun, 13 Oct 2013 14:56:36 -0700 (PDT)
Received: by 10.70.102.45 with HTTP; Sun, 13 Oct 2013 14:56:36 -0700 (PDT)
In-Reply-To: <1381561628-20665-3-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236083>

On Sat, Oct 12, 2013 at 12:07 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> Virtually all packaging guidelines would prefer 1.8.4~rc1, over
> 1.8.4.rc1 or 1.8.4-rc1, so it makes sense to use that instead.
>
> In particular, the only packaging we provide, git.spec, generates a
> wrong version, because git-1.8.4 < git-1.8.4.rc1, changing to ~rc1 fixes
> the problem as it's considered newer.
>
> The same happens in dpkg.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  GIT-VERSION-GEN | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
> index e96538d..c04c4de 100755
> --- a/GIT-VERSION-GEN
> +++ b/GIT-VERSION-GEN
> @@ -28,7 +28,7 @@ then
>         VN=$(cat version) || VN="$DEF_VER"
>  elif test -d ${GIT_DIR:-.git} -o -f .git && describe
>  then
> -       VN=$(echo "$VN" | sed -e 's/-/./g')
> +       VN=$(echo "$VN" | sed -e 's/-/~/g')
>  else
>         VN="$DEF_VER"
>  fi
> --

This seems related:

http://lintian.debian.org/tags/rc-version-greater-than-expected-version.html

Should the RC tags in the Git repo be named v1.2.3~rc4 (tilde-rc#)
instead of dash-rc#, or does that not matter?

If so, would that change anything about this patch, or is it better to
normalize it all here?

The input is subtly different sometimes so I'm curious whether whether
"~" is preferred in all cases (particularly, by all package managers).
 e.g.

$ git describe v1.5.0^
v1.5.0-rc4-372-g26cfcfb

$ git describe v1.5.0.1^
v1.5.0-27-g38eb932
-- 
David
