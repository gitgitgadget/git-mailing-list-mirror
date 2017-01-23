Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8AD9E1F89C
	for <e@80x24.org>; Mon, 23 Jan 2017 10:19:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750725AbdAWKTA (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jan 2017 05:19:00 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36676 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750703AbdAWKS7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2017 05:18:59 -0500
Received: by mail-wm0-f67.google.com with SMTP id r126so25266894wmr.3
        for <git@vger.kernel.org>; Mon, 23 Jan 2017 02:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=PXvqIyzTFbveh7W1AAWl/lcwxy3g9uM2934evR4LF3I=;
        b=vQ53Pw3Yy1MzvF81dFA/p4BhUccwe2ma3A3ljTPo79pR8sowi8J2ZMwDUBaHTqsY/X
         BqNeK8qpOcYDWXRxPV9mgoU9YyfLze4ejQGnKqTSkcnx8E7osVLZqxNm5h9Em8Q909jg
         1ieEpt+QItFS1XiSQ2qvNgSJTb/4JveFB6U2yjmLfgT2PT6e5RoDPCYhNYfuJBWxOf18
         NczF21Eg1Wl6jBTQ/6bGJiqphFxoJq9lWIr81BwytMN/aCWKZ4xLn7F72oxfG4tklokR
         nrLEHtyu07wfOYOeomXdlzf2dWiPONzPQ3MNoFT7c37BS5pzmxkiQMW5u2W9WqOiJtI8
         81wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=PXvqIyzTFbveh7W1AAWl/lcwxy3g9uM2934evR4LF3I=;
        b=MNnjz6OhrCxftIIJsE8NtMObSJrsM5JW6X6L/PO/vwNCO+cPYuidbyWkwDsWJfkRMP
         Ovak67rh3sC9X76P9IQzKpM5xC948fIcqo9cCBLGSsOv8Vch9NLvQTPHRQHxrIP1e7ht
         Dpjxt8saLwQZkoRryfbhcdy0P+kwvix0oAGj10LFOhePtjgcPrcPvY1HLiVJBMaikC78
         GFzTegOjnogXMGdLQ0sK8GPQDRaMFybUo0oelpYiE8TWR7BrHjw5ix8Lyy5H6BE4e+SW
         4CYvTz+uFBVjrtCw9bvOmoDhH8//xZjEB2Ly3BWEF65DelWOuw23awDDLwG8PM53wmZ6
         Nw4g==
X-Gm-Message-State: AIkVDXJzjWwfMmWCWdAqJz118qh4KkYvQ/rK8+LvoPgjhaOjdSavxEEHOY0uQRbrIOnJGrQ8Nam/S3blhroYDA==
X-Received: by 10.223.155.221 with SMTP id e29mr23316592wrc.107.1485166737946;
 Mon, 23 Jan 2017 02:18:57 -0800 (PST)
MIME-Version: 1.0
Received: by 10.28.145.193 with HTTP; Mon, 23 Jan 2017 02:18:37 -0800 (PST)
In-Reply-To: <xmqqpojeu14h.fsf@gitster.mtv.corp.google.com>
References: <20170121131629.16326-1-giuseppe.bilotta@gmail.com> <xmqqpojeu14h.fsf@gitster.mtv.corp.google.com>
From:   Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Date:   Mon, 23 Jan 2017 11:18:37 +0100
Message-ID: <CAOxFTczut_CGGxmbrVFzhn_o4=StTOY6N1mEAw75Ro2Q4tzWgQ@mail.gmail.com>
Subject: Re: [RFC PATCH] Option to allow cherry-pick to skip empty commits
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 23, 2017 at 12:27 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:

>> +static int allow_or_skip_empty(struct replay_opts *opts, struct commit *commit)
>>  {
>>       int index_unchanged, empty_commit;
>>
>>       /*
>> -      * Three cases:
>> +      * Four cases:
>>        *
>> -      * (1) we do not allow empty at all and error out.
>> +      * (1) we do not allow empty at all and error out;
>>        *
>> -      * (2) we allow ones that were initially empty, but
>> +      * (2) we skip empty commits altogether;
>> +      *
>> +      * (3) we allow ones that were initially empty, but
>>        * forbid the ones that become empty;
>>        *
>> -      * (3) we allow both.
>> +      * (4) we allow both.
>>        */
>
> The original gave callers the choice to tell two cases (a commit was
> empty in the original history, and a commit that was not empty in
> the original history turns out to be redundant) apart and handle
> them differently.  I tend to agree that skipping the former should
> be the norm, and also I think it is sensible to drop the latter, and
> that is what your updated (2) gives us, I think.
>
> But I would suspect that it would rather be common to have a
> deliberately empty commit in the original as a marker in a history
> and want to keep that across cherry-picking a series, while wanting
> to discard/skip patches that are already applied in an updated base.
> Shouldn't that be supported as the fifth case?

I was actually wondering about that. I guess the best approach
(symmetric wrt to the --allow) would be to intro introduce
--skip-empty _and_ --skip-redundant, with the former implying the
latter.

By the way, I noticed going over the code that the -allow options are
not stored, so that in case of interruption they will be reset, is
this intentional or a bug?


-- 
Giuseppe "Oblomov" Bilotta
