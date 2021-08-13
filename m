Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D9CFC4338F
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 20:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDCDD610CF
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 20:14:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234079AbhHMUPP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Aug 2021 16:15:15 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54906 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234457AbhHMUPO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Aug 2021 16:15:14 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9A7D5DF8C7;
        Fri, 13 Aug 2021 16:14:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OJ+BAHP8Bbe2xjhZT0Mxa/lVIrjmyeO2dE8fA8
        GStFc=; b=df6jqsuEXafpSpcvm8anbENqjwS39Zw2shUoM/mcp1DAYfAWzoN5tY
        konwiNGl71L55oIhzlyeN4pjEitKS2nJClllcIC2fwYqMupdXGV2KFZrp5h7glRK
        ntrD0jDa6nC7MV56fLuvCVLf7bV7HqrMmdbImBboiBe0/rcdwDLrQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8F4E8DF8C6;
        Fri, 13 Aug 2021 16:14:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DDFF8DF8C5;
        Fri, 13 Aug 2021 16:14:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnI=?= =?utf-8?B?w7A=?= Bjarmason 
        <avarab@gmail.com>, Han-Wen Nienhuys <hanwen@google.com>,
        Ramkumar Ramachandra <artagnon@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH v3] [GSOC] cherry-pick: use better advice message
References: <pull.1010.v2.git.1627953383.gitgitgadget@gmail.com>
        <pull.1010.v3.git.1628142482640.gitgitgadget@gmail.com>
        <a510722c-d5a2-f00c-dd20-dd7f76da2408@gmail.com>
Date:   Fri, 13 Aug 2021 13:14:44 -0700
In-Reply-To: <a510722c-d5a2-f00c-dd20-dd7f76da2408@gmail.com> (Phillip Wood's
        message of "Wed, 11 Aug 2021 11:00:32 +0100")
Message-ID: <xmqqzgtlumob.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1A66980C-FC73-11EB-89CA-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

>> +++ b/t/t3507-cherry-pick-conflict.sh
>> @@ -53,9 +53,12 @@ test_expect_success 'advice from failed cherry-pick' "
>>   	picked=\$(git rev-parse --short picked) &&
>>   	cat <<-EOF >expected &&
>
> If you quote the here doc end marker then there is no substitution in
> the here doc so writing
>
> 	cat <<-\EOF >expected &&
>
>>   	error: could not apply \$picked... picked
>> -	hint: after resolving the conflicts, mark the corrected paths
>> -	hint: with 'git add <paths>' or 'git rm <paths>'
>> -	hint: and commit the result with 'git commit'
>> +	hint: Resolve all conflicts manually, mark them as resolved with
>> +	hint: \"git add/rm <conflicted_files>\", then run
>
> means you can replace \" with " here

Hmph, actually the double-quote that opens the body of
test_expect_success should be stared at with a very cautious eyes,
as they often do not mean what the author of the patch thought they
do.  I can see that it already fooled your eyes into thinking that
there is no substitution, but $picked needs to be substituted into
its value.  The backslash before it is *not* about guarding it from
substitution inside here-doc; it is to pass literal "$" into the
string, which is the last parameter to test_expect_success, that
gets eval'ed.

The original of this one, for example, would probably have been
better if written like so:

test_expect_success 'advice from failed cherry-pick' '
	pristine_detach initial &&
	SQ='\'' &&

	picked=$(git rev-parse --short picked) &&
	cat <<-EOF >expected &&
	error: could not apply $picked... picked
	hint: after resolving the conflicts, mark the corrected paths
	hint: with ${SQ}git add <paths>${SQ} or ${SQ}git rm <paths>${SQ}
	hint: and commit the result with ${SQ}git commit${SQ}
	EOF
	test_must_fail git cherry-pick picked 2>actual &&

	test_cmp expected actual
'

And because there is no single quote in the updated text, it would
become:

test_expect_success 'advice from failed cherry-pick' '
	pristine_detach initial &&

	picked=$(git rev-parse --short picked) &&
	cat <<-EOF >expected &&
	error: could not apply $picked... picked
	hint: Resolve all conflicts manually, mark them as resolved with
	hint: "git add/rm <conflicted_files>", then run
	EOF
	test_must_fail git cherry-pick picked 2>actual &&

	test_cmp expected actual
'

which makes it far easier to see that $picked needs to be
substituted, and the "git add/rm" are to be enclosed in dq pair.
