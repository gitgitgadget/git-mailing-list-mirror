From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH 1/3] mergetool--lib: fix startup options for gvimdiff tool
Date: Thu, 24 Jan 2013 21:07:10 -0800
Message-ID: <CAJDDKr4Zi-pVVtX4LxRv9K7ocjdpLS_5NH5P_wrx0+ZRSwmfFA@mail.gmail.com>
References: <1359011768-7665-1-git-send-email-Alex.Crezoff@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Pat Thoyts <patthoyts@users.sourceforge.net>,
	Junio C Hamano <gitster@pobox.com>
To: Alexey Shumkin <alex.crezoff@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 25 06:15:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TybdE-0003BB-4H
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jan 2013 06:15:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750976Ab3AYFOz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2013 00:14:55 -0500
Received: from mail-ea0-f181.google.com ([209.85.215.181]:62994 "EHLO
	mail-ea0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750838Ab3AYFOy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2013 00:14:54 -0500
Received: by mail-ea0-f181.google.com with SMTP id i13so3239376eaa.12
        for <git@vger.kernel.org>; Thu, 24 Jan 2013 21:14:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=qvFJz2JgpPAnRBC5oCIozNy8rfOm6FKC2l8NymE+1pA=;
        b=WxWjPoeHQ7VaufSJaWvz2jC03VN6tLXVTSDiwb1ly6rs04LVjy9NQjPZUJpAYNa9Ka
         zSLkCllmat5PbDOU+QiDDeknyUnfV4cVeDm0DKl6FyQrZG/hBBkmegbgKgL25inniAZh
         Vw+JLaMDpM19OmXmBdkbovl4to42EOmM2whbREeVNruK48+UPNoU08STYRFY2tyWh7yN
         f41K/5UQj234pAfnPiD3GrtEgfwpLdFz5W1OF8MrYBOQ6Wo2XyO4V9HkiacCxd7yAmk0
         nNv04X89h4+RPlw2nvuhq5rlfobfysiWNU0RfocE/bCmG50PsF/XYbjXAeO5P65wZUdU
         x2SQ==
X-Received: by 10.14.202.3 with SMTP id c3mr14294267eeo.4.1359090430465; Thu,
 24 Jan 2013 21:07:10 -0800 (PST)
Received: by 10.14.125.135 with HTTP; Thu, 24 Jan 2013 21:07:10 -0800 (PST)
In-Reply-To: <1359011768-7665-1-git-send-email-Alex.Crezoff@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214499>

On Wed, Jan 23, 2013 at 11:16 PM, Alexey Shumkin <alex.crezoff@gmail.com> wrote:
> Options are taken from <Git source>/mergetools/vim
>
> Signed-off-by: Alexey Shumkin <Alex.Crezoff@gmail.com>
> ---
>  git-gui/lib/mergetool.tcl | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)

A better long-term solution might be to teach git gui to use "git difftool".

Would it be better to teach git-gui (and gitk) about mergetool/difftool?
That would allow us to possibly eliminate this duplication.

We did start towards that path when difftool learned the --extcmd
option (for use by gitk) but I have not followed through.

What do you think about trying that approach?


> diff --git a/git-gui/lib/mergetool.tcl b/git-gui/lib/mergetool.tcl
> index 3c8e73b..4fc1cab 100644
> --- a/git-gui/lib/mergetool.tcl
> +++ b/git-gui/lib/mergetool.tcl
> @@ -211,7 +211,13 @@ proc merge_resolve_tool2 {} {
>                 }
>         }
>         gvimdiff {
> -               set cmdline [list "$merge_tool_path" -f "$LOCAL" "$MERGED" "$REMOTE"]
> +               if {$base_stage ne {}} {
> +                       set cmdline [list "$merge_tool_path" -f -d -c "wincmd J" \
> +                               "$MERGED" "$LOCAL" "$BASE" "$REMOTE"]
> +               } else {
> +                       set cmdline [list "$merge_tool_path" -f -d -c "wincmd l" \
> +                               "$LOCAL" "$MERGED" "$REMOTE"]
> +               }
>         }
>         kdiff3 {
>                 if {$base_stage ne {}} {
> --
> 1.8.1.1.10.g9255f3f
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
David
