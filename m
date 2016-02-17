From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v6 01/11] ref-filter: use string_list_split over strbuf_split
Date: Wed, 17 Feb 2016 17:11:50 -0500
Message-ID: <CAPig+cRTtXPjvCL3a-2Y+sKBPY1fKNO39VYnzFQ7Ed3dJn+w8w@mail.gmail.com>
References: <1455732379-22479-1-git-send-email-Karthik.188@gmail.com>
	<1455732379-22479-2-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 17 23:12:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWAKB-00060f-UQ
	for gcvg-git-2@plane.gmane.org; Wed, 17 Feb 2016 23:11:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965676AbcBQWLy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2016 17:11:54 -0500
Received: from mail-vk0-f45.google.com ([209.85.213.45]:33082 "EHLO
	mail-vk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965423AbcBQWLv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2016 17:11:51 -0500
Received: by mail-vk0-f45.google.com with SMTP id k196so28226300vka.0
        for <git@vger.kernel.org>; Wed, 17 Feb 2016 14:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=Ptu8r4CqVQ38p4Fsfh5yWSYVHtCoDexVyRgeHdEF9DM=;
        b=GyJWydH7fPR0+mnlJ+ixYR6MP3DmhIMmWi6osfXcUCbUEJi1d6Nt4LpfjjLmqnyIu1
         NpJKnVsijAdMZHT4jdOnaQL0MiYMDWYRp0IkwOABPbn35ewml1KMGgFUNeZcy3nMPRG/
         C325IQvchBxvatPX/+MCU5D+Lh+S2W2DJ9gbtBK9U5NA0025Gd4dd/w54qaqKUxQz/nh
         xcnKfEDekCmiFc7zAql171yvNegUNR9Onq4o9rhfQCMtyYdu+EPdotkLobIUD6XRRhHJ
         ctQn3u4E4PlHpaq6JdP/hdSA1lfJeQAs3/5JHZNJLQKydbgaymdXvPl3jSxMyw6S4Djx
         mHMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=Ptu8r4CqVQ38p4Fsfh5yWSYVHtCoDexVyRgeHdEF9DM=;
        b=Ljs+UX7KSbuvNEOvFLchk6SQwwAno1Oc8FGenoKoOLRCBaQZSNL3t+BxZ/k8Giy07U
         BOcgeOvO+DDAoms92L5nkG0jrjiMPWPfcm7O5ein9BY/wyZDnd+4gjQwf5EsSW9CfcIb
         QMcRCK+zv9J3fzIoNhLquTYhW5ElZ8T7cf5YbYAkwKjAamd1I2Wxa1qz1Iufg6JoxL0n
         zsaKdkXBXFr9r4bZAGUKGJBn9KYDaT+X9vOC7EQhd03NaM909Wi1h8/WQdBVyeWK1P4o
         iG3+glmhZyIHKLbqPUK8XYK1e6biqkeaU4R2X4Xa5/nvXB1fyrlU/HtVuksyXmqx9e5H
         GnYQ==
X-Gm-Message-State: AG10YOSFSDw9raiBUGomZ9HoQyxA99GCDNdTisC6Vrj6VySvGXIrGKikw0vEP86YnQhl1cyyyjiH2q3EEV0CvQ==
X-Received: by 10.31.47.135 with SMTP id v129mr3409818vkv.115.1455747110762;
 Wed, 17 Feb 2016 14:11:50 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Wed, 17 Feb 2016 14:11:50 -0800 (PST)
In-Reply-To: <1455732379-22479-2-git-send-email-Karthik.188@gmail.com>
X-Google-Sender-Auth: ZzCP3yQZrj_q86KLYTUnd3IVqGs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286558>

On Wed, Feb 17, 2016 at 1:06 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
> From: Jeff King <peff@peff.net>
>
> We don't do any post-processing on the resulting strbufs, so it is
> simpler to just use string_list_split, which takes care of removing
> the delimiter for us.
>
> Written-by: Jeff King <peff@peff.net>

Perhaps Peff can give his sign-off...

> Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
> ---
>  ref-filter.c | 29 +++++++++++------------------
>  1 file changed, 11 insertions(+), 18 deletions(-)
>
> diff --git a/ref-filter.c b/ref-filter.c
> index f097176..19367ce 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -886,41 +886,34 @@ static void populate_value(struct ref_array_item *ref)
>                         continue;
>                 } else if (match_atom_name(name, "align", &valp)) {
>                         struct align *align = &v->u.align;
> -                       struct strbuf **s, **to_free;
> +                       struct string_list params = STRING_LIST_INIT_DUP;
> +                       int i;
>                         int width = -1;
>
>                         if (!valp)
>                                 die(_("expected format: %%(align:<width>,<position>)"));
>
> -                       /*
> -                        * TODO: Implement a function similar to strbuf_split_str()
> -                        * which would omit the separator from the end of each value.
> -                        */
> -                       s = to_free = strbuf_split_str(valp, ',', 0);
> -
>                         align->position = ALIGN_LEFT;
>
> -                       while (*s) {
> -                               /*  Strip trailing comma */
> -                               if (s[1])
> -                                       strbuf_setlen(s[0], s[0]->len - 1);
> -                               if (!strtoul_ui(s[0]->buf, 10, (unsigned int *)&width))
> +                       string_list_split(&params, valp, ',', -1);
> +                       for (i = 0; i < params.nr; i++) {
> +                               const char *s = params.items[i].string;
> +                               if (!strtoul_ui(s, 10, (unsigned int *)&width))
>                                         ;
> -                               else if (!strcmp(s[0]->buf, "left"))
> +                               else if (!strcmp(s, "left"))
>                                         align->position = ALIGN_LEFT;
> -                               else if (!strcmp(s[0]->buf, "right"))
> +                               else if (!strcmp(s, "right"))
>                                         align->position = ALIGN_RIGHT;
> -                               else if (!strcmp(s[0]->buf, "middle"))
> +                               else if (!strcmp(s, "middle"))
>                                         align->position = ALIGN_MIDDLE;
>                                 else
> -                                       die(_("improper format entered align:%s"), s[0]->buf);
> -                               s++;
> +                                       die(_("improper format entered align:%s"), s);
>                         }
>
>                         if (width < 0)
>                                 die(_("positive width expected with the %%(align) atom"));
>                         align->width = width;
> -                       strbuf_list_free(to_free);
> +                       string_list_clear(&params, 0);
>                         v->handler = align_atom_handler;
>                         continue;
>                 } else if (!strcmp(name, "end")) {
> --
> 2.7.1
