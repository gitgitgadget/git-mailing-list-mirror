Return-Path: <SRS0=dguO=BT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F94C433DF
	for <git@archiver.kernel.org>; Sun,  9 Aug 2020 18:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 573C2206C3
	for <git@archiver.kernel.org>; Sun,  9 Aug 2020 18:09:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="yV0C9qF0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgHISJt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 Aug 2020 14:09:49 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53493 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbgHISJs (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Aug 2020 14:09:48 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 199FDE1852;
        Sun,  9 Aug 2020 14:09:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SxwmBrOYNnT+y3I5T/D93xRfTPE=; b=yV0C9q
        F0pz/BqPER/uSGR31bQ9RuGlEcrZG1UUenErLLydXZTkHicAoLdZ9C56q/3bLS5Z
        2jpXrJ1qLke5vOA1vZmU+IxBoy9gKmiy8iCfHGoXZL2h5KdPXuLiB81/dhF1CexA
        Bt4PC9P2ZevNEhPS4A7qbjncLr9VPiD6lQV6E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uP7F2JwaNcw07NWn+0BNiaUHnb/1bV5P
        UafWWUXjH8tgf+ZU+vsBCQ0FMi4gV+d5Dw9/k5FYdSKMgme9DqAQT/ithkeTLWwC
        pNMGhFVvf6Od9emizxRor57Tlct22nr3zq01fd5/DpaL2Nr0NzQiVcl04Dz04QkR
        KrWIX/TpZkg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 035F8E1851;
        Sun,  9 Aug 2020 14:09:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 48FB5E184F;
        Sun,  9 Aug 2020 14:09:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Raymond E. Pasco" <ray@ameretat.dev>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/1] diff-lib: use worktree mode in diffs from i-t-a entries
References: <20200806060119.74587-1-ray@ameretat.dev>
        <20200808075323.36041-1-ray@ameretat.dev>
Date:   Sun, 09 Aug 2020 11:09:42 -0700
In-Reply-To: <20200808075323.36041-1-ray@ameretat.dev> (Raymond E. Pasco's
        message of "Sat, 8 Aug 2020 03:53:23 -0400")
Message-ID: <xmqqh7tbelnd.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 80A8D2EA-DA6B-11EA-9096-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Raymond E. Pasco" <ray@ameretat.dev> writes:

> When creating "new file" diffs against i-t-a index entries, diff-lib
> erroneously used the mode of the cache entry rather than the mode of the
> file in the worktree. This changes run_diff_files() to correctly use the
> mode of the worktree file in this case.
>
> Signed-off-by: Raymond E. Pasco <ray@ameretat.dev>
> ---
> This is a distinct bugfix from the other changes, so I've sent it as a
> separate patch also based on v2.28.0.
>
>  diff-lib.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/diff-lib.c b/diff-lib.c
> index 25fd2dee19..50521e2093 100644
> --- a/diff-lib.c
> +++ b/diff-lib.c
> @@ -219,7 +219,8 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
>  				continue;
>  			} else if (revs->diffopt.ita_invisible_in_index &&
>  				   ce_intent_to_add(ce)) {
> -				diff_addremove(&revs->diffopt, '+', ce->ce_mode,
> +				newmode = ce_mode_from_stat(ce, st.st_mode);
> +				diff_addremove(&revs->diffopt, '+', newmode,
>  					       &null_oid, 0, ce->name, 0);

;-)  

The ita-invisible-in-index option means that Git must ignore
anything in the index about the entry, other than just the fact that
the path is subject to comparison, so use of ce->ce_mode here is
wrong by definition.  Makes sense.

>  				continue;
>  			}
