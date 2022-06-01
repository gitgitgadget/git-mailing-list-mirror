Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24511C433EF
	for <git@archiver.kernel.org>; Wed,  1 Jun 2022 20:46:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbiFAUqX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jun 2022 16:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbiFAUpz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jun 2022 16:45:55 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 607491E7ACB
        for <git@vger.kernel.org>; Wed,  1 Jun 2022 13:36:04 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 713291A7472;
        Wed,  1 Jun 2022 14:55:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+9VU75eF9xeN77b2S9nlRWMAAvq8WcCkLWs3DZ
        lFqms=; b=jbVzBlgWtguw2LV1T1iQpTVoSzVK+zPLHKgCGm6HQdVdRsgiKIr8Vc
        0oxkIFwAfLh9/GbPlEJ7aALgWKDJIyZ7NQkypXPtuFhWfGID+EMMop7ctbEnjz0v
        f/P7s5QgWbMs8Vc1IGxsqGKn9mJHezm9Q6tWH1ZzlkSm9A8f/sIpU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 550561A7471;
        Wed,  1 Jun 2022 14:55:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id EE8481A7470;
        Wed,  1 Jun 2022 14:55:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH v2 4/6] parse-options.c: use optbug() instead of BUG()
 "opts" check
References: <cover-0.5-00000000000-20220521T170939Z-avarab@gmail.com>
        <cover-v2-0.6-00000000000-20220531T164806Z-avarab@gmail.com>
        <patch-v2-4.6-47d384d0ae5-20220531T164806Z-avarab@gmail.com>
        <YpZSrNM/bZ3i6Yvu@google.com>
Date:   Wed, 01 Jun 2022 11:55:36 -0700
In-Reply-To: <YpZSrNM/bZ3i6Yvu@google.com> (Josh Steadmon's message of "Tue,
        31 May 2022 10:38:52 -0700")
Message-ID: <xmqqczfsrz6f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6D082324-E1DC-11EC-AD24-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

>> +			if (!opts->ll_callback) {
>> +				optbug(opts, "OPTION_LOWLEVEL_CALLBACK needs a callback");
>> +				break;
>> +			}
>> +			if (opts->callback) {
>> +				optbug(opts, "OPTION_LOWLEVEL_CALLBACK needs no high level callback");
>> +				break;
>> +			}
>>  			break;
>
> A minor point, but I'm not sure I understand why we're adding breaks for
> the two cases above. In the OPTION_CALLBACK case, the if conditions are
> mutually exclusive and are followed by an unconditional break, so adding
> additional breaks seems unnecessary.

Yeah, good thinking.  

> For the OPTION_LOWLEVEL_CALLBACK
> case, the conditions are not mutually exclusive, but isn't this exactly
> the issue that optbug() is intended to address? I.e., wouldn't the
> caller want to see both optbug()s if both are relevant?

Exactly.

Thanks for a careful reading.
