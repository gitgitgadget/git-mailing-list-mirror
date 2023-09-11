Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D83EEE57DF
	for <git@archiver.kernel.org>; Mon, 11 Sep 2023 06:11:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234355AbjIKGLx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Sep 2023 02:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232144AbjIKGLx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Sep 2023 02:11:53 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D40E3100
        for <git@vger.kernel.org>; Sun, 10 Sep 2023 23:11:48 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 31FDE1BD781;
        Mon, 11 Sep 2023 02:11:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=ICAl0qEQ8VuzWSEygxZxwJg4wcm9Qyhs2T6ijP
        AY+Sw=; b=l5Vyy6FDMfF5o/OpNoMHS/ueZwHvTiApSAHBtce8KAZGEi9W8K91SC
        u0bXgdH38FGLCbmfzYmcnEhUZ1XTt5jode/CnxA56kLfxATtpqtEadJs9/RuNZJ3
        MJYZWvTHzKtVyvNIXEX1dYqknf+qSe4nEgiAXv2OsTcdTJwj4DdsI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2A8021BD780;
        Mon, 11 Sep 2023 02:11:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 915AA1BD77F;
        Mon, 11 Sep 2023 02:11:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>, git@vger.kernel.org
Subject: Re: [PATCH 02/32] doc hash-function-transition: Replace
 compatObjectFormat with compatMap
In-Reply-To: <ZP3UCQf+9D/J3wqT@tapette.crustytoothpaste.net> (brian
        m. carlson's message of "Sun, 10 Sep 2023 14:34:49 +0000")
References: <87sf7ol0z3.fsf@email.froward.int.ebiederm.org>
        <20230908231049.2035003-2-ebiederm@xmission.com>
        <ZP3UCQf+9D/J3wqT@tapette.crustytoothpaste.net>
Date:   Sun, 10 Sep 2023 23:11:46 -0700
Message-ID: <xmqqy1hdi6hp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 16E81FB4-506A-11EE-A699-25B3960A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

>> +Documentation/technical/repository-version.txt) with the extension
>> +`objectFormat`, and an optional core.compatMap configuration.
>>  
>>  	[core]
>>  		repositoryFormatVersion = 1
>> +		compatMap = on
>>  	[extensions]
>>  		objectFormat = sha256
>> -		compatObjectFormat = sha1
>
> While I'm in favour of an approach that uses the compat map, the
> situation we've implemented here doesn't specify the extra hash
> algorithm.  We want this approach to work just as well for moving from
> SHA-1 to SHA-256 as it might for a future transition from SHA-256 to,
> say, SHA-3-512, if that becomes necessary.
>
> Making a future transition easier has been a goal of my SHA-256 work
> (because who wants to write several hundred patches in such a case?), so
> my hope is we can keep that here as well by explicitly naming the
> algorithm we're using.
>
> I also wonder if an approach that doesn't use an extension is going to
> be helpful.  Say, that I have a repository that is using Git 3.x, which
> supports interop, but I also need to use Git 2.x, which does not.  While
> it's true that Git 2.x can read my SHA-256 repository, it won't write
> the appropriate objects into the map, and thus it will be practically
> very difficult to actually use Git 3.x to push data to a repository of a
> different hash function.  We might well prefer to have Git 2.x not work
> with the repository at all rather than have incomplete data preventing
> us from, well, interoperating.

Very sensible line of thought and suggestion to move the topic
forward.  Very much appreciated.

