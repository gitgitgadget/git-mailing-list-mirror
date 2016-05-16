From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v6 3/3] bisect--helper: `write_terms` shell function in C
Date: Mon, 16 May 2016 03:28:42 -0400
Message-ID: <CAPig+cS=zcSVLwARZ5A8hdiE0wqgYPU2Jwnr0OcjDXZFO--cZw@mail.gmail.com>
References: <1462546167-1125-1-git-send-email-pranit.bauva@gmail.com>
	<1463031127-17718-1-git-send-email-pranit.bauva@gmail.com>
	<1463031127-17718-4-git-send-email-pranit.bauva@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 16 09:29:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2CxN-0002AR-RZ
	for gcvg-git-2@plane.gmane.org; Mon, 16 May 2016 09:28:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751983AbcEPH2o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2016 03:28:44 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:34072 "EHLO
	mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750787AbcEPH2n (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2016 03:28:43 -0400
Received: by mail-io0-f195.google.com with SMTP id d62so12939449iof.1
        for <git@vger.kernel.org>; Mon, 16 May 2016 00:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=N8sFaPtGPi/hH7f/j3zTu2aAVLJEjaLNj0G7SaS+Ass=;
        b=yHS81qGbexCd7xpLAiURz9VE8azD/fY5a1XB+z6Isaumx9KGrJ/icFQ/oQy5p0WV1c
         WrGf366qolVimjIVvz8/62bEyw9TaM5CpgW3aIOhxFzgAetzkjuaBS5jogceMck0zb0o
         vcyjdrTWJfiVtfoYzEam95zNwcni+MbyPxZKhNQqbdKGXprdT1gVNBkTDe6QWj2EI1pP
         m2IzYo/no6O2s2W7bFM3AEyl9SwCXmfcWD4I+h3TwejwUHXEcMVP6MaNzbfUer0z6ub1
         weC7pK7J6JXukYVCe0Zr3P4kirICUXIxxoRkKSoQ305vXTX+OWfbVkMbcg5Y7FRr9tGQ
         da2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=N8sFaPtGPi/hH7f/j3zTu2aAVLJEjaLNj0G7SaS+Ass=;
        b=BmqdqQ6K22I3cqBZX1Xx8uX0OLEJKoVWJOPNVO0uXnZ4xlj98veYL58cQ1nefuV/UC
         IFhYFkRvMnsjL4JBWr9/JFu554ag6rbhDwrKFqLxRq54q/ggQAYmRsQ3zTyBdXi9cOrD
         jHj/4w98tQm3x9FmU2HzNRQ3w5dSZtkLAKwCin6ViAOab6YGFhdbWKwvqcSMfBGwE3WP
         EKLdwxhN6qFH1XMXOrdR/EYrewnFq7OPHCj35lVhkU1sZfv7XQTbUdOFKvybtyCockpe
         L1kcCPsdBoXg1NKwg7Aa8SvOjuXGlI7EH3hMhcIXL3RXxkIhNwLHkHi+qkgsvjHA33iK
         MceA==
X-Gm-Message-State: AOPr4FVuZuPnlpygh+lYDcasSSpwYUikS7FQRnBOL0qJYaoqIYEGrtWzGmlOa0/rA6z3UjWVh4/A9zNpAW/PQw==
X-Received: by 10.107.132.66 with SMTP id g63mr20441172iod.34.1463383723016;
 Mon, 16 May 2016 00:28:43 -0700 (PDT)
Received: by 10.79.139.4 with HTTP; Mon, 16 May 2016 00:28:42 -0700 (PDT)
In-Reply-To: <1463031127-17718-4-git-send-email-pranit.bauva@gmail.com>
X-Google-Sender-Auth: _q0ztKx1I8FDIwF8LrOZIENF7VU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294728>

On Thu, May 12, 2016 at 1:32 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
> Reimplement the `write_terms` shell function in C and add a `write-terms`
> subcommand to `git bisect--helper` to call it from git-bisect.sh . Also
> remove the subcommand `--check-term-format` as it can now be called from
> inside the function write_terms() C implementation.
>
> Using `--write-terms` subcommand is a temporary measure to port shell
> function to C so as to use the existing test suite. As more functions
> are ported, this subcommand will be retired and will be called by some
> other method.
>
> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
> ---
> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> @@ -56,18 +56,41 @@ static int check_term_format(const char *term, const char *orig_term)
> +int write_terms(const char *bad, const char *good)

s/^/static/

> +{
> +       struct strbuf content = STRBUF_INIT;
> +       FILE *fp;
> +       int res;
> +
> +       if (!strcmp(bad, good))
> +               return error(_("please use two different terms"));
> +
> +       if (check_term_format(bad, "bad") || check_term_format(good, "good"))
> +               return -1;
> +
> +       strbuf_addf(&content, "%s\n%s\n", bad, good);

What's the point of the strbuf when you could more easily emit this
same content directly to the file via:

    fprintf(fp, "%s\n%s\n", bad, good);

> +       fp = fopen(".git/BISECT_TERMS", "w");

Hardcoding ".git/" is wrong for a variety of reasons: It won't be
correct with linked worktrees, or when GIT_DIR is pointing elsewhere,
or when ".git" is a symbolic link, etc. Check out the get_git_dir(),
get_git_common_dir(), etc. functions in cache.h instead.

> +       if (!fp){

Style: space before '{'

> +               strbuf_release(&content);
> +               die_errno(_("could not open the file to read terms"));

"read terms"? I thought this was writing.

Is dying here correct? I thought we established previously that you
should be reporting failure via normal -1 return value rather than
dying. Indeed, you're doing so below when strbuf_write() fails.

> +       }
> +       res = strbuf_write(&content, fp);
> +       fclose(fp);
> +       strbuf_release(&content);
> +       return (res < 0) ? -1 : 0;
> +}
>  int cmd_bisect__helper(int argc, const char **argv, const char *prefix)

Style: insert blank line between functions
