Return-Path: <SRS0=3T2S=5I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A0EAC10F26
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 05:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E15E8206F9
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 05:32:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rnKjrGQt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbgCWFcf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Mar 2020 01:32:35 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53405 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbgCWFcf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Mar 2020 01:32:35 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DB488573E9;
        Mon, 23 Mar 2020 01:32:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=p1i0ptngjfZDDAbljSnZiJT/zDk=; b=rnKjrG
        QthISf4OPf4xr3tu1ApTh2aII3vN19eHIae/vysR3lIxcUK1SbPtFliaDfyJHf5+
        kr2ivUhM3rIQ2SN2YI5N6mN3seZ3ubeGF/PtMFytCK8Ihf0ZXLOdoHY68poALonF
        jzzT+f4pd5acEbGzxsG+iyWPoe+oVH+KsuNDg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ADR1vXRjqULNf3AYLpK/fuEIchU/wvLU
        8suSkhZ93MUFRzrADzA/BXTAl6BYHie15GUXQqZB+erAKFdpm1hfkhg9MuviE9fV
        rmkMHRBNpx1yXejYyxFkfwnzNXeaF/d+4k/NmVKFN1XTVCbC8RNwLeeeoyWVlT+E
        QBDZVoBZU24=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D1E35573E8;
        Mon, 23 Mar 2020 01:32:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 58EC4573E5;
        Mon, 23 Mar 2020 01:32:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Abhishek Kumar <abhishekkumar8222@gmail.com>
Cc:     Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
        christian.couder@gmail.com
Subject: Re: [RFC][GSoC] Implement Generation Number v2
References: <20200322093526.GA4718@Abhishek-Arch> <86eetkrw8p.fsf@gmail.com>
        <20200323042517.GA1258@Abhishek-Arch>
Date:   Sun, 22 Mar 2020 22:32:32 -0700
In-Reply-To: <20200323042517.GA1258@Abhishek-Arch> (Abhishek Kumar's message
        of "Mon, 23 Mar 2020 09:55:17 +0530")
Message-ID: <xmqq369z7i1b.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B24B9916-6CC7-11EA-BE63-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Abhishek Kumar <abhishekkumar8222@gmail.com> writes:

>> Unfortunately for the time being we cannot use commit-graph format
>> version; the idea that was proposed on the mailing list (when we found
>> about the bug in handling commit-graph versioning, during incremental
>> commit-graph implementation), was to create and use metadata chunk or
>> versioning chunk (the final version of incremental format do not use
>> this mechanism).  This could be used by gen2 compatibile Git to
>> distinguish between situation where old commit-graph file to be updated
>> uses generation number v1, and when it uses v2.
>> 
>> If you have a better idea, please say so.
>
> We could also use a flag file. Here's how it works:
>
> If the file `.git/info/generation-number-v2` exists, use gen2.
> Otherwise use gen1.

If the file is lost then we will try to read the other file that has
the commit-graph data as if it were in old format?  And if such a
file was created (say, with "touch .git/info/generation-number-v2"),
a file in the original format will be read as if it is in new
format?  If that is the case, it is likely that we'd see a segfault;
sounds too brittle to me.

It appears that the format of "CDAT", and the fact that generation
is represented as higher 30-bit of a be32 integer, is very much
hardcoded in the design and is hard to change, but your new version
of graph file can be designed not to use "CDAT" chunk at all, and
instead have the commit data with new version of generation numbers
stored in a different chunk (say "CDA2") to force older version of
Git not to use the new graph file---would that work?
