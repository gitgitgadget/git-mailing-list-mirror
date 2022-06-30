Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 381EEC43334
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 23:50:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbiF3XuG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 19:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbiF3XuB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 19:50:01 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E8D28734
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 16:49:09 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1A6AC1A9D2C;
        Thu, 30 Jun 2022 19:49:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=itsfgXwdZR63EqBQtdGnpYBScq4YPsoy1uH2mA
        2X1qs=; b=KXG5PrEkUOoKHe66S5DB4ftJygmCDEtV4kltqou69MnlgakQSkMHrP
        5ncc+GqbzCjYEVeZVxbc3zTxqrHiXbPBKComIFmfvbXoBfH5j9c9mPWsBRz50PFL
        KI5sm54rHWes99fqxfeS6iPqIDjcdZYLq5iFSuupSw4RIY1D4HRo0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 126641A9D2B;
        Thu, 30 Jun 2022 19:49:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A529F1A9D2A;
        Thu, 30 Jun 2022 19:49:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Erik Cervin Edin <erik@cervined.in>
Cc:     "lilinchao@oschina.cn" <lilinchao@oschina.cn>,
        git <git@vger.kernel.org>
Subject: Re: let git-ls-files suppress the expanding of all files in sub
 directory
References: <202206281608475079493@oschina.cn>
        <CA+JQ7M_rd_SdzLOL=a0ok=HL9AZ-q=V2Bc2aTuLRrPW8j7DOqA@mail.gmail.com>
Date:   Thu, 30 Jun 2022 16:49:04 -0700
In-Reply-To: <CA+JQ7M_rd_SdzLOL=a0ok=HL9AZ-q=V2Bc2aTuLRrPW8j7DOqA@mail.gmail.com>
        (Erik Cervin Edin's message of "Fri, 1 Jul 2022 01:04:21 +0200")
Message-ID: <xmqqv8shaf0v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3A048BD4-F8CF-11EC-AEC3-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Erik Cervin Edin <erik@cervined.in> writes:

> On Thu, Jun 30, 2022, 8:26 AM lilinchao@oschina.cn <lilinchao@oschina.cn> wrote:
>>
>> As subject said, is this possible for git-ls-files to work like this?:
>> " $ git ls-files --no-recursion
>>     a.txt
>>     b.txt
>>     dir/
>> "
>
> An alternative
>   git ls-tree --name-only HEAD
> is suggested here
> https://stackoverflow.com/a/10453994

The index may have different contents from HEAD, so it won't be a
replacement in general.

The index is a flat list of paths, so it is not like you can
suppressing the expansion (to avoid extra work).  You have to do
more work to omit paths in subdirectories to create such output.

