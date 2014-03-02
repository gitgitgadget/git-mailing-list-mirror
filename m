From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] Replace memcpy with hashcpy when lengths defined
Date: Sun, 2 Mar 2014 17:39:07 -0500
Message-ID: <CAPig+cRVNP0Jdid33j8avMDkkf3XqVHxNLB6Fp3dgzOWw7i2Aw@mail.gmail.com>
References: <1393787977-13164-1-git-send-email-albcoron@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Alberto <albcoron@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 02 23:39:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKF2i-0004cb-OV
	for gcvg-git-2@plane.gmane.org; Sun, 02 Mar 2014 23:39:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752952AbaCBWjJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2014 17:39:09 -0500
Received: from mail-yk0-f176.google.com ([209.85.160.176]:49100 "EHLO
	mail-yk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752348AbaCBWjI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2014 17:39:08 -0500
Received: by mail-yk0-f176.google.com with SMTP id 19so8590908ykq.7
        for <git@vger.kernel.org>; Sun, 02 Mar 2014 14:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=pWbshNTiCYLQfPRthbpfzzSjH/8bsJZCpLlnjWrIC54=;
        b=XFk1Zv9We/SAji9WH4oAnglzGYgEH6m6tiVMfLIL01tZDg1Pqo+Uml+t7tr3x/AZP/
         8HzQJ8oaN/WxQk+riTu77JKJkHAe9Mcz+5CQ6o4Neisx75HvGJ9r0KM9pHOCYgZbDL0L
         wVAIuFVgfDM+dm5mVfA0IyGtuVIRWMTWjrNqLQB9/RGDPfDl2Bqu3ys3ILSNxpcu2bZ3
         rFOOXRKdeA/EG//YsMa+ECAEDJwVWmAsEipRDHatLq9v3WCJmcphX27IRaaPJbGVtl9g
         Q+SuOpLrxm65Cne8oUefJc5zq5AzkaaFQzRYfJHzy/GYh3hDdspRsKlPa+8VhukmQk77
         SQdQ==
X-Received: by 10.236.147.129 with SMTP id t1mr314136yhj.91.1393799947267;
 Sun, 02 Mar 2014 14:39:07 -0800 (PST)
Received: by 10.170.180.195 with HTTP; Sun, 2 Mar 2014 14:39:07 -0800 (PST)
In-Reply-To: <1393787977-13164-1-git-send-email-albcoron@gmail.com>
X-Google-Sender-Auth: uoBIXEHd1blj_N0nMY4rgtBrTwE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243163>

On Sun, Mar 2, 2014 at 2:19 PM, Alberto <albcoron@gmail.com> wrote:
> From: Alberto Corona <albcoron@gmail.com>
>
> Replaced memcpy with hashcpy where lengts in memcpy
> are already defined.

This doesn't really explain what this patch is attempting to do. What
does "lengths already defined" mean? It's also misleading if taken
literally (as seen below).

Instead, you should say something about the purpose of the change. For
instance, explain that the change takes advantage of the abstraction
provided by hashcpy() rather than hardcoding knowledge about a
particular hash representation.

More below.

> Signed-off-by: Alberto Corona <albcoron@gmail.com>
> ---
>  bundle.c    | 2 +-
>  grep.c      | 2 +-
>  refs.c      | 2 +-
>  sha1_name.c | 4 ++--
>  4 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/bundle.c b/bundle.c
> index e99065c..7809fbb 100644
> --- a/bundle.c
> +++ b/bundle.c
> @@ -19,7 +19,7 @@ static void add_to_ref_list(const unsigned char *sha1, const char *name,
>                 list->list = xrealloc(list->list,
>                                 list->alloc * sizeof(list->list[0]));
>         }
> -       memcpy(list->list[list->nr].sha1, sha1, 20);
> +       hashcpy(list->list[list->nr].sha1, sha1);
>         list->list[list->nr].name = xstrdup(name);
>         list->nr++;
>  }
> diff --git a/grep.c b/grep.c
> index c668034..f5101f7 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -1650,7 +1650,7 @@ void grep_source_init(struct grep_source *gs, enum grep_source_type type,
>                 break;
>         case GREP_SOURCE_SHA1:
>                 gs->identifier = xmalloc(20);
> -               memcpy(gs->identifier, identifier, 20);
> +               hashcpy(gs->identifier, identifier);
>                 break;
>         case GREP_SOURCE_BUF:
>                 gs->identifier = NULL;
> diff --git a/refs.c b/refs.c
> index 89228e2..f90b7ea 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1222,7 +1222,7 @@ static int resolve_gitlink_packed_ref(struct ref_cache *refs,
>         if (ref == NULL)
>                 return -1;
>
> -       memcpy(sha1, ref->u.value.sha1, 20);
> +       hashcpy(sha1, ref->u.value.sha1);
>         return 0;
>  }
>
> diff --git a/sha1_name.c b/sha1_name.c
> index 6fca869..3f5010f 100644
> --- a/sha1_name.c
> +++ b/sha1_name.c
> @@ -111,7 +111,7 @@ static void find_short_object_filename(int len, const char *hex_pfx, struct disa
>                                 continue;
>                         if (memcmp(de->d_name, hex_pfx + 2, len - 2))
>                                 continue;
> -                       memcpy(hex + 2, de->d_name, 38);
> +                       hashcpy(hex + 2, de->d_name);

This can't be correct. hashcpy() copies the binary representation of a
hash (which is currently 20 bytes, as seen in the implementation of
hashcpy() in cache.h). The fact that this particular memcpy() is
copying 38 bytes should be a clue that something is different here. In
fact, for this case, 'hex' is a 40-character textual representation of
the hash, thus not suitable for hashcpy().

>                         if (!get_sha1_hex(hex, sha1))
>                                 update_candidates(ds, sha1);
>                 }
> @@ -373,7 +373,7 @@ const char *find_unique_abbrev(const unsigned char *sha1, int len)
>         static char hex[41];
>
>         exists = has_sha1_file(sha1);
> -       memcpy(hex, sha1_to_hex(sha1), 40);
> +       hashcpy(hex, sha1_to_hex(sha1));

Same as above.

>         if (len == 40 || !len)
>                 return hex;
>         while (len < 40) {
> --
> 1.9.0.138.g2de3478.dirty
