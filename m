Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A386C433E2
	for <git@archiver.kernel.org>; Wed, 13 May 2020 16:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF3FE2053B
	for <git@archiver.kernel.org>; Wed, 13 May 2020 16:15:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="L0EWdLHT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389484AbgEMQP6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 May 2020 12:15:58 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51830 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730291AbgEMQP4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 May 2020 12:15:56 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E1948C4655;
        Wed, 13 May 2020 12:15:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2ZEYqjqKA8aAHGvZVywAqGuYL1Q=; b=L0EWdL
        HTbUripxL4iZO9lnr4tpOrsjeTD6dO7HPiYMlI1ExTxt0dR7MQ2tFti5FdSVUP+/
        79uculyCv1WkckyfH1FEnamdRy22+/axMMjj4MvnFYBoWx6wkjx5exGF02rWooPB
        gfUHEP+fKrkugtl7aPlwL9pJPbRft14VnxoTI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UMuKC4h97GR/49T2AB0RmA3k4fmwG0Qm
        /yH5bnI1HYa0v+8ThgLINQ9vnymGfJ8WKbTKg4tdau+6A40YAqKVsI0J0K3JGN2z
        E6/rsa41p6Z385xS684wIc0OxJc3YRNn3b8utdhkPe3xW7Vg597AbBx6/RWo0lNX
        DyOPFkMvUFo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D9198C4654;
        Wed, 13 May 2020 12:15:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 29F89C4652;
        Wed, 13 May 2020 12:15:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org, Chunlin Zhang <zhangchunlin@gmail.com>
Subject: Re: bugreport: Wrong binary file content after cherry-pick
References: <CAG2rzA=c8bGD6A_8kKCdz+UABjed9W6mSJYjLhYckbsXiFe4CQ@mail.gmail.com>
Date:   Wed, 13 May 2020 09:15:48 -0700
In-Reply-To: <CAG2rzA=c8bGD6A_8kKCdz+UABjed9W6mSJYjLhYckbsXiFe4CQ@mail.gmail.com>
        (Chunlin Zhang's message of "Wed, 13 May 2020 16:47:56 +0800")
Message-ID: <xmqqsgg3vmiz.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 02D9D966-9535-11EA-A131-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Chunlin Zhang <zhangchunlin@gmail.com> writes:

> git version: after v2.21.0 can reproduce this bug
>
> reproduce steps:
> git clone https://github.com/zhangchunlin/gitbug
> cd gitbug
> git cherry-pick dev
>
> Then there will be a conflict with the cherry-pick, but if you run
> "md5sum *", will get:
> 6f96c8bc9e3df2f6fef1ecbb09f218f6
> ICS_usc_any_any_9.1.5_8871.uscc_261_130664_2048-release.apk
> 6f96c8bc9e3df2f6fef1ecbb09f218f6
> ICS_usc_any_any_9.8.0_b2cbd84d94.b2cbd84_297_131010_2048-release.apk
>
> The second file get a wrong file content.
> 3 related files md5:
> 6f96c8bc9e3df2f6fef1ecbb09f218f6
> ICS_usc_any_any_9.1.5_8871.uscc_261_130664_2048-release.apk
> d1bdd852b32c09ec93a5494afb3c67e7
> ICS_usc_any_any_9.1.5_8871.uscc_266_130703_2048-release.apk
> b2c50a9d7d488aa0b62ec7e68706ea85
> ICS_usc_any_any_9.8.0_b2cbd84d94.b2cbd84_297_131010_2048-release.apk
>
> I use git bisect to found the commit which cause this problem:
> https://github.com/git/git/commit/48c9cb9d6d058bcf18e931a1ed0d88792bb506c9

That's Elijah's 48c9cb9d (merge-recursive: improve
rename/rename(1to2)/add[/add] handling, 2018-11-07)

The history Chunlin's repository has is a three-commit single strand
of pearls; each commit's tree records only a single blob:

 * 'master' that has "uscc_261" file whose contents is f98ab07.

 * another commit on top of 'master' that renames "uscc_261" to
   "uscc_266" with some modifications; the contents after the
   modification is 3f71e11.

 * 'dev' that is a child of the above, which again renames it to a
   name without "uscc" in it, whose contents is 4f19f66.

As the .apk file is binary that cannot be merged textually, it is
perfectly fine for "cherry-pick dev" to leave the index unmerged.
The index has

    f98ab07 at uscc_261, stage #2 (ours)
    3f71e11 at uscc_266, stage #1 (common)
    4f19f66 at the name in 'dev', stage #3 (theirs)

which is perfectly expected.

In the working tree, we see 

    "uscc_261" with contents f98ab07 (i.e. "ours")
    a file with the name in 'dev', with contents f98ab07

The latter is unexpected to me.



 
