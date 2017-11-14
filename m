Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4EB06201C8
	for <e@80x24.org>; Tue, 14 Nov 2017 09:10:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753937AbdKNJKp (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Nov 2017 04:10:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:42923 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753819AbdKNJKf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Nov 2017 04:10:35 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6ED1DAAB5;
        Tue, 14 Nov 2017 09:10:34 +0000 (UTC)
Subject: Re: [RFC 1/3] mailinfo: extract patch series id
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <xmqqbmk68o9d.fsf@gitster.mtv.corp.google.com>
 <2252b046-a608-b2aa-d67a-8f7e95fe2dbc@suse.de>
 <xmqqfu9h4div.fsf@gitster.mtv.corp.google.com>
From:   Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.de>
Openpgp: preference=signencrypt
Message-ID: <e49e107d-b211-f544-9512-b83eab9dd82a@suse.de>
Date:   Tue, 14 Nov 2017 10:10:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:56.0) Gecko/20100101
 Thunderbird/56.0
MIME-Version: 1.0
In-Reply-To: <xmqqfu9h4div.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: fr-xx-classique+reforme1990
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



Le 14/11/2017 à 06:47, Junio C Hamano a écrit :
> Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.de> writes:
>
>> Extract the patch ID and series length from the [PATCH N/M]
>>  prefix in the mail header
>>
>> Signed-off-by: Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
>> ---
>>  mailinfo.c | 35 +++++++++++++++++++++++++++++++++++
>>  mailinfo.h |  2 ++
>>  2 files changed, 37 insertions(+)
> As JTan already mentioned, relying on a substring "PATCH" may not be
> very reliable, and trying to locate "%d/%d]" feels like a better
> approach.
>
> cleanup_subject() is called only when keep_subject is false, so this
> code will not trigger in that case at all.  Is this intended?
>
> I would have expected that a new helper function would be written,
> without changing existing helpers like cleanup_subject(), and that
> new helper gets called by handle_info() after output_header_lines()
> helper is called for the "Subject".
Isn't that too late ?
If keep subject is not set, will cleanup_subject not drop all those info from the strbuf  ?
But yes it is not in the right function now.
But I would call the function before
            if (!mi->keep_subject) {

>
> Whenever mailinfo learns to glean a new useful piece of information,
> it should be made available to scripts that run "git mailinfo", too.
> Perhaps show something like
>
> 	PatchNumber: 1
> 	TotalPatches: 3
>
> at the end of handle_info() to mi->output?  I do not think existing
> tools mind too much, even if we added a for-debug output e.g.
>
> 	RawSubject: [RFC 1/3] mailinfo: extract patch series id
>
> to the output.
Will do.
