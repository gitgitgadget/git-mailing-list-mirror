Return-Path: <SRS0=i2G4=DF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 068E4C2D0A8
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 13:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4FBC206B8
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 13:26:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wE6Degmm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgI1N0k (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Sep 2020 09:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbgI1N0k (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Sep 2020 09:26:40 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29408C061755
        for <git@vger.kernel.org>; Mon, 28 Sep 2020 06:26:40 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id c62so898520qke.1
        for <git@vger.kernel.org>; Mon, 28 Sep 2020 06:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=R7N/nW494n/bS03msyuf3bCWn5dQ6Tljkg2TP0HFxnI=;
        b=wE6DegmmjPfuZtOALKDZ+xGNYrWdhhekCp68h0dksEi1HypwCRgY14+mSqdCZQjqdo
         C6pchiuB271nHVNxtIGd7457iYJYSLx2wXb8yTfx94Q/xaSpeWtue7TNBLCbjCQiBjnV
         qSy1OmQr93aHaH/TzJ7CbqnZMbO2g3IZPB7mpsakCh1WS9wwFEFYa+ZJrz36JadWklfr
         XL8n3uW0RQQpVbXd+aFt9yjziM2DamxS69KuS6TAMbrdy39n4oIKVUn84i32Ly65JuHg
         wnolkYdYwqyeiv/qU/cOX/yA+1P4bklaRmcGFJO54iT5uD4b11DH2C9t+FkLRVOOnU7Y
         +3jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=R7N/nW494n/bS03msyuf3bCWn5dQ6Tljkg2TP0HFxnI=;
        b=gaDt1P6Dp7Z5tAM7AVmG0aMdL4WZMHzgf3Mw08//YQZqF39YPzbudSpdvlBJrEY6ap
         NMNEGj5JiXvuhh52vU0ukpINp0xOWQeSm0IMI/9vlEU5I/uBgRfyfTEsTygXUUD0U8sh
         /sZSAXwCODPcJFIHqyTKs2YiIJFWZgtIkcwta7Mj1sJgdg+P1uoea3nmNpoJCQaGKivW
         UEtPxYJ8RxCX8hyWMJPLSwTDYMpXakKaqvqyZfVY5YpDQ0jO9srDqPF92ty16LfFybKw
         pcbK6uYF92AXt1T9vr+aoTS71mf5k0oYckOgbHIFwX0zG0C1SiyQBWS7J4NuNhjTHZ3J
         gpBg==
X-Gm-Message-State: AOAM530HJ0lOVmHhts5KEqlI2004n/yib9sS+oCidjMWF7iKc0sZWxbK
        o3i8zgZ1w1du+SdPECgDSHe6ic+pN8p+hsU+
X-Google-Smtp-Source: ABdhPJzFnGBWcJGW/OnfTgG/Aib4DHs7CQ0s70SmOLakkS/rDqqQdK57oIj+XurZhGvWGPXeLssmtA==
X-Received: by 2002:a05:620a:c10:: with SMTP id l16mr1310444qki.245.1601299598319;
        Mon, 28 Sep 2020 06:26:38 -0700 (PDT)
Received: from [192.168.0.102] (d-65-175-178-104.nh.cpe.atlanticbb.net. [65.175.178.104])
        by smtp.gmail.com with ESMTPSA id 8sm909992qkd.47.2020.09.28.06.26.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2020 06:26:36 -0700 (PDT)
Subject: Re: [PATCH 2/4] blame: validate and peel the object names on the
 ignore list
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Cc:     git@vger.kernel.org
References: <20200925055954.1111389-1-gitster@pobox.com>
 <20200925055954.1111389-3-gitster@pobox.com>
 <40488753-c179-4ce2-42d0-e57b5b1ec6cd@web.de>
 <xmqqtuvkii1j.fsf@gitster.c.googlers.com>
From:   Barret Rhoden <brho@google.com>
Message-ID: <32370477-c6e4-5378-fedc-c86b9ddf96bd@google.com>
Date:   Mon, 28 Sep 2020 09:26:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <xmqqtuvkii1j.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi -

On 9/26/20 1:06 PM, Junio C Hamano wrote:
> René Scharfe <l.s.r@web.de> writes:
> 
>> When I request "Don't eat any glue!", perfectly human responses could be
>> "But I don't have any glue!" or "It doesn't even taste that good.", but
>> I'd expect a computer program to act I bit more logical and just don't
>> do it, without talking back.  Maybe that's just me.
>>
>> (I had been bitten by a totally different software adding such a check,
>> which made it complain about my long catch-all ignore list, and I had to
>> craft and maintain a specific "clean" list for each deployment --
>> perhaps I'm still bitter about that.)
> 
> A user who says "ignore v2.3", sees that the commit pointed at by
> that release tag is not ignored, comes here to complain, and is told
> to write v2.3^0 instead, would not be happy.  It is a mistake easy
> to catch to help users, so I am more for than against that part of
> the change.

That sounds like a nice change.

> I am completely neutral about "you told me to ignore
> this, but as far as I can tell it does not even exist---did you
> screw up when you prepared the list of stuff to ignore?" part.  I do
> not mind seeing it removed.

Part of my reasoning for "fail if you can't find it" was that it was 
highly likely to be a user error.  Especially because it will fail for a 
short hash from a file.  If you do have a list of commits to ignore 
(.git-blame-ignore-revs), that list is probably under version control in 
the same git repo, so it should change as you change branches.

But all in all, I'm fine with skipping unknown objects.  Or for warning 
or having a git-config option, like we do for a couple other aspects of 
blame-ignore, since one size doesn't fit all.

>>> +		if (kind == OBJ_COMMIT) {
>>> +			oidcpy(oid_ret, &oid);
>>
>> At that point we know it's an object, but cast it up to the most generic
>> class we have -- an object ID.  We could have set an object flag to mark
>> it ignored instead, which would be trivial to check later.  On the other
>> hand it probably wouldn't make much of a difference -- hashmaps are
>> pretty fast, and blame has lots of things to do beyond ignoring commits.
> 
> Quite honestly, I am not interested in the "blame --ignore" feature
> itself.  It is good that you CC'ed Barret so that such an
> improvement suggestion would be heard by the right party ;-).

Any performance improvement would be welcome.  I haven't looked at the 
code in a while, but I don't recall any reasons why this wouldn't work.

> 
>>> @@ -815,10 +836,12 @@ static void build_ignorelist(struct blame_scoreboard *sb,
>>>   		if (!strcmp(i->string, ""))
>>>   			oidset_clear(&sb->ignore_list);
>>
>> This preexisting feature is curious.  It's even documented ('An empty
>> file name, "", will clear the list of revs from previously processed
>> files.') and covered by t8013.6.  Why would we need such magic in
>> addition to the standard negation (--no-ignore-revs-file) for clearing
>> the list?  The latter counters blame.ignoreRevsFile as well. *puzzled*
> 
> I shared the puzzlement when I saw it, but ditto.

I don't recall exactly.  Someone on the list might have wanted to both 
counter the blame.ignoreRevsFile and specify another file.  Or maybe 
they just wanted to counter the ignoreRevsFile, and I didn't know that 
--no- would already do that.  I'm certainly not wed to it.

Thanks,

Barret


>>> +void oidset_parse_file_carefully(struct oidset *set, const char *path,
>>> +				 oidset_parse_tweak_fn fn, void *cbdata)
>>>   {
>>>   	FILE *fp;
>>>   	struct strbuf sb = STRBUF_INIT;
>>> @@ -66,7 +72,8 @@ void oidset_parse_file(struct oidset *set, const char *path)
>>>   		if (!sb.len)
>>>   			continue;
>>>
>>> -		if (parse_oid_hex(sb.buf, &oid, &p) || *p != '\0')
>>> +		if (parse_oid_hex(sb.buf, &oid, &p) || *p != '\0' ||
>>> +		    (fn && fn(&oid, cbdata)))
>>
>> OK, so this turns the basic all-I-know-is-hashes oidset loader into a
>> flexible higher-order map function.  Fun, but wise?  Can't make up my
>> mind.
> 
> Fun and probably useful.  It is a different matter if it is wise to
> use it to (1) peel tags to commits and (2) fail on an nonexistent
> object.  My take on them is (1) is probably true, and (2) is Meh ;-)
> 
> Thanks.
> 

