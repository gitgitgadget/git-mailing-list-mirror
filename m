From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] fixup! mergetools: simplify how we handle "vim" and "defaults"
Date: Mon, 28 Jan 2013 17:37:13 -0800
Message-ID: <CAJDDKr5wsYqnBk+kvKj1qzUYKJBJ5nAiwMJZ=HpzPPgJf8BBTQ@mail.gmail.com>
References: <20130128192856.GA7498@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Tue Jan 29 02:37:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U008o-0008SG-0a
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jan 2013 02:37:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753108Ab3A2BhQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2013 20:37:16 -0500
Received: from mail-wi0-f171.google.com ([209.85.212.171]:55675 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752717Ab3A2BhO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2013 20:37:14 -0500
Received: by mail-wi0-f171.google.com with SMTP id hn14so1992553wib.4
        for <git@vger.kernel.org>; Mon, 28 Jan 2013 17:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=zWWXW7PIdIgDq7bst9+z2v880BiBOrU43D17Pq8G7Ds=;
        b=vnzGDXtsBp5qTSmAspa/b4CQqk3NhmJH/b9hmPobs316p3KthyvPCgdLDNAZu5RbfB
         x52R6nX/W9+bAcxuKLQFInylNAne3ydf76g89uTktpkKooIXw9W+pA0BxS4U7Z/laGU5
         R6Vwqccq6B5ZmZQhqvsW0fKDXn0Fx/BGMOtiqDe76zpZAYniBygXX0TCiJ/KFZk07dHa
         +CkBbzNOSXaF/FHKhV7HZPDaU9jRpVslr6cr/f/mvO+DhKFSa3BnkBAreeY8SRl3ONNZ
         bw1hiHnZ22CRoxy8ny4qSoPSDrG7LG5hbumZtWPgeDsfuKWZhrXcPW3/H1tow86zaEdd
         YlFg==
X-Received: by 10.194.119.5 with SMTP id kq5mr314994wjb.48.1359423433137; Mon,
 28 Jan 2013 17:37:13 -0800 (PST)
Received: by 10.194.24.231 with HTTP; Mon, 28 Jan 2013 17:37:13 -0800 (PST)
In-Reply-To: <20130128192856.GA7498@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214892>

On Mon, Jan 28, 2013 at 11:28 AM, John Keeping <john@keeping.me.uk> wrote:
> ---
> Junio, please can you squash this into f9924e5 on jk/mergetool,
> providing that David is OK with that?

This looks good to me.

> The original change breaks custom mergetool by making changing the logic
> around default functions so that they are now only defined when the tool
> file exists in $MERGE_TOOLS_DIR but we need the default implementations
> when a custom tool is in use, which by definition means that the file
> doesn't exist in $MERGE_TOOLS_DIR.
>
>  git-mergetool--lib.sh | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
> index 1d0fb12..211ffe5 100644
> --- a/git-mergetool--lib.sh
> +++ b/git-mergetool--lib.sh
> @@ -48,15 +48,6 @@ valid_tool () {
>  setup_tool () {
>         tool="$1"
>
> -       if ! test -f "$MERGE_TOOLS_DIR/$tool"
> -       then
> -               # Use a special return code for this case since we want to
> -               # source "defaults" even when an explicit tool path is
> -               # configured since the user can use that to override the
> -               # default path in the scriptlet.
> -               return 2
> -       fi
> -
>         # Fallback definitions, to be overriden by tools.
>         can_merge () {
>                 return 0
> @@ -80,6 +71,15 @@ setup_tool () {
>                 echo "$1"
>         }
>
> +       if ! test -f "$MERGE_TOOLS_DIR/$tool"
> +       then
> +               # Use a special return code for this case since we want to
> +               # source "defaults" even when an explicit tool path is
> +               # configured since the user can use that to override the
> +               # default path in the scriptlet.
> +               return 2
> +       fi
> +
>         # Load the redefined functions
>         . "$MERGE_TOOLS_DIR/$tool"
>
> --
> 1.8.1.1



-- 
David
