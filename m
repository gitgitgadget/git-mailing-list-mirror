Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 719161F462
	for <e@80x24.org>; Thu, 25 Jul 2019 22:50:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfGYWua (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jul 2019 18:50:30 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56500 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbfGYWu3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jul 2019 18:50:29 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 851C016EA57;
        Thu, 25 Jul 2019 18:50:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rThcEbFwmXf0LbiB5OzSvwb1U6s=; b=j/sRbz
        N0HKiQ2V77i2FPqppKMeihfTHkf4xuiZl3n2GRYLvCrfBUB1iXeKYV2Vfag2i86b
        0ThLeQKim/4U6YEkNFSM/QbuOtZNX83zu6/sa+UdJbiov3VHoZYOFv5deizUbhDz
        c28b7bunilWccWeYKPXNO4lK/7nzxGASFwt6M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hQmMc9+h3UHTyFCM6xbltkwIh2kA5WVl
        Du7SJNIhdph4Z2aGIcrdruIuyrWamOaruzUyc7doehJev4kLt3dcaHFGQBJmEB/x
        3u7bqc0BZ3YOikqDkZZ9dv1AWxIto5uFq+xuBg04cNwWvdoihyrM6slfxrnakP7h
        FW8QDKpQc6o=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7C64216EA56;
        Thu, 25 Jul 2019 18:50:27 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DDC6C16EA55;
        Thu, 25 Jul 2019 18:50:26 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 00/19] Cleanup merge API
References: <20190725174611.14802-1-newren@gmail.com>
        <xmqqblxioufc.fsf@gitster-ct.c.googlers.com>
        <CABPp-BGkGch-ebOrJTprw3oGgubgZyyVBCCM30VLbC24BU+MUQ@mail.gmail.com>
Date:   Thu, 25 Jul 2019 15:50:25 -0700
In-Reply-To: <CABPp-BGkGch-ebOrJTprw3oGgubgZyyVBCCM30VLbC24BU+MUQ@mail.gmail.com>
        (Elijah Newren's message of "Thu, 25 Jul 2019 12:06:25 -0700")
Message-ID: <xmqq7e85pw3y.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 98403DBC-AF2E-11E9-979D-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Thu, Jul 25, 2019 at 11:12 AM Junio C Hamano <gitster@pobox.com> wrote:
>
>> > Stuff I'd most welcome review on:
>> >   * Is cache-tree.c the right place for write_tree_from_memory()?
>> >     [see patch 7]  Should there be docs on how it differs from
>> >     write_index_as_tree(), already found in cache-tree?  What does
>> >     the latter even do?
>>
>> write_index_as_tree() is supposed to write the contents of an index
>> state as a tree object, and return the object ID for the resulting
>> tree.  It is the primary interface designed to be used by
>> write-tree.
>
> Other than the last sentence, that also sounds like the description of
> write_index_as_tree() -- at least as best I understood it.

Yes, I didn't even know merge-recursive had its own variant.  I
suspect that back when "merge-recursive in C" was being developed,
it first used "git write-tree" via run_command(), and then just
copied and pasted what was done in the write-tree implementation
without bothering to refactor it into write_index_as_tree() and its
own bits about the unmerged index.

