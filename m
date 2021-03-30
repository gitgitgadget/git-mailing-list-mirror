Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4913C433C1
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 21:32:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DF11619D1
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 21:32:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233149AbhC3Vbq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Mar 2021 17:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232984AbhC3Vad (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Mar 2021 17:30:33 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70753C061762
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 14:30:31 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id d12so4869682lfv.11
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 14:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=4pTdmcga+0mO0wzl6wk/VwkkSY1Q28dwLfoTwsbA98U=;
        b=ve8pF+SFS/YoS6YLCbUqOZPmAGifZMsHs0D0mjLmIqH78MDbB/Z/onOK4LVS71e0s8
         KdxbHfau8TeqozM0Q6F06Nuz1nYtdz2DDPyYNB25i5QUMK6fNXVUeMqoLXumDs0B9AOG
         zjZuiKu6vtSuMynDNIj2dJ7S9HQG7Q5GxXhBkBPksIYdToufXWjX899pevmL9X2ksK98
         7sNSKlB8FPw1223VfLqI2RyrtXhCcpI7bIY7UPbfHTPsvP6lPmc1rzaVY+KauMKdedIL
         GgtbjgRPPtLsocIwfwn0Fj6//eOBJNAAAlOiW3vquiG9rRAABPECKeNHjl4ZlnZFZB4S
         +KLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=4pTdmcga+0mO0wzl6wk/VwkkSY1Q28dwLfoTwsbA98U=;
        b=ZuVS2Xc9WLRRIfhfg/iWfsTZo2GlUJ5vlc4ZG9ZfP4NifDbefkSI9Gg9DBOpSaJISk
         zt5i7xzLWY+QhCqlYY93Dn7SrnajTmTFktS3r3jLayRDXe++kk/x41Ofv43VupFcZB9j
         cGvEGv+K54KLv6T2Zi6VjYwt3I1YXIDkhzWnRKQgJBbDowIKdB1C9FL/q36y8p2p/YJH
         CAsxgn28t267Eo/ElN5VQtCoFzj9pZrpXs9tXEnGpjT1tQS5YIu3n20EjvmWqW5lzR1x
         jkmdczUkoowYahWBwJEn7yZWygw86j9w9Jyx5FlM1CUA35R+1kRYSRFdvuOlmfJQAWwG
         AYyw==
X-Gm-Message-State: AOAM53281DScM88xFR30RRIcKTxpEDLJpjv5SV2rHzudmnQ8qD1vA87e
        iwNXwkDQSVouidpbzI37HnM=
X-Google-Smtp-Source: ABdhPJwwa+gL9N9LUhQeRAWXafc5fTttedHQ3M3uoaYMWFmgtbkBiFOF6jsvW0jctV+n7ujc3OvEkQ==
X-Received: by 2002:ac2:5df6:: with SMTP id z22mr63488lfq.485.1617139829925;
        Tue, 30 Mar 2021 14:30:29 -0700 (PDT)
Received: from Margaret-Hamilton.local ([195.246.120.96])
        by smtp.gmail.com with ESMTPSA id 28sm2896342ljv.125.2021.03.30.14.30.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Mar 2021 14:30:29 -0700 (PDT)
Subject: Re: [PATCH] persistent-https: add go.mod to fix compile
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Dominyk Tiller via GitGitGadget <gitgitgadget@gmail.com>
References: <pull.989.git.git.1617109668438.gitgitgadget@gmail.com>
 <xmqqy2e4cvbl.fsf@gitster.g>
From:   Dominyk Tiller <dominyktiller@gmail.com>
Autocrypt: addr=dominyktiller@gmail.com; keydata=
 mQINBFOnIrUBEACvVbvEJfRBvhUKPFgGbplIx+LXkkcv96O28CzGLa1l6qESXi6WsN1ovG71
 GJKxRkvK9FKVrxNYVEzHHPKXEBa71Od/aJtBjNYI5Mx8YAGQ7OxIZzPt0DQu3HhA7o/yg2Tk
 IxT5wD8Np8dBH51ffzcVa17wEJZ255kMP/geQ2Tm7bymiLxnx7M2z1WiMWC+Pihwe7XdlMVs
 iu7bgiCvCTUcO+1TLs2rNBc1b6d3J1368szNNwuLoSVPAzBHz76cI4YS4bSqxvj6qgfZCUMa
 WszAa8MPkHMIdyNSY8LXG6uMFV12LrvIMkyrgYnh1bQL2GkQb4Xb2lD4ehyzfY0qCcL+gUzT
 HRs7qlJUYsZgWTPuv9aIJn8i+tswn0lkanWEFSnWlih3pRhaZrtbk7wqtjENiMvlflWqBVCn
 cAJx1WJbh8bEJ4KxkYekDLGQvHxeaiTj8eJUsAZ7YSHYt5a+XEGj8gGLkkc8CcGjN/QSqsft
 MTkk0J6phZSRBu4akk4njd2/CZH4WlqJFnZbptWWa8dpKQ5eziYgwERMrY8lPfMtNHMUtQgi
 pwZ0LSNa0zDOMhMm2ol+ZnTO5dwNGuwA11Qdo3nfbQXibpW4RGsAQ+znrhlsJRrWLP7VnuA+
 gt3ElgL7CW27o/WSsgoRMC13WFS1pM/PMQ4/w9/dYrDG6bl8vQARAQABtC1Eb21pbnlrIFRp
 bGxlciAoVFMpIDxkb21pbnlrdGlsbGVyQGdtYWlsLmNvbT6JAj0EEwEKACcFAlOnIrUCGwMF
 CQtJ2AAFCwkIBwMFFQoJCAsFFgIDAQACHgECF4AACgkQtEfwU+K/2K095g/7B6oyvXYDlhGR
 DNSg69svI0Jfqz13a4fytOsZUqhpBt5POOeB3SOUdER6kPVI7X5e7PzNM+TCaIBKjqzNkl5T
 duR1gcUCwVdyKm+MUz7+E6XSWXsu+LVz6Z1Ys8XMbUE2VSL1EIQxbDwRviGXYtFGEJ2/iuG5
 qtlB5mqErqKO6WEvB3d44QNMG0H2HT257GjU8XhP5kApsBwuozInq5cYZaIv8S1lLlqIPsYi
 7lrWOarNmWBhtRhhQMRIdgaC2Ff5r5KfKzOi9dlroVf4cB8zX66c99W4abbSNjoPsvypaZ4x
 kmDLCSm9Wv5cyZAzy/Iv+XV4gN/0exco7mOh3/+TveUrEcdOW0mBuCCv6pe5dQg8arYxoruU
 AXdZUQafVX6m01ME28yHc/Z1Ko2KPQuiiE2KWVQPEBeFtHGj/WpEOvY+ct62aY6lS464a7qH
 sx47bnyk1QgQOm/rbi/b7DWuwTJ3DlC1FkMlt1MEyRz1yj2QQbQHk1pjrwwjNx5s3tOm7/Es
 oghnoWMt26/EzrwW9HRKm4bBOuhD3MfUg8zSjjJ5ioJbYs3N9s/TmaQf5TF3NEBWp4fki2LH
 4TcXK88t6OOraxxym8TtAy3C6FU6aWeDIbv7zuhRxfQdpO/nMqniE0I3RQuiPbdOTh8tN7Ac
 08IbnsHunY/Hpjuk8WzGIq0=
Message-ID: <3dd5a0cd-94cc-e7ec-b1b1-feb39c65e85d@gmail.com>
Date:   Tue, 30 Mar 2021 22:30:26 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:52.0)
 Gecko/20100101 PostboxApp/7.0.47
MIME-Version: 1.0
In-Reply-To: <xmqqy2e4cvbl.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote on 30/03/2021 20:09:
> "Dominyk Tiller via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> From: Dominyk Tiller <dominyktiller@gmail.com>
>>
>> GOPATH-based builds and non module-aware builds are being deprecated
>> by golang upstream, which currently causes this to fail. This adds a
>> barebones mod file to fix the build.
>>
>> The `persistent-https` code hasn't been touched for a long time but
>> I assume this is preferable to simply removing it from the codebase.
>>
>> Before this change:
>> ```
>> case $(go version) in \
>> 	"go version go"1.[0-5].*) EQ=" " ;; *) EQ="=" ;; esac && \
>> 	go build -o git-remote-persistent-https \
>> 		-ldflags "-X main._BUILD_EMBED_LABEL${EQ}"
>> go: cannot find main module, but found .git/config in ../git
>> 	to create a module there, run:
>> 	cd ../.. && go mod init
>> make: *** [git-remote-persistent-https] Error 1
>> ```
> With which version of go?  Any recent version would fail the same
> way, or only 1.16 and later?
The link I referenced in the notes explains a little more in depth, but
there's an environment variable you can use with 1.16 to temporarily
mitigate the failure, i.e. `export GO111MODULE=off`, but regardless of
the presence of that the lack of module-awareness will become a hard
failure in Go 1.17. The lack of module awareness is only a failure on Go
1.16 and later. Module support was added in basic form as far back as Go
1.11, released late 2018.
>
>> Ref: https://blog.golang.org/go116-module-changes.
>> diff --git a/contrib/persistent-https/go.mod b/contrib/persistent-https/go.mod
>> new file mode 100644
>> index 000000000000..6028b1fe5e62
>> --- /dev/null
>> +++ b/contrib/persistent-https/go.mod
>> @@ -0,0 +1,3 @@
>> +module github.com/git/git/contrib/persistent-https
>> +
>> +go 1.16
> Can I ask what is affected by this 1.16 version number?  Do the
> users have to use 1.16 and nothing older or newer?
>
> As a non Go user, I am trying to see if this change is "make it work
> for all users of reasonably new versions of Go" (if that is the
> case, what is the "reasonably new") or "make it work for those with
> 1.16, and everybody else should either install 1.16 or figure out 
> their own solutions".
>
> Thanks.
This is more thoroughly detailed here:
https://golang.org/ref/mod#go-mod-file-go, but essentially the version
number was/is intended to be the minimum Go version the module is
designed to work with. We could set it lower to play it safe if the Git
project wishes, but to date there have been no backwards
incompatibilities with the module system and the way we're using the
module system is so basic I don't see any way we'd trigger the
version-based behaviours detailed in the link above. For what it's worth
testing locally against 1.15 it builds without issue, despite being a
lower version number than specified in the string.

Dom
===

