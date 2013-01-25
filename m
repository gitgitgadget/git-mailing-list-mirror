From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] mergetools: Enhance tortoisemerge to work with
Date: Fri, 25 Jan 2013 02:09:45 -0800
Message-ID: <CAJDDKr7eNyJp1ffBYEJaZkmnVWqd0AMpnm1kdjnrrhPtuGNL_w@mail.gmail.com>
References: <50FBD4AD.2060208@tu-clausthal.de>
	<7v4nibjrg0.fsf@alter.siamese.dyndns.org>
	<50FCFBBB.2080305@tu-clausthal.de>
	<7vfw1qbbr4.fsf@alter.siamese.dyndns.org>
	<5101B0A5.1020308@tu-clausthal.de>
	<51024B02.9020400@tu-clausthal.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Jeff King <peff@peff.net>
To: Sven Strickroth <sven.strickroth@tu-clausthal.de>
X-From: git-owner@vger.kernel.org Fri Jan 25 11:10:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TygEr-0002Xx-B8
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jan 2013 11:10:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755336Ab3AYKKC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2013 05:10:02 -0500
Received: from mail-ee0-f52.google.com ([74.125.83.52]:36330 "EHLO
	mail-ee0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756020Ab3AYKJr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2013 05:09:47 -0500
Received: by mail-ee0-f52.google.com with SMTP id b15so98775eek.11
        for <git@vger.kernel.org>; Fri, 25 Jan 2013 02:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=XNmTze7QlSmLw11yHUNDwTJv3vYnaYw9M+Yv3LgzQ2k=;
        b=K1WZgUiVI5llVEL0HYtw/jEjw6/oZR1KdMPMeYXol7m0AiswOSZmYNkAhNJY1oyO+P
         SImGFBTjbHXdHS3ejJiSNa0zOmKYREarEv1wjg6ZP4KkbwZRrCbeXsb+NNexEvPio19u
         IpGvlIgylVDfOYkzv0aMrkcIHj+gg1j7Z35LDM+LodcAoHDZ0Hf7usvtgHVD0aki+9VT
         S+guftAyerNuapq4pOARNI1WlpogcBx40DM9fEbeAJ82/+Dk7x2BPXN19aHIjl/ATJTy
         z3kq81vXRndnLW4SACNo3QFL6JzL4nZ0/mnvhv794JDQzVtwxYgllw5L3PccJ37e9/R/
         TuVA==
X-Received: by 10.14.204.198 with SMTP id h46mr16782672eeo.1.1359108585608;
 Fri, 25 Jan 2013 02:09:45 -0800 (PST)
Received: by 10.14.125.135 with HTTP; Fri, 25 Jan 2013 02:09:45 -0800 (PST)
In-Reply-To: <51024B02.9020400@tu-clausthal.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214536>

On Fri, Jan 25, 2013 at 1:06 AM, Sven Strickroth
<sven.strickroth@tu-clausthal.de> wrote:
> TortoiseGitMerge and filenames with spaces
>
> - The TortoiseGit team renamed TortoiseMerge.exe to TortoiseGitMerge.exe
>   (starting with 1.8.0) in order to make clear that this one has special
>   support for git, (uses spaces as cli parameter key-value separators)
>   and prevent confusion with the TortoiseSVN TortoiseMerge version.
> - The tortoisemerge mergetool does not work with filenames which have
>   a space in it. Fixing this required changes in git and also in
>   TortoiseGitMerge; see https://github.com/msysgit/msysgit/issues/57.
>
> Signed-off-by: Sven Strickroth <email@cs-ware.de>
> Reported-by: Sebastian Schuberth <sschuberth@gmail.com>
> ---
>  mergetools/tortoisemerge | 24 ++++++++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)
>
> diff --git a/mergetools/tortoisemerge b/mergetools/tortoisemerge
> index ed7db49..9890737 100644
> --- a/mergetools/tortoisemerge
> +++ b/mergetools/tortoisemerge
> @@ -6,12 +6,28 @@ merge_cmd () {
>         if $base_present
>         then
>                 touch "$BACKUP"
> -               "$merge_tool_path" \
> -                       -base:"$BASE" -mine:"$LOCAL" \
> -                       -theirs:"$REMOTE" -merged:"$MERGED"
> +               if test "$merge_tool_path" == "tortoisegitmerge"

I like the approach this is taking.  Thank you.
I have one small note:

I think this should use "=" instead of "==" here.

It might also make sense to wrap a basename call around it
so that users can set their own mergetool.tortoisemerge.path

basename="$(basename "$merge_tool_path" .exe)"
if test "$basename" = "tortoisegitmerge"
...


> +               then
> +                       "$merge_tool_path" \
> +                               -base "$BASE" -mine "$LOCAL" \
> +                               -theirs "$REMOTE" -merged "$MERGED"
> +               else
> +                       "$merge_tool_path" \
> +                               -base:"$BASE" -mine:"$LOCAL" \
> +                               -theirs:"$REMOTE" -merged:"$MERGED"
> +               fi
>                 check_unchanged
>         else
> -               echo "TortoiseMerge cannot be used without a base" 1>&2
> +               echo "$merge_tool_path cannot be used without a base" 1>&2
>                 return 1
>         fi
>  }
> +
> +translate_merge_tool_path() {
> +       if type tortoisegitmerge >/dev/null 2>/dev/null
> +       then
> +               echo tortoisegitmerge
> +       else
> +               echo tortoisemerge
> +       fi
> +}
> --
> Best regards,
>  Sven Strickroth
>  PGP key id F5A9D4C4 @ any key-server
-- 
David
