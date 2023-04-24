Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 494C2C7618E
	for <git@archiver.kernel.org>; Mon, 24 Apr 2023 14:42:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbjDXOm1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Apr 2023 10:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjDXOm0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2023 10:42:26 -0400
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [IPv6:2a0c:5a00:149::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F079E30ED
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 07:42:18 -0700 (PDT)
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
        by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <admin@game-point.net>)
        id 1pqxOR-00DwGj-AR; Mon, 24 Apr 2023 16:42:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=game-point.net; s=selector2; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject;
        bh=FIXBOowMvaczQkMs19xqUGl8ZpFTfrcD+vgNT0effbg=; b=Q9RUklGLuqvfz5gs7IjIKtBZuo
        lNGt2/VMKz/mLCJQgzNoudHmTkFue88SIuYX0htsGFYYXLBetOmzmStEEoyG835puCppZ70kVQpZr
        Hl+fAJMCzimqYhXP3KV5BkRQZ7W/hBgYfueLLNw2RnDcd/tbw6G8bP4AAw/wiN63ki387ZUBfXtqD
        6MnO1kwmZtdshBATwATuZfwyh6h9NdYEU5KegOLg7Syb5hqB5bI9NLVD19TvoGUjzlgx3Ja/G3O+W
        Y+R8BRtXkJLCepwptUIqOeEKSMVJBnB6Sum8GagRNiwVfa3twzq4MiWivayNaMDq2gzEmGrmjGmHV
        65Pm2D0g==;
Received: from [10.9.9.73] (helo=submission02.runbox)
        by mailtransmit02.runbox with esmtp (Exim 4.86_2)
        (envelope-from <admin@game-point.net>)
        id 1pqxOQ-0008OM-Up; Mon, 24 Apr 2023 16:42:15 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (956903)]  (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        id 1pqxOI-0008Rp-J7; Mon, 24 Apr 2023 16:42:06 +0200
Subject: Re: Proposal: tell git a file has been renamed
To:     Erik Cervin Edin <erik@cervined.in>
Cc:     Chris Torek <chris.torek@gmail.com>, git@vger.kernel.org
References: <8fe188a9-c01f-9fb5-5877-8ff508094b22@game-point.net>
 <CAPx1Gvdc6bqzt2PpqD1Z4e5w+b=8gZhUSyfUQC1n8QazdBacEw@mail.gmail.com>
 <74a361fd-4ee6-f362-8d49-92417f0e2dac@game-point.net>
 <CA+JQ7M-1YvZFzE_CtBQa5_eEXa1sPqK4xsTxdwpAQo_YcmW+-A@mail.gmail.com>
 <91dab444-5f65-31ae-c0c6-0b84313bcd94@game-point.net>
 <CA+JQ7M_Lv1acopOpPoHxp7mPwWMFj-7wwwDPpV7KUbwFsjpoxA@mail.gmail.com>
From:   Jeremy Morton <admin@game-point.net>
Message-ID: <b157077e-a336-e550-2666-9880130eb5aa@game-point.net>
Date:   Mon, 24 Apr 2023 15:42:04 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:60.0) Gecko/20100101
 Firefox/60.0 SeaMonkey/2.53.1
MIME-Version: 1.0
In-Reply-To: <CA+JQ7M_Lv1acopOpPoHxp7mPwWMFj-7wwwDPpV7KUbwFsjpoxA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Yep, and that suggestion is rather arduous compared to something like:

git markasrenamed file2 file1
git commit

-- 
Best regards,
Jeremy Morton (Jez)

On 24/04/2023 15:00, Erik Cervin Edin wrote:
> On Mon, Apr 24, 2023 at 1:17 PM Jeremy Morton <admin@game-point.net> wrote:
>>
>> There's no getting away from the fact that this adds a lot of (IMHO
>> unnecessary) work if you've already done a rename that git can't
>> detect and have both that and a bunch of other changes sitting in the
>> index.  What feels like it would be a natural resolution in these
>> cases, though, is a "no, this remove/add is actually a rename" command.
> 
> It can definitely be both arduous and non-obvious how to deal with this.
> 
> The problem is that such a command cannot exist atm. because renames
> don't exist, they are only interpreted. So the only way to achieve
> this is to revert enough of the contents staged to the index such that
> the rename is detected. The only way to do that in a foolproof manner
> is reverting all the staged changes except the path so that the moved
> file in the index is identical to the old file in HEAD.
> 
> If I understand you correctly, your point here is that it's
> non-trivial to go from a state where a file has been renamed, with
> enough changes staged into the index that the rename hasn't been
> detected, to a state where the rename is recorded in the index?
> 
> The most straightforward method I can think of to restore the staged
> changes, do the rename without changes, commit and then go about the
> rest
> eg:
>    git restore --staged file2
>    mv file2 file1
>    git mv file1 file2
>    git commit -m rename
> 
