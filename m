Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEC851FF7F
	for <e@80x24.org>; Wed,  7 Dec 2016 20:58:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932674AbcLGU6h (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Dec 2016 15:58:37 -0500
Received: from mail-qt0-f172.google.com ([209.85.216.172]:36767 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753177AbcLGU6g (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2016 15:58:36 -0500
Received: by mail-qt0-f172.google.com with SMTP id w33so391971964qtc.3
        for <git@vger.kernel.org>; Wed, 07 Dec 2016 12:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=al8pu30KDgymhzNpJK+CDclC6S3wAEcyDPN+lZfuzjI=;
        b=FkCaGOGcZUQqcoHVXqPLULHS1NkoUy4NAIalCbuG14D583mz6eHGIJkFiekMnD3Vxz
         mgv/WmMLbDzf1oNEMuSpGiVpewIdDXn7brEXEZE+t46CR+AtSXZaCbzKLppJIp05l8VN
         x9puhqMLI0CFX8T5XZbflMDv1eeChz33jD+3P/mEc2Zyx+UHVPAPi9Q4ddixwlf/HmTa
         SEJS8izk16yUlkQ39zVK4rkdPglfILR4aqqn88nqMMTFoTKled8iJDVZauKwseMnkU6a
         VOIKYrtUMv40NVR5//Aho/aJTJLTbkxGlqeT5FrYVBMx7G1yje0DuJX8lGaFH1rVDf+6
         /mvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=al8pu30KDgymhzNpJK+CDclC6S3wAEcyDPN+lZfuzjI=;
        b=Slc46km6twyI6nfgeldFq+B7Bpp+3kHJ9o73QV74DH8cjih0UgQxX22UbjH2QSR6Jp
         p0eVJ43Z0kuwv74AzD+FytDZOCgdY0+d0mSAvm5M71Xeo2/d+dXCx8fEiYcMPs07hl+8
         QFvlLC/wO+Qyl8aNB/unJ+4CJZq7OS+oZR6Z1WvFaRHeZJQBu/Ri38E14B2JQtoe+mI1
         x0hCkVbnFMedMGq3jVaz5NNSJz4vokhSWPYgq5iID+fro+VhuWvKQGkCxf9IvKyKD+cZ
         32SHEf2xwHz3GlJ78mq4CDG3+0/NlLv2gxd1o5UhXOnm7FQaUHbhQRNum57MK0QOUY30
         uVng==
X-Gm-Message-State: AKaTC01PDnwzgPys+dBtigZgue3v8GYGhGAUiUbeNv3iAKXLvQYyQw4bo2YPZzMQUKpkO5U2mCE5RMFoAGtN+XTK
X-Received: by 10.200.49.235 with SMTP id i40mr69315705qte.170.1481143714473;
 Wed, 07 Dec 2016 12:48:34 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.147.188 with HTTP; Wed, 7 Dec 2016 12:48:34 -0800 (PST)
In-Reply-To: <20161207194105.25780-2-gitster@pobox.com>
References: <xmqqd1h3y506.fsf@gitster.mtv.corp.google.com> <20161207194105.25780-1-gitster@pobox.com>
 <20161207194105.25780-2-gitster@pobox.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 7 Dec 2016 12:48:34 -0800
Message-ID: <CAGZ79kZHGqU2y19_uKhtVuE6vhspzPNpw-nVDnm8gLQ8u528kQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] wt-status: implement opportunisitc index update correctly
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Paul Tan <pyokagan@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 7, 2016 at 11:41 AM, Junio C Hamano <gitster@pobox.com> wrote:
> The require_clean_work_tree() function calls hold_locked_index()
> with die_on_error=0 to signal that it is OK if it fails to obtain
> the lock, but unconditionally calls update_index_if_able(), which
> will try to write into fd=-1.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---

So my first question I had to answer was if we do the right thing here,
i.e. if we could just fail instead. But we want to continue and just
not write back the index, which is fine.

So we do not have to guard refresh_cache, but just call
update_index_if_able conditionally.

However I think the promise of that function is
to take care of the fd == -1?

    /*
    * Opportunistically update the index but do not complain if we can't
    */
    void update_index_if_able(struct index_state *istate, struct
lock_file *lockfile)
    {
        if ((istate->cache_changed || has_racy_timestamp(istate)) &&
            verify_index(istate) &&
            write_locked_index(istate, lockfile, COMMIT_LOCK))
                rollback_lock_file(lockfile);
    }

So I would expect that we'd rather fix the update_index_if_able instead by
checking for the lockfile to be in the correct state?


>  wt-status.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/wt-status.c b/wt-status.c
> index a2e9d332d8..a715e71906 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -2258,11 +2258,12 @@ int has_uncommitted_changes(int ignore_submodules)
>  int require_clean_work_tree(const char *action, const char *hint, int ignore_submodules, int gently)
>  {
>         struct lock_file *lock_file = xcalloc(1, sizeof(*lock_file));
> -       int err = 0;
> +       int err = 0, fd;
>
> -       hold_locked_index(lock_file, 0);
> +       fd = hold_locked_index(lock_file, 0);
>         refresh_cache(REFRESH_QUIET);
> -       update_index_if_able(&the_index, lock_file);
> +       if (0 <= fd)
> +               update_index_if_able(&the_index, lock_file);
>         rollback_lock_file(lock_file);
>
>         if (has_unstaged_changes(ignore_submodules)) {
> --
> 2.11.0-274-g0631465056
>
