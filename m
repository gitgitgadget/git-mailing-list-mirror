From: John Szakmeister <john@szakmeister.net>
Subject: Re: [PATCH] credential-osxkeychain: support more protocols
Date: Mon, 27 May 2013 06:27:47 -0400
Message-ID: <CAEBDL5W4sLB0R1ZOspb-yQzmyTCE7Y1HeC2KZ69F8R28fJY7_A@mail.gmail.com>
References: <1369641431-44504-1-git-send-email-quanxunzhen@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Xidorn Quan <quanxunzhen@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 27 12:27:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uguef-00049V-0J
	for gcvg-git-2@plane.gmane.org; Mon, 27 May 2013 12:27:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757412Ab3E0K1t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 May 2013 06:27:49 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:46160 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756121Ab3E0K1s (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 May 2013 06:27:48 -0400
Received: by mail-wi0-f170.google.com with SMTP id hr14so2116139wib.5
        for <git@vger.kernel.org>; Mon, 27 May 2013 03:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=v5zDsPHXl9NqU/ZIwp09EPOBi3SOM0DwncJ5AadxcAA=;
        b=MkpBZx6Y1c1phg5sYahK/LGfOVDuNWUJ/EsQRuqOZ6rqcEPnzH8tAPK1LqRiJ4lFjh
         v9pYItJn4ZJSHUf81aFoOqFOwqwng7NQ1Yr0DqyOuWUSEKNgjQrXBJZCmNkzO/jUIXci
         3kT9SsCqgx9V5sK+3ajEoWyDEsyQcntoAEt6npCwEdld7Qm06SlfH3RrsdWldc8j6Zm6
         SJ9Dvy3JDAOnFbYdGouebwYwLgQ7b4XzIaOxl9NtNpV8tedr174xbK3hA3pe8lEqkoiI
         2mYQNqYJCHA1k1eBqoLZwTeTGfXkWHaKBPeATH0heHaUaGtQFTrvWRdumvhDKrov20WT
         mvfw==
X-Received: by 10.180.76.194 with SMTP id m2mr7947751wiw.4.1369650467141; Mon,
 27 May 2013 03:27:47 -0700 (PDT)
Received: by 10.180.5.33 with HTTP; Mon, 27 May 2013 03:27:47 -0700 (PDT)
In-Reply-To: <1369641431-44504-1-git-send-email-quanxunzhen@gmail.com>
X-Google-Sender-Auth: sQMloz-vDsVsQE6GHsSAVBTQ3SY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225584>

On Mon, May 27, 2013 at 3:57 AM, Xidorn Quan <quanxunzhen@gmail.com> wrote:
> Add protocol ftp, smtp, and ssh for credential-osxkeychain.
> ---
>  contrib/credential/osxkeychain/git-credential-osxkeychain.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/contrib/credential/osxkeychain/git-credential-osxkeychain.c b/contrib/credential/osxkeychain/git-credential-osxkeychain.c
> index 3940202..4ddcfb3 100644
> --- a/contrib/credential/osxkeychain/git-credential-osxkeychain.c
> +++ b/contrib/credential/osxkeychain/git-credential-osxkeychain.c
> @@ -127,10 +127,16 @@ static void read_credential(void)
>                 *v++ = '\0';
>
>                 if (!strcmp(buf, "protocol")) {
> -                       if (!strcmp(v, "https"))
> +                       if (!strcmp(v, "ftp"))
> +                               protocol = kSecProtocolTypeFTP;
> +                       else if (!strcmp(v, "https"))
>                                 protocol = kSecProtocolTypeHTTPS;
>                         else if (!strcmp(v, "http"))
>                                 protocol = kSecProtocolTypeHTTP;
> +                       else if (!strcmp(v, "smtp"))
> +                               protocol = kSecProtocolTypeSMTP;
> +                       else if (!strcmp(v, "ssh"))
> +                               protocol = kSecProtocolTypeSSH;
>                         else /* we don't yet handle other protocols */
>                                 exit(0);

This looks pretty good, except the last one raises a question.  I'm
using Mac OS X, and ssh already interacts with keychain to get my SSH
key password.  Is this mainly for password logins via SSH?  Assuming
that's the case:

Signed-off-by: John Szakmeister <john@szakmeister.net>

-John
