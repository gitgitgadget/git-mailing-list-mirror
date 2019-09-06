Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 366CD1F461
	for <e@80x24.org>; Fri,  6 Sep 2019 21:46:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404397AbfIFVq0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Sep 2019 17:46:26 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64474 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391501AbfIFVq0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Sep 2019 17:46:26 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E757C33598;
        Fri,  6 Sep 2019 17:46:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9EKF6xYO7qip3xADGjJBlAkav6k=; b=t0NXd6
        jKMbzDHk7e6I4anr2z091O/L26NtzTwvNoNQUr6RscX11MnBbLvZgxEXBAU6i0LX
        1FkcMixZpr9w5bCUu1VMQYFwOlOCKEAtai8EEzqZubVG001BhDltM2KumPsa42g5
        TAQW5p+QLAnYbdqduACH9F1Kq9jMZNO9R8m/k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xQa4sar4y+s4R2Wf0Y93qHu6L/Xer3Tn
        CQOcnuoSqIwJvUF+d0K3krtY8Qoyy9MFH3u1K19lQO+bVlAQsTQLnOcqd87VFyjG
        bNpltoBrF0HdqECVP8/6HzEADroR0jpwGeQSSZM/F1lT3iCjS6/lL8V0SBpl+GBU
        aq71VRozvV8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DFBAB33597;
        Fri,  6 Sep 2019 17:46:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 54AC233596;
        Fri,  6 Sep 2019 17:46:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, peff@peff.net, avarab@gmail.com,
        garimasigit@gmail.com, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/1] fetch: add fetch.writeCommitGraph config setting
References: <pull.328.git.gitgitgadget@gmail.com>
        <49f877c85ca2be5bb76d9082ee4aa26e26111a14.1567477320.git.gitgitgadget@gmail.com>
        <xmqqef0xtd3p.fsf@gitster-ct.c.googlers.com>
        <d550ac23-cb65-b547-d9dc-1428ee2e9420@gmail.com>
Date:   Fri, 06 Sep 2019 14:46:22 -0700
In-Reply-To: <d550ac23-cb65-b547-d9dc-1428ee2e9420@gmail.com> (Derrick
        Stolee's message of "Tue, 3 Sep 2019 19:36:48 -0400")
Message-ID: <xmqqlfv1m72p.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C51399AA-D0EF-11E9-BDB4-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

>>> +		write_commit_graph_reachable(get_object_directory(),
>>> +					     commit_graph_flags,
>>> +					     &split_opts);
>>> +	}
>> 
>> As a low-impact change this is good.  
>> 
>> For longer term, it feels a bit unfortunate that this is still a
>> separate phase of the program, though.  We know what new refs we
>> added, we know what new objects we received, and we even scanned
>> each and every one of them while running the index-pack step to
>> store the .pack and compute the .idx file, i.e. it feels that we
>> have most of the information already in-core to extend the commit
>> graph for new parts of the history we just received.
>
> You're right that we could isolate the new write to the refs we
> just received. We could use the more cumbersome write_commit_graph()
> method with a list of commit oids as starting points. I'm happy to
> make that change if we see a lot of value there.

Well, that is not the kind of information reuse I am talking about.

I was wondering if "index-pack" has enough information in-core after
it receives and processes the incoming pack data, scanned each and
every object in it, in order to write out the commit graph _without_
having to do a lot of duplicate computation and enumeration of the
objects done in the current commit-graph.c::write_commit_graph(), so
that it can learn a "--write-commit-graph" option that performs much
better than running "git fetch && git commit-graph write".

Perhaps that would require too much refactoring of both index-pack
and commit-graph code and infeasible in short to medium term and
that is why I said "for longer term, it feels a bit unfortunate".

Thanks.
