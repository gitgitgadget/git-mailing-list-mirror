Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDA4A1F404
	for <e@80x24.org>; Wed, 24 Jan 2018 21:11:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932702AbeAXVLE (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 16:11:04 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:45952 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932238AbeAXVLD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 16:11:03 -0500
Received: by mail-io0-f193.google.com with SMTP id p188so6313918ioe.12
        for <git@vger.kernel.org>; Wed, 24 Jan 2018 13:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=TIabGGMN5JQS+/SqEsxIdhCSV5OkRHuGdsri0SU7B18=;
        b=nnF132TGs5xVRvzlDmkIv7laqiWum0rz8KGvjm9jGr+NWs3HlQCW39CyMBc+g9rt/v
         2R7IDPRBfp4sOjtazWL9lh95/5bagx41fEmuJq+0+hPEBxOsIGUuziAfoXQnc4ppyvyi
         yRdzRO63aGFV8cto0oDJ0cK3aBjhSqgbKoLJwwMAYu1F+2pfHrnl8RUL3yEXIwy2VaJW
         mfzW7sX0Hjp120s57GgJ4fgqIac02x92/12IzlHbbR+8nVMfWTo5vbJ7OUCn8Nzu+cyC
         Rnaee0jfUUwqritcgSuSccJWhCz3Z1l/s69FsHUQxy5pbvJ6POGNvx2bylESetjC13y+
         MsLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=TIabGGMN5JQS+/SqEsxIdhCSV5OkRHuGdsri0SU7B18=;
        b=OSPv2QjFU00QxFIrX4/LSskksGEamGNC1fZjBf0EjInJ8OJZ7738jR8RVSIpbXe/40
         Z6YNnEg5QAChR1hpXxM/+qH3ePMqS8oV4YAjX44TGX9ydv1xqC7yyUE/1DQ32TZV8mKi
         mJmpnMNZse4jIDk6lQvpzHbgt8W0h5dilsbfogrOGOXq05XOlHu6MkeZCoPENTeRpFr4
         fHZQuNVj4lc0os1Dq0ExNssMPiRFD/gZLQFTccPbcSTjwirI8sK7kuIpHMwSt04n8qwc
         G3KMB927Ro4TPDiAKH1bsbu2cd4HgOF91vKkXgKreFN3iCfjYrf66FmqhG2b32Rp3Hox
         zKSw==
X-Gm-Message-State: AKwxytfgv0YxL79G1ayj8tAN0g8P1BVXMA403+ofQEFSrQbGhtF5UZLX
        EQcEADPXnBcx/U5fZLnnLL8=
X-Google-Smtp-Source: AH8x224VTzHP6JWakL4RuUgwvrlEgysv9U66XuUyOAMb42dJnPJY0rW0ng48KDlBWj9iB/zwPDOWWw==
X-Received: by 10.107.169.142 with SMTP id f14mr10438601ioj.56.1516828262410;
        Wed, 24 Jan 2018 13:11:02 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:69e6:5f42:e334:a0e2])
        by smtp.gmail.com with ESMTPSA id d202sm635733iod.73.2018.01.24.13.11.01
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 24 Jan 2018 13:11:01 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Kim Gybels <kgybels@infogroep.be>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH 3/6] find_reference_location(): make function safe for empty snapshots
References: <cover.1516791909.git.mhagger@alum.mit.edu>
        <e9f9ed1944c297a68c2b76f5d4ddd73e279bd207.1516791909.git.mhagger@alum.mit.edu>
        <20180124202754.GA7773@sigill.intra.peff.net>
Date:   Wed, 24 Jan 2018 13:11:00 -0800
In-Reply-To: <20180124202754.GA7773@sigill.intra.peff.net> (Jeff King's
        message of "Wed, 24 Jan 2018 15:27:54 -0500")
Message-ID: <xmqq8tcnc68r.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Jan 24, 2018 at 12:14:13PM +0100, Michael Haggerty wrote:
>
>> diff --git a/refs/packed-backend.c b/refs/packed-backend.c
>> index 08698de6ea..361affd7ad 100644
>> --- a/refs/packed-backend.c
>> +++ b/refs/packed-backend.c
>> [...]
>> @@ -551,7 +553,7 @@ static const char *find_reference_location(struct snapshot *snapshot,
>>  	 */
>>  	const char *hi = snapshot->eof;
>>  
>> -	while (lo < hi) {
>> +	while (lo != hi) {
>>  		const char *mid, *rec;
>>  		int cmp;
>
> This tightens the binary search termination condition. If we ever did
> see "hi > lo", we'd want to terminate the loop. Is that ever possible?

I think you meant "lo > hi", but I shared the same "Huh?" moment.

Because "While lo is strictly lower than hi" is a so well
established binary search pattern, even though we know that it is
equivalent to "While lo and hi is different" due to your analysis
below, the new code looks somewhat strange at the first glance.

> I think the answer is "no". Our "hi" here is an exclusive bound, so we
> should never go past it via find_end_of_record() when assigning "lo".
> And "hi" is always assigned from the start of the current record. That
> can never cross "lo", because find_start_of_record() ensures it.
>
> So I think it's fine, but I wanted to double check.

It would be much simpler to reason about if we instead do

	#define is_empty_snapshot(s) ((s)->start == NULL)

	if (is_empty_snapshot(snapshot))
		return NULL;

or something like that upfront.
	

