Return-Path: <SRS0=YePV=76=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_SBL,URIBL_SBL_A autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8842C433E0
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 21:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83FA421841
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 21:17:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jrgocJIf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbgFQVRF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Jun 2020 17:17:05 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52519 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726906AbgFQVRD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jun 2020 17:17:03 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CC3977D8F2;
        Wed, 17 Jun 2020 17:17:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9S6m2v1AbLPVKRjdOS7vCS6mzKg=; b=jrgocJ
        IfWNQwIRZCUneXsonlTw+L6Bt/iIxrRtsJZQt6Pq/ejbI2WPTUvIhFvfnbkcrlXO
        INIrSTLnDyJTLUz9aFtwWicveEKbx2LRypigjEgBGLBjhvaakHMmC0AnMLexDEvr
        iHgQ6T1scZtXNXl5UYJyQzUucX98Xs8rE4cW0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JPeeoTQ8blVvro0cVzSg1Og9JBC6Gdai
        Dv6e2gRKsO9c8BMhymKAIal62nmeyvcnWk9GpUi6ULa8e7HsAUZ2yczMO+fW3JKu
        BMQ/pXUIYZuSkHDvVJSM72RwED4UFoilb7M+eMHKjMi8diRxXe9UkAEV5nMXyP3V
        H2O/8zPMKeE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AC01E7D8F1;
        Wed, 17 Jun 2020 17:17:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C90FC7D8F0;
        Wed, 17 Jun 2020 17:16:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, don@goodman-wilson.com, stolee@gmail.com,
        peff@peff.net, sandals@crustytoothpaste.net,
        Matt Rogers <mattr94@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 02/12] fmt-merge-msg: introduce a way to override the main branch name
References: <pull.656.git.1591823971.gitgitgadget@gmail.com>
        <pull.656.v2.git.1592225416.gitgitgadget@gmail.com>
        <f4d547391537e5c3b0b4a07adb41b6aa56541fc3.1592225416.git.gitgitgadget@gmail.com>
        <1612660e-aa49-5d7f-d47e-34740e330eaa@kdbg.org>
Date:   Wed, 17 Jun 2020 14:16:59 -0700
In-Reply-To: <1612660e-aa49-5d7f-d47e-34740e330eaa@kdbg.org> (Johannes Sixt's
        message of "Wed, 17 Jun 2020 22:56:18 +0200")
Message-ID: <xmqqmu51s88k.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E1AA6046-B0DF-11EA-A5C6-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> Am 15.06.20 um 14:50 schrieb Johannes Schindelin via GitGitGadget:
>> @@ -451,10 +451,12 @@ static void fmt_merge_msg_title(struct strbuf *out,
>>  			strbuf_addf(out, " of %s", srcs.items[i].string);
>>  	}
>>  
>> -	if (!strcmp("master", current_branch))
>> +	main_branch = git_main_branch_name();
>> +	if (!strcmp(main_branch, current_branch))
>>  		strbuf_addch(out, '\n');
>>  	else
>>  		strbuf_addf(out, " into %s\n", current_branch);
>> +	free(main_branch);
>>  }
>
> Now that the removal of this special case is on the plate, I would
> prefer that the phrase "into foo" is never appended instead of always
> appended.

I do not mind such an optional feature.  I always find it useful
whenever I read "git log --oneline --first-parent master..pu" (of
course I have an alias for that) to see which topics are already in
my private "to be used in real life" edition, so I would oppose to
an unconditional removal, though.

