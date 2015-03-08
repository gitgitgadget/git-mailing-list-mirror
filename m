From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 1/3] cache: modify for "cat-file --literally -t"
Date: Sun, 8 Mar 2015 18:25:28 -0400
Message-ID: <CAPig+cT-AG2pnHJnkUcnHXzWu9jp2Q7ZBE7Re5jimFU7mOWLhQ@mail.gmail.com>
References: <54F89D90.6090505@gmail.com>
	<1425579499-18780-1-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 08 23:25:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUjdf-0007iQ-Go
	for gcvg-git-2@plane.gmane.org; Sun, 08 Mar 2015 23:25:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752974AbbCHWZb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Mar 2015 18:25:31 -0400
Received: from mail-yk0-f181.google.com ([209.85.160.181]:44670 "EHLO
	mail-yk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752364AbbCHWZa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2015 18:25:30 -0400
Received: by ykbq200 with SMTP id q200so7340045ykb.11
        for <git@vger.kernel.org>; Sun, 08 Mar 2015 15:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=XmqYkoD5u1u8LHq38lTITdcOhCX9fck61tsOd6Ru5oE=;
        b=1HOEG0+YQLmSBOewV4buUh/abzib3vPp9k2izMobzfzECGYrghROMUOkASyTXvHOwM
         j20kZXkFugcgGKJr2QiID1manjc53jPQvMuCgG/UsONZmi6ZgpicP4c9u6E7Pr8iTa6C
         q38WRa2mDlaoAZTbdh+xLRr3lETy/mwkuc1k5KaubtyqUKOS5qD6eJ9UDp+PJUteT+OP
         XkRDRS/GRIPEX2OJH4eai7jXU6iiLR/zwLdlRsbu5sv4+UXUKbwZVrAd28vcz0bR+3nu
         BwPm/BH0hKjbZYDeX20ZLzF7TD7EFI7CqRHw/G7TYVORtKdouWjQzntZ/A7cydCPgEhE
         qgAA==
X-Received: by 10.170.136.19 with SMTP id d19mr28008230ykc.2.1425853528866;
 Sun, 08 Mar 2015 15:25:28 -0700 (PDT)
Received: by 10.170.73.7 with HTTP; Sun, 8 Mar 2015 15:25:28 -0700 (PDT)
In-Reply-To: <1425579499-18780-1-git-send-email-karthik.188@gmail.com>
X-Google-Sender-Auth: Dl-z9pVY1UlK-GOqurRGd_fy7Ik
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265115>

On Thu, Mar 5, 2015 at 1:18 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
> cache: modify for "cat-file --literally -t"

It is desirable for the first line of the commit message to explain,
as well as possible, the intent of the patch. The bulk of the commit
message then elaborates. Unfortunately, this line says almost nothing.
All patches modify, so writing "modify" here is not helpful and merely
wastes precious horizontal real estate. A more informative summary
might say something like:

    cache: add object_info::typename in support of 'cat-file --literally'

> Add a "struct strbuf *typename" to object_info to hold the
> typename when the literally option is used. Add a flag to
> notify functions when literally is used.

It's good to split up changes such that each patch comprises one
logical step, however, this patch does not really do anything on its
own, so having it stand-alone doesn't make much sense. It would make
more sense to fold it into the patch which actually requires these
changes.

> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
> diff --git a/cache.h b/cache.h
> index 4d02efc..949ef4c 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -830,6 +830,7 @@ extern int is_ntfs_dotgit(const char *name);
>
>  /* object replacement */
>  #define LOOKUP_REPLACE_OBJECT 1
> +#define LOOKUP_LITERALLY 2
>  extern void *read_sha1_file_extended(const unsigned char *sha1, enum object_type *type, unsigned long *size, unsigned flag);
>  static inline void *read_sha1_file(const unsigned char *sha1, enum object_type *type, unsigned long *size)
>  {
> @@ -1296,6 +1297,7 @@ struct object_info {
>         unsigned long *sizep;
>         unsigned long *disk_sizep;
>         unsigned char *delta_base_sha1;
> +       struct strbuf *typename;
>
>         /* Response */
>         enum {
> --
> 2.3.1.167.g7f4ba4b.dirty
