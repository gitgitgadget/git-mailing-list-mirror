From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] commit.c: Replace starts_with() with skip_prefix()
Date: Mon, 3 Mar 2014 18:54:13 -0500
Message-ID: <CAPig+cQuzWv1+yg6F4zBqYfGdH6iz5xteCFHW6_o8Wyx68JT7w@mail.gmail.com>
References: <1393832875-29096-1-git-send-email-karthik.188@gmail.com>
	<CAPig+cQLoZy=MV_AqPQseMxsrU6T_PqmCifWn1SrOGwF2FcYzg@mail.gmail.com>
	<CAOLa=ZRxj-iBiQRXEYvq6MrQyQcyzk32kPij8zzxh4ECbBrnMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: karthik nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 04 00:54:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKcgd-0008NN-NS
	for gcvg-git-2@plane.gmane.org; Tue, 04 Mar 2014 00:54:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755435AbaCCXyP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 18:54:15 -0500
Received: from mail-yh0-f46.google.com ([209.85.213.46]:64691 "EHLO
	mail-yh0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755301AbaCCXyO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2014 18:54:14 -0500
Received: by mail-yh0-f46.google.com with SMTP id v1so4303722yhn.19
        for <git@vger.kernel.org>; Mon, 03 Mar 2014 15:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=Ye9S7llAYMoWWl9mQvsvjEjyyYFamiIGbnSO0NlkIy0=;
        b=TbgSVm9IlYF3ColVDNcdLg0Ap5z/3jixaV5vlS3bN0B+z6oldGjPsPWhNjcGrA9v7r
         VvEdYpKdgrP3XdiXMLmG2AEquV9T0pDup/9F18ZJ1zwOcEJwfrnNJb5bV+IV5k3yoghh
         1FqcQRL7XLPfcEPr4STX9lqvwPKSqf0bmOMDmJQ4IhmxdB+qzDzPgsFT/tyPbT+j2QX8
         7sNHigZ5JEgDHG1Yc/n6ws698ltMNJYeDEF6XGCfSM0CVah7NvfWZrnTuhoVQuypz5t3
         5s3slXzgJmcB6svYbzwK0DVCTvypoZtDO8qkeLx2sgFxCkw5IKqguXhHroT0g8eTAyx/
         WcoQ==
X-Received: by 10.236.120.102 with SMTP id o66mr4230272yhh.99.1393890853562;
 Mon, 03 Mar 2014 15:54:13 -0800 (PST)
Received: by 10.170.180.195 with HTTP; Mon, 3 Mar 2014 15:54:13 -0800 (PST)
In-Reply-To: <CAOLa=ZRxj-iBiQRXEYvq6MrQyQcyzk32kPij8zzxh4ECbBrnMw@mail.gmail.com>
X-Google-Sender-Auth: 1a90yaXC2iooYLGcTlUbbRUmr3k
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243316>

On Mon, Mar 3, 2014 at 10:23 AM, karthik nayak <karthik.188@gmail.com> wrote:
> Hello Eric,
> Thanks for Pointing out everything, i had a thorough look and fixed a
> couple of things.
> Here is an Updated Patch.
> - Removed unnecessary code and variables.
> - Replaced all instances of starts_with() with skip_prefix()

This commentary is important for the on-going email discussion but
does not belong in the commit message for the permanent project
history, so place it below the "---" line just under your sign-off.

Explaining what changed since the last attempt, as you do here, is a
good thing. To further ease the review process, supply a link to the
previous attempt, like this [1].

[1]: http://thread.gmane.org/gmane.comp.version-control.git/243194

> Replace starts_with() with skip_prefix() for better reading purposes.
> Also to replace "buf + strlen(author )" by skip_prefix(), which is
> saved in a new "const char" variable "buf_skipprefix".

The second sentence is really the meat of this change, and not at all
incidental as "Also" implies. You should use it (or a refinement of
it) as your commit message. The first sentence doesn't particularly
add much and can easily be dropped.

> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  commit.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/commit.c b/commit.c
> index 6bf4fe0..e5dc2e2 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -552,6 +552,7 @@ static void record_author_date(struct
> author_date_slab *author_date,
>   char *buffer = NULL;
>   struct ident_split ident;
>   char *date_end;
> + const char *buf_skipprefix;

Read this response by Junio [2] to another GSoC candidate which
explains why this is a poor variable name and how to craft a better
one.

[2]: http://thread.gmane.org/gmane.comp.version-control.git/243231/focus=243259

>   unsigned long date;
>
>   if (!commit->buffer) {
> @@ -562,18 +563,20 @@ static void record_author_date(struct
> author_date_slab *author_date,
>   return;
>   }
>
> + buf_skipprefix = skip_prefix(buf, "author ");

Unfortunately, your patch is badly whitespace-damaged as if it was
pasted into the mailer and mangled. (Your first submission did not
have this problem.) If you can, use "git send-email" to avoid such
corruption.

> +
>   for (buf = commit->buffer ? commit->buffer : buffer;
>       buf;
>       buf = line_end + 1) {
>   line_end = strchrnul(buf, '\n');
> - if (!starts_with(buf, "author ")) {
> + if (!buf_skipprefix) {
>   if (!line_end[0] || line_end[1] == '\n')
>   return; /* end of header */
>   continue;
>   }
>   if (split_ident_line(&ident,
> -     buf + strlen("author "),
> -     line_end - (buf + strlen("author "))) ||
> + buf_skipprefix,
> + line_end - buf_skipprefix) ||

Looks reasonable (sans whitespace damage).

>      !ident.date_begin || !ident.date_end)
>   goto fail_exit; /* malformed "author" line */
>   break;
> @@ -1113,7 +1116,7 @@ int parse_signed_commit(const unsigned char *sha1,
>   next = next ? next + 1 : tail;
>   if (in_signature && line[0] == ' ')
>   sig = line + 1;
> - else if (starts_with(line, gpg_sig_header) &&
> + else if (skip_prefix(line, gpg_sig_header) &&
>   line[gpg_sig_header_len] == ' ')
>   sig = line + gpg_sig_header_len + 1;
>   if (sig) {
> @@ -1193,7 +1196,7 @@ static void parse_gpg_output(struct signature_check *sigc)
>   for (i = 0; i < ARRAY_SIZE(sigcheck_gpg_status); i++) {
>   const char *found, *next;
>
> - if (starts_with(buf, sigcheck_gpg_status[i].check + 1)) {
> + if (skip_prefix(buf, sigcheck_gpg_status[i].check + 1)) {
>   /* At the very beginning of the buffer */
>   found = buf + strlen(sigcheck_gpg_status[i].check + 1);
>   } else {

For these two sets of changes, unless you are actually taking
advantage of the return value of skip_prefix(), the mere mechanical
replacement of starts_with() with skip_prefix() actually hurts
readability. Examine each of these cases more carefully to determine
whether skip_prefix() is in fact useful. If so, take advantage of it.
If not, explain in the patch commentary why skip_prefix() doesn't
help.

> --
> 1.9.0.138.g2de3478
