Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DACF7C433EF
	for <git@archiver.kernel.org>; Tue,  1 Feb 2022 23:27:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242871AbiBAX1b (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Feb 2022 18:27:31 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63232 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242864AbiBAX1a (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Feb 2022 18:27:30 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7D808170F6A;
        Tue,  1 Feb 2022 18:27:30 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lnunEDAiJIQbdEYgX9P4WMmjh7DgCoNSbSZtfr
        WEtA0=; b=pEE9wFV3on4NuNhTUwClOy/RTH0SpqD+YZQrjKJvZLOCAt7/euxzpg
        eYw3bJpcM3U3fNNCxOBNqF3agCk0bsSf2UhezMigIdwOCVYK9k33yRJIpJoEBdLF
        7Wk9AWt68RUWNlFB+ZDkqnT4h7Mcyc3YtK9mIeY2gCgU0sTOXlbPo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 746B0170F69;
        Tue,  1 Feb 2022 18:27:30 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E37C8170F68;
        Tue,  1 Feb 2022 18:27:27 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Chen BoJun <bojun.cbj@gmail.com>
Cc:     git@vger.kernel.org, Chen Bojun <bojun.cbj@alibaba-inc.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Teng Long <dyroneteng@gmail.com>
Subject: Re: [PATCH v2] receive-pack: purge temporary data if no command is
 ready to run
References: <pull.1124.git.1642987616372.gitgitgadget@gmail.com>
        <20220129063538.24038-1-bojun.cbj@gmail.com>
        <xmqqczk6b3pt.fsf@gitster.g>
Date:   Tue, 01 Feb 2022 15:27:25 -0800
In-Reply-To: <xmqqczk6b3pt.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
        01 Feb 2022 14:51:26 -0800")
Message-ID: <xmqqk0ee9nhe.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 84F37E68-83B6-11EC-BFD5-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> index 9f4a0b816c..a0b193ab3f 100644
>> --- a/builtin/receive-pack.c
>> +++ b/builtin/receive-pack.c
>> @@ -1971,6 +1971,15 @@ static void execute_commands(struct command *commands,
>>  		return;
>>  	}
>
> With the new logic, "return;" we see above becomes unnecessary.  I
> wonder if it is a good idea to keep it or remove it.

I think it makes the code easier to maintain to keep the above
"return;".  There may be some code added in the future right here,
before the final "if no ref updates succeeds, leave early" this
patch adds, and it is unlikely we would want to run it when
pre-receive rejects the push.

IOW, this part of the patch that did not touch the above "return;"
is just fine as-is.

Thanks.
