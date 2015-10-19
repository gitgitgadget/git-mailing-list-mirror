From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 10/34] mailinfo: move global "line" into mailinfo() function
Date: Mon, 19 Oct 2015 18:57:03 -0400
Message-ID: <CAPig+cQ5bcaTEsGMP7_LZKD4ze8vQAaqcw7kbhU7rZQXGdDRUQ@mail.gmail.com>
References: <1444855557-2127-1-git-send-email-gitster@pobox.com>
	<1445239731-10677-1-git-send-email-gitster@pobox.com>
	<1445239731-10677-11-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 20 00:57:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZoJMe-0006tA-Nj
	for gcvg-git-2@plane.gmane.org; Tue, 20 Oct 2015 00:57:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751526AbbJSW5G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2015 18:57:06 -0400
Received: from mail-vk0-f41.google.com ([209.85.213.41]:34112 "EHLO
	mail-vk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751392AbbJSW5E (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2015 18:57:04 -0400
Received: by vkat63 with SMTP id t63so57100vka.1
        for <git@vger.kernel.org>; Mon, 19 Oct 2015 15:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=W0P4BcIEiI182kGYeNGZq49Yu0HoafQI4bH7n99M6tA=;
        b=YoOA08VYaSmePFanNPJjpruCjNb4c5C6Z/q/E6XwGNxs+ciWo/Cr6EX0QORRggqdIl
         3uk2qluk9Qqx+UOSNRLM8gcblKjppzCIiWpVJki6EBXcPaDvMKmNjSHo8HOkPkMNcJt5
         oqtsGIhBoXnR7CGaKWUm4RGiytxn7MoKJ3N12AONJJJAGwSF2nhRXo8dkDibIjX+OmmU
         a1y1ud1d+fTR4QcbPXSn63YwgqwIW8V1mvjuNuGxEd/9VeHfjqBsfAGVz/RsrHgfBYpt
         DJY2siG6KQeAnJ3uwvnzlEQot5eGxS5q3hDTaYliTK39QxRo5t2lsLRSCNkFHm6ApPE2
         xj+A==
X-Received: by 10.31.8.131 with SMTP id 125mr20784114vki.45.1445295423459;
 Mon, 19 Oct 2015 15:57:03 -0700 (PDT)
Received: by 10.31.159.204 with HTTP; Mon, 19 Oct 2015 15:57:03 -0700 (PDT)
In-Reply-To: <1445239731-10677-11-git-send-email-gitster@pobox.com>
X-Google-Sender-Auth: WNFjsa3nvcKETm8ySsmwZxrduoY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279894>

On Mon, Oct 19, 2015 at 3:28 AM, Junio C Hamano <gitster@pobox.com> wrote:
> With the previous steps, it becomes clear that the mailinfo()
> function is the only one that wants the "line" to be directly
> touchable.  Move it to the function scope of this function.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
> index 12d1eda..c8dc73f 100644
> --- a/builtin/mailinfo.c
> +++ b/builtin/mailinfo.c
> @@ -12,7 +12,6 @@ static FILE *cmitmsg, *patchfile, *fin, *fout;
>  static int keep_subject;
>  static int keep_non_patch_brackets_in_subject;
>  static const char *metainfo_charset;
> -static struct strbuf line = STRBUF_INIT;
>  static struct strbuf name = STRBUF_INIT;
>  static struct strbuf email = STRBUF_INIT;
>  static char *message_id;
> @@ -966,6 +965,8 @@ static void handle_info(void)
>  static int mailinfo(FILE *in, FILE *out, const char *msg, const char *patch)
>  {
>         int peek;
> +       struct strbuf line = STRBUF_INIT;

Does there need to be a corresponding strbuf_release(&line) at the end
of the function?

>         fin = in;
>         fout = out;
>
> --
> 2.6.2-383-g144b2e6
