From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v10 04/13] utf8: add function to align a string into given strbuf
Date: Thu, 13 Aug 2015 15:08:54 -0400
Message-ID: <CAPig+cS+rS=xKX-LrJSTqFgaopuLzbh3hqURFWXfzMXH=XUk2w@mail.gmail.com>
References: <1439129506-9989-1-git-send-email-Karthik.188@gmail.com>
	<1439129506-9989-5-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 13 21:09:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPxs4-0001oI-0k
	for gcvg-git-2@plane.gmane.org; Thu, 13 Aug 2015 21:09:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753651AbbHMTI4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2015 15:08:56 -0400
Received: from mail-yk0-f178.google.com ([209.85.160.178]:36328 "EHLO
	mail-yk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753094AbbHMTIz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2015 15:08:55 -0400
Received: by ykay144 with SMTP id y144so49695163yka.3
        for <git@vger.kernel.org>; Thu, 13 Aug 2015 12:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=Wmr3axRmjh2PN2qk2yve/WVWO+B+mB3LgInLvxWPo5s=;
        b=LyKxMpTIfonh9PEsC9EHmS7FZQK/aDDg7+OqCuVuUNmTH9KDuna4hMPjcvs2DV9Nm6
         bvskZVWxcKv7oVCjcvL/MYegz1wN+sErHd40GUnJCoqVc13RTMV1JOgQiBneeJu31gDt
         AwQc8r+g3yuvIYZQlPARjD6HcDFSjNpcPpr55lCjZAkXHdGLAfcKuxvVnBCq5dhfweFb
         BLsYG4y8ys4gsVyPlqaLruw/TrA+BFGorxa2gF+KNX1bEjkzX5VRo+pmtdLmD5Ux8CP/
         oXL2ULcFju8cZraK69BZuzsE9XYnlo4sgVnXFKs0zOaXsNX1LykirbVVlEDVFfUPHy7t
         Vqpw==
X-Received: by 10.129.70.69 with SMTP id t66mr41159075ywa.4.1439492934820;
 Thu, 13 Aug 2015 12:08:54 -0700 (PDT)
Received: by 10.37.208.78 with HTTP; Thu, 13 Aug 2015 12:08:54 -0700 (PDT)
In-Reply-To: <1439129506-9989-5-git-send-email-Karthik.188@gmail.com>
X-Google-Sender-Auth: IzUgwbHn2N1uxYOran_vt7xsdKE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275886>

On Sun, Aug 9, 2015 at 10:11 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
> Add strbuf_utf8_align() which will align a given string into a strbuf
> as per given align_type and width. If the width is greater than the
> string length then no alignment is performed.

In addition to Junio's valuable comments...

> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
> diff --git a/utf8.h b/utf8.h
> index 5a9e94b..db8ca63 100644
> --- a/utf8.h
> +++ b/utf8.h
> @@ -55,4 +55,17 @@ int mbs_chrlen(const char **text, size_t *remainder_p, const char *encoding);
>   */
>  int is_hfs_dotgit(const char *path);
>
> +typedef enum {
> +       ALIGN_LEFT,
> +       ALIGN_MIDDLE,
> +       ALIGN_RIGHT
> +} align_type;
> +
> +/*
> + * Align the string given and store it into a strbuf as per the type
> + * and width.
> + */

Please extend this documentation to state explicitly that this
function preserves (does not truncate) the input string if it is wider
than 'width'. That's quite important information for the caller to
know.

(Aside: I could easily see this function being extended to support
optional truncation, but that's a separate topic, and something that
can be done by someone else when the feature is actually needed; it's
not your responsibility.)

> +void strbuf_utf8_align(struct strbuf *buf, align_type position, unsigned int width,
> +                      const char *s);
> +
>  #endif
