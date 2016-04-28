From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 2/4] git_connect: avoid quoting the path on the command
 line when it's not necessary
Date: Thu, 28 Apr 2016 09:14:56 -0700
Message-ID: <CAGZ79kYf+7r_eA3pDPiQaMP+fb5Rp6cYwts+YQzamUnVzsr-Kg@mail.gmail.com>
References: <1461852759-28429-1-git-send-email-mh@glandium.org>
	<1461852759-28429-3-git-send-email-mh@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Thu Apr 28 18:15:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avoas-0000Jn-QE
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 18:15:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752764AbcD1QPE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2016 12:15:04 -0400
Received: from mail-io0-f171.google.com ([209.85.223.171]:34144 "EHLO
	mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752586AbcD1QPC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2016 12:15:02 -0400
Received: by mail-io0-f171.google.com with SMTP id 190so76167402iow.1
        for <git@vger.kernel.org>; Thu, 28 Apr 2016 09:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=820dDkzpzl3hCTDFhv1JcsnCzEusCfQVpeZB4EJPah4=;
        b=GtdBC0qt/0FXei60TWmqWwUCp6BLFOpsqyxD85z/ttNZtXzwjE1jrOq79pQ+L6TJ4+
         hi1seH7sfTAkDtBknGs24oybDZVlY47w7Ac8TiLFQF9uv7s6+CWgod4ESBt0FM8V6Du1
         c6YXkuIJiwQZ6F1TaJ4fq3yztVrvTQuRDbuCiHwXL3bRBySHYbELE4CwzcZI+Wil16/U
         vv9G/mwwJSHszfIUTE53VjbsvWIxVIxsvIt6NiOKSAztzHmUzvI2aCBVVtXHbGMbd0R+
         CS9giqqbeE4hu/e0C+gxrtr7KQ6zWVUF58o4nm/ohJkk9c2uqtDfR/MD8nHcxdj2CyTK
         9/1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=820dDkzpzl3hCTDFhv1JcsnCzEusCfQVpeZB4EJPah4=;
        b=Br/+RsT6zXpJJ9ALHPD8BYx0LltMarzzYVzW8PnLLEsrbMq7KlXZk+6yHxvHl3FZKm
         eRks5YxdSz6XoZmLx/p3jQvMGDqNvjReUMYbVnqV46rDjZwB0XlbKNn3n5gUiharZdtA
         53pcBtAb37B6482EGMnavxg2ISqTKTIo0f08ZQFjJVT87dxUjaAQ7vqnpCWMs/LMOerv
         WSJ6NMusem9VUsBeaO6nceT3lpJVkb/Vwf0ZY++3YJkGl1t80hYE92VcRVK+KF6Ferwr
         P8fZH7Sb+7vMMo1nEhv/AMwgF8ZxjkvQXcFccIktyppRUfVKU/AbagFd93+WUeL0zZud
         y1Fg==
X-Gm-Message-State: AOPr4FXnMweMzPALLZXI8NWNBun42VqeJoF8N1Es7yKDGvIfP6q5UU/bF/5akgGQXm+UhV4RP6PTsLtiffQB/UIk
X-Received: by 10.107.174.205 with SMTP id n74mr18515249ioo.96.1461860096199;
 Thu, 28 Apr 2016 09:14:56 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Thu, 28 Apr 2016 09:14:56 -0700 (PDT)
In-Reply-To: <1461852759-28429-3-git-send-email-mh@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292913>

On Thu, Apr 28, 2016 at 7:12 AM, Mike Hommey <mh@glandium.org> wrote:
> Some remote systems can employ restricted shells that aren't very smart
> with quotes, so avoid quoting when it's not strictly necessary.
>
> The list of "safe" characters comes from Mercurial's shell quoting
> function used for its ssh client side. There likely are more that could
> be added to the list.
>

Would it make sense to move the new code into its own function and
document it with this paragraph of the commit message, i.e. hinting
at Mercurial safe characters or others?

> Signed-off-by: Mike Hommey <mh@glandium.org>
> ---
>  connect.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/connect.c b/connect.c
> index 96c8c1d..919bf9e 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -668,6 +668,17 @@ static void prepare_connect_command(struct strbuf *cmd, const char *prog,
>                 strbuf_addstr(cmd, prog);
>                 strbuf_addch(cmd, ' ');
>         }
> +       if (quote) {
> +               const char *p;
> +               for (p = path; *p; p++) {
> +                       if (!isalnum(*p) && *p != '@' && *p != '%' &&
> +                           *p != '_' && *p != '+' && *p != '=' && *p != ':' &&
> +                           *p != ',' && *p != '.' && *p != '/' && *p != '-')
> +                               break;
> +               }
> +               if (!*p)
> +                       quote = 0;
> +       }
>         if (quote)
>                 sq_quote_buf(cmd, path);
>         else
> --
> 2.8.1.5.g18c8a48
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
