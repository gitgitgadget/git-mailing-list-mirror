Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A65D9202A0
	for <e@80x24.org>; Thu, 16 Nov 2017 16:21:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935163AbdKPQVo (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Nov 2017 11:21:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:44833 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935084AbdKPQVm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Nov 2017 11:21:42 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 8D274ABD9;
        Thu, 16 Nov 2017 16:21:41 +0000 (UTC)
Subject: Re: [RFC 2/3] am: semi working --cover-at-tip
From:   Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <xmqqbmk68o9d.fsf@gitster.mtv.corp.google.com>
 <948b19c2-9f2d-de9d-1e0a-6681dc9317a9@suse.de>
 <xmqqbmk54cy3.fsf@gitster.mtv.corp.google.com>
 <325a3a6f-9916-29cb-48c0-69aa59e5913d@suse.de>
Openpgp: preference=signencrypt
Message-ID: <4bbaaf33-3796-4aa2-6434-ab79182274f5@suse.de>
Date:   Thu, 16 Nov 2017 17:21:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:57.0) Gecko/20100101
 Thunderbird/57.0
MIME-Version: 1.0
In-Reply-To: <325a3a6f-9916-29cb-48c0-69aa59e5913d@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: fr-xx-classique+reforme1990
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



Le 14/11/2017 à 10:17, Nicolas Morey-Chaisemartin a écrit :
>
> Le 14/11/2017 à 07:00, Junio C Hamano a écrit :
>> Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.de> writes:
>>
>> By the way, don't we want to sanity check state->last (which we
>> learn by running "git mailsplit" that splits the incoming mbox into
>> pieces and counts the number of messages) against state->series_len?
>> Sometimes people send [PATCH 0-6/6], a 6-patch series with a cover
>> letter, and then follow-up with [PATCH 7/6].  For somebody like me,
>> it would be more convenient if the above code (more-or-less) ignored
>> series_len and called do_apply_cover() after applying the last patch
>> (which would be [PATCH 7/6]) based on what state->last says.
> I thought about that.
> Is there a use case for cover after the last patch works and removes the need to touch am_next (can be done out of the loop in am_run).

Do you have an opinion on that ? It has quite a big impact on how things are done !
Single series only would mean a simple flush at the end.
Multiple series makes things a whole lot complex.
We do not know the series_id of the next patch until it's parsed by parse_mail.
Which would mean interrupting parse_mail when detecting a new series to call parse_mail on the cover_id plus an extra detection at the end of the loop.

Nicolas
