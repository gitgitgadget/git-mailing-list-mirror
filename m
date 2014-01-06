From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 2/2] shallow: Remove unused code
Date: Mon, 6 Jan 2014 07:08:12 +0700
Message-ID: <CACsJy8BqKmsw7JRzgYCZs4gGKM-G1DSBN=e1+T_RDaZuibUa1w@mail.gmail.com>
References: <52C9F23A.40902@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Mon Jan 06 01:08:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VzxkN-0006vQ-Lc
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jan 2014 01:08:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751817AbaAFAIo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Jan 2014 19:08:44 -0500
Received: from mail-qe0-f48.google.com ([209.85.128.48]:59405 "EHLO
	mail-qe0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751407AbaAFAIn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Jan 2014 19:08:43 -0500
Received: by mail-qe0-f48.google.com with SMTP id gc15so17330400qeb.21
        for <git@vger.kernel.org>; Sun, 05 Jan 2014 16:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=M/mcoO4gWNW/AWe0Jay39wnjn6t/7gD5F+K1PfmJKMI=;
        b=F98FgKii2UAmsdJrHOG8bMMQmOG2UBw0bwkuKexV5NYhwcE/+w77fplitHgosLAEOJ
         IqWvk/dp/mk11ozL9TGOLuLPS9bXsLPs65I7weG6ajN0uBflpGS+7/6BQ1iys6PyLios
         hbc/UqA9MCF3TAZbG2vmH59OjBaLT2jx+Jn+e3A4kCPbtW1eKJjwkRzhlVqbKI4tFl6n
         vnKrmCAZrv6G8EEClQgic/NrwPDq+m/TwyaiOg6kdtjtmdWoepwAnVx+4VoI9neaE8tS
         /Y1WrE3ZrlUYLM5tGoMIzyrCfAucokObrEDOYVsYxUMp/Of7T8Zn6MEM/ra55iagA5Zq
         9rJw==
X-Received: by 10.224.151.145 with SMTP id c17mr174269770qaw.24.1388966922673;
 Sun, 05 Jan 2014 16:08:42 -0800 (PST)
Received: by 10.96.136.98 with HTTP; Sun, 5 Jan 2014 16:08:12 -0800 (PST)
In-Reply-To: <52C9F23A.40902@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239983>

On Mon, Jan 6, 2014 at 7:00 AM, Ramsay Jones <ramsay@ramsay1.demon.co.uk> wrote:
>
> Commit 58babfff ("shallow.c: the 8 steps to select new commits for
> .git/shallow", 05-12-2013) added a function to implement step 5 of
> the quoted eight steps, namely 'remove_nonexistent_ours_in_pack()'.
> This function implements an optional optimization step in the new
> shallow commit selection algorithm. However, this function has no
> callers. (The commented out call sites would need to change, in
> order to provide information required by the function.)
>
> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
> ---
>
> Hi Junio,
>
> This should, perhaps, be marked as RFC; if the patch to actually
> use this function is coming soon, then this is not needed.
> However, I suspect it could be slow in coming ... :-P

I'm not against this patch. I think the function is to demonstrate
what step 5 is, which is already in the history (unless there are
major errors that I'll need to resend the whole series). I may do the
real step 5 differently anyway to fit better how index-pack and
unpack-objects are run. Not fully realized yet.

>
> ATB,
> Ramsay Jones
>
>  builtin/receive-pack.c |  1 -
>  commit.h               |  2 --
>  fetch-pack.c           |  1 -
>  shallow.c              | 16 ----------------
>  4 files changed, 20 deletions(-)
>
> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index de869b5..85bba35 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -1059,7 +1059,6 @@ static void update_shallow_info(struct command *commands,
>         struct command *cmd;
>         int *ref_status;
>         remove_nonexistent_theirs_shallow(si);
> -       /* XXX remove_nonexistent_ours_in_pack() */
>         if (!si->nr_ours && !si->nr_theirs) {
>                 shallow_update = 0;
>                 return;
> diff --git a/commit.h b/commit.h
> index 5507460..30598c6 100644
> --- a/commit.h
> +++ b/commit.h
> @@ -230,8 +230,6 @@ struct shallow_info {
>  extern void prepare_shallow_info(struct shallow_info *, struct sha1_array *);
>  extern void clear_shallow_info(struct shallow_info *);
>  extern void remove_nonexistent_theirs_shallow(struct shallow_info *);
> -extern void remove_nonexistent_ours_in_pack(struct shallow_info *,
> -                                           struct packed_git *);
>  extern void assign_shallow_commits_to_refs(struct shallow_info *info,
>                                            uint32_t **used,
>                                            int *ref_status);
> diff --git a/fetch-pack.c b/fetch-pack.c
> index 1d0328d..d52de74 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -984,7 +984,6 @@ static void update_shallow(struct fetch_pack_args *args,
>                 return;
>
>         remove_nonexistent_theirs_shallow(si);
> -       /* XXX remove_nonexistent_ours_in_pack() */
>         if (!si->nr_ours && !si->nr_theirs)
>                 return;
>         for (i = 0; i < nr_sought; i++)
> diff --git a/shallow.c b/shallow.c
> index f48f732..bbc98b5 100644
> --- a/shallow.c
> +++ b/shallow.c
> @@ -358,22 +358,6 @@ void remove_nonexistent_theirs_shallow(struct shallow_info *info)
>         info->nr_theirs = dst;
>  }
>
> -/* Step 5, remove non-existent ones in "ours" in the pack */
> -void remove_nonexistent_ours_in_pack(struct shallow_info *info,
> -                                    struct packed_git *p)
> -{
> -       unsigned char (*sha1)[20] = info->shallow->sha1;
> -       int i, dst;
> -       trace_printf_key(TRACE_KEY, "shallow: remove_nonexistent_ours_in_pack\n");
> -       for (i = dst = 0; i < info->nr_ours; i++) {
> -               if (i != dst)
> -                       info->ours[dst] = info->ours[i];
> -               if (find_pack_entry_one(sha1[info->ours[i]], p))
> -                       dst++;
> -       }
> -       info->nr_ours = dst;
> -}
> -
>  define_commit_slab(ref_bitmap, uint32_t *);
>
>  struct paint_info {
> --
> 1.8.5



-- 
Duy
