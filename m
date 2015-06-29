From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v4 40/44] builtin-am: support and auto-detect mercurial patches
Date: Mon, 29 Jun 2015 13:32:03 -0700
Message-ID: <CAGZ79kbO+f2iwTE0dG2zx09SAPR3KTt7T5sw5AFmLuNpo8HG3g@mail.gmail.com>
References: <1435500366-31700-1-git-send-email-pyokagan@gmail.com>
	<1435500366-31700-41-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 29 22:32:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9fis-00074E-8r
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jun 2015 22:32:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752597AbbF2UcG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jun 2015 16:32:06 -0400
Received: from mail-yk0-f182.google.com ([209.85.160.182]:36561 "EHLO
	mail-yk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751754AbbF2UcE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jun 2015 16:32:04 -0400
Received: by ykdr198 with SMTP id r198so125496808ykd.3
        for <git@vger.kernel.org>; Mon, 29 Jun 2015 13:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=VWhReJHl64SZhEAb+5VmsEwk5flQRSQIaNhpWP9yh8E=;
        b=oi1upFt/OlAq07CSKbROb2tvMwSeGrYLJJrh3l4F9j/iIXgn9/TgWad3zmkz6qmCyf
         JtOJp/gf0gms0xJ9w2A4HMv1aPrclYpFLKG9L4v0qaY3zXaL6cID92r+IZN173jsFTQk
         ST8pM6/DX/nztuRSHyecrPJbJisdxL5IiL3ASgMFPty315qDz/HnR1MinIfuHzUC+BXR
         flU4wRdr75TfM8oejkWI4Ii3m2koMqb5o3ij4ypyo3tufGM7gzm8S8UAhdaMKtsh4zSB
         ytePHSEnyK3irjhoDWp9TeXlQDrPZPoGUM7xzbAfdTKlMWUzjeNC4ddULi5RLYerGq9J
         LfsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=VWhReJHl64SZhEAb+5VmsEwk5flQRSQIaNhpWP9yh8E=;
        b=mbvY3z1xLeTfR3ucwpzQsrKstfxFpSrV4CPAXp53rBpK0VIb1RAyVyDQqdRNOvg1CA
         74PyXq+xdDRlIYQIzvgI/2wKMhyZ0DcQlfJTh9Qidq3SEkpo+DY640S0r8riG/9b6r/B
         Oouq0JsmPzoi3hAmkfVsPaLXoo2XbbG9XOJSnhEg5J7x4KgnTy+XVVoeCTihAwZnlYRP
         KmRlG68XTCL4m8jkoAo03YY8m/h7ZbOuGrAFtDJrEqOIdMpbHDN9QwR6CkS6Ym6KfXrD
         WXWyrwhXbwOsposA58XIV0Q0FXx4QrYZHbsdPu+edi4zQniymxF2vkKrMvp0mrozTrgg
         K4uA==
X-Gm-Message-State: ALoCoQkBzdtFCFcI1rWZTj4sqIDZ4KIFI4ZQkMwM7Zse1OrzTNpSFLuPPEoJ8/BH3fV4BKORoFXR
X-Received: by 10.170.217.85 with SMTP id j82mr20991714ykf.25.1435609923593;
 Mon, 29 Jun 2015 13:32:03 -0700 (PDT)
Received: by 10.37.4.80 with HTTP; Mon, 29 Jun 2015 13:32:03 -0700 (PDT)
In-Reply-To: <1435500366-31700-41-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273015>

On Sun, Jun 28, 2015 at 7:06 AM, Paul Tan <pyokagan@gmail.com> wrote:
> Since 0cfd112 (am: preliminary support for hg patches, 2011-08-29),
> git-am.sh could convert mercurial patches to an RFC2822 mail patch
> suitable for parsing with git-mailinfo, and queue them in the state
> directory for application.
>
> Since 15ced75 (git-am foreign patch support: autodetect some patch
> formats, 2009-05-27), git-am.sh was able to auto-detect mercurial
> patches by checking if the file begins with the line:
>
>         # HG changeset patch
>
> Re-implement the above in builtin/am.c.
>
> Signed-off-by: Paul Tan <pyokagan@gmail.com>
> ---
>  builtin/am.c | 73 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 72 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/am.c b/builtin/am.c
> index 1576bd4..5c86e6f 100644
> --- a/builtin/am.c
> +++ b/builtin/am.c
> @@ -81,7 +81,8 @@ enum patch_format {
>         PATCH_FORMAT_UNKNOWN = 0,
>         PATCH_FORMAT_MBOX,
>         PATCH_FORMAT_STGIT,
> -       PATCH_FORMAT_STGIT_SERIES
> +       PATCH_FORMAT_STGIT_SERIES,
> +       PATCH_FORMAT_HG
>  };
>
>  enum keep_type {
> @@ -697,6 +698,11 @@ static int detect_patch_format(const char **paths)
>                 goto done;
>         }
>
> +       if (!strcmp(l1.buf, "# HG changeset patch")) {
> +               ret = PATCH_FORMAT_HG;
> +               goto done;
> +       }
> +
>         strbuf_reset(&l2);
>         strbuf_getline_crlf(&l2, fp);
>         strbuf_reset(&l3);
> @@ -895,6 +901,67 @@ static int split_mail_stgit_series(struct am_state *state, const char **paths,
>  }
>
>  /**
> + * A split_patches_conv() callback that converts a mercurial patch to a RFC2822
> + * message suitable for parsing with git-mailinfo.
> + */
> +static int hg_patch_to_mail(FILE *out, FILE *in, int keep_cr)
> +{
> +       struct strbuf sb = STRBUF_INIT;
> +
> +       while (!strbuf_getline(&sb, in, '\n')) {
> +               const char *str;
> +
> +               if (skip_prefix(sb.buf, "# User ", &str))
> +                       fprintf(out, "From: %s\n", str);
> +               else if (skip_prefix(sb.buf, "# Date ", &str)) {
> +                       unsigned long timestamp;
> +                       long tz;
> +                       char *end;
> +
> +                       errno = 0;
> +                       timestamp = strtoul(str, &end, 10);
> +                       if (errno)
> +                               return error(_("invalid timestamp"));
> +
> +                       if (!skip_prefix(end, " ", &str))
> +                               return error(_("invalid Date line"));
> +
> +                       errno = 0;
> +                       tz = strtol(str, &end, 10);
> +                       if (errno)
> +                               return error(_("invalid timezone offset"));
> +
> +                       if (*end)
> +                               return error(_("invalid Date line"));
> +
> +                       /*
> +                        * mercurial's timezone is in seconds west of UTC,
> +                        * however git's timezone is in hours + minutes east of
> +                        * UTC. Convert it.
> +                        */
> +                       tz = tz / (60 * 60) * 100 + tz % (60 * 60);

What happens if we have a negative input not matching a full hour, say -5400 ?
(would equate to 0130 in git)

for calculating the minutes we would only need to take % 3600 (which
you do), but
then we still need to divide by 60 to convert seconds to minutes?

> +                       tz = -tz;
> +
> +                       fprintf(out, "Date: %s\n", show_date(timestamp, tz, DATE_RFC2822));
> +               } else if (starts_with(sb.buf, "# ")) {
> +                       continue;
> +               } else {
> +                       fprintf(out, "\n%s\n", sb.buf);
> +                       break;
> +               }
> +       }
> +
> +       strbuf_reset(&sb);
> +       while (strbuf_fread(&sb, 8192, in) > 0) {
> +               fwrite(sb.buf, 1, sb.len, out);
> +               strbuf_reset(&sb);
> +       }
> +
> +       strbuf_release(&sb);
> +       return 0;
> +}
> +
> +/**
>   * Splits a list of files/directories into individual email patches. Each path
>   * in `paths` must be a file/directory that is formatted according to
>   * `patch_format`.
> @@ -926,6 +993,8 @@ static int split_mail(struct am_state *state, enum patch_format patch_format,
>                 return split_mail_conv(stgit_patch_to_mail, state, paths, keep_cr);
>         case PATCH_FORMAT_STGIT_SERIES:
>                 return split_mail_stgit_series(state, paths, keep_cr);
> +       case PATCH_FORMAT_HG:
> +               return split_mail_conv(hg_patch_to_mail, state, paths, keep_cr);
>         default:
>                 die("BUG: invalid patch_format");
>         }
> @@ -1960,6 +2029,8 @@ static int parse_opt_patchformat(const struct option *opt, const char *arg, int
>                 *opt_value = PATCH_FORMAT_STGIT;
>         else if (!strcmp(arg, "stgit-series"))
>                 *opt_value = PATCH_FORMAT_STGIT_SERIES;
> +       else if (!strcmp(arg, "hg"))
> +               *opt_value = PATCH_FORMAT_HG;
>         else
>                 return error(_("Invalid value for --patch-format: %s"), arg);
>         return 0;
> --
> 2.5.0.rc0.76.gb2c6e93
>
