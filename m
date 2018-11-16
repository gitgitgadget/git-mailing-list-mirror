Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 343BB1F97E
	for <e@80x24.org>; Fri, 16 Nov 2018 06:26:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbeKPQhJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Nov 2018 11:37:09 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61211 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727353AbeKPQhJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Nov 2018 11:37:09 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 74CF93CC54;
        Fri, 16 Nov 2018 01:26:05 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2uy3SldCteGpR5w+tca2WZYSDdk=; b=uulrjQ
        ZsX7BKzFY0sVaA8UKc9SEGoG33hNr/6KgpijYJ8BjL8qFUfFtOmriTSvdi/iMQnG
        TS0NsjJuXFbi03XUr90Jsxeudbx5Swdrc9aM0YJmjOO6OUSw56Uv9XpJJHLZkqWL
        eWapPOn2ght7ADVkdXtMuxCf7bYXrrX645vDQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KOX2wEj0YKHdwwA+4DrdRZblgFDhCrJO
        BHyT23LJSHiDhvY785m8aAumH3OCnDy6zKzIU2wasoYX3dXqOp2F3G6fXjE4t39F
        0K4QmA6EsVgrbo9s6tYa0rdP+GrA6fDsuLN412QI7qBXqGMVO2E/kJtBzmsb/4cg
        R31+rW81Bpg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6E5713CC53;
        Fri, 16 Nov 2018 01:26:05 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 819F73CC51;
        Fri, 16 Nov 2018 01:26:02 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Slavica Djukic <slavicadj.ip2018@gmail.com>
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org,
        slawica92@hotmail.com
Subject: Re: [PATCH v2 1/2] [Outreachy] t3903-stash: test without configured user.name and user.email
References: <20181114221218.3112-1-slawica92@hotmail.com>
        <20181114222524.2624-1-slawica92@hotmail.com>
        <xmqqsh01k1mr.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 16 Nov 2018 15:26:00 +0900
In-Reply-To: <xmqqsh01k1mr.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Fri, 16 Nov 2018 14:55:08 +0900")
Message-ID: <xmqqa7m9k07b.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7D744F78-E968-11E8-8FE8-F5C31241B9FE-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Now we start using use-config-only, so unsetting environment
> variables will cause trouble when Git insists on having an
> explicitly configured identities.  Makes sense.
>
>> +	(
>> +		sane_unset GIT_AUTHOR_NAME &&
>> +		sane_unset GIT_AUTHOR_EMAIL &&
>> +		sane_unset GIT_COMMITTER_NAME &&
>> +		sane_unset GIT_COMMITTER_EMAIL &&
>> +		test_unconfig user.email &&
>> +		test_unconfig user.name &&
>
> And then we try the same test, but without environment or config.

I suspect that it makes sense to replace the "git stash" we see
below with something like this:

	test_must_fail git commit -m should fail &&
	echo "git stash <git@stash>" >expect &&
	echo >2 &&
	git stash &&
	git show -s --format="%(authorname) <%(authoremail)>" refs/stash >actual &&
	test_cmp expect actual

That is

 - we make sure "commit" would not go through, to make sure our
   preparation to unset environment variables was sufficient;

 - we make sure "stash" does succeed (which is the primary thing you
   are interested in);

 - we make sure the resulting "stash" is not created under our
   default identity but under our fallback one.

>> +		git stash
>> +	)
>> +'
>> +
>>  test_done
