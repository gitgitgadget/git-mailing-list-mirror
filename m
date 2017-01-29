Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29D2A1F6DC
	for <e@80x24.org>; Sun, 29 Jan 2017 17:19:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751879AbdA2RRm (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Jan 2017 12:17:42 -0500
Received: from mail-qk0-f193.google.com ([209.85.220.193]:32836 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751833AbdA2RRL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Jan 2017 12:17:11 -0500
Received: by mail-qk0-f193.google.com with SMTP id 11so15712471qkl.0
        for <git@vger.kernel.org>; Sun, 29 Jan 2017 09:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=RqF2mGsv4met9uKBmnKqRbvSwUOK8mvK0g3Ah3VQRkg=;
        b=gX3RPBVQrjh7ptt1wMu5aYuwqKlQIEHV4/pQo2ljWnmi9tNeYxcrXHsKZFIqb6LcHf
         UCCgZoic+dRUKQOYawWUsSdtzTw8WDe+OhBxBilYFl4uNeuntyGq/uCaAABjAeLqiJFr
         2TPDfqONLpISCi1S8KjWbmfxB9G3Zeh+YJeL8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=RqF2mGsv4met9uKBmnKqRbvSwUOK8mvK0g3Ah3VQRkg=;
        b=N9+e1CiAnocPK/298wkvlieYQLSAEWHT79EgDGG/rXI/gcO/jIQWzINNYIMQXJWx5G
         GeuOCgSCh0xlXYVOCCNiDnyeWso9auvnFzk/UO/uSZwVRAsmcGN93QOxIkSkBM4V31LQ
         e+CmezxwU0GQDn56nQpyZygd4Bda0mD2ExV5OnDPjTYePJP0NIstAWfCTBFQry63kV4B
         6UDt5Uy5YEDrLSyN++oFuCPrdKU00Ei789EUSbGYPbI2q1IA/a6YTKIGWIiwfm6s30zA
         6TQeW3KkeXGEGiEAUJI38RLjq6AE8qu4J8ntnZvUnhYdDI9djWx6SkL80gckNHrGrQoJ
         rCIg==
X-Gm-Message-State: AIkVDXJMl+FfPEEh3NUJ59SS8cYa2YGJEL0PXo/x1E2Nhf0yXKzyzyYWwbEoJrKlEAE8BdeZM8hbun2vE3mcPw==
X-Received: by 10.55.139.70 with SMTP id n67mr9817042qkd.286.1485709804922;
 Sun, 29 Jan 2017 09:10:04 -0800 (PST)
MIME-Version: 1.0
Received: by 10.237.62.179 with HTTP; Sun, 29 Jan 2017 09:10:04 -0800 (PST)
In-Reply-To: <xmqqa8ac1k7o.fsf@gitster.mtv.corp.google.com>
References: <01020159c0e82598-e373cf0d-2bad-41bb-b455-6896ad183e22-000000@eu-west-1.amazonses.com>
 <01020159d4ea6861-fce45d61-8be5-49b0-ab4e-d161b9429795-000000@eu-west-1.amazonses.com>
 <xmqqa8ac1k7o.fsf@gitster.mtv.corp.google.com>
From:   Luke Diamand <luke@diamand.org>
Date:   Sun, 29 Jan 2017 17:10:04 +0000
Message-ID: <CAE5ih7-qug9n-Df2gA27iTjSQo67tAnPhTJWQhyvR_PP9h3rcg@mail.gmail.com>
Subject: Re: [PATCH v2] git-p4: Fix git-p4.mapUser on Windows
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Git Users <git@vger.kernel.org>,
        George Vanburgh <george@vanburgh.me>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 27 January 2017 at 17:33, Junio C Hamano <gitster@pobox.com> wrote:
> George Vanburgh <george@vanburgh.me> writes:
>
>> From: George Vanburgh <gvanburgh@bloomberg.net>
>>
>> When running git-p4 on Windows, with multiple git-p4.mapUser entries in
>> git config - no user mappings are applied to the generated repository.
>> ...
>> Using splitlines solves this issue, by splitting config on all
>> typical delimiters ('\n', '\r\n' etc.)
>
> Luke, Lars, this version seems to be in line with the conclusion of
> your earlier reviews, e.g.
>
> <CAE5ih7_+Vc9oqKdjo8h2vgZPup4pto9wd=sBb=W6hCs4tuW2Jg@mail.gmail.com>
>
> Even though it looks OK to my eyes, I'll wait for Acks or further
> refinement suggestions from either of you two before acting on this
> patch.

It looks good to me. The tests all pass, and the change looks correct.

Ack.

Luke


>
> Thanks.
>
>> Signed-off-by: George Vanburgh <gvanburgh@bloomberg.net>
>> ---
>>  git-p4.py | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/git-p4.py b/git-p4.py
>> index f427bf6..b66f68b 100755
>> --- a/git-p4.py
>> +++ b/git-p4.py
>> @@ -656,7 +656,7 @@ def gitConfigInt(key):
>>  def gitConfigList(key):
>>      if not _gitConfig.has_key(key):
>>          s = read_pipe(["git", "config", "--get-all", key], ignore_error=True)
>> -        _gitConfig[key] = s.strip().split(os.linesep)
>> +        _gitConfig[key] = s.strip().splitlines()
>>          if _gitConfig[key] == ['']:
>>              _gitConfig[key] = []
>>      return _gitConfig[key]
>>
>> --
>> https://github.com/git/git/pull/319
