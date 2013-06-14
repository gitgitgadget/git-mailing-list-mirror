From: Phil Hord <phil.hord@gmail.com>
Subject: Re: [PATCH 5/5] rebase: use 'git stash store' to simplify logic
Date: Fri, 14 Jun 2013 08:47:54 -0400
Message-ID: <CABURp0rEzKwE__Sg+Z66iOo7qZn0NKPzPuuhb52taBs8zyga=Q@mail.gmail.com>
References: <1371205924-8982-1-git-send-email-artagnon@gmail.com> <1371205924-8982-6-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 14 14:48:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnTQT-0007xr-Km
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 14:48:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751606Ab3FNMsR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jun 2013 08:48:17 -0400
Received: from mail-vb0-f52.google.com ([209.85.212.52]:33350 "EHLO
	mail-vb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750930Ab3FNMsR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jun 2013 08:48:17 -0400
Received: by mail-vb0-f52.google.com with SMTP id f12so398133vbg.11
        for <git@vger.kernel.org>; Fri, 14 Jun 2013 05:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=m+5S2gKUvj7AhstWCyXHfMWNlTGsVHhkaS/9a01ZMSM=;
        b=D84lgWt4p4HDTh9tKQ75mMCMqKrOmRSp06uZiu36qmLucyIVXfZFX8I27c8ucgnWq7
         p03ctzft8hMnG6k0rvq/t84M+B545aTSpgBLIME/unTeQXwQ7XW83PP4O4PLt+erN2Vt
         H9wlBDHVr044XWrXouR7HUx3vyA6RMoc8lHA+Fsb5+680PFZkLeFnmy/wz8fLqw6YI9O
         gMqVIaWpakuh+5UJGiH3oR4Xo1VR044jpQJlNBS+KskrG5ioWKIrlLmszgw/kOt1PyyY
         XqiKhqaST3z6mSeNPVO4UJG5UmP3SIIyDyiu8i+ZRBnBS7zmbdBpyszB+We18HT1NB/C
         cLcQ==
X-Received: by 10.220.71.200 with SMTP id i8mr866896vcj.44.1371214094261; Fri,
 14 Jun 2013 05:48:14 -0700 (PDT)
Received: by 10.58.243.34 with HTTP; Fri, 14 Jun 2013 05:47:54 -0700 (PDT)
In-Reply-To: <1371205924-8982-6-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227821>

On Fri, Jun 14, 2013 at 6:32 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> rebase has no reason to know about the implementation of the stash.  In
> the case when applying the autostash results in conflicts, replace the
> relevant code in finish_rebase () to simply call 'git stash store'.
>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  git-rebase.sh | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/git-rebase.sh b/git-rebase.sh
> index d0c11a9..bf37259 100755
> --- a/git-rebase.sh
> +++ b/git-rebase.sh
> @@ -153,11 +153,7 @@ finish_rebase () {
>                 then
>                         echo "$(gettext 'Applied autostash.')"
>                 else
> -                       ref_stash=refs/stash &&
> -                       >>"$GIT_DIR/logs/$ref_stash" &&
> -                       git update-ref -m "autostash" $ref_stash $stash_sha1 ||
> -                       die "$(eval_gettext 'Cannot store $stash_sha1')"
> -
> +                       git stash store -m "autostash" -e "Cannot store $stash_sha1." $stash_sha1

nit: adds a period where there was not one previously.

Maybe this doesn't matter so much since this code is new anyway.  But
showing a period after sha1 seems wrong, too. Or maybe I am confused
again.  Does eval_gettext routinely add a period to the end of
translated strings?

>                         gettext 'Applying autostash resulted in conflicts.
>  Your changes are safe in the stash.
>  You can run "git stash pop" or "git stash drop" it at any time.
> --
> 1.8.3.1.383.g0d5ad6b
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
