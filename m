From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 6/8] reflog_expire(): ignore --updateref for symbolic references
Date: Tue, 10 Feb 2015 16:44:41 -0800
Message-ID: <CAGZ79kZvM4FeHQ074kh7qhsz8cHgGaHxOruP7CM2DgPJErkA-w@mail.gmail.com>
References: <1423473164-6011-1-git-send-email-mhagger@alum.mit.edu>
	<1423473164-6011-7-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, "git@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Feb 11 01:45:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YLLQg-00086s-E4
	for gcvg-git-2@plane.gmane.org; Wed, 11 Feb 2015 01:45:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753016AbbBKAop (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2015 19:44:45 -0500
Received: from mail-ig0-f171.google.com ([209.85.213.171]:43184 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752877AbbBKAom (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2015 19:44:42 -0500
Received: by mail-ig0-f171.google.com with SMTP id h15so27570043igd.4
        for <git@vger.kernel.org>; Tue, 10 Feb 2015 16:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=dBRoyfGmM1SEZ6BUWxMR89Kf4ltd5uN/LB99TSVpgQw=;
        b=a1CyT0Pu+f4apJueZdYe5SXSROByLW4GzklOsTE2ANtA7y7J7b4L7yihtsnaGsuPXk
         L33TbbwyUMoybrh/D/xYzeFx+YuCzUZVxHyrjXbvmvgwTq9AmGGBb+ur7uIXdIUfEoG3
         VazIptYS9w+pl1O3W+w8o65238tEZLvBsQsVnqRQVVWC2CFEjeoH4PlzvROBirwgacNJ
         IU2x7FbdO+sm011hi7im1kX0hbYzlV19PT+IE3I2ummf6xwlDvZaSkR4cx8up0Be5aO2
         OvVEL3s220/IZIROmnRnM+0gYcdkYlmp5TyBnMyjaSm6cIIWo2Nc0kSyPSp3INx3LY9L
         Cr9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=dBRoyfGmM1SEZ6BUWxMR89Kf4ltd5uN/LB99TSVpgQw=;
        b=l1Sy53ZMij4ZSHv8e3bA+e7Vil8tHKcMZe1BcLJTm8Y0EYAKSkmUaQfENRT+Nb0nHj
         n5/l75g6uAtthKZT1g3R1pHbv8FNluoQxJXQmaJBC4/xmNo09vzg8r4+dheyQ5FTBitb
         9sHLyPhABuDZgGU8J+bIZaO7OvR+O/bBvG+QapqAsTdOj+tzJANWlbWut9maN0lFfI5A
         Hp7cyFG3Zc1DRmMxFRp/vCF67aU0ST7gBKLp2qIT4fR0L1p4Yv3BDW4+EjSqI3Jo+b4X
         GH0XAeOfGlIrsAZUJ7diIPwtZRdosgRq6Ji/RCxfLA7Gs6R18snT9Wojo/iBdjQL3Sqk
         LTHA==
X-Gm-Message-State: ALoCoQl+gWIYeFwd3nJ6J61fX7F/txUYwg4mXnr9wIu1Tt06lGxH3fIflBtTN4j4A1KvTAPjbSOj
X-Received: by 10.42.207.129 with SMTP id fy1mr413177icb.17.1423615481939;
 Tue, 10 Feb 2015 16:44:41 -0800 (PST)
Received: by 10.50.26.42 with HTTP; Tue, 10 Feb 2015 16:44:41 -0800 (PST)
In-Reply-To: <1423473164-6011-7-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263666>

On Mon, Feb 9, 2015 at 1:12 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:

> If we are expiring reflog entries for a symbolic reference, then how
> should --updateref be handled if the newest reflog entry is expired?
>
> Option 1: Update the referred-to reference. (This is what the current
> code does.) This doesn't make sense, because the referred-to reference
> has its own reflog, which hasn't been rewritten.
>
> Option 2: Update the symbolic reference itself (as in, REF_NODEREF).
> This would convert the symbolic reference into a non-symbolic
> reference (e.g., detaching HEAD), which is surely not what a user
> would expect.
>
> Option 3: Error out. This is plausible, but it would make the
> following usage impossible:
>
>     git reflog expire ... --updateref --all
>
> Option 4: Ignore --updateref for symbolic references.
>

Ok let me ask a question first about the symbolic refs.

We used to use symbolic links for that, but because of
portability issues we decided to not make it a link, but rather
a standard file containing the pointing link (The content of
.git/HEAD is "ref: refs/heads/master\n" except when detached)

So this is the only distinction? Or is there also a concept of
symbolic links/pointers for the reflog handling?

> We choose to implement option 4.

You're only saying why the other options are insane, not why this
is sane.

Also I'd rather tend for option 3 than 4, as it is a safety measure
(assuming we give a hint to the user what the problem is, and
how it is circumventable)

>
> Note: there are still other problems in this code that will be fixed
> in a moment.
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  Documentation/git-reflog.txt |  3 ++-
>  refs.c                       | 15 ++++++++++++---
>  2 files changed, 14 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/git-reflog.txt b/Documentation/git-reflog.txt
> index f15a48e..9b87b46 100644
> --- a/Documentation/git-reflog.txt
> +++ b/Documentation/git-reflog.txt
> @@ -85,7 +85,8 @@ them.
>
>  --updateref::
>         Update the ref with the sha1 of the top reflog entry (i.e.
> -       <ref>@\{0\}) after expiring or deleting.
> +       <ref>@\{0\}) after expiring or deleting.  (This option is
> +       ignored for symbolic references.)
>
>  --rewrite::
>         While expiring or deleting, adjust each reflog entry to ensure
> diff --git a/refs.c b/refs.c
> index b083858..c0001da 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -4025,6 +4025,7 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
>         struct ref_lock *lock;
>         char *log_file;
>         int status = 0;
> +       int type;
>
>         memset(&cb, 0, sizeof(cb));
>         cb.flags = flags;
> @@ -4036,7 +4037,7 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
>          * reference itself, plus we might need to update the
>          * reference if --updateref was specified:
>          */
> -       lock = lock_ref_sha1_basic(refname, sha1, NULL, 0, NULL);
> +       lock = lock_ref_sha1_basic(refname, sha1, NULL, 0, &type);
>         if (!lock)
>                 return error("cannot lock ref '%s'", refname);
>         if (!reflog_exists(refname)) {
> @@ -4073,10 +4074,18 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
>         (*cleanup_fn)(cb.policy_cb);
>
>         if (!(flags & EXPIRE_REFLOGS_DRY_RUN)) {
> +               /*
> +                * It doesn't make sense to adjust a reference pointed
> +                * to by a symbolic ref based on expiring entries in
> +                * the symbolic reference's reflog.
> +                */
> +               int update = (flags & EXPIRE_REFLOGS_UPDATE_REF) &&
> +                       ~(type & REF_ISSYMREF);
> +
>                 if (close_lock_file(&reflog_lock)) {
>                         status |= error("couldn't write %s: %s", log_file,
>                                         strerror(errno));
> -               } else if ((flags & EXPIRE_REFLOGS_UPDATE_REF) &&
> +               } else if (update &&
>                         (write_in_full(lock->lock_fd,
>                                 sha1_to_hex(cb.last_kept_sha1), 40) != 40 ||
>                          write_str_in_full(lock->lock_fd, "\n") != 1 ||
> @@ -4087,7 +4096,7 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
>                 } else if (commit_lock_file(&reflog_lock)) {
>                         status |= error("unable to commit reflog '%s' (%s)",
>                                         log_file, strerror(errno));
> -               } else if ((flags & EXPIRE_REFLOGS_UPDATE_REF) && commit_ref(lock)) {
> +               } else if (update && commit_ref(lock)) {
>                         status |= error("couldn't set %s", lock->ref_name);
>                 }
>         }
> --
> 2.1.4
>
