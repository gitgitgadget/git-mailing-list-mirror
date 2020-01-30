Return-Path: <SRS0=gonI=3T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E7AC2D0DB
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 15:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70D9720678
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 15:08:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RsirmbKG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727238AbgA3PIQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jan 2020 10:08:16 -0500
Received: from mail-ot1-f53.google.com ([209.85.210.53]:34779 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726996AbgA3PIQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jan 2020 10:08:16 -0500
Received: by mail-ot1-f53.google.com with SMTP id a15so3448047otf.1
        for <git@vger.kernel.org>; Thu, 30 Jan 2020 07:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=sej8snfjLfp5u+GdQemXNyTQE55Q57XBNXbcvtd/gDw=;
        b=RsirmbKGghh+CV9G8cqtiuEtX59ylc5PueqyIvPfFh4iteX+WaSfZelrac5RZFVUcL
         9DPQbzZHtdPYA7hIbuDGyi3rXFvLY7z2lvhTBhknghXk4Jp9kNlqkBvBzuzFi+VAFp6/
         AhZtHNMnaN/vrvHK3QfO9lojKPbaHeeraQ2UAJnB30/UrF8lNBTei6QERodzv9vJ0bTB
         7ksc+YN4eZqmvhLybjLH5lmDk7J6kuYokYK58RKO44Pnkazakst37rz0EimZq/FgvUNv
         knmq73XPezdZyX9vA+n57rQFUtBBOsBtpiAEYXihkldjCx9l+riy9VaketxoBW2tuYiY
         I2NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sej8snfjLfp5u+GdQemXNyTQE55Q57XBNXbcvtd/gDw=;
        b=mQMvoaANRVP4phn1LUVX1i5apY33lzM7N25PykT8f8GSx084iFxMNzVga79sE8xV0Q
         +E/vsxIw1GO4ORyPUZeCVWe3EzLLZnw3tKngFCPNmIH3dDhZ+HnZ9EcfVTwZqGw/81uQ
         cGkmFLcpU0QFD57Avh89mPqNsYNv0VwxXEewfLd98ju6wehBLobaDzl3xQyNKwpQlcSS
         Wweze4KCJ96v6Nu/nHvSJSPqZ6LEKn6xiNLXQvJN0KcPvNcLGLtNDorBOJgYB9XUoFsG
         3BQZh2b9LkgomjvKBasanA8QhiHYED4r0hp3upqKPTo7R6SYO6xlGG7PBX35h8QHN5ib
         NcpQ==
X-Gm-Message-State: APjAAAUTbXdILhDzGqXOWp9K0qtIGkGxPBYMBE19Tdlw/5g+q7cvtc4A
        dW1wGyRsMRP4dDzNa9+Vi57D2Oy/e5U=
X-Google-Smtp-Source: APXvYqyQSsmp38d8KKU/D9+3HLTeE0N/yRhagDUHawICR5Z3uyX7Uym1XqvgZSpOU/r9NK/DMtobAA==
X-Received: by 2002:a05:6830:1bda:: with SMTP id v26mr3772273ota.314.1580396894912;
        Thu, 30 Jan 2020 07:08:14 -0800 (PST)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id u18sm1928615otq.26.2020.01.30.07.08.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jan 2020 07:08:14 -0800 (PST)
Subject: Re: How to undo git sparse-checkout set only for one directory?
To:     dk@tutunak.com, git@vger.kernel.org
References: <21812981580396191@vla3-a60e960147e7.qloud-c.yandex.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <9b717655-5a89-6d88-b5c5-8bee9faf75aa@gmail.com>
Date:   Thu, 30 Jan 2020 10:08:12 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:73.0) Gecko/20100101
 Thunderbird/73.0
MIME-Version: 1.0
In-Reply-To: <21812981580396191@vla3-a60e960147e7.qloud-c.yandex.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/30/2020 9:56 AM, dk@tutunak.com wrote:
> After git sparse-checkout set <dir1> <dir2> <dir3> I want to disable sparse checkout only for one directroy - <dir2>. How can I do that? git sparse-checkout disable will do that for whole repository. 

I'm planning to add some "add" and "remove" subcommands to the
sparse-checkout builtin soon, and those would allow you to modify
the sparse-checkout cone one-by-one.

For the case you have now, you can try this:

	git sparse-checkout list >dirs.txt
	(edit dirs.txt to remove the directory you do not want)
	git sparse-checkout set --stdin <dirs.txt

Alternatively, you could do this abomination:

	git sparse-checkout list | grep -v "<dir2>" | git sparse-checkout set --stdin

I hope that helps.

Thanks,
-Stolee

