From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 5/5] rev-parse: introduce --exclude=<glob> to tame wildcards
Date: Fri, 1 Nov 2013 15:43:45 -0400
Message-ID: <CAPig+cQf+FEiZiLfHUsH2XH9KcpCqmJP7xVPok-Ww9fuTX_Wxw@mail.gmail.com>
References: <52264070.3080909@kdbg.org>
	<1383334455-18623-1-git-send-email-gitster@pobox.com>
	<1383334455-18623-4-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 01 20:43:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VcKdL-0007xS-Ip
	for gcvg-git-2@plane.gmane.org; Fri, 01 Nov 2013 20:43:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752343Ab3KATns (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Nov 2013 15:43:48 -0400
Received: from mail-lb0-f170.google.com ([209.85.217.170]:62708 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751071Ab3KATnr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Nov 2013 15:43:47 -0400
Received: by mail-lb0-f170.google.com with SMTP id u14so3868653lbd.1
        for <git@vger.kernel.org>; Fri, 01 Nov 2013 12:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=Wrzn1keSC5Vm9jxQw4U81H08V6lc1nRqtQahK/YW7hs=;
        b=MuShdjWRXB/uLSly6sAhvQPdoG4zs+gAnBWkxezQGrnzeNDX7ijzo2V3Ol7jxwSABd
         ndBl5TVffith/66lJ7Yv7OtOYP53OiwcgX/j+6hYrMA7Plu1Xtx/F2Ah6Cy0zPNLdZj5
         YldL3+tfr62gJ0NRPxSAhm9uL7LpSxpqtHMLfNFNyA7CEy9b50r937hXfc0r+mADgmhs
         G+hiUNQ7N/JQeRIKwZOlCozysfWYpRrp8TOiZAj7AuKMw5wDyUYpgEsxMc7thmBOisq9
         /FOGgEEqyBdpYWcojA7r2smak7P16V8ayIoPoLwWHGo9KprDw5pvgi6dkOlrDNwt+3rw
         g5Dg==
X-Received: by 10.152.115.177 with SMTP id jp17mr333684lab.59.1383335025881;
 Fri, 01 Nov 2013 12:43:45 -0700 (PDT)
Received: by 10.114.200.180 with HTTP; Fri, 1 Nov 2013 12:43:45 -0700 (PDT)
In-Reply-To: <1383334455-18623-4-git-send-email-gitster@pobox.com>
X-Google-Sender-Auth: 8c_fEpXCS2IROKixYt3zQunvdNk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237222>

On Fri, Nov 1, 2013 at 3:34 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Teach "rev-parse" the same "I'm going to glob, but omit the ones
> that match these patterns" feature as "rev-list".
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/git-rev-parse.txt | 14 ++++++++++++++
>  builtin/rev-parse.c             | 17 +++++++++++++++++
>  t/t6018-rev-list-glob.sh        | 12 ++++++++++++
>  3 files changed, 43 insertions(+)
>
> diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
> index 2b126c0..d4639a2 100644
> --- a/Documentation/git-rev-parse.txt
> +++ b/Documentation/git-rev-parse.txt
> @@ -155,6 +155,20 @@ shown.  If the pattern does not contain a globbing character (`?`,
>         character (`?`, `*`, or `[`), it is turned into a prefix
>         match by appending `/*`.
>
> +--exclude=<glob-pattern>::
> +       Do not include refs matching '<glob-pattern>' that the next `--all`,
> +       `--branches`, `--tags`, `--remotes`, or `--glob` would otherwise
> +       consider. Repetitions of this option accumulate exclusion patterns
> +       up to the next `--all`, `--branches`, `--tags`, `--remotes`, or
> +       `--glob` option (other options or arguments do not clear
> +       accumlated patterns).
> ++
> +The patterns given should not begin with `refs/heads`, `refs/tags`, or
> +`refs/remotes` when applied to `--branches`, `--tags`, or `--remotes`,
> +restrictively, and they must begin with `refs/` when applied to `--glob`

Did you mean s/restrictively/respectively/ ?

> +or `--all`. If a trailing '/{asterisk}' is intended, it must be given
> +explicitly.
