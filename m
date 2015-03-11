From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 3/4] docs/git-credential-store: document XDG file and precedence
Date: Wed, 11 Mar 2015 03:47:02 -0400
Message-ID: <CAPig+cTvX-yZpwC8BvN2CmgkBrOKUaotvJHdwXwfU8YnqLi4nQ@mail.gmail.com>
References: <1426056553-9364-1-git-send-email-pyokagan@gmail.com>
	<1426056553-9364-4-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 11 08:47:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVbMC-0006KJ-N3
	for gcvg-git-2@plane.gmane.org; Wed, 11 Mar 2015 08:47:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751375AbbCKHrE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2015 03:47:04 -0400
Received: from mail-yk0-f182.google.com ([209.85.160.182]:40053 "EHLO
	mail-yk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750832AbbCKHrD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Mar 2015 03:47:03 -0400
Received: by ykq142 with SMTP id 142so3210295ykq.7
        for <git@vger.kernel.org>; Wed, 11 Mar 2015 00:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=JQ+vZfcupMzFqcTzNU2Vp95qGgca4R7mYrD85ciAWAA=;
        b=MdgzIrWXD+jJuiaMvUlQtnr5BJz/LbeDpXTMPYxthDOBMaC9PUbxDMswqxDBCuxtYf
         S6lbi4/ovV06q0VAQiQWF/mziNOzPpXvhfEP2evWaaxJrBMAtj7O4X7hIoTELiFr2xNa
         9c6zZ+u6CAQ/RJEWuBSu1nz4XBDjf4M/DpHO/4i/zh52cfSNN8A4zFVxlkZDKTFhEnqo
         E7EgwPO8DpxOfgJlHkrqi1Atz1YVT0wCXBJvZRE1k4V1SVwrhMrOjhmZ8aX1vu/n6HBM
         T1wwMUsWctBrAAj8pjqA1ovQSgE8Oeqz+d6sd/HGkD1tV803N8NDM4Xmt4VKbB+Ub1n4
         Mmxw==
X-Received: by 10.170.194.7 with SMTP id l7mr6430952yke.91.1426060022354; Wed,
 11 Mar 2015 00:47:02 -0700 (PDT)
Received: by 10.170.73.7 with HTTP; Wed, 11 Mar 2015 00:47:02 -0700 (PDT)
In-Reply-To: <1426056553-9364-4-git-send-email-pyokagan@gmail.com>
X-Google-Sender-Auth: 21hI5OWRio8nDC6VYeXBxrA94Wo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265312>

On Wed, Mar 11, 2015 at 2:49 AM, Paul Tan <pyokagan@gmail.com> wrote:
> git-credential-store now supports an additional default credential file
> at $XDG_CONFIG_HOME/git/credentials. However, ~/.git-credentials takes
> precedence over it for backwards compatibility. To make the precedence
> ordering explicit, add a new section FILES that lists out the credential
> file paths in their order of precedence, and explains how the ordering
> affects the lookup, storage and erase operations.
>
> Also update documentation for --store to briefly explain the operations
> on multiple files if the --store option is not provided.
>
> Signed-off-by: Paul Tan <pyokagan@gmail.com>
> ---
> diff --git a/Documentation/git-credential-store.txt b/Documentation/git-credential-store.txt
> index bc97071..451c4fa 100644
> --- a/Documentation/git-credential-store.txt
> +++ b/Documentation/git-credential-store.txt
> @@ -31,10 +31,43 @@ OPTIONS
> +[[FILES]]
> +FILES
> +-----
> +
> +If not set explicitly with '--file', there are two files where
> +git-credential-store will search for credentials in order of precedence:
> +
> +~/.git-credentials::
> +       User-specific credentials file.
> +
> +$XDG_CONFIG_HOME/git/credentials::
> +       Second user-specific credentials file. If '$XDG_CONFIG_HOME' is not set
> +       or empty, `$HOME/.config/git/credentials` will be used. Any credentials
> +       stored in this file will not be used if `~/.git-credentials` has a
> +       matching credential as well. It is a good idea not to create this file
> +       if you sometimes use older versions of Git, as support for this file
> +       was added fairly recently.

The final sentence won't age well: "fairly recently" is too nebulous.
It may be sufficient merely to advise the reader to avoid this file if
she also uses an older version of Git which doesn't support XDG for
credentials.

Other than this minor point, the patch series seems well prepared and
quite nicely done. Thanks.

> +For credential lookups, the files are read in the order given above, with the
> +first matching credential found taking precedence over credentials found in
> +files further down the list.
> +
> +Credential storage will per default write to the first existing file in the
> +list. If none of these files exist, `~/.git-credentials` will be created and
> +written to.
> +
> +When erasing credentials, matching credentials will be erased from all files.
>
>  EXAMPLES
>  --------
> --
> 2.1.4
