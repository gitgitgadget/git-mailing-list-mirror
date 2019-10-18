Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B78271F4C0
	for <e@80x24.org>; Fri, 18 Oct 2019 00:50:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438788AbfJRAuH (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Oct 2019 20:50:07 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57122 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409167AbfJRAuH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Oct 2019 20:50:07 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 01AF494113;
        Thu, 17 Oct 2019 20:50:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4IECmS7NnwO0+/1Qg/9NUUuD0pg=; b=Zqryaf
        fV7KPQA8ihh489F3SL665kNh68qAYEl5UAevCdbCHYAjZa4SM3GnSue2VNh98PdA
        x8AunU325YWkhYdYTKc/Hz17Al1ar5FsOm/hTZGSehSBv6DmSU5CnZgU8judJpBQ
        Uym1pG6CRP96DDL5kEMb8+Rp4bESZPVTY1F1E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xXy2lqAFKvN5wjeSky00S4wJJdONoSl7
        IPaqqBQMjAqx2rJz0N76i3gWdzUR3azjUbYKrk+cVOI1OqR6aSQETOeZCyPLGCUm
        IQ4oCHx0+JO6C/roV++iaqHYZ8RFjBljIK80i+5tlSedTsBitXV0FrD+B10cY80S
        3aOjfwBpT64=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id ED73C94112;
        Thu, 17 Oct 2019 20:50:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id DEB9D9410F;
        Thu, 17 Oct 2019 20:50:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     James Coglan via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, James Coglan <jcoglan@gmail.com>
Subject: Re: [PATCH v3 08/13] graph: tidy up display of left-skewed merges
References: <pull.383.v2.git.1571182864.gitgitgadget@gmail.com>
        <pull.383.v3.git.1571183279.gitgitgadget@gmail.com>
        <c34a5eb160310613cbde6313cda6cff753d6d7fd.1571183279.git.gitgitgadget@gmail.com>
        <xmqqsgnt8hlh.fsf@gitster-ct.c.googlers.com>
        <863fb1b9-8829-64db-d355-56a97e979427@gmail.com>
Date:   Fri, 18 Oct 2019 09:49:59 +0900
In-Reply-To: <863fb1b9-8829-64db-d355-56a97e979427@gmail.com> (Derrick
        Stolee's message of "Thu, 17 Oct 2019 08:34:56 -0400")
Message-ID: <xmqq5zkm7u88.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 379641B4-F141-11E9-B44F-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> I hit this very situation recently when I was experimenting with
> 'git fast-import' and accidentally created many parallel, independent
> histories. Running "git log --graph --all --simplify-by-decoration"
> made it look like all the refs were in a line, but they were not.
> (The one way I knew something was up: the base commits also appeared
> without a decoration. That was the only clue that the histories did
> not continue in a line.)
>
>> 
>> and the fact that B and A do not share parent-child relationships is
>> lost.  An easy way to show that would be to draw the bottom three
>> lines of the full history output we saw earlier:
>> 
>>     | * e6277a9 C
>>     | * 13ae9b2 B
>>     * afee005 A
>> 
>> either with or without the vertical bar to imply that A may have a
>> child.
> The natural extension of this would be multiple columns:
>
>  | | | | | *
>  | | | | *
>  | | | *
>  | | *
>  | *
>  *

After sleeping over it, I now think we shouldn't draw lines that
imply a child for each of these commits, as we haven't seen, but
I agree that this can be extended to 3 or more roots.

