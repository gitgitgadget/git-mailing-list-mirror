Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48FAD1F5FB
	for <e@80x24.org>; Mon, 27 Feb 2017 20:11:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751617AbdB0ULR (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Feb 2017 15:11:17 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34965 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751510AbdB0ULO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2017 15:11:14 -0500
Received: by mail-pf0-f195.google.com with SMTP id y23so1131078pfk.2
        for <git@vger.kernel.org>; Mon, 27 Feb 2017 12:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=Dr1H1TiZSeEXT3J4cPLeVLQTCrzcqyFvQ/zwCPN4qdA=;
        b=GByOZWhZP5tfIjf6/8t1It/oAWy+EIkuDsCw0TFDKKN6+NnnhicJZwikQXLzQJDi+Q
         BPM66oi0lyHEE8tctT5s9fkXAKgOUxZr8nLj6PqrvXbiYUFoZymNjrNnssGXWHtuOMhI
         CWqYX0/62InZjqbS7CJrbTRWxEzJIU1eVuPRAQ29YoKEdiolYBghOEiioiTKefCzVgim
         dexL0LowFtdOUbwzDtVRMml0P53Opa/3hsfk6NviGe/cZ0bpb+Z9m85LXeef3EP6dgFg
         8y0+zm4cga5XNsPcqIC59EX6lUzTwOO9C/ltNNMzA9NgDA0UKqbc4beGOa22Z5R/helf
         yNaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=Dr1H1TiZSeEXT3J4cPLeVLQTCrzcqyFvQ/zwCPN4qdA=;
        b=XKxvJCbtTPHn8LBfkLVp1WiFAX7VQ6iEySnjZooKqXK0iZjGIqkuyb2xw2BY+Q7vd3
         GzburifPhHOO8C7uGW1Dcjc4qOD5XFggrEUScK64iDQKokFqTeERQdrnOdfDdVMj+xvH
         rGzSj3i721oc4TETJzy0cHYsGy6Od+lrqBehx9ajc7i/+nviZLm+HyyQ8RwynfkNq4OP
         a1cGNeVkJASqismDgqzq3hIrnQLJFrmDskXBHXGXkeLDsB0/Ku3mAYTD+8v8vGqFkXUR
         hLhUzBH7m6Vs6yWg18hp4EOlbIsQM+DjDfnOWq2HfvRDSFX30k37PTRvruhUAi2MYJLh
         Ubyg==
X-Gm-Message-State: AMke39luelIdBgPmMMxfY9zVc1jEiExkyLiqqsNYo9zj5c8DeUuv+qrY51r0h2Z1Dq2dUA==
X-Received: by 10.99.240.83 with SMTP id s19mr22863592pgj.45.1488225866143;
        Mon, 27 Feb 2017 12:04:26 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:c953:ec42:862e:1e81])
        by smtp.gmail.com with ESMTPSA id b8sm32495700pgn.6.2017.02.27.12.04.24
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 27 Feb 2017 12:04:25 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Vegard Nossum <vegard.nossum@oracle.com>, git@vger.kernel.org,
        Christian Couder <christian.couder@gmail.com>,
        Michal Zalewski <lcamtuf@google.com>
Subject: Re: [PATCH 2/2] apply: handle assertion failure gracefully
References: <20170225101307.24067-1-vegard.nossum@oracle.com>
        <20170225101307.24067-2-vegard.nossum@oracle.com>
        <a5626d97-e644-65b5-2fd3-41ce870f85a6@web.de>
Date:   Mon, 27 Feb 2017 12:04:24 -0800
In-Reply-To: <a5626d97-e644-65b5-2fd3-41ce870f85a6@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sat, 25 Feb 2017 22:21:45 +0100")
Message-ID: <xmqqmvd7wgc7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

>> diff --git a/apply.c b/apply.c
>> index cbf7cc7f2..9219d2737 100644
>> --- a/apply.c
>> +++ b/apply.c
>> @@ -3652,7 +3652,6 @@ static int check_preimage(struct apply_state *state,
>>  	if (!old_name)
>>  		return 0;
>>
>> -	assert(patch->is_new <= 0);
>
> 5c47f4c6 (builtin-apply: accept patch to an empty file) added that
> line. Its intent was to handle diffs that contain an old name even for
> a file that's created.  Citing from its commit message: "When we
> cannot be sure by parsing the patch that it is not a creation patch,
> we shouldn't complain when if there is no such a file."  Why not stop
> complaining also in case we happen to know for sure that it's a
> creation patch? I.e., why not replace the assert() with:
>
> 	if (patch->is_new == 1)
> 		goto is_new;
>
>>  	previous = previous_patch(state, patch, &status);

When the caller does know is_new is true, old_name must be made/left
NULL.  That is the invariant this assert is checking to catch an
error in the calling code.

Errors in the patches fed as its input are caught by "if we do not
know if the patch is to add a new path yet, then declare it is, but
if we do know the patch is _NOT_ adding a new path, barf if that
path is not there" and other checks in this function, and changing
the assert to "if already new, then make it a no-op" defeats the
whole point of having an assert (and just removing it is even worse).

Thanks.
