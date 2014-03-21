From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] Rewritten fsck.c:fsck_commit() through using
 starts_with() instead of memcmp()
Date: Fri, 21 Mar 2014 00:18:03 -0400
Message-ID: <CAPig+cQtSxFNPGx5N5JhTtKiwi6DZAx5MUXJfxw6CNe7r0Z5cA@mail.gmail.com>
References: <1395294508-18301-1-git-send-email-cengoguzhanunlu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: blacksimit <cengoguzhanunlu@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 21 05:18:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQquK-0005by-8K
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 05:18:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751659AbaCUESG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2014 00:18:06 -0400
Received: from mail-yh0-f47.google.com ([209.85.213.47]:54834 "EHLO
	mail-yh0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750987AbaCUESF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2014 00:18:05 -0400
Received: by mail-yh0-f47.google.com with SMTP id 29so1882943yhl.20
        for <git@vger.kernel.org>; Thu, 20 Mar 2014 21:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=ZV85Aq1vjpgRIVgNTORl5uVaKzPC/oqownizBuhNatA=;
        b=PmRLINgw+TZ7DGZGbhb6PH+phPTBoe37rgCbrtE7ORUwpV29pG2wrh3IXWYzTuKmYl
         hGupw9cbc/h8HJ1hqlEodXv751YPDZeWncw2IVM8DR38CTLRYEMI22/48R/BF6esYFTs
         8uYEH2cte3tMVMLgtzItiaSWmXLKb38rmSgaqWxDiOlJPzF4UyHkxSAVjw7xnLMS6DJK
         o53f1q750Wcg9DKD8Ir076UK3cRkwvkHMhBaUGgBAOoDLqwk+fN6L9C9xMu0MDcHO5gk
         wiQhbS8x2nHOFgOJ0pwMn0UWTFrkXe3Uror3MAvYP0CSbvGp5XJq57Z3CV6VMDQap5Mo
         GiFA==
X-Received: by 10.236.150.205 with SMTP id z53mr39332258yhj.75.1395375484042;
 Thu, 20 Mar 2014 21:18:04 -0700 (PDT)
Received: by 10.170.180.134 with HTTP; Thu, 20 Mar 2014 21:18:03 -0700 (PDT)
In-Reply-To: <1395294508-18301-1-git-send-email-cengoguzhanunlu@gmail.com>
X-Google-Sender-Auth: RfVsJcxpiPuKBdJAw9GskHSY5Wk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244637>

Thanks for the submission. Comments below to give you a feel for the
Git review process...

On Thu, Mar 20, 2014 at 1:48 AM, blacksimit <cengoguzhanunlu@gmail.com> wrote:
> Subject: Rewritten fsck.c:fsck_commit() through using starts_with() instead of memcmp()

Use imperative mood ("rewrite" instead of "rewritten"). Keep it short
but informative. Possibly like this:

    Subject: fsck_commit: replace memcmp() with starts_with()

> Hi, I've done a microproject, number 15, "Rewrite fsck.c:fsck_commit() to use starts_with() and/or skip_prefix()." I used only starts_with().

Wrap messages to 65-70 characters.

Use the commit message for explaining and justifying the change.
Commentary about GSoC and the fact that you avoided skip_prefix()
won't be meaningful to someone reading the commit message in the
permanent project history months or years from now. Place such
commentary after the "---" line just below your sign-off.

> memcmp() returns 0 when both are equal, therefore when replacing with starts_with() , I used "!" or deleted where appropriate.

Good. Some applicants have tripped over this. Nevertheless, it's not
necessary to mention this in either the commit message or the
commentary below the "---" line since the inversion is an obvious
requirement of using starts_with() in place of memcmp().

> I plan to apply for the GSoC 2014. I expect your feedbacks!

Place this below the "---" line after your sign-off.

> Signed-off-by: Oguzhan Unlu <cengoguzhanunlu@gmail.com>
> ---
>  fsck.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/fsck.c b/fsck.c
> index 64bf279..d43be98 100644
> --- a/fsck.c
> +++ b/fsck.c
> @@ -290,12 +290,12 @@ static int fsck_commit(struct commit *commit, fsck_error error_func)
>         int parents = 0;
>         int err;
>
> -       if (memcmp(buffer, "tree ", 5))
> +       if (!starts_with(buffer, "tree "))
>                 return error_func(&commit->object, FSCK_ERROR, "invalid format - expected 'tree' line");
>         if (get_sha1_hex(buffer+5, tree_sha1) || buffer[45] != '\n')

One of the benefits of starts_with() and skip_prefix() is that they
allow you to eliminate magic numbers, such as 5 in the memcmp()
invocation. However, if you look a couple lines below, you see in the
expression 'buffer+5' that the magic number is still present. In fact,
the code becomes less clear with your change because the 5 in
'buffer+5' is much more mysterious without the preceding
memcmp(foo,"bar",5). It is possible to eliminate this magic number,
but starts_with() is not the answer.

>                 return error_func(&commit->object, FSCK_ERROR, "invalid 'tree' line format - bad sha1");
>         buffer += 46;
> -       while (!memcmp(buffer, "parent ", 7)) {
> +       while (starts_with(buffer, "parent ")) {
>                 if (get_sha1_hex(buffer+7, sha1) || buffer[47] != '\n')

Ditto here with magic number 7 in 'buffer+7'.

>                         return error_func(&commit->object, FSCK_ERROR, "invalid 'parent' line format - bad sha1");
>                 buffer += 48;
> @@ -322,13 +322,13 @@ static int fsck_commit(struct commit *commit, fsck_error error_func)
>                 if (p || parents)
>                         return error_func(&commit->object, FSCK_ERROR, "parent objects missing");
>         }
> -       if (memcmp(buffer, "author ", 7))
> +       if (!starts_with(buffer, "author "))
>                 return error_func(&commit->object, FSCK_ERROR, "invalid format - expected 'author' line");
>         buffer += 7;

And again with 7.

>         err = fsck_ident(&buffer, &commit->object, error_func);
>         if (err)
>                 return err;
> -       if (memcmp(buffer, "committer ", strlen("committer ")))
> +       if (!starts_with(buffer, "committer "))
>                 return error_func(&commit->object, FSCK_ERROR, "invalid format - expected 'committer' line");
>         buffer += strlen("committer ");

This is a similar case. You eliminated the strlen("committer ") in the
line you changed, but then it appears again a couple lines below. This
can be improved.

>         err = fsck_ident(&buffer, &commit->object, error_func);
> --
> 1.9.1.286.g5172cb3
