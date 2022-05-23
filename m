Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00FCAC433EF
	for <git@archiver.kernel.org>; Mon, 23 May 2022 20:09:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232381AbiEWUJu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 May 2022 16:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiEWUJs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 May 2022 16:09:48 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F32F1980B1
        for <git@vger.kernel.org>; Mon, 23 May 2022 13:09:47 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7F2F8183475;
        Mon, 23 May 2022 16:09:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=i/h3djgLY3fAwJOVrDnNb9eJezWa7JgZ7FA1j4
        lcoXs=; b=jHJp1DsnH/IemxbhG+pgk401VlnkrGhJ1AoTP6MKjKgFyucm9fF357
        JTrUlmp+vWvl0wXISlzxZrL3nqAKltU01giDwwWsDKOd4tN2A43s2q87sXPDjVHd
        m7PgjHbJygtlCT4nimbrM4ShMBFdT3CjlJz838yY7WEXhZLFYAcW0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7891A183474;
        Mon, 23 May 2022 16:09:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id EE88D183473;
        Mon, 23 May 2022 16:09:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     git@vger.kernel.org, avarab@gmail.com
Subject: Re: ds/bundle-uri (was Re: What's cooking in git.git (May 2022,
 #06; Fri, 20))
References: <xmqqmtfbcoaa.fsf@gitster.g>
        <a467d972-85a6-f4b0-7ec7-184add308e25@github.com>
Date:   Mon, 23 May 2022 13:09:42 -0700
In-Reply-To: <a467d972-85a6-f4b0-7ec7-184add308e25@github.com> (Derrick
        Stolee's message of "Sat, 21 May 2022 14:07:14 -0400")
Message-ID: <xmqqh75gqad5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4955D142-DAD4-11EC-ABE1-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> On 5/21/22 3:55 AM, Junio C Hamano wrote:
>
>> * ds/bundle-uri (2022-05-20) 32 commits
>>  - t5601: basic bundle URI tests
>>  - clone: unbundle the advertised bundles
>>  - bundle-uri: download bundles from an advertised list
>>  - bundle-uri: allow relative URLs in bundle lists
>>  - bundle-uri client: add boolean transfer.bundleURI setting
>>  - bundle-uri: serve URI advertisement from bundle.* config
>>  - bundle-uri client: add "git ls-remote-bundle-uri"
>>  - bundle-uri client: add minimal NOOP client
>>  - protocol v2: add server-side "bundle-uri" skeleton
>>  - bundle-uri: fetch a list of bundles
>>  - bundle-uri: parse bundle list in config format
>>  - bundle-uri: limit recursion depth for bundle lists
>>  - bundle-uri: unit test "key=value" parsing
>>  - bundle-uri: create "key=value" line parsing
>>  - bundle-uri: create base key-value pair parsing
>>  - bundle-uri: create bundle_list struct and helpers
>>  - clone: --bundle-uri cannot be combined with --depth
>>  - clone: add --bundle-uri option
>>  - fetch: add 'refs/bundle/' to log.excludeDecoration
>>  - fetch: add --bundle-uri option
>>  - bundle-uri: add support for http(s):// and file://
>>  - bundle-uri: create basic file-copy logic
>>  - remote-curl: add 'get' capability
>>  - docs: document bundle URI standard
> ...
>>  source: <pull.1234.git.1653072042.gitgitgadget@gmail.com>
>
> These patches are for the combined bundle URI RFC. I
> appreciate that you're tracking them, but they aren't ready
> for full review, since they are missing a lot of tests.
> First, we need to establish that the overall design is a
> good approach. After that consensus is reached, I expect
> that this series to be split into several parts that are
> more manageable to review bit-by-bit. 

Split the above into a separate topic; thanks.
