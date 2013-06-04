From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 08/15] for-each-ref: get --pretty using format_commit_message
Date: Tue, 4 Jun 2013 17:12:10 -0400
Message-ID: <CAPig+cRmnc=poOZUxZms_OWdLpBM_q=h+MDYisu8WtuF11PYXA@mail.gmail.com>
References: <1370349337-20938-1-git-send-email-artagnon@gmail.com>
	<1370349337-20938-9-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 04 23:12:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjyWg-0002bj-Rd
	for gcvg-git-2@plane.gmane.org; Tue, 04 Jun 2013 23:12:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751489Ab3FDVMO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Jun 2013 17:12:14 -0400
Received: from mail-la0-f48.google.com ([209.85.215.48]:35481 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751279Ab3FDVMM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Jun 2013 17:12:12 -0400
Received: by mail-la0-f48.google.com with SMTP id fs12so728366lab.21
        for <git@vger.kernel.org>; Tue, 04 Jun 2013 14:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=+Hlwcq+OlF7uHAwGlMm0lHjVi5HSJQK0R840rcg7zFY=;
        b=mBdkEhRHtTLys02euLR/QE9+r+PqASw3LaCkvu8xGT+TX8a+U52iKgAGljPBx+LEi4
         48rH66L7N8q0UMVKycGcnvvixpIgVvbU7LhYp8UWjXUFWbZqdDSnXf/SjguHb1YRaeyA
         /KOpK6IqQE3y1YGaMrkmZZ+m15u5oG7WjayXldFMUdxJLhq+YJ9hlesIyez5xoWGSLar
         JzepEppl0QuoKCLn0FXkMk9/w9YX48as5EDF8jtBCyec5pZECLhRqBwbLVdTW9KJs8lI
         n7duVU1T+UZM+A8/TEfRXnXtdW5DOLTgWms2m3dudQWYtVwVDAJBjApcmdi4oMQuvp7c
         5tXQ==
X-Received: by 10.112.145.100 with SMTP id st4mr13781048lbb.102.1370380330288;
 Tue, 04 Jun 2013 14:12:10 -0700 (PDT)
Received: by 10.114.161.4 with HTTP; Tue, 4 Jun 2013 14:12:10 -0700 (PDT)
In-Reply-To: <1370349337-20938-9-git-send-email-artagnon@gmail.com>
X-Google-Sender-Auth: gSTidzYLOwijiOpQql9lBTY95XA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226404>

On Tue, Jun 4, 2013 at 8:35 AM, Ramkumar Ramachandra <artagnon@gmail.co=
m> wrote:
> From: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
>
> [rr: documentation]
>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  Documentation/git-for-each-ref.txt | 22 ++++++++++++-
>  builtin/for-each-ref.c             | 67 ++++++++++++++++++++++++++++=
++++++++--
>  2 files changed, 85 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-f=
or-each-ref.txt
> index f2e08d1..6135812 100644
> --- a/Documentation/git-for-each-ref.txt
> +++ b/Documentation/git-for-each-ref.txt
> @@ -47,6 +48,25 @@ OPTIONS
>         `xx`; for example `%00` interpolates to `\0` (NUL),
>         `%09` to `\t` (TAB) and `%0a` to `\n` (LF).
>
> +<pretty>::
> +       A format string with supporting placeholders described in the
> +       "PRETTY FORMATS" section in linkgit:git-log[1].  Additionally
> +       supports placeholders from `<format>`
> +       (i.e. `%[*](fieldname)`).
> ++
> +Caveats:
> +
> +1. Many of the placeholders in "PRETTY FORMATS" are designed to work
> +   specifically on commit objects: when non-commit objects are
> +   supplied, those placeholders won't work.

Should "won't work" be expanded upon? It's not clear if this means
that git will outright crash, or if it will abort with an appropriate
error message, or if the directive will be displayed as-is or removed
from the output.

> +2. Does not interpolate `%ab` (where `ab` are hex digits) with the
> +   corresponding hex code.  To print a byte from a hex code, use
> +   `%xab` (from pretty-formats) instead.
> +
> +3. Only the placeholders inherited from `<format>` will respect
> +   quoting settings.
> +
>  <pattern>...::
>         If one or more patterns are given, only refs are shown that
>         match against at least one pattern, either using fnmatch(3) o=
r
