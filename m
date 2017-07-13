Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3503D2027C
	for <e@80x24.org>; Thu, 13 Jul 2017 21:23:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752593AbdGMVXE (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 17:23:04 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36578 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751153AbdGMVXD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 17:23:03 -0400
Received: by mail-pg0-f65.google.com with SMTP id y129so8220318pgy.3
        for <git@vger.kernel.org>; Thu, 13 Jul 2017 14:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=exF2UVl5zOjabQOmD4OIGoklWUeKTjEpV4pY8elJKkw=;
        b=sPv4b/rFHlBA5iaeGRS04PIRfV1bZll97prgZBV8Lrk9Pe3SX03cU+mZ5VNxof//jr
         aUoH/S40mcV4mWQu71Hgy4pPSW3JvVUD/KCWa7QUJhTku1LkyEWkPs/oBH4rV2rslJtK
         Rd2fk38+idYTVe/Cttqw1oKRrRhYQ7TFaOgLKtQTDl2wRwYlZbum+ZifIIxgPJ2ZCihu
         ef2DJScqEQo5Xg5sCpO4GtihNTZlaWrNWes44jk/b3KDJ1Iv3UvEKuubstxWUFwN34SQ
         I89pxo9lykIZ72f7haBx3j3QsNtBKDXkV0m5wOR0xfA74Gocn/tidprm/c31T3a4mMdk
         I24g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=exF2UVl5zOjabQOmD4OIGoklWUeKTjEpV4pY8elJKkw=;
        b=k78wbGd8sckUc61utQ18SVrzj+neOYCm2aKtbkz2FTYFm/aTeXs6TMG4heZHFqSVp1
         OkYX7oh9r8vUxvxiSOseBE9SyWAdxtj4hjbBSPI03DcTEX6jLd8rV94HFUOPXE4zzDYK
         Zki6WocV7xCQCQRQVdZxY1dMyEcAMGxgz23lY6yv481V2MrxF6TElH+GhHo3sYWTQMtz
         K4WkdZ0DCtkwNAzRBwA3p1uLslxqVkVqAFNcfa5MTylD3RYArPPiXj+ehLyD1QTHTIEE
         HOoTRKHwdM1eAHiVHrc0g9QTz4KFHkTb+7hCcqu9HHc8WbfRpFMCTFjI5Ho+mcOvtMWl
         UxAA==
X-Gm-Message-State: AIVw112N5ttH8Fxc6A8gd8uAeAzzyYtStfZcKtk//XTY+EgalHNQJloS
        Oj7KNOK97T6bOg==
X-Received: by 10.84.134.34 with SMTP id 31mr12538791plg.57.1499980982460;
        Thu, 13 Jul 2017 14:23:02 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3079:9e61:8883:4f9c])
        by smtp.gmail.com with ESMTPSA id n90sm13551272pfk.105.2017.07.13.14.23.01
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 13 Jul 2017 14:23:01 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] tag: convert gpg_verify_tag to use struct object_id
References: <20170713004415.5051-1-sbeller@google.com>
        <20170713004415.5051-2-sbeller@google.com>
        <xmqq4lugukju.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kb3_K8NxpHuzAdHhSLWUcbw_X3qVVspPeuSNA4sAeT-Kw@mail.gmail.com>
Date:   Thu, 13 Jul 2017 14:23:01 -0700
In-Reply-To: <CAGZ79kb3_K8NxpHuzAdHhSLWUcbw_X3qVVspPeuSNA4sAeT-Kw@mail.gmail.com>
        (Stefan Beller's message of "Thu, 13 Jul 2017 14:00:24 -0700")
Message-ID: <xmqqvamwt4ju.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> On Thu, Jul 13, 2017 at 1:52 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Stefan Beller <sbeller@google.com> writes:
>>
>>> diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
>>> index f9a5f7535a..ed8329340f 100644
>>> --- a/builtin/verify-tag.c
>>> +++ b/builtin/verify-tag.c
>>> @@ -56,20 +56,21 @@ int cmd_verify_tag(int argc, const char **argv, const char *prefix)
>>>       }
>>>
>>>       while (i < argc) {
>>> -             unsigned char sha1[20];
>>> +             struct object_id oid;
>>>               const char *name = argv[i++];
>>> -             if (get_sha1(name, sha1)) {
>>> +
>>> +             if (get_oid(name, &oid)) {
>>>                       had_error = !!error("tag '%s' not found.", name);
>>>                       continue;
>>>               }
>>
>> This part is already done, it seems, in bc/object-id topic, even
>> though other parts are not yet done?
>
> Oops. I assumed the latest bc/object-id would have been in master
> already, but after checking it is not. 967635dc3c2
> (builtin/verify-tag: convert to struct object_id)
> converts this part, although there are 2 differences:
> * I added a stray newline before get_oid
> * The argument to gpg_verify_tag is a sha1 or oid
>
> So yes, this produces a merge conflict. :/

That is OK.  This actually shouldn't create any meaningful conflict.
Both try to do the same code, with only a blank-line difference.

As Brian said bc/object-id would be rerolled, I was wondering if I
should queue these two patches (even though I already queued them)
myself, or it would be better for you to send them to Brian to make
it part of his series.
