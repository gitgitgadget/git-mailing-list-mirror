From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH 2/3] combine-diff: suppress a clang warning
Date: Mon, 4 Feb 2013 02:20:06 +0800
Message-ID: <CALUzUxowrh53g50ZxkXSjLfOrSgX-YiZEB2MJXbLwxmwNB187A@mail.gmail.com>
References: <cover.1359901732.git.john@keeping.me.uk> <6995fd5e4d9cb3320ab80c983f1b25ae8a399284.1359901732.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>,
	Antoine Pelisse <apelisse@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sun Feb 03 19:20:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U24BO-0006nK-EF
	for gcvg-git-2@plane.gmane.org; Sun, 03 Feb 2013 19:20:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753405Ab3BCSU2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2013 13:20:28 -0500
Received: from mail-ob0-f173.google.com ([209.85.214.173]:36707 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753371Ab3BCSU1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2013 13:20:27 -0500
Received: by mail-ob0-f173.google.com with SMTP id dn14so5719811obc.18
        for <git@vger.kernel.org>; Sun, 03 Feb 2013 10:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=6Zg/tIil5rHgqobtgI1L1knnu5CmPa3FnjD9IvfERM8=;
        b=0GszErOuwgbnLnIFKpB1nE8ciZPZwVDlzqbcJb8+sor4/CHBiw+N11UuoY6zoxKmLZ
         hb3h/wONaSBxGQfsFFZqU9aX9vCEY5akj3ZgRwA/FnN0NAT8a53X4/0t8ZO3j4R/dJoD
         thQE+aMQFxD8waIZ+GAiTIXr8gnJfYm7oKZAh6QnU14tbweP1LMt1WnwK2pFiCidWQkr
         ZoKS+aYUGL6cds6tZ4UdRc/NCEPfNorTtA1vzAN+5rhCv25PYEGemt0uBoUPLGUnVc3b
         MpEQL0ymD7JEnjiKbEA2t7c6CT2v0yVbf3z58G92kkniytqU6kOM3JlodACcu2lXkDXx
         xu4Q==
X-Received: by 10.182.98.5 with SMTP id ee5mr13721241obb.28.1359915626548;
 Sun, 03 Feb 2013 10:20:26 -0800 (PST)
Received: by 10.76.151.166 with HTTP; Sun, 3 Feb 2013 10:20:06 -0800 (PST)
In-Reply-To: <6995fd5e4d9cb3320ab80c983f1b25ae8a399284.1359901732.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215321>

On Sun, Feb 3, 2013 at 10:37 PM, John Keeping <john@keeping.me.uk> wrote:
> When compiling combine-diff.c, clang 3.2 says:
>
>     combine-diff.c:1006:19: warning: adding 'int' to a string does not
>             append to the string [-Wstring-plus-int]
>                 prefix = COLONS + offset;
>                          ~~~~~~~^~~~~~~~
>     combine-diff.c:1006:19: note: use array indexing to silence this warning
>                 prefix = COLONS + offset;
>                                 ^
>                          &      [       ]
>
> Suppress this by making the suggested change.
>
> Signed-off-by: John Keeping <john@keeping.me.uk>
> ---
>  combine-diff.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/combine-diff.c b/combine-diff.c
> index bb1cc96..dba4748 100644
> --- a/combine-diff.c
> +++ b/combine-diff.c
> @@ -1003,7 +1003,7 @@ static void show_raw_diff(struct combine_diff_path *p, int num_parent, struct re
>                 offset = strlen(COLONS) - num_parent;
>                 if (offset < 0)
>                         offset = 0;
> -               prefix = COLONS + offset;
> +               prefix = &COLONS[offset];
>
>                 /* Show the modes */
>                 for (i = 0; i < num_parent; i++) {
> --

Hmm, does

               prefix = (const char *) COLONS + offset;

suppress the warning?

--
Cheers,
Ray Chuan
