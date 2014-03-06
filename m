From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] commit.c: Replace starts_with() with skip_prefix()
Date: Thu, 6 Mar 2014 04:38:48 -0500
Message-ID: <CAPig+cSp6ckBifayD5a0Z=+xWVfRiVcEyf6rEi_4M-fqWJ9TBw@mail.gmail.com>
References: <1394028372-29990-1-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Tanay Abhra <tanayabh@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 06 10:38:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLUlT-0005hD-UM
	for gcvg-git-2@plane.gmane.org; Thu, 06 Mar 2014 10:38:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750972AbaCFJiv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2014 04:38:51 -0500
Received: from mail-yk0-f172.google.com ([209.85.160.172]:57470 "EHLO
	mail-yk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750805AbaCFJit (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2014 04:38:49 -0500
Received: by mail-yk0-f172.google.com with SMTP id 200so6049624ykr.3
        for <git@vger.kernel.org>; Thu, 06 Mar 2014 01:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=/gvaqpD8E5jpY0H0RnCBvbVaCgH76CMiEXq6xXMKrv0=;
        b=OY2ghpEbv5TEombJi1dvg/fv1KYWgLuc+gvqRbkw+RjSVVQv0PyQr5bfixjscecYn1
         G7ykZ1sJW+4TH0gQBlQKAHKcV2+O0XwVDoD2mNyeZMr7Tps3iN3iC7bE4RlzCbj9eFdg
         h9vJ2npTcx1vedcocW1RsAb1V5Q+q+flyNdBJ8Gwma23mKHuQiuUvfzjXH3ZUdJ76+ss
         aOd6Rz84qTDIOQBsNvdEwjo9pjaR+HZv13FwOH+HP0uFUy61oOJm10dOHdrEtkhL5R/h
         ODq9MCZpxaWORCEUEiSIQzFI4cgwH+pCILHTJOMife14h85Y/ai+G3OAF163k+uYyRhH
         rYDQ==
X-Received: by 10.236.3.10 with SMTP id 10mr12446961yhg.79.1394098728684; Thu,
 06 Mar 2014 01:38:48 -0800 (PST)
Received: by 10.170.180.195 with HTTP; Thu, 6 Mar 2014 01:38:48 -0800 (PST)
In-Reply-To: <1394028372-29990-1-git-send-email-karthik.188@gmail.com>
X-Google-Sender-Auth: TiHSg4N9olCImPIj2bYCocoWhiw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243508>

On Wed, Mar 5, 2014 at 9:06 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
> Replaces all instances of starts_with() by skip_prefix(),

Use imperative mode: "Replace all..."

> which can not only be used to check presence of a prefix,
> but also used further on as it returns the string after the prefix,
> if the prefix is present.

This is a lot better than previous versions. It could be improved a
bit by more directly stating that skip_prefix() singly does what the
current code is doing in two steps. (See Tanay's submission [1] for an
example of a well-crafted commit message). However, we're probably at
the point of diminishing returns, so no need to reroll just for this.

[1]: http://thread.gmane.org/gmane.comp.version-control.git/243395

> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>
> Hey Eric,
> Here are the changes i have made in this Patch v2:
> 1. Edited the variables names to fit their usage
> 2. set my emacs to indent 8 tabs, so proper indentation
> 3. fixed my error where i increased the value by 1 in parse_signed_commit().
> Thanks again for your patience.

Thanks for the reroll and for explaining the changes. More below.

> ---
>  commit.c | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
>
> diff --git a/commit.c b/commit.c
> index 6bf4fe0..f006490 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -553,6 +553,7 @@ static void record_author_date(struct author_date_slab *author_date,
>         struct ident_split ident;
>         char *date_end;
>         unsigned long date;
> +       const char *buf_split;

In a previous review, I suggested reading Junio's response [1] to a
similar submission. Of particular interest, Junio says:

    A good rule of thumb to remember is to name things after what
    they are, not how you obtain them, how they are used or what
    they are used for/as.

The name 'buf_split' is clearly a "how you obtain them", which does
not convey much. Better would be to name the variable to reflect what
it references once assigned.

[1]: http://thread.gmane.org/gmane.comp.version-control.git/243231/focus=243259

>         if (!commit->buffer) {
>                 unsigned long size;
> @@ -562,18 +563,19 @@ static void record_author_date(struct author_date_slab *author_date,
>                         return;
>         }
>
> +       buf_split = skip_prefix(buf, "author ");
> +
>         for (buf = commit->buffer ? commit->buffer : buffer;
>              buf;
>              buf = line_end + 1) {
>                 line_end = strchrnul(buf, '\n');
> -               if (!starts_with(buf, "author ")) {
> +               if (!buf_split) {
>                         if (!line_end[0] || line_end[1] == '\n')
>                                 return; /* end of header */
>                         continue;
>                 }
> -               if (split_ident_line(&ident,
> -                                    buf + strlen("author "),
> -                                    line_end - (buf + strlen("author "))) ||
> +               if (split_ident_line(&ident, buf_split,
> +                                    line_end - buf_split) ||
>                     !ident.date_begin || !ident.date_end)
>                         goto fail_exit; /* malformed "author" line */
>                 break;
> @@ -1098,6 +1100,7 @@ int parse_signed_commit(const unsigned char *sha1,
>         char *buffer = read_sha1_file(sha1, &type, &size);
>         int in_signature, saw_signature = -1;
>         char *line, *tail;
> +       const char *line_split;

Ditto.

>         if (!buffer || type != OBJ_COMMIT)
>                 goto cleanup;
> @@ -1111,11 +1114,11 @@ int parse_signed_commit(const unsigned char *sha1,
>                 char *next = memchr(line, '\n', tail - line);
>
>                 next = next ? next + 1 : tail;
> +               line_split = skip_prefix(line, gpg_sig_header);
>                 if (in_signature && line[0] == ' ')
>                         sig = line + 1;
> -               else if (starts_with(line, gpg_sig_header) &&
> -                        line[gpg_sig_header_len] == ' ')
> -                       sig = line + gpg_sig_header_len + 1;
> +               else if (line_split && line_split[0] == ' ')
> +                       sig = line_split + 1;

A shortcoming of this change is that skip_prefix() is now being called
unconditionally, even when its result won't be used (as in the first
'if' statement). The original code did the work of checking the prefix
only if the first 'if' statement evaluated to false.

>                 if (sig) {
>                         strbuf_add(signature, sig, next - sig);
>                         saw_signature = 1;
> @@ -1193,10 +1196,8 @@ static void parse_gpg_output(struct signature_check *sigc)
>         for (i = 0; i < ARRAY_SIZE(sigcheck_gpg_status); i++) {
>                 const char *found, *next;
>
> -               if (starts_with(buf, sigcheck_gpg_status[i].check + 1)) {
> -                       /* At the very beginning of the buffer */
> -                       found = buf + strlen(sigcheck_gpg_status[i].check + 1);
> -               } else {
> +               found = skip_prefix(buf, sigcheck_gpg_status[i].check + 1);
> +               if(!found) {

Space after 'if'.

>                         found = strstr(buf, sigcheck_gpg_status[i].check);
>                         if (!found)
>                                 continue;
> --
> 1.9.0.138.g2de3478
