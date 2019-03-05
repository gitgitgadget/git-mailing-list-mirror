Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3294720248
	for <e@80x24.org>; Tue,  5 Mar 2019 13:28:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727622AbfCEN2S (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Mar 2019 08:28:18 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34943 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbfCEN2S (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Mar 2019 08:28:18 -0500
Received: by mail-wr1-f66.google.com with SMTP id t18so9471303wrx.2
        for <git@vger.kernel.org>; Tue, 05 Mar 2019 05:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=RVedYIe8/EpwQyWBR8cmKUhKaX9yQy3MdN/gZW+bkf4=;
        b=ItefEdMaa62FKk24iUTFxTHelPKLiOw4CPhEnFkpFTTUG5e8+9lNAVMBLUdx/6uf8u
         AkdGxUJkCN08urP8K6XJ6ae5Dn+oG9sFKC6Dyy5lG0CU9vyXQBuKpr/vGuBHcIIyKmQE
         oJpiwTwCaMQoImkENCNKg5QBf3TqIuOAfjTmXxY/JPV32yxPLh9tlJUi7fbBnbTcuErn
         tCPJa+DvhkLNBeFOWNPB4LwiHhAgq97GAx/7mgxa3DmtFuG2G1j2Yih69lELcLCSQLlN
         +Fr94OS/YXaDGiSQPct8CwKfZMo1juLDQf1I1Aov8OO5AsoUud8mnokSWDR5obZ9hwEg
         oxpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=RVedYIe8/EpwQyWBR8cmKUhKaX9yQy3MdN/gZW+bkf4=;
        b=HEK++EuxnBEuyHkvkhOIbC6XGmY8EAhCLSMpdIkXs1podvnAf57zSsVh7lZhy5k1gl
         QP3Km/6sctRm2d1Kz2iLgLyUBoaFZGynp7X+UtztwEw7N76SzpwWLVrXWG/ihHEN59r+
         fbw/pdPFbPDncwe8d6fQ5T6gQdBQ00XUvA2B6rCHPfJhXYsShV1IeUHjyiAm5tX5PmxY
         BFQV2REwZMtPVNbPxfXb6xYa78oAMG25X4b7r/hLXIQWTryUqaFv9HmKhDQgRa7hBaMo
         C0WPqVnVL52eDEuKbo5d/m2gHkmmuCGkhm2eXUJIXQyeAbK/kNwyPVQMaWFBRnVuRaxi
         F29g==
X-Gm-Message-State: APjAAAWGhAZ6cMik4b+hVQ957B92VYuYOuEu8nC7SHrU8UIRgRCaEqCQ
        Swxy95Rwg/t1gThiaSDZ5TU=
X-Google-Smtp-Source: APXvYqzKCQOWIgSkneBZeCyRb38vw6eRPiVuv/6Ea5M1b5VVy/R89NlIXWtlEyoWxGqjbH58dCNjSg==
X-Received: by 2002:a5d:6703:: with SMTP id o3mr15968777wru.75.1551792495375;
        Tue, 05 Mar 2019 05:28:15 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id p6sm32147200wre.63.2019.03.05.05.28.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Mar 2019 05:28:14 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Matthew DeVore <matvore@google.com>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] rev-list: allow cached objects in existence check
References: <20190304174053.GA27497@sigill.intra.peff.net>
Date:   Tue, 05 Mar 2019 22:28:14 +0900
In-Reply-To: <20190304174053.GA27497@sigill.intra.peff.net> (Jeff King's
        message of "Mon, 4 Mar 2019 12:40:54 -0500")
Message-ID: <xmqq4l8hv4b5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> This fixes a regression in 7c0fe330d5 (rev-list: handle missing tree
> objects properly, 2018-10-05) where rev-list will now complain about the
> empty tree when it doesn't physically exist on disk.
>
> Before that commit, we relied on the traversal code in list-objects.c to
> walk through the trees. Since it uses parse_tree(), we'd do a normal
> object lookup that includes looking in the set of "cached" objects
> (which is where our magic internal empty-tree kicks in).
>
> After that commit, we instead tell list-objects.c not to die on any
> missing trees, and we check them ourselves using has_object_file(). But
> that function uses OBJECT_INFO_SKIP_CACHED, which means we won't use our
> internal empty tree.

Yikes.  Thanks for spotting.

> This patch makes the minimal fix, which is to swap out a direct call to
> oid_object_info_extended(), minus the SKIP_CACHED flag, instead of
> calling has_object_file(). This is all that has_object_file() is doing
> under the hood. And there's little danger of unrelated fallout from
> other unexpected "cached" objects, since there's only one call site that
> ends such a cached object, and it's in git-blame.

OK.  That last one is not even "cached" but "merely exists in-core"
virtual commit, that represents the locally modified state, right?
I do not think rev-list ever asks if these object exist, but if they
were asked, we should say they also exist.

> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I prepared this directly on top of 7c0fe330d5, but it should merge
> cleanly into the current tip of master.
>
> I think we might also consider just having has_object_file() respect
> cached objects. The SKIP_CACHED flag comes from Jonathan Tan's
> e83e71c5e1 (sha1_file: refactor has_sha1_file_with_flags, 2017-06-21).
> But it was just matching the old behavior; it's not clear to me that we
> particularly care about that, and it wasn't simply that nobody bothered
> to put the cached-object check into has_sha1_file().

Yup, I am fine with such a clean-up after we fix this regression.

> Some concerns/arguments against it:
>
>   - we probably would want to make sure we do not short-cut
>     write_sha1_file(). I.e., we should still write it to disk when
>     somebody wants it. But I think that works, because that function
>     uses its own check-and-freshen infrastructure.
>
>   - some callers of has_sha1_file() might care about durability between
>     processes. Because it's baked in, the empty tree is safe for that
>     (whatever follow-on process runs, it will also be baked in there).
>     But that's not necessarily true for other "cached" objects. I'm not
>     really that worried about it because we use it sparingly (the only
>     call to pretend_sha1_file() is in git-blame, and if it ever did ask
>     "do we have this object", I actually think the right answer would be
>     "yes").

... and I realize that I should have read ahead before writing the
four lines above myself ;-)  We are on the same page.

>     But if this is a concern, we could perhaps have two levels of flags:
>     SKIP_CACHED and SKIP_INTERNAL.
>
>  builtin/rev-list.c           |  2 +-
>  t/t1060-object-corruption.sh | 10 ++++++++++
>  2 files changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/rev-list.c b/builtin/rev-list.c
> index 49d6deed70..877b6561f4 100644
> --- a/builtin/rev-list.c
> +++ b/builtin/rev-list.c
> @@ -237,7 +237,7 @@ static inline void finish_object__ma(struct object *obj)
>  static int finish_object(struct object *obj, const char *name, void *cb_data)
>  {
>  	struct rev_list_info *info = cb_data;
> -	if (!has_object_file(&obj->oid)) {
> +	if (oid_object_info_extended(the_repository, &obj->oid, NULL, 0) < 0) {
>  		finish_object__ma(obj);
>  		return 1;
>  	}
> diff --git a/t/t1060-object-corruption.sh b/t/t1060-object-corruption.sh
> index ac1f189fd2..807b63b473 100755
> --- a/t/t1060-object-corruption.sh
> +++ b/t/t1060-object-corruption.sh
> @@ -125,4 +125,14 @@ test_expect_success 'fetch into corrupted repo with index-pack' '
>  	)
>  '
>  
> +test_expect_success 'internal tree objects are not "missing"' '
> +	git init missing-empty &&
> +	(
> +		cd missing-empty &&
> +		empty_tree=$(git hash-object -t tree /dev/null) &&
> +		commit=$(echo foo | git commit-tree $empty_tree) &&
> +		git rev-list --objects $commit
> +	)
> +'
> +
>  test_done
