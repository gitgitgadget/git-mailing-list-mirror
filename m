Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1985E20373
	for <e@80x24.org>; Mon, 13 Mar 2017 22:46:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753716AbdCMWqa (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 18:46:30 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53181 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753206AbdCMWq2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 18:46:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6B2B586647;
        Mon, 13 Mar 2017 18:46:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UlyKBpVeI0safC3/JHWFHwEegUA=; b=es8ppt
        vgdVwHd3AYkFpEGECI++JDi1hiJRm6g8P05i87B7GFcAq5FzqQmJWbDDMsPd18TN
        e3nDHi1Fdp7HXqJT1+bLoFePyvtrJW3JX1Di3/MA6SGh1cujsNR3WfqngFra0B2d
        VZ7RWM7NO+7GIfDt0l20mravAnDO7YU+/ZH4Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YbH0QFfnK2ZJyEronx3sZ2uZmf01TzC3
        h2pycutWJ0sQqDwL/Vi9ocJIiocUNprtS36Eg/JK0DgxkWqCPWsYupA2fSCcmxyI
        5gNzkmRoVb3y5oNEeXdp8hOdwJgtnI/Xvqj91Ee6Jnbj5KWgaONvL9HMuKgUfomF
        NhqEWK8z9kY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 62ED786646;
        Mon, 13 Mar 2017 18:46:27 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C504686645;
        Mon, 13 Mar 2017 18:46:26 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Domagoj Stolfa <domagoj.stolfa@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: Possible git blame bug?
References: <20170313201104.GA32821@workstation>
        <xmqqmvcorjyo.fsf@gitster.mtv.corp.google.com>
        <CAPc5daVRX_-bJ_2reDLKJin9PNfy6EjbD14T=Mpx=9P8xzdmuw@mail.gmail.com>
        <20170313214400.GA98717@workstation>
        <xmqqfuign7jw.fsf@gitster.mtv.corp.google.com>
Date:   Mon, 13 Mar 2017 15:46:25 -0700
In-Reply-To: <xmqqfuign7jw.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Mon, 13 Mar 2017 15:19:47 -0700")
Message-ID: <xmqqy3w8lrr2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E43B7D92-083E-11E7-B1B0-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Domagoj Stolfa <domagoj.stolfa@gmail.com> writes:
>
>> For example, saying:
>>
>> $ git blame time.h --since=2017
>> ^e19f2a27ed8 (Domagoj Stolfa 2017-03-12 20:43:01 +0100  33) #ifndef _SYS_TIME_H_
>>
>> $ git blame time.h --since=2016
>> ^21613a57af9 (bz  2016-03-13 21:26:18 +0000  33) #ifndef _SYS_TIME_H_
>>
>> $ git blame time.h --since=2015
>> ^48507f436f0 (mav 2015-03-13 21:01:25 +0000  33) #ifndef _SYS_TIME_H_
>>
>> and so on, with different hashes.
>
> The output lines "^deadbeef" does *NOT* mean that commit deadbeef
> changed the revision.  It just is telling you that the hisory was
> dug down to that revision and it was found that since that revision
> there is no change (and you told the command not to bother looking
> beyond that time range, so we do not know what happened before that
> time).
> ...
> So it is entirely sane if you saw three boundary commits named with
> three different time ranges.

Side note.  If the displaying of the boundary commit object names
are distracting, the user can always use the -b option to blank them
out.
