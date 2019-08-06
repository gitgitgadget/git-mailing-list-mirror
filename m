Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 440BA1F731
	for <e@80x24.org>; Tue,  6 Aug 2019 18:22:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729131AbfHFSWw (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Aug 2019 14:22:52 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61832 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727549AbfHFSWw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Aug 2019 14:22:52 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3AABA6D74F;
        Tue,  6 Aug 2019 14:22:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UPUcp3ZtJUDQPyY5U9WUyDvwbVU=; b=d/MvgZ
        u4RX4aSMkaPm/geggBxugmismvHDSV4K6uNN0J71qqkRJMaTsxxVzwXHVjaZqgTV
        IQ1kNwOQLmKUG06l7r5l5c0+vAkFXmwdXDQtqoKM8dcL9D62ik1f0qO+wqvwz0JF
        U9aGu19pj8gMdBefgZNnLaZtdSzPo2IoF8RQw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XzvBaW/+6f+djzAjEKXjz+j7I7thAShD
        1KB/ghQA5aakbfUQrB3aHZg+EWjEzeR1ImqNZh3bIOv5SsNHzTlz16vD4XWx6SHu
        tJ1ByoVx98owuzAo5pbj4YPubpJ5G3i9s50OjPN9RSTAB5/YC4ZQ6OAphDx6qTMr
        sTvBnz69xWw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 31A426D74E;
        Tue,  6 Aug 2019 14:22:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 551E16D74D;
        Tue,  6 Aug 2019 14:22:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-gui: Call do_quit before destroying the main window
References: <20190804143919.10732-1-me@yadavpratyush.com>
        <b7cbe50d-879f-68b9-30b2-181c3058297f@yadavpratyush.com>
Date:   Tue, 06 Aug 2019 11:22:42 -0700
In-Reply-To: <b7cbe50d-879f-68b9-30b2-181c3058297f@yadavpratyush.com>
        (Pratyush Yadav's message of "Tue, 6 Aug 2019 21:22:38 +0530")
Message-ID: <xmqqftmejgr1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2F2D1924-B877-11E9-ACA4-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pratyush Yadav <me@yadavpratyush.com> writes:

> If there are no comments/objections with this patch, can it be merged
> please?

It usually works the other way around (no comments by default means
no interests), but sadly, a larger problem with this area is that
there currently is nobody who is actively working on maintaining the
'git-gui' project, which is a separate project that our tree merely
pulls from time to time.  So we need to find a volunteer to run that
project, send the patch in that direction and get it merged, and
then finally we can pull from them X-<.




>
> On 8/4/19 8:09 PM, Pratyush Yadav wrote:
>> If the toplevel window for the window being destroyed is the main window
>> (aka "."), then simply destroying it means the cleanup tasks are not
>> executed like saving the commit message buffer, saving window state,
>> etc. All this is handled by do_quit so, call it instead of directly
>> destroying the main window. For other toplevel windows, the old behavior
>> remains.
>>
>> Signed-off-by: Pratyush Yadav <me@yadavpratyush.com>
>> ---
>>   git-gui/git-gui.sh | 19 +++++++++++++++++--
>>   1 file changed, 17 insertions(+), 2 deletions(-)
>>
>> diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
>> index 6de74ce639..6ec562d5da 100755
>> --- a/git-gui/git-gui.sh
>> +++ b/git-gui/git-gui.sh
>> @@ -3030,8 +3030,23 @@ unset doc_path doc_url
>>   wm protocol . WM_DELETE_WINDOW do_quit
>>   bind all <$M1B-Key-q> do_quit
>>   bind all <$M1B-Key-Q> do_quit
>> -bind all <$M1B-Key-w> {destroy [winfo toplevel %W]}
>> -bind all <$M1B-Key-W> {destroy [winfo toplevel %W]}
>> +
>> +set m1b_w_script {
>> +	set toplvl_win [winfo toplevel %W]
>> +
>> +	# If we are destroying the main window, we should call do_quit to take
>> +	# care of cleanup before exiting the program.
>> +	if {$toplvl_win eq "."} {
>> +		do_quit
>> +	} else {
>> +		destroy $toplvl_win
>> +	}
>> +}
>> +
>> +bind all <$M1B-Key-w> $m1b_w_script
>> +bind all <$M1B-Key-W> $m1b_w_script
>> +
>> +unset m1b_w_script
>>     set subcommand_args {}
>>   proc usage {} {
>>
