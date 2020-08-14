Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD934C433DF
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 00:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 408582078B
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 00:50:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="iGUTKfmx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726570AbgHNAuf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Aug 2020 20:50:35 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56523 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbgHNAue (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Aug 2020 20:50:34 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9179879319;
        Thu, 13 Aug 2020 20:50:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Wce6C4pZKpc1
        6N8JmpQGL0HTqFw=; b=iGUTKfmx/MuXyYZ7+Wx9iCa92i8j2t4RRFV0WUA93o/B
        ParuuyXKqjQGV52NQuuU2wtJCq/1olkrv4u7J4P0X/wcUgECOUkfxVldHbmjWqNX
        sEbmvw54buE4Ko9NLeAEdDW3fVY+lb2iYvcNJtvgcLSu7Z9yREeDd4tG0j9l4fY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=noZ7gC
        UVitOo26bgg2ugesF5+9BbLkKnNs6kOLm1uQggtFSApHPoZSUkO4Truf7Z5t+nsy
        2d310+YLt+i7XxpuUmN5+9KLs61GGYLmGaWX7yd1y5a6B6FS5Ejwa/9ng7xvGCYq
        GnQa/cAb/Vs0IKV8z3OKvPSmGOszqqvU+NnfI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8AAC679318;
        Thu, 13 Aug 2020 20:50:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1811779317;
        Thu, 13 Aug 2020 20:50:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 1/2] revision: differentiate if --no-abbrev asked explicitly
References: <cover.1596887883.git.congdanhqx@gmail.com>
        <cover.1597364493.git.congdanhqx@gmail.com>
        <9a26c5b6110081cd8d029f2ab0327c4a1d228ef7.1597364493.git.congdanhqx@gmail.com>
Date:   Thu, 13 Aug 2020 17:50:31 -0700
In-Reply-To: <9a26c5b6110081cd8d029f2ab0327c4a1d228ef7.1597364493.git.congdanhqx@gmail.com>
        (=?utf-8?B?IsSQb8OgbiBUcuG6p24gQ8O0bmc=?= Danh"'s message of "Fri, 14 Aug
 2020 07:23:09 +0700")
Message-ID: <xmqq8sei125k.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 27EB6A36-DDC8-11EA-B47B-01D9BED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh  <congdanhqx@gmail.com> writes=
:

> When we see --no-abbrev in command's arguments, we reset the 'abbrev'
> field in diff-options to 0 and this value will be looked at
> diff_abbrev_oid() to decide not to truncate the object name.
>
> In a later change, we want to extend --abbrev support to diff-patch
> format. When --abbrev supporting diff-patch, we need to differentiate
> those below scenarios:
>
> * None of those options --abbrev, --no-abbrev, and --full-index are
>   asked. diff-patch should keep old behavior of using DEFAULT_ABBREV
>   for the index length.
> * --no-abbrev is asked, diff-patch should treat this option as same as
>   --full-index and show full object name in index line.

Sorry, but are you saying that the above two cases cannot be
differentiated in the current code?

 * If none of --abbrev, --no-abbrev, --full-index are given, then
   diff.c::prep_parse_options() will leave options->flags.full_index
   and options->abbrev untouched.  They are initialized to false and
   DEFAULT_ABBREV (typically -1 when unconfigured).

 * If --no-abbrev is given, options->abbrev is set to 0.
   options->flags.full_index is not touched.

So you should be able to tell these two apart by only looking at
options->flags.full_index bit.  Perhaps, even though you said "we
need to differentiate", you meant something else?

> While not doing anything is very effective way to show full object id,
> we couldn't differentiate if --no-abbrev or not.

Hmph.  --no-abbrev without --full-index would not set
flags.full_index bit; using --full-index would set the bit.  Are you
planning to do something special when BOTH --no-abbrev and --full-index
is given?  I am confused X-<.

