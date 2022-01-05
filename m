Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C499C433EF
	for <git@archiver.kernel.org>; Wed,  5 Jan 2022 19:47:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243655AbiAETrT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jan 2022 14:47:19 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57919 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243651AbiAETrT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jan 2022 14:47:19 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5BCB1FF799;
        Wed,  5 Jan 2022 14:47:18 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hnTgPQjmohJIY44fraBbeM/Q6Kbrn8p+J58iiO
        n4fJI=; b=vVJlm4sf8oT99/QoiceA4AeJINVDrU75epU/A4X94+u4viRrmib2OQ
        IhM0BSE1BPBedTdqNK+iZPYz4ZHiFaEU6E4U0g13wCJeSPkl58a8h/I0FwVtHpXW
        /kA4hsbLLBAPKug46Yai8J2EHA+0G0+0sr3tf1wOnUfD4a77Co1GI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 50FE5FF798;
        Wed,  5 Jan 2022 14:47:18 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 756A5FF797;
        Wed,  5 Jan 2022 14:47:17 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v4 1/2] name-rev: deprecate --stdin in favor of
 --annotate-stdin
References: <pull.1171.v3.git.git.1641221261.gitgitgadget@gmail.com>
        <pull.1171.v4.git.git.1641307776.gitgitgadget@gmail.com>
        <4e9200922a4c2c91e69e3b497fbf4c8702046a27.1641307776.git.gitgitgadget@gmail.com>
        <16666d32-833a-f3d7-351a-eeef7f25b002@gmail.com>
Date:   Wed, 05 Jan 2022 11:47:16 -0800
In-Reply-To: <16666d32-833a-f3d7-351a-eeef7f25b002@gmail.com> (Phillip Wood's
        message of "Wed, 5 Jan 2022 11:15:57 +0000")
Message-ID: <xmqqr19mhsmz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 49C22FBC-6E60-11EC-8D01-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

>> @@ -613,8 +622,8 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
>>   	for_each_ref(name_ref, &data);
>>   	name_tips();
>>   -	if (transform_stdin) {
>> -		char buffer[2048];
>> +	if (annotate_stdin) {
>> +		struct strbuf sb = STRBUF_INIT;
>
> I think this hunk belongs in the next patch. Before posting a patch
> series I find it helpful to run
>
>     git rebase --keep-base -x'make -j4 git && cd t && prove -j4 <tests
>     I think might fail> :: --root=/dev/shm'
>
> to check that the individual patches compile and pass the relevant
> tests. I've never got round to trying it but git-test[1] also lets you 
> test all the commits in a series

Ahh, I saw and pointed out exactly the same mistake in an earlier
round, but failed to spot it this time around.  Thanks for spotting.
