From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCHv2] fsck.c:fsck_commit() use skip_prefix() and starts_with()
Date: Thu, 20 Mar 2014 20:24:23 -0400
Message-ID: <CAPig+cQCn+mzauXHpwMUZjtVhai5cJ=8PC5rr5P3bJLXzWeSpQ@mail.gmail.com>
References: <1395236673-8936-1-git-send-email-darrazo16@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Othman Darraz <darrazo16@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 21 01:24:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQnGD-0005jp-Pz
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 01:24:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966182AbaCUAY1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2014 20:24:27 -0400
Received: from mail-yh0-f46.google.com ([209.85.213.46]:59661 "EHLO
	mail-yh0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965616AbaCUAYY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2014 20:24:24 -0400
Received: by mail-yh0-f46.google.com with SMTP id b6so1723826yha.33
        for <git@vger.kernel.org>; Thu, 20 Mar 2014 17:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=oXBdabnt74UX5QhKIB7OIFoXe3HKtVUBrIacx4iBlNk=;
        b=pLn1Tamd1ICXXg9ZEq1YbG4kiP2LEQUS0baIL8HVj14ZWQBbsJ5IXrbI82Snbbe7gc
         MvD/aLeMduh3GvM1GZdTH3E4ccyf8L0qacbfsB8AosluDwvdrf61U9kwO/EfCnoPVN08
         AFyRciPKLsPwf2F8EK1Zb4YVTVcWR7tazJ9prcwZ8yjoIwtsvlhWyXRYzI2bkszA3FVA
         xSgs1JN3UcUPEkWwPoZ8132LO9Wz2Ia1BR+czvE7MdGrFUhvd3mzP+3Ez+rb2RRAcJQF
         lk2RxBrxLDTew6Kzx6kgiJamq3ZSmnmcsOow2Dz5Idm1CrXyAEWKJudBjzSivbBG6mUV
         Gi9Q==
X-Received: by 10.236.45.69 with SMTP id o45mr38533173yhb.64.1395361463490;
 Thu, 20 Mar 2014 17:24:23 -0700 (PDT)
Received: by 10.170.180.134 with HTTP; Thu, 20 Mar 2014 17:24:23 -0700 (PDT)
In-Reply-To: <1395236673-8936-1-git-send-email-darrazo16@gmail.com>
X-Google-Sender-Auth: MgyVh4TY5GpoNyhkajurAdSVCE0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244622>

On Wed, Mar 19, 2014 at 9:44 AM, Othman Darraz <darrazo16@gmail.com> wrote:
> Subject: fsck.c:fsck_commit() use skip_prefix() and starts_with()

Add a space after the colon. Add a colon after fsck_commit().

> make buffer const char* because the content of the memory referenced by this variable doesn't change in this function.

Wrap lines to 65-70 characters. Capitalize start of sentence. You
don't need to spell out 'const char*'. It's okay to say that you're
just making it 'const'.

Conceptually, this is a distinct change, so it deserves its own patch.
Thus, your submission should become a two-patch series. See
documentation for "git format-patch" and "git send-email" to learn how
to create a multi-part patch series.

> Add cast to buffer to match fsck_ident signature which is (char**,...)

But, is _this_ cast really needed? In my earlier review, I asked if
you could drop the cast you had in that attempt by making 'buffer'
const. I also mentioned that you might have to fix some small fallout
from making it const. That was a hint that you should dig a bit
deeper. It is possible to eliminate the casts. See if you can figure
out how.

> use skip_prefix() instead of memcmp() to avoid using magic number.

Capitalize start of sentence. You might want to explain a bit that
skip_prefix() conveys more clearly than memcmp() that the code is
checking the string for a prefix. An added benefit is that it allows
you to eliminate some magic numbers.

> Signed-off-by: Othman Darraz <darrazo16@gmail.com>
> ---
> I am planning to apply for GSOC2014
>  fsck.c | 27 ++++++++++++++-------------
>  1 file changed, 14 insertions(+), 13 deletions(-)
>
> diff --git a/fsck.c b/fsck.c
> index 5eae856..128d426 100644
> --- a/fsck.c
> +++ b/fsck.c
> @@ -284,21 +284,22 @@ static int fsck_ident(char **ident, struct object *obj, fsck_error error_func)
>
>  static int fsck_commit(struct commit *commit, fsck_error error_func)
>  {
> -       char *buffer = commit->buffer;
> +       const char *buffer = commit->buffer;
>         unsigned char tree_sha1[20], sha1[20];
>         struct commit_graft *graft;
>         int parents = 0;
>         int err;
> -
> -       if (starts_with(buffer, "tree "))
> +       buffer = skip_prefix(buffer, "tree ");

Unfortunately, this patch is quite broken since it is based upon your
previous patch rather than upon a clean copy of fsck.c. I'll abort the
review at this point since this and your previous attempt are
intermingled, and the patch does not provide a clear picture of how
the original fsck.c gets changed.

> +       if (!buffer)
>                 return error_func(&commit->object, FSCK_ERROR, "invalid format - expected 'tree' line");
> -       if (get_sha1_hex(buffer+5, tree_sha1) || buffer[45] != '\n')()
> +       if (get_sha1_hex(buffer, tree_sha1) || buffer[40] != '\n')
>                 return error_func(&commit->object, FSCK_ERROR, "invalid 'tree' line format - bad sha1");
> -       buffer += 46;
> -       while (!memcmp(buffer, "parent ", 7)) {
> -               if (get_sha1_hex(buffer+7, sha1) || buffer[47] != '\n')
> +       buffer += 41;
> +       while (starts_with(buffer, "parent ")) {
> +               buffer = skip_prefix(buffer, "parent ");
> +               if (get_sha1_hex(buffer, sha1) || buffer[40] != '\n')
>                         return error_func(&commit->object, FSCK_ERROR, "invalid 'parent' line format - bad sha1");
> -               buffer += 48;
> +               buffer += 41;
>                 parents++;
>         }
>         graft = lookup_commit_graft(commit->object.sha1);
> @@ -322,16 +323,16 @@ static int fsck_commit(struct commit *commit, fsck_error error_func)
>                 if (p || parents)
>                         return error_func(&commit->object, FSCK_ERROR, "parent objects missing");
>         }
> -       if (starts_with(buffer, "author "))
> +       buffer = skip_prefix(buffer, "author ");
> +       if (!buffer)
>                 return error_func(&commit->object, FSCK_ERROR, "invalid format - expected 'author' line");
> -       buffer += 7;
> -       err = fsck_ident(&buffer, &commit->object, error_func);
> +       err = fsck_ident((char **)&buffer, &commit->object, error_func);
>         if (err)
>                 return err;
> -       buffer = (char* )skip_prefix(buffer,"committer ");
> +       buffer = skip_prefix(buffer,"committer ");
>         if (!buffer)
>                 return error_func(&commit->object, FSCK_ERROR, "invalid format - expected 'committer' line");
> -       err = fsck_ident(&buffer, &commit->object, error_func);
> +       err = fsck_ident((char **)&buffer, &commit->object, error_func);
>         if (err)
>                 return err;
>         if (!commit->tree)
> --
> 1.9.0.258.g00eda23.dirty
