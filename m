Return-Path: <SRS0=Z/Vr=2I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B41C43603
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 18:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 928E721582
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 18:14:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="fMYoTYgc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727311AbfLRSO4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Dec 2019 13:14:56 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58556 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbfLRSO4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Dec 2019 13:14:56 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 04F40A7A8A;
        Wed, 18 Dec 2019 13:14:53 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1CPDHIb3mBVCW32lWTiZBc5tFUk=; b=fMYoTY
        gcMadzma4ifAFI0gcFiwxvDDa5qdAyw7nPA3uL7qikh5kfUn4748nlIoWiQPsgEZ
        5vpFMxAVuS1nhszA1fXerX44vOAmuYaWrj+0tIqzo2KwGjE9laX/+A8qCuxBnrWs
        TElxPrvTw8FXvP/2pP6GBbvmlMnZyrvhIg7yY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ovOu5P35/nS/2ffSGU8jpZ11zZg5Ceok
        m+NX1kviOO/2I1UBZDMg8KExTUD/60AJJ3nBPmH2iNngNPR9luNQSSC2sVXZDh+m
        YTlEej21pZJYDPnBmY4yRhcn8RqutWgr8cNMPZ3lvsWxzRhpx8vdQak7GuGA7QF+
        Gmnwx80CSoc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F1678A7A89;
        Wed, 18 Dec 2019 13:14:52 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 23546A7A88;
        Wed, 18 Dec 2019 13:14:49 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     gitgitgadget@gmail.com, git@vger.kernel.org, heba.waly@gmail.com
Subject: Re: [PATCH 1/1] commit: display advice hints when commit fails
References: <f23477c5a32e5d638310024194040146026972b8.1576574242.git.gitgitgadget@gmail.com>
        <20191218031338.203382-1-jonathantanmy@google.com>
Date:   Wed, 18 Dec 2019 10:14:47 -0800
In-Reply-To: <20191218031338.203382-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Tue, 17 Dec 2019 19:13:38 -0800")
Message-ID: <xmqqo8w5ec14.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 47E23E90-21C2-11EA-9BFC-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>> From: Heba Waly <heba.waly@gmail.com>
>> 
>> Display hints to the user when trying to commit without staging the modified
>> files first (when advice.statusHints is set to true). Change the output of the
>> unsuccessful commit from e.g:
>
> Wrap your commit messages at 72 characters.
>
>>   # [...]
>>   # Changes not staged for commit:
>>   #   modified:   builtin/commit.c
>>   #
>>   # no changes added to commit
>> 
>> to:
>> 
>>   # [...]
>>   # Changes not staged for commit:
>>   #   (use "git add <file>..." to update what will be committed)
>>   #   (use "git checkout -- <file>..." to discard changes in working directory)
>>   #
>>   #   modified:   ../builtin/commit.c
>
> For tidiness, can this line also be "builtin/commit.c" (that is, without
> the "../" at the beginning) to match what's before "to:"?
>
>> In ea9882bfc4 (commit: disable status hints when writing to COMMIT_EDITMSG,
>> 2013-09-12) the intent was to disable status hints when writing to
>> COMMIT_EDITMSG, but in fact the implementation disabled status messages in
>> more locations, e.g in case the commit wasn't successful, status hints
>> will still be disabled and no hints will be displayed to the user although
>> advice.statusHints is set to true.
>> 
>> Signed-off-by: Heba Waly <heba.waly@gmail.com>
>> ---
>>  builtin/commit.c                          | 1 +
>>  t/t7500-commit-template-squash-signoff.sh | 9 +++++++++
>
> I wondered if there was a better place to put the test, but I couldn't
> find one, so this is fine.
>
>> @@ -961,6 +961,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>>  	 */
>>  	if (!committable && whence != FROM_MERGE && !allow_empty &&
>>  	    !(amend && is_a_merge(current_head))) {
>> +		s->hints = advice_status_hints;
>>  		s->display_comment_prefix = old_display_comment_prefix;
>>  		run_status(stdout, index_file, prefix, 0, s);
>>  		if (amend)
>
> I checked that this undoing of "s->hints = 0" is safe, because s is no
> longer used in this function nor in the calling function cmd_commit()
> (which is the one that declared s locally).
>
> Still probably worth a comment, though. For example:
>
>   This status is to be printed to stdout, so hints will be useful to the
>   user. Reset s->hints to what the user configured.
>
> The corresponding comment on "s->hints = 0" might need to be tweaked,
> too, but I can't think of anything at the moment.
>
>> +test_expect_success 'commit without staging files fails and displays hints' '
>> +	echo "initial" >>file &&
>> +	git add file &&
>> +	git commit -m initial &&
>> +	echo "changes" >>file &&
>> +	test_must_fail git commit -m initial >actual &&
>
> Use another commit message for this, since this is no longer "initial".
> (Maybe "after initial" or something like that.)

Thanks for a careful review.
