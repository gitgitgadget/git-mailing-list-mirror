From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [PATCH] rev-list docs: clarify --topo-order description
Date: Mon, 13 Aug 2012 15:46:08 -0700
Message-ID: <CAOeW2eGoNvgpbQ9iM0xHpSD1Z4XyC-J8VNVW0bVw3p9qOeijjg@mail.gmail.com>
References: <7vsjbqbfhm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 14 00:46:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T13Oq-0001Rr-OH
	for gcvg-git-2@plane.gmane.org; Tue, 14 Aug 2012 00:46:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754117Ab2HMWqL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Aug 2012 18:46:11 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:34895 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754052Ab2HMWqK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Aug 2012 18:46:10 -0400
Received: by yhmm54 with SMTP id m54so3841409yhm.19
        for <git@vger.kernel.org>; Mon, 13 Aug 2012 15:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=WFHgB8NbTFOMRaIRPAMuTS58UvJCOPt1yzDA1a4ouHg=;
        b=a+1uq8RAbc3DXyuu8WliQZqacEy64KP7FSarRkBMS6O7MQLr/2cPp8SBtBaH9UthX8
         EB+kdJtUOXTp5me37wCDRFu5nDQg/eMw6ARVSEQlYaKSevM4mn1ZTmsrsnorzAD2UAQ9
         vSlBD3pZCkCWXT63jQqckQ8724Dhz+jRU9hVdAFoMvtVY6NBH1blX/BM85j4MI+YMneV
         Ak3gHM4LCLcE4bTovW7j7XkT+54RCveLuLsCCIdExS30ciHy1ahl1CQW/BabO0ns6Syh
         75llEMbqR/WWJZEFGQ3R07yHi1UuZxMrB7jvtFgPhQTH1qBxYrrL8JF2KIaWXj7WIe2g
         JWrg==
Received: by 10.68.136.137 with SMTP id qa9mr17875224pbb.140.1344897969093;
 Mon, 13 Aug 2012 15:46:09 -0700 (PDT)
Received: by 10.68.120.112 with HTTP; Mon, 13 Aug 2012 15:46:08 -0700 (PDT)
In-Reply-To: <7vsjbqbfhm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203373>

On Mon, Aug 13, 2012 at 3:21 PM, Junio C Hamano <gitster@pobox.com> wrote:
>  * Let's do this before I forget...; came up in discussion $gmane/203370

Thanks! That definitely confused me (and I suppose I stupidly didn't
test with a proper range).

>
>  Documentation/rev-list-options.txt | 29 +++++++++++++++++++++++------
>  1 file changed, 23 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
> index 6a4b635..dc501ee 100644
> --- a/Documentation/rev-list-options.txt
> +++ b/Documentation/rev-list-options.txt
> @@ -579,15 +579,32 @@ Commit Ordering
>  By default, the commits are shown in reverse chronological order.

It seems likely that those reading the above sentence will continue on
to read about --topo-order, but still, do you think the "descendant
commits are shown before parents" part belong here instead?

>  --topo-order::
> -
> -       This option makes them appear in topological order (i.e.
> -       descendant commits are shown before their parents).
> +       This option makes them appear in topological order.  Even
> +       without this option, descendant commits are shown before
> +       their parents, but this tries to avoid showing commits on
> +       multiple lines of history intermixed.
>
>  --date-order::
>
> -       This option is similar to '--topo-order' in the sense that no
> -       parent comes before all of its children, but otherwise things
> -       are still ordered in the commit timestamp order.
> +       Show no parents before all of its children, but otherwise
> +       show commits in the commit timestamp order.
> ++
> +For example, in a commit history like this:
> ++
> +----------------------------------------------------------------
> +
> +    ---1----2----4----7
> +       \              \
> +        3----5----6----8---
> +
> +----------------------------------------------------------------
> ++
> +where the numbers denote the order of commit timestamps, `git
> +rev-list` and friends with `--date-order` show the commits in the
> +timestamp order: 8 7 6 5 4 3 2 1.
> ++
> +With `--topo-order`, they would show 8 6 5 3 7 4 2 1 (or 8 7 4 2 6 5
> +3 1), to avoid commits from two branches mixed together.

It would help at least me to also know what the output would be
without either of --date-order or --topo-order. (Does the default
order have a name, by the way?)
