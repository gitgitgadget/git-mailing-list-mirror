From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 4/6] for-each-ref: introduce %(upstream:track[short])
Date: Sat, 16 Nov 2013 18:53:04 -0500
Message-ID: <CAPig+cRqwOgE8by8DwuGc1nNA3C_bA07ob-GuRzETKoRPBe+CQ@mail.gmail.com>
References: <1384513148-22633-1-git-send-email-artagnon@gmail.com>
	<1384513148-22633-5-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 17 00:53:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vhpg9-0002ov-VU
	for gcvg-git-2@plane.gmane.org; Sun, 17 Nov 2013 00:53:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753351Ab3KPXxJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Nov 2013 18:53:09 -0500
Received: from mail-lb0-f179.google.com ([209.85.217.179]:58097 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752743Ab3KPXxG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Nov 2013 18:53:06 -0500
Received: by mail-lb0-f179.google.com with SMTP id l4so1329819lbv.24
        for <git@vger.kernel.org>; Sat, 16 Nov 2013 15:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=zwmjFvWGYVJkYRlcchYXdLJKbRDZwKqHpOEcteFpNsI=;
        b=RCzC5crkRvTQooHv7Occbgfu93CIBw49U9UqQVVyFWL5/d1ivgmznmVB8YiWGQ9/0n
         1tSECFD4n/cbzL0x33yPukUrcF7dRVDjBsqat64XEhImfJC+zZGpQUwzI5+B0qaCaexX
         ObbSNZ2iGuUTb9VCM0tlm9BAx2vVP3U3rtCeZOoa26HU/LX/OFGjTkqAzK/fhQif1V1f
         kmhurdRiJbHf1uKhtO0clyiQ6GVopk6rczwHgfFNh7coffW5gs5ueKjFURLEku0ZrsL7
         Nd0FgyuGYt1W5HhvJhOOx4uLUiaN0piY1Nu9yLw4iyBloZQ/4o/pSGi7cLX5fL5w2p3Z
         lGTw==
X-Received: by 10.112.200.100 with SMTP id jr4mr390854lbc.36.1384645984371;
 Sat, 16 Nov 2013 15:53:04 -0800 (PST)
Received: by 10.114.200.180 with HTTP; Sat, 16 Nov 2013 15:53:04 -0800 (PST)
In-Reply-To: <1384513148-22633-5-git-send-email-artagnon@gmail.com>
X-Google-Sender-Auth: VOjcMl3kDQylQZ3RSRDHVlU2QK0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237946>

On Fri, Nov 15, 2013 at 5:59 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Introduce %(upstream:track) to display "[ahead M, behind N]" and
> %(upstream:trackshort) to display "=", ">", "<", or "<>"
> appropriately (inspired by contrib/completion/git-prompt.sh).
>
> Now you can use the following format in for-each-ref:
>
>   %(refname:short)%(upstream:trackshort)
>
> to display refs with terse tracking information.
>
> Note that :track and :trackshort only work with "upstream", and error
> out when used with anything else.
>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  Documentation/git-for-each-ref.txt |  6 +++++-
>  builtin/for-each-ref.c             | 40 +++++++++++++++++++++++++++++++++++---
>  t/t6300-for-each-ref.sh            | 22 +++++++++++++++++++++
>  3 files changed, 64 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
> index ab3da0e..c9b192e 100644
> --- a/Documentation/git-for-each-ref.txt
> +++ b/Documentation/git-for-each-ref.txt
> @@ -91,7 +91,11 @@ objectname::
>  upstream::
>         The name of a local ref which can be considered ``upstream''
>         from the displayed ref. Respects `:short` in the same way as
> -       `refname` above.
> +       `refname` above.  Additionally respects `:track` to show
> +       "[ahead N, behind M]" and `:trackshort` to show the terse
> +       version (like the prompt) ">", "<", "<>", or "=".  Has no

The "prompt" is not mentioned elsewhere in for-each-ref documentation,
and a person not familiar with contrib/completion/ may be confused by
this reference. It might make sense instead to explain the meanings of
">", "<", "<>", and "=" directly since they are not necessarily
obvious to the casual reader.

> +       effect if the ref does not have tracking information
> +       associated with it.
>
>  HEAD::
>         Used to indicate the currently checked out branch.  Is '*' if
> diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
> index 5f1842f..ed81407 100644
> --- a/builtin/for-each-ref.c
> +++ b/builtin/for-each-ref.c
> @@ -689,13 +690,46 @@ static void populate_value(struct refinfo *ref)
>                         continue;
>
>                 formatp = strchr(name, ':');
> -               /* look for "short" refname format */
>                 if (formatp) {
> +                       int num_ours, num_theirs;
> +
>                         formatp++;
>                         if (!strcmp(formatp, "short"))
>                                 refname = shorten_unambiguous_ref(refname,
>                                                       warn_ambiguous_refs);
> -                       else
> +                       else if (!strcmp(formatp, "track") &&
> +                               !prefixcmp(name, "upstream")) {
> +                               char buf[40];
> +
> +                               stat_tracking_info(branch, &num_ours, &num_theirs);
> +                               if (!num_ours && !num_theirs)
> +                                       v->s = "";
> +                               else if (!num_ours) {
> +                                       sprintf(buf, "[behind %d]", num_theirs);
> +                                       v->s = xstrdup(buf);
> +                               } else if (!num_theirs) {
> +                                       sprintf(buf, "[ahead %d]", num_ours);
> +                                       v->s = xstrdup(buf);
> +                               } else {
> +                                       sprintf(buf, "[ahead %d, behind %d]",

Is the intention that these strings ("[ahead %d]", etc.) will be
internationalized in the future? If so, the allocated 40-character
buffer may be insufficient.

> +                                               num_ours, num_theirs);
> +                                       v->s = xstrdup(buf);
> +                               }
> +                               continue;
> +                       } else if (!strcmp(formatp, "trackshort") &&
> +                               !prefixcmp(name, "upstream")) {
> +
> +                               stat_tracking_info(branch, &num_ours, &num_theirs);
> +                               if (!num_ours && !num_theirs)
> +                                       v->s = "=";
> +                               else if (!num_ours)
> +                                       v->s = "<";
> +                               else if (!num_theirs)
> +                                       v->s = ">";
> +                               else
> +                                       v->s = "<>";
> +                               continue;
> +                       } else
>                                 die("unknown %.*s format %s",
>                                     (int)(formatp - name), name, formatp);

Is it still accurate to call this a "format" in the error message?
'track' and 'trackshort' seem more like decorations.

>                 }
> diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
> index 5e29ffc..9d874fd 100755
> --- a/t/t6300-for-each-ref.sh
> +++ b/t/t6300-for-each-ref.sh
> @@ -303,6 +303,28 @@ test_expect_success 'Check short upstream format' '
>         test_cmp expected actual
>  '
>
> +test_expect_success 'setup for upstream:track[short]' '
> +       test_commit two
> +'
> +
> +cat >expected <<EOF
> +[ahead 1]
> +EOF
> +
> +test_expect_success 'Check upstream:track format' '
> +       git for-each-ref --format="%(upstream:track)" refs/heads >actual &&
> +       test_cmp expected actual
> +'
> +
> +cat >expected <<EOF
> +>
> +EOF
> +
> +test_expect_success 'Check upstream:trackshort format' '
> +       git for-each-ref --format="%(upstream:trackshort)" refs/heads >actual &&
> +       test_cmp expected actual
> +'
> +
>  cat >expected <<EOF
>  $(git rev-parse --short HEAD)
>  EOF

Would it make sense also to add tests verifying that :track and
:trackshort correctly fail when applied to a key other than
"upstream"?
