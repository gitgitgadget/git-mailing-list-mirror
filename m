From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 06/26] mailinfo: always pass "line" as an argument
Date: Wed, 14 Oct 2015 13:22:06 -0700
Message-ID: <CAGZ79kaTPGCzKooBjhk2+=njagFfFir6d5C40zpscuoweQgyiA@mail.gmail.com>
References: <1444778207-859-1-git-send-email-gitster@pobox.com>
	<1444778207-859-7-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 14 22:22:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmSYw-00038N-Iq
	for gcvg-git-2@plane.gmane.org; Wed, 14 Oct 2015 22:22:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753826AbbJNUWJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2015 16:22:09 -0400
Received: from mail-yk0-f171.google.com ([209.85.160.171]:35200 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753579AbbJNUWI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2015 16:22:08 -0400
Received: by ykaz22 with SMTP id z22so33088635yka.2
        for <git@vger.kernel.org>; Wed, 14 Oct 2015 13:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=4DC5ZnJakuvM7KpFlfWDOl0uplyK5bSQsGDsgYbIVRI=;
        b=pj/INm11psfMTtPQkI2o+qsvVreOLtpYl16p3ayJXPp93XN9/Fqku4gFZ+Soe6aBge
         3aO4BJPrt5GyPfttNrUG3HFLTynks0cUjYMGM0dexMQknFMNfylqeK4yqHvtvz/mUdPU
         +TlAV3g1QtilSm4VaFmaWXBqiYYqKoKTCqT3HHID3DmYMb4mj/w4vdRZlwGGfIR56Dhy
         Ucic5mbauoK7GQrAK6u0L8ipr6PI0jXV3SEKp5OwY6LCIOHeXFvqv4QqNXhLnyTRh8N6
         yopoRD7Ah9DOjzoe+GWA6xbVV2Ud2varYmtdaOyl0nUfZzqyY4c2m9FDlJhzbhKhSC+x
         Jqgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=4DC5ZnJakuvM7KpFlfWDOl0uplyK5bSQsGDsgYbIVRI=;
        b=f9w7JsWy8+d2cu4yNmI4vpS3QSmneI//vp/eXejL+t156SQuS/ioy0y/KOnEJCiiTC
         VeIJ4dT94swAkwDZjFIpMQIPWydo0fO6JS2sYAQZteye/iPan6CRTf5TX6C8uS2xBpiC
         jUy/rJUfltTGT/fz6LMNxjY56dgn9EOT5LgR+P2LCFvplVq5cRO6iKGT5eIjT4rV9koF
         z5tXaWcFmi0aBjiDR2Uj0nJMkXsfmqoH0HWhsgpMjkMGmsIRwZRmvRheXDne0A+Wmn4s
         ioeFQrC3ELFGiOS2+dDZgnXIJBRPTzhhz0WhkqbgJBqGZhYgYViqhOqzVyu+IeVwFiIP
         w1BQ==
X-Gm-Message-State: ALoCoQm5DID1yFyj+YuNwyHUYvJlt4iOZbx4CCoChnwxC1uv0l2vZi3vs+MHdtF9qd/fjt034YD1
X-Received: by 10.129.75.2 with SMTP id y2mr4229469ywa.48.1444854126234; Wed,
 14 Oct 2015 13:22:06 -0700 (PDT)
Received: by 10.37.29.213 with HTTP; Wed, 14 Oct 2015 13:22:06 -0700 (PDT)
In-Reply-To: <1444778207-859-7-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279590>

On Tue, Oct 13, 2015 at 4:16 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Some functions in this module accessed the global "struct strbuf
> line" while many others used a strbuf passed as an argument.
> Convert the former to ensure that nobody deeper in the callchains
> relies on the global one.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  builtin/mailinfo.c | 48 ++++++++++++++++++++++++------------------------
>  1 file changed, 24 insertions(+), 24 deletions(-)
>
> diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
> index 5a74811..c3c7d67 100644
> --- a/builtin/mailinfo.c
> +++ b/builtin/mailinfo.c
> @@ -12,7 +12,7 @@ static FILE *cmitmsg, *patchfile, *fin, *fout;
>  static int keep_subject;
>  static int keep_non_patch_brackets_in_subject;
>  static const char *metainfo_charset;
> -static struct strbuf line = STRBUF_INIT;
> +static struct strbuf line_global = STRBUF_INIT;
>  static struct strbuf name = STRBUF_INIT;
>  static struct strbuf email = STRBUF_INIT;
>  static char *message_id;
> @@ -817,23 +817,23 @@ static void handle_filter(struct strbuf *line, int *filter_stage, int *header_st
>         }
>  }
>
> -static int find_boundary(void)
> +static int find_boundary(struct strbuf *line)
>  {
> -       while (!strbuf_getline(&line, fin, '\n')) {
> -               if (*content_top && is_multipart_boundary(&line))
> +       while (!strbuf_getline(line, fin, '\n')) {
> +               if (*content_top && is_multipart_boundary(line))
>                         return 1;
>         }
>         return 0;
>  }
>
> -static int handle_boundary(int *filter_stage, int *header_stage)
> +static int handle_boundary(struct strbuf *line, int *filter_stage, int *header_stage)
>  {
>         struct strbuf newline = STRBUF_INIT;
>
>         strbuf_addch(&newline, '\n');
>  again:
> -       if (line.len >= (*content_top)->len + 2 &&
> -           !memcmp(line.buf + (*content_top)->len, "--", 2)) {
> +       if (line->len >= (*content_top)->len + 2 &&
> +           !memcmp(line->buf + (*content_top)->len, "--", 2)) {
>                 /* we hit an end boundary */
>                 /* pop the current boundary off the stack */
>                 strbuf_release(*content_top);
> @@ -852,7 +852,7 @@ again:
>                 strbuf_release(&newline);
>
>                 /* skip to the next boundary */
> -               if (!find_boundary())
> +               if (!find_boundary(line))
>                         return 0;
>                 goto again;
>         }
> @@ -862,18 +862,18 @@ again:
>         strbuf_reset(&charset);
>
>         /* slurp in this section's info */
> -       while (read_one_header_line(&line, fin))
> -               check_header(&line, p_hdr_data, 0);
> +       while (read_one_header_line(line, fin))
> +               check_header(line, p_hdr_data, 0);
>
>         strbuf_release(&newline);
>         /* replenish line */
> -       if (strbuf_getline(&line, fin, '\n'))
> +       if (strbuf_getline(line, fin, '\n'))
>                 return 0;
> -       strbuf_addch(&line, '\n');
> +       strbuf_addch(line, '\n');
>         return 1;
>  }
>
> -static void handle_body(void)
> +static void handle_body(struct strbuf *line)
>  {
>         struct strbuf prev = STRBUF_INIT;
>         int filter_stage = 0;
> @@ -881,24 +881,24 @@ static void handle_body(void)
>
>         /* Skip up to the first boundary */
>         if (*content_top) {
> -               if (!find_boundary())
> +               if (!find_boundary(line))
>                         goto handle_body_out;
>         }
>
>         do {
>                 /* process any boundary lines */
> -               if (*content_top && is_multipart_boundary(&line)) {
> +               if (*content_top && is_multipart_boundary(line)) {
>                         /* flush any leftover */
>                         if (prev.len) {
>                                 handle_filter(&prev, &filter_stage, &header_stage);
>                                 strbuf_reset(&prev);
>                         }
> -                       if (!handle_boundary(&filter_stage, &header_stage))
> +                       if (!handle_boundary(line, &filter_stage, &header_stage))
>                                 goto handle_body_out;
>                 }
>
>                 /* Unwrap transfer encoding */
> -               decode_transfer_encoding(&line);
> +               decode_transfer_encoding(line);
>
>                 switch (transfer_encoding) {
>                 case TE_BASE64:
> @@ -907,7 +907,7 @@ static void handle_body(void)
>                         struct strbuf **lines, **it, *sb;
>
>                         /* Prepend any previous partial lines */
> -                       strbuf_insert(&line, 0, prev.buf, prev.len);
> +                       strbuf_insert(line, 0, prev.buf, prev.len);
>                         strbuf_reset(&prev);
>
>                         /*
> @@ -915,7 +915,7 @@ static void handle_body(void)
>                          * multiple new lines.  Pass only one chunk
>                          * at a time to handle_filter()
>                          */
> -                       lines = strbuf_split(&line, '\n');
> +                       lines = strbuf_split(line, '\n');
>                         for (it = lines; (sb = *it); it++) {
>                                 if (*(it + 1) == NULL) /* The last line */
>                                         if (sb->buf[sb->len - 1] != '\n') {
> @@ -933,10 +933,10 @@ static void handle_body(void)
>                         break;
>                 }
>                 default:
> -                       handle_filter(&line, &filter_stage, &header_stage);
> +                       handle_filter(line, &filter_stage, &header_stage);
>                 }
>
> -       } while (!strbuf_getwholeline(&line, fin, '\n'));
> +       } while (!strbuf_getwholeline(line, fin, '\n'));
>
>  handle_body_out:
>         strbuf_release(&prev);
> @@ -1019,10 +1019,10 @@ static int mailinfo(FILE *in, FILE *out, const char *msg, const char *patch)
>         ungetc(peek, in);
>
>         /* process the email header */
> -       while (read_one_header_line(&line, fin))
> -               check_header(&line, p_hdr_data, 1);
> +       while (read_one_header_line(&line_global, fin))
> +               check_header(&line_global, p_hdr_data, 1);

This is the only function to use line_global if I see correctly.
The function is called only once, so no need to preserve state
outside the function. Would it make sense to remove line_global
completely and have a local variable in this function instead?

>
> -       handle_body();
> +       handle_body(&line_global);
>         handle_info();
>
>         return 0;
> --
> 2.6.1-320-g86a1181
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
