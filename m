Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79FFD20970
	for <e@80x24.org>; Fri, 14 Apr 2017 18:29:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754719AbdDNS3D (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Apr 2017 14:29:03 -0400
Received: from mail-pg0-f46.google.com ([74.125.83.46]:35425 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752912AbdDNS27 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2017 14:28:59 -0400
Received: by mail-pg0-f46.google.com with SMTP id 72so37981415pge.2
        for <git@vger.kernel.org>; Fri, 14 Apr 2017 11:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=tAd241LG7xwjWQHOAiX2UyDJesMnmDLQE282mEcLsjE=;
        b=KQTBxAJA3cRUJHmQjKgu3jun3LxAsg9RMWPvyUj3at64BI4TYNsP/w/pdSai6vZ4Q0
         UDyBtf9RQNUG6Ij5FW2M0JxslqN7SRV+Ubuz0A+FfBySd6fWYnJGnCBmdwe8W1nFiOCz
         tep1wt6AdenH7yo4SLRfpQzmxSqDM0AaHk40oFuKHbrf3s/7HpIQfLJ5nbJ8wyB7QPjP
         3lPvUT1Tu8n0ip/stvuZ34s2fiJptGgh5Kd6AotuOksaJoSe+YM7CtzS7DrqvWHUIp2j
         wiWfJS8YoZ67y2fwWjW9lnETCWr04tNh+e2xEsiwHO7UEy1+HNmSoL5Ms9po7gKqwv15
         bUcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=tAd241LG7xwjWQHOAiX2UyDJesMnmDLQE282mEcLsjE=;
        b=tNmN+8lvUFdy5zDQUeL6sNuNTgVEZrxHE1nYK0Hwg4xohQ9gzYNLRAQlCUIVxNWTCX
         8IISYyRKbMEe+8uh70iKr5monhMwuRWxjLxM4Z6DIzPSASTfskyvGDR3UAnKsT5ptSAu
         +6xIT8AQFl2HFNuERhhmnSV6Jlj6u1oJe+qrMmL9upCVCzocuN25sUb39C8aA3evGQ4A
         AZVNmdDtgA7anhP4xplnqyttPNhlTSQLPZUvS0W7lLq0+pVUj2/OkjtBfEmYQtMBE+xN
         GlqEJY6aExUJnRAQmn/ryBQTYVhmYyPORwnPLqB1qFDz6ubSiK/rkmKKZjgAV2isGxAU
         Qt8g==
X-Gm-Message-State: AN3rC/66jCzVWFvdTwNpffrscHOyIn9S7lLU4VIzPLoGxHr58xQO9CsV
        LJdkHYpxJVgLvVz9
X-Received: by 10.84.143.1 with SMTP id 1mr10526779ply.70.1492194538184;
        Fri, 14 Apr 2017 11:28:58 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([2620:0:1000:5b10:89f1:c9fd:6430:a29d])
        by smtp.gmail.com with ESMTPSA id c3sm4517203pfg.46.2017.04.14.11.28.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Apr 2017 11:28:57 -0700 (PDT)
Subject: Re: [PATCH 1/4] entry.c: submodule recursing: respect force flag
 correctly
To:     Stefan Beller <sbeller@google.com>, bmwill@google.com
References: <20170411234923.1860-1-sbeller@google.com>
 <20170411234923.1860-2-sbeller@google.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com, gitster@pobox.com
From:   Jonathan Tan <jonathantanmy@google.com>
Message-ID: <15b87ca2-98c4-edfc-1e7e-7a25c28bd8da@google.com>
Date:   Fri, 14 Apr 2017 11:28:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170411234923.1860-2-sbeller@google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/11/2017 04:49 PM, Stefan Beller wrote:
> In case of a non-forced worktree update, the submodule movement is tested
> in a dry run first, such that it doesn't matter if the actual update is
> done via the force flag. However for correctness, we want to give the
> flag is specified by the user. All callers have been inspected and updated
> if needed.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  entry.c        | 8 ++++----
>  unpack-trees.c | 7 ++++++-
>  2 files changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/entry.c b/entry.c
> index d2b512da90..d6b263f78e 100644
> --- a/entry.c
> +++ b/entry.c
> @@ -208,7 +208,8 @@ static int write_entry(struct cache_entry *ce,
>  		sub = submodule_from_ce(ce);
>  		if (sub)
>  			return submodule_move_head(ce->name,
> -				NULL, oid_to_hex(&ce->oid), SUBMODULE_MOVE_HEAD_FORCE);
> +				NULL, oid_to_hex(&ce->oid),
> +				state->force ? SUBMODULE_MOVE_HEAD_FORCE : 0);
>  		break;
>  	default:
>  		return error("unknown file mode for %s in index", path);
> @@ -282,12 +283,11 @@ int checkout_entry(struct cache_entry *ce,
>  					unlink_or_warn(ce->name);
>
>  				return submodule_move_head(ce->name,
> -					NULL, oid_to_hex(&ce->oid),
> -					SUBMODULE_MOVE_HEAD_FORCE);
> +					NULL, oid_to_hex(&ce->oid), 0);

Should we be consistent (with the "else" block below and with the 
existing code) to use "state->force ? SUBMODULE_MOVE_HEAD_FORCE : 0" 
instead of 0? (I glanced briefly through the code and 
SUBMODULE_MOVE_HEAD_FORCE might have no effect anyway if "old" is NULL, 
but it's probably still better to be consistent.)

>  			} else
>  				return submodule_move_head(ce->name,
>  					"HEAD", oid_to_hex(&ce->oid),
> -					SUBMODULE_MOVE_HEAD_FORCE);
> +					state->force ? SUBMODULE_MOVE_HEAD_FORCE : 0);
>  		}
>
>  		if (!changed)
> diff --git a/unpack-trees.c b/unpack-trees.c
> index 8333da2cc9..7316ca99c2 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -252,14 +252,18 @@ static int check_submodule_move_head(const struct cache_entry *ce,
>  				     const char *new_id,
>  				     struct unpack_trees_options *o)
>  {
> +	unsigned flags = SUBMODULE_MOVE_HEAD_DRY_RUN;
>  	const struct submodule *sub = submodule_from_ce(ce);
>  	if (!sub)
>  		return 0;
>
> +	if (o->reset)
> +		flags |= SUBMODULE_MOVE_HEAD_FORCE;

It seems to me that this is independent of the entry.c change, and might 
be better in its own patch. (Or if it is not, maybe the subject should 
be "entry, unpack-trees: propagate force when submodule recursing" or 
something like that, containing the names of both modified components.)

Also, you mentioned in the parent message that this patch is required 
for patch 3. Is only the entry.c part required, or unpack-trees.c, or both?

> +
>  	switch (sub->update_strategy.type) {
>  	case SM_UPDATE_UNSPECIFIED:
>  	case SM_UPDATE_CHECKOUT:
> -		if (submodule_move_head(ce->name, old_id, new_id, SUBMODULE_MOVE_HEAD_DRY_RUN))
> +		if (submodule_move_head(ce->name, old_id, new_id, flags))
>  			return o->gently ? -1 :
>  				add_rejected_path(o, ERROR_WOULD_LOSE_SUBMODULE, ce->name);
>  		return 0;
> @@ -308,6 +312,7 @@ static void unlink_entry(const struct cache_entry *ce)
>  		case SM_UPDATE_CHECKOUT:
>  		case SM_UPDATE_REBASE:
>  		case SM_UPDATE_MERGE:
> +			/* state.force is set at the caller. */

I don't understand the relevance of this comment - it is indeed set 
there, but "state" is not used there until after the invocation to 
unlink_entry so it doesn't seem related.

>  			submodule_move_head(ce->name, "HEAD", NULL,
>  					    SUBMODULE_MOVE_HEAD_FORCE);
>  			break;
>
