Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 101601F563
	for <e@80x24.org>; Fri,  3 Feb 2017 23:38:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753132AbdBCXin (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Feb 2017 18:38:43 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36572 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752877AbdBCXim (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Feb 2017 18:38:42 -0500
Received: by mail-pg0-f67.google.com with SMTP id 75so3127353pgf.3
        for <git@vger.kernel.org>; Fri, 03 Feb 2017 15:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=TaTP/39cAZFa3EjgIrabtoIHMuftCNM4F5PcPd6iAS4=;
        b=LtaRuKXMo0/fyEXREf3LW4n4j8XBtMmKNcsHqrpC/3Zx1HPr95gdj/Hv+lejcJVJBH
         1GBE8RzlahpL/aRLiB8X8nMp57Qt5n8cZacSf5XTvhXOi6J19HfegdO2UxG+oGPfRH2d
         0ueUOh/l+niofyGk5LwKp271M2YCbe5cv85yF5W8z9kCt3IX5Ie7qEza69QkgqohnlLO
         p+4kky52SsrXeCrwRpGRceReZ0BU7CnCYfTqu1iTKBj3T4/CDo9Jh+2dDyLeJHz/rtoR
         CB9KrlepuWOt9XnPwEYJMejBbcdQvvbr6ZvNjvOUrxlDDRzCZhkQv8Yep/agStGCJtPE
         0gmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=TaTP/39cAZFa3EjgIrabtoIHMuftCNM4F5PcPd6iAS4=;
        b=U296s546X5ZgA7EciuVKlZ863DmFRmMSrrNuxHYKMutI1qQFcNy/Rb/8AoCwXonXmA
         Y21QZOHPOVY/9jsRDNuTUC4iOhN17so4NBaeySyMHdcoaX7lpNYvlfFQTxK/5mILF6pe
         H7jbQcJ5GnENjeecPTNmjnt6112VeDWKnHYUtBXCM1A67hMitV5DOivmttc2q74dZPhe
         wn7WRgVCr163V9VHeN2j8tYJmNahHVt5CV2+BIGmzAGvikX/hG25RnYYJT6gLwODyXDq
         WRW47BCfUONA1e76X/ZdkYf32WtWQoe2KOK9Le2PAdKVUZR7r/XwuUXWz77qX8+j1Lt7
         cduQ==
X-Gm-Message-State: AIkVDXJtqNbgftxyqK6Pira/AfeXPRc9rLygWAopt5xIJeZeqII2mP30F1K5+wyj5XZH2g==
X-Received: by 10.84.215.200 with SMTP id g8mr24762581plj.161.1486165122190;
        Fri, 03 Feb 2017 15:38:42 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:dd9f:576d:b8fa:253a])
        by smtp.gmail.com with ESMTPSA id a1sm8156635pgc.14.2017.02.03.15.38.41
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 03 Feb 2017 15:38:41 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Gumbel\, Matthew K" <matthew.k.gumbel@intel.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] commit: Optimize number of lstat() calls
References: <DA0A42D68346B1469147552440A645039A9C9988@ORSMSX115.amr.corp.intel.com>
Date:   Fri, 03 Feb 2017 15:38:40 -0800
In-Reply-To: <DA0A42D68346B1469147552440A645039A9C9988@ORSMSX115.amr.corp.intel.com>
        (Matthew K. Gumbel's message of "Fri, 3 Feb 2017 23:22:30 +0000")
Message-ID: <xmqqh94adev3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Gumbel, Matthew K" <matthew.k.gumbel@intel.com> writes:

> When making a --only commit, original behavior was to do a full cache
> update for the purposes of giving the pre-commit hook an up-to-date set 
> of stat data. That would result in long runtime for git-commit in a big 
> repo on NFS (>60s for a 54k-file repo).
>
> With this change, when doing a --only commit and no pre-commit hook is
> present, the cache update is skipped since it is known a priori which
> files are to be committed.

Did you determine that "pre-commit" hook is the only thing that
needs the special case and if so how?  With that stated in the log
message, we would feel safe to take this patch.

> Signed-off-by: Matthew K. Gumbel <matthew.k.gumbel@intel.com>
> ---
> builtin/commit.c | 8 ++++++--
> 1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 2de5f6c..1df3d71 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -470,7 +470,9 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
>
>     hold_locked_index(&index_lock, LOCK_DIE_ON_ERROR);
>     add_remove_files(&partial);
> -   refresh_cache(REFRESH_QUIET);
> +    if (find_hook("pre-commit")) {
> +        refresh_cache(REFRESH_QUIET);
> +    }
>     update_main_cache_tree(WRITE_TREE_SILENT);
>     if (write_locked_index(&the_index, &index_lock, CLOSE_LOCK))
>         die(_("unable to write new_index file"));

I wonder why this patch is full of 0xa0 bytes instead of spaces.
Somebody between your editor and mailing list is munging your
patches?

> @@ -482,7 +484,9 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
>
>     create_base_index(current_head);
>     add_remove_files(&partial);
> -   refresh_cache(REFRESH_QUIET);
> +    if (find_hook("pre-commit")) {
> +        refresh_cache(REFRESH_QUIET);
> +    }
>
>     if (write_locked_index(&the_index, &false_lock, CLOSE_LOCK))
>         die(_("unable to write temporary index file"));

I'd prefer if you introduced a small helper function, name it
can_cheat_on_refreshing() or something, and encapsulate the call to
find_hook("pre-commit") inside it---if there are other corner cases
you didn't think of, or if in the future more hooks are added that
need their incoming index file already refreshed, we do not want to
update these two places---rather we'd want to limit the need for
updating to the single helper function.

